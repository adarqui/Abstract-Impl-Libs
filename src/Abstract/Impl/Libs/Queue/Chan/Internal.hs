{-# LANGUAGE RecordWildCards #-}
module Abstract.Impl.Libs.Queue.Chan.Internal (
 QueueChan,
 mkQueue'Chan
) where

import Control.Exception
import Control.Concurrent
import Control.Concurrent.Chan

import Abstract.Interfaces.Queue

data QueueChan t = QueueChan {
 _conn :: Chan t
}

mkQueue'Chan :: QueueChan t -> IO (Queue IO t)
mkQueue'Chan qrw = do
 mv <- newChan
 return $ buildQueue $ qrw { _conn = mv }

enqueue' :: QueueChan t -> t -> IO ()
enqueue' QueueChan{..} t = do
 writeChan _conn t

enqueueBatch' :: QueueChan t -> [t] -> IO ()
enqueueBatch' QueueChan{..} ts = do
 writeList2Chan _conn ts

dequeue' :: QueueChan t -> IO (Maybe t)
dequeue' QueueChan{..} = readChan _conn >>= return . Just

drain' :: QueueChan t -> IO [t]
drain' QueueChan{..} = getChanContents _conn

size' :: QueueChan t -> IO Int
size' QueueChan{..} = return 0

destroy' :: QueueChan t -> IO ()
destroy' QueueChan{..} = return ()

buildQueue :: QueueChan t -> Queue IO t
buildQueue w =
 Queue {
  _enqueue = enqueue' w,
  _enqueueBatch = enqueueBatch' w,
  _dequeue = dequeue' w,
  _drain = drain' w,
  _size = size' w,
  _destroy = destroy' w
 }
