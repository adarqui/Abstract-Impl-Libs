module Abstract.Impl.Libs.Counter.IORef.Dec (
 module Abstract.Interfaces.Counter.Dec,
 mkCounter'IORef'Dec
) where

import Abstract.Interfaces.Counter.Dec
import qualified Abstract.Impl.Libs.Counter.IORef.Internal as IOREF (mkCounter'IORef)

mkCounter'IORef'Dec t = do
 v <- IOREF.mkCounter'IORef t 
 return $ counterToDec v
