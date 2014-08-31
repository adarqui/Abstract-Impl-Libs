module Abstract.Impl.Libs.Counter.IORef.Internal (
 CounterIORef,
 defaultCounter'IORef,
 mkCounter'IORef
) where

import Abstract.Interfaces.Counter
import Data.IORef


data CounterIORef t = CounterIORef {
 _conn :: IORef t,
 _n :: t
}


mkCounter'IORef :: (Num t) => t -> IO (Counter IO t)
mkCounter'IORef t = do
 ir <- newIORef t
 return $ defaultCounter'IORef $ counterIORef ir t


incr' :: (Num t) => CounterIORef t -> IO t
incr' w = do
 incrBy' w 1


incrBy' :: (Num t) => CounterIORef t -> t -> IO t
incrBy' w n = do
 atomicModifyIORef' (_conn w) (\a -> (a+n,a+n))


decr' :: (Num t) => CounterIORef t -> IO t
decr' w = do
 decrBy' w 1


decrBy' :: (Num t) => CounterIORef t -> t -> IO t
decrBy' w n = do
 atomicModifyIORef' (_conn w) (\a -> (a-n,a-n))
 

get' :: (Num t) => CounterIORef t -> IO (Maybe t)
get' w = do
 v <- readIORef (_conn w)
 return $ Just v


reset' :: (Num t) => CounterIORef t -> IO ()
reset' w = do
 writeIORef (_conn w) (_n w)


gentleReset' :: (Num t) => CounterIORef t -> IO ()
gentleReset' _ = return ()


counterIORef  :: (Num t) => IORef t -> t -> (CounterIORef t)
counterIORef ir n = CounterIORef { _conn = ir, _n = n }


defaultCounter'IORef :: (Num t) => CounterIORef t -> (Counter IO t)
defaultCounter'IORef w = do
 Counter {
  _incr = incr' w,
  _incrBy = incrBy' w,
  _decr = decr' w,
  _decrBy = decrBy' w,
  _get = get' w,
  _reset = reset' w,
  _gentleReset = gentleReset' w
 }
