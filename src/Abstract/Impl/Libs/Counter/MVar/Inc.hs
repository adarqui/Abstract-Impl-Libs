module Abstract.Impl.Libs.Counter.MVar.Inc (
 module Abstract.Interfaces.Counter.Inc,
 mkCounter'MVar'Inc
) where

import Abstract.Interfaces.Counter.Inc
import qualified Abstract.Impl.Libs.Counter.MVar.Internal as MVAR (mkCounter'MVar)

mkCounter'MVar'Inc t = do
 v <- MVAR.mkCounter'MVar t 
 return $ counterToInc v
