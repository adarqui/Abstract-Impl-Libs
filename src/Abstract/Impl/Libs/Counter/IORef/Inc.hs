module Abstract.Impl.Libs.Counter.IORef.Inc (
 module Abstract.Interfaces.Counter.Inc,
 mkCounter'IORef'Inc
) where

import Abstract.Interfaces.Counter.Inc
import qualified Abstract.Impl.Libs.Counter.IORef.Internal as IOREF (mkCounter'IORef)

mkCounter'IORef'Inc t = do
 v <- IOREF.mkCounter'IORef t 
 return $ counterToInc v
