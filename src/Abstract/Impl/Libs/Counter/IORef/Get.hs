module Abstract.Impl.Libs.Counter.IORef.Get (
 module Abstract.Interfaces.Counter.Get,
 mkCounter'IORef'Get
) where

import Abstract.Interfaces.Counter.Get
import qualified Abstract.Impl.Libs.Counter.IORef.Internal as IOREF (mkCounter'IORef)

mkCounter'IORef'Get t = do
 v <- IOREF.mkCounter'IORef t 
 return $ counterToGet v
