module Abstract.Impl.Libs.Queue.Chan.Deq (
 mkQueue'Chan'Deq
) where

import Abstract.Interfaces.Queue.Deq

import qualified Abstract.Impl.Libs.Queue.Chan.Internal as CHAN (mkQueue'Chan)

mkQueue'Chan'Deq = do
 v <- CHAN.mkQueue'Chan
 return $ queueToDeq v
