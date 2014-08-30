module Abstract.Impl.Libs.Counter.MVar.Internal (
 CounterMVarWrapper,
 defaultCounterWrapper,
 mkCounter'MVar
) where

import Abstract.Interfaces.Counter
import Control.Concurrent.MVar

data CounterMVarWrapper t = CounterMVarWrapper {
 _conn :: MVar t,
 _n :: t
}


mkCounter'MVar :: (Num t) => String -> t -> IO (Counter IO (CounterMVarWrapper t) t)
mkCounter'MVar cname t = do
 mv <- newMVar t
 return $ defaultCounterWrapper cname $ counterMVarWrapper mv t


incr' :: (Num t) => CounterMVarWrapper t -> IO t
incr' w = incrBy' w 1


incrBy' :: (Num t) => CounterMVarWrapper t -> t -> IO t
incrBy' w by = do
 modifyMVar (_conn w) (\a -> return (a+by,a+by))


decr' :: (Num t) => CounterMVarWrapper t -> IO t
decr' w = decrBy' w 1


decrBy' :: (Num t) => CounterMVarWrapper t -> t -> IO t
decrBy' w by = do
 modifyMVar (_conn w) (\a -> return (a-by,a-by))


get' :: (Num t) => CounterMVarWrapper t -> IO (Maybe t)
get' w = do
 v <- takeMVar (_conn w)
 putMVar (_conn w) v
 return $ Just v


reset' :: (Num t) => CounterMVarWrapper t -> IO ()
reset' w = do
 _ <- modifyMVar (_conn w) (\_ -> return (_n w, _n w))
 return ()


gentleReset' :: (Num t) => CounterMVarWrapper t -> IO ()
gentleReset' _ = return ()


counterMVarWrapper :: (Num t) => MVar t -> t -> (CounterMVarWrapper t)
counterMVarWrapper mv n = CounterMVarWrapper { _conn = mv, _n = n }


defaultCounterWrapper :: (Num t) => String -> CounterMVarWrapper t -> Counter IO (CounterMVarWrapper t) t
defaultCounterWrapper cname w = do
 Counter {
  _c = w,
  _cname = cname,
  _incr = incr',
  _incrBy = incrBy',
  _decr = decr',
  _decrBy = decrBy',
  _get = get',
  _reset = reset',
  _gentleReset = gentleReset'
 }
