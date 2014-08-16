module Abstract.Impl.Libs.Lock.ConcurrentLock (
 LockWrapper,
 defaultLockWrapper,
 mkLock
) where

import Abstract.Interfaces.Lock
import qualified Control.Concurrent.Lock as L

data LockWrapper = LockWrapper {
 _conn :: L.Lock
}


mkLock :: String ->  IO (Lock IO LockWrapper)
mkLock lkname = do
 lk <- L.new
 return $ defaultLockWrapper lkname $ lockWrapper lk


acquire' :: LockWrapper -> IO ()
acquire' w = L.acquire $ _conn w


tryAcquire' :: LockWrapper -> IO Bool
tryAcquire' w = L.tryAcquire $ _conn w


release' :: LockWrapper -> IO ()
release' w = L.release $ _conn w


with' :: LockWrapper -> IO t -> IO t
with' w = L.with (_conn w)


tryWith' :: LockWrapper -> IO t -> IO (Maybe t)
tryWith' w = L.tryWith (_conn w)


wait' :: LockWrapper -> IO ()
wait' w = L.wait (_conn w)


locked' :: LockWrapper -> IO Bool
locked' w = L.locked (_conn w)


lockWrapper :: L.Lock -> LockWrapper
lockWrapper lk = LockWrapper { _conn = lk }


defaultLockWrapper :: String -> LockWrapper -> Lock IO LockWrapper
defaultLockWrapper lkname lk = 
 Lock {
  _lk = lk,
  _lkname = lkname,
  _acquire = acquire',
  _tryAcquire = tryAcquire',
  _release = release',
  _with = with',
  _tryWith = tryWith',
  _wait = wait',
  _locked = locked'
 }
