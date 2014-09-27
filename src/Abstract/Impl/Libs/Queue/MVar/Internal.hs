module Abstract.Impl.Libs.Queue.MVar.Internal (
 QueueMVar{-,
 queueMVar,
 mkQueue'MVar
-}
) where

import Control.Exception
import Control.Concurrent
import Control.Concurrent.MVar

import Abstract.Interfaces.Queue

data QueueMVar t = QueueMVar {
 _conn :: MVar t
}

{-
mkQueue'MVar :: QueueMVar t -> IO (Queue IO t)
mkQueue'MVar qrw = do
 mv <- newEmptyMVar
 return $ buildQueue $ qrw { _conn = mv }

enqueue' :: QueueMVar t -> t -> IO ()
enqueue' w t = do
 v <-  putMVar (_conn w) t
 return $ case v of
  (Left _) -> throw OperationFailed
  (Right _) -> ()
-}
