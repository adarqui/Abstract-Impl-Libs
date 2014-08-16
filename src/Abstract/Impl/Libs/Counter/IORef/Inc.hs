module Abstract.Impl.Libs.Counter.IORef.Inc (
 module Abstract.Interfaces.Counter.Inc,
 mkCounter'IORef'Inc
) where

import Abstract.Interfaces.Counter.Inc
import qualified Abstract.Impl.Libs.Counter.IORef.Internal as IOREF (mkCounter'IORef)

mkCounter'IORef'Inc s t = do
 v <- IOREF.mkCounter'IORef s t 
 return $ counterToInc v
