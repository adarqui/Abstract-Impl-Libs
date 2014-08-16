module Abstract.Impl.Libs.Counter.MVar.Inc (
 module Abstract.Interfaces.Counter.Inc,
 mkCounter'MVar'Inc
) where

import Abstract.Interfaces.Counter.Inc
import qualified Abstract.Impl.Libs.Counter.MVar.Internal as MVAR (mkCounter'MVar)

mkCounter'MVar'Inc s t = do
 v <- MVAR.mkCounter'MVar s t 
 return $ counterToInc v
