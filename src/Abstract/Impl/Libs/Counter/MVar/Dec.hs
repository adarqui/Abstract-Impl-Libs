module Abstract.Impl.Libs.Counter.MVar.Dec (
 module Abstract.Interfaces.Counter.Dec,
 mkCounter'MVar'Dec
) where

import Abstract.Interfaces.Counter.Dec
import qualified Abstract.Impl.Libs.Counter.MVar.Internal as MVAR (mkCounter'MVar)

mkCounter'MVar'Dec s t = do
 v <- MVAR.mkCounter'MVar s t 
 return $ counterToDec v
