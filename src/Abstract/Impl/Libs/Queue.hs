module Abstract.Impl.Libs.Queue (
 module Abstract.Interfaces.Queue,
 mkQueue'Chan,
 mkQueue'Chan'Enq,
 mkQueue'Chan'Deq 

{-
 mkQueue'MVar,
 mkQueue'MVar'Enq,
 mkQueue'MVar'Deq 

 mkQueue'IORef,
 mkQueue'IORef'Enq,
 mkQueue'IORef'Deq
-}
) where

import Abstract.Interfaces.Queue

import Abstract.Impl.Libs.Queue.Chan.Internal (mkQueue'Chan)
import Abstract.Impl.Libs.Queue.Chan.Enq (mkQueue'Chan'Enq)
import Abstract.Impl.Libs.Queue.Chan.Deq (mkQueue'Chan'Deq)
{-
import Abstract.Impl.Libs.Queue.MVar.Internal (mkQueue'MVar)
import Abstract.Impl.Libs.Queue.MVar.Enq (mkQueue'MVar'Enq)
import Abstract.Impl.Libs.Queue.MVar.Deq (mkQueue'MVar'Deq)
-}

{-
import Abstract.Impl.Libs.Queue.IORef.Internal (mkQueue'IORef)
import Abstract.Impl.Libs.Queue.IORef.Enq (mkQueue'IORef'Enq)
import Abstract.Impl.Libs.Queue.IORef.Deq (mkQueue'IORef'Deq)
-}
