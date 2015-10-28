{-# LANGUAGE TypeFamilies #-}
----------------------------------------------------------------
-- |
-- Module      : Crypto.Noise.Curve
-- Maintainer  : John Galt <centromere@users.noreply.github.com>
-- Stability   : experimental
-- Portability : POSIX

module Crypto.Noise.Curve
  ( -- * Classes
    Curve(..),
    -- * Types
    KeyPair
  ) where

import Data.ByteArray (ScrubbedBytes)

-- | Typeclass for EC curves.
class Curve c where
  -- | Represents a public key.
  data PublicKey c :: *

  -- | Represents a secret key.
  data SecretKey c :: *

  -- | Returns the name of the curve. This is used when generating
  --   the handshake name.
  curveName        :: proxy c -> ScrubbedBytes

  -- | Returns the length of public keys for this Curve in bytes.
  curveLength      :: proxy c -> Int

  -- | Generates a KeyPair.
  curveGenKey      :: IO (KeyPair c)

  -- | Performs ECDH.
  curveDH          :: SecretKey c -> PublicKey c -> ScrubbedBytes

  -- | Exports a PublicKey.
  curvePubToBytes  :: PublicKey c -> ScrubbedBytes

  -- | Imports a PublicKey.
  curveBytesToPub  :: ScrubbedBytes -> PublicKey c

  -- | Exports a SecretKey.
  curveSecToBytes  :: SecretKey c -> ScrubbedBytes

  -- | Imports a SecretKey.
  curveBytesToPair :: ScrubbedBytes -> KeyPair c

-- | Represents a private/public EC keypair for a given Curve.
type KeyPair c = (SecretKey c, PublicKey c)
