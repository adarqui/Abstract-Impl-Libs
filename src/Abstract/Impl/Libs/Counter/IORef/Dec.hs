module Abstract.Impl.Libs.Counter.IORef.Dec (
 module Abstract.Interfaces.Counter.Dec,
 mkCounter'IORef'Dec
) where

import Abstract.Interfaces.Counter.Dec
import qualified Abstract.Impl.Libs.Counter.IORef.Internal as IOREF (mkCounter'IORef)

mkCounter'IORef'Dec s t = do
 v <- IOREF.mkCounter'IORef s t 
 return $ counterToDec v
