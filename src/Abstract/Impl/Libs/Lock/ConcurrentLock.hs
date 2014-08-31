module Abstract.Impl.Libs.Lock.ConcurrentLock (
 Lock,
 mkLock
) where

import Abstract.Interfaces.Lock
import qualified Control.Concurrent.Lock as L

mkLock :: IO (Lock IO)
mkLock = do
 lk <- L.new
 return $ buildLock lk


buildLock :: L.Lock -> Lock IO
buildLock lk = 
 Lock {
  _acquire = L.acquire lk,
  _tryAcquire = L.tryAcquire lk,
  _release = L.release lk,
  _with = L.with lk,
  _tryWith = L.tryWith lk,
  _wait = L.wait lk,
  _locked = L.locked lk
 }
