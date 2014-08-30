module Abstract.Impl.Libs.Counter.MVar.Get (
 module Abstract.Interfaces.Counter.Get,
 mkCounter'MVar'Get
) where

import Abstract.Interfaces.Counter.Get
import qualified Abstract.Impl.Libs.Counter.MVar.Internal as MVAR (mkCounter'MVar)

mkCounter'MVar'Get t = do
 v <- MVAR.mkCounter'MVar t 
 return $ counterToGet v
