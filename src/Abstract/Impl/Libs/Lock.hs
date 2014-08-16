module Abstract.Impl.Libs.Lock (
 module Abstract.Interfaces.Lock,
 mkLock
) where

import Abstract.Interfaces.Lock
import Abstract.Impl.Libs.Lock.ConcurrentLock (mkLock)
