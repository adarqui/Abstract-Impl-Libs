module Abstract.Impl.Libs.Counter.MVar.Internal (
 CounterMVar,
 defaultCounter'MVar,
 mkCounter'MVar
) where

import Abstract.Interfaces.Counter
import Control.Concurrent.MVar

data CounterMVar t = CounterMVar {
 _conn :: MVar t,
 _n :: t
}


mkCounter'MVar :: (Num t) => t -> IO (Counter IO t)
mkCounter'MVar t = do
 mv <- newMVar t
 return $ defaultCounter'MVar $ counterMVar mv t


incr' :: (Num t) => CounterMVar t -> IO t
incr' w = incrBy' w 1


incrBy' :: (Num t) => CounterMVar t -> t -> IO t
incrBy' w by = do
 modifyMVar (_conn w) (\a -> return (a+by,a+by))


decr' :: (Num t) => CounterMVar t -> IO t
decr' w = decrBy' w 1


decrBy' :: (Num t) => CounterMVar t -> t -> IO t
decrBy' w by = do
 modifyMVar (_conn w) (\a -> return (a-by,a-by))


get' :: (Num t) => CounterMVar t -> IO (Maybe t)
get' w = do
 v <- takeMVar (_conn w)
 putMVar (_conn w) v
 return $ Just v


reset' :: (Num t) => CounterMVar t -> IO ()
reset' w = do
 _ <- modifyMVar (_conn w) (\_ -> return (_n w, _n w))
 return ()


gentleReset' :: (Num t) => CounterMVar t -> IO ()
gentleReset' _ = return ()


counterMVar :: (Num t) => MVar t -> t -> (CounterMVar t)
counterMVar mv n = CounterMVar { _conn = mv, _n = n }


defaultCounter'MVar :: (Num t) => CounterMVar t -> Counter IO t
defaultCounter'MVar w = do
 Counter {
  _incr = incr' w,
  _incrBy = incrBy' w,
  _decr = decr' w,
  _decrBy = decrBy' w,
  _get = get' w,
  _reset = reset' w,
  _gentleReset = gentleReset' w
 }
