module Abstract.Impl.Libs.Counter.IORef.Internal (
 CounterIORefWrapper,
 defaultCounterWrapper,
 mkCounter'IORef
) where

import Abstract.Interfaces.Counter
import Data.IORef


data CounterIORefWrapper t = CounterIORefWrapper {
 _conn :: IORef t,
 _n :: t
}


mkCounter'IORef :: (Num t) => String -> t -> IO (Counter IO (CounterIORefWrapper t) t)
mkCounter'IORef cname t = do
 ir <- newIORef t
 return $ defaultCounterWrapper cname $ counterIORefWrapper ir t


incr' :: (Num t) => CounterIORefWrapper t -> IO t
incr' w = do
 incrBy' w 1


incrBy' :: (Num t) => CounterIORefWrapper t -> t -> IO t
incrBy' w n = do
 atomicModifyIORef' (_conn w) (\a -> (a+n,a+n))


decr' :: (Num t) => CounterIORefWrapper t -> IO t
decr' w = do
 decrBy' w 1


decrBy' :: (Num t) => CounterIORefWrapper t -> t -> IO t
decrBy' w n = do
 atomicModifyIORef' (_conn w) (\a -> (a-n,a-n))
 

get' :: (Num t) => CounterIORefWrapper t -> IO (Maybe t)
get' w = do
 v <- readIORef (_conn w)
 return $ Just v


reset' :: (Num t) => CounterIORefWrapper t -> IO ()
reset' w = do
 writeIORef (_conn w) (_n w)


gentleReset' :: (Num t) => CounterIORefWrapper t -> IO ()
gentleReset' _ = return ()


counterIORefWrapper  :: (Num t) => IORef t -> t -> (CounterIORefWrapper t)
counterIORefWrapper ir n = CounterIORefWrapper { _conn = ir, _n = n }


defaultCounterWrapper :: (Num t) => String -> CounterIORefWrapper t -> (Counter IO (CounterIORefWrapper t) t)
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
