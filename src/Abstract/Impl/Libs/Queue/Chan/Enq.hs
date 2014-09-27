module Abstract.Impl.Libs.Queue.Chan.Enq (
 mkQueue'Chan'Enq
) where

import Abstract.Interfaces.Queue.Enq

import qualified Abstract.Impl.Libs.Queue.Chan.Internal as CHAN (mkQueue'Chan)

mkQueue'Chan'Enq qrw = do
 v <- CHAN.mkQueue'Chan qrw
 return $ queueToEnq v
