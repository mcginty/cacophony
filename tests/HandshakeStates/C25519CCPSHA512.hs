{-# LANGUAGE OverloadedStrings #-}
module HandshakeStates.C25519CCPSHA512 where

import Crypto.Noise.Cipher.ChaChaPoly1305
import Crypto.Noise.Curve
import Crypto.Noise.Curve.Curve25519
import Crypto.Noise.Handshake
import Crypto.Noise.HandshakePatterns
import Crypto.Noise.Hash.SHA512
import Crypto.Noise.Types

initStatic :: KeyPair Curve25519
initStatic = curveBytesToPair . bsToSB' $ "I\f\232\218A\210\230\147\FS\222\167\v}l\243!\168.\ESC\t\SYN\"\169\179A`\DC28\211\169tC"

respStatic :: KeyPair Curve25519
respStatic = curveBytesToPair . bsToSB' $ "\ETB\157\&7\DC2\252\NUL\148\172\148\133\218\207\&8\221y\144\209\168FX\224Ser_\178|\153.\FSg&"

respEphemeral :: KeyPair Curve25519
respEphemeral = curveBytesToPair . bsToSB' $ "<\231\151\151\180\217\146\DLEI}\160N\163iKc\162\210Y\168R\213\206&gm\169r\SUB[\\'"

noiseNNIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNNIHS =
  handshakeState
  "NN"
  noiseNNI
  ""
  Nothing
  Nothing
  Nothing
  Nothing

noiseKNIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKNIHS =
  handshakeState
  "KN"
  noiseKNI
  ""
  (Just initStatic)
  Nothing
  Nothing
  Nothing

noiseNKIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNKIHS =
  handshakeState
  "NK"
  noiseNKI
  ""
  Nothing
  Nothing
  (Just (snd respStatic))
  Nothing

noiseKKIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKKIHS =
  handshakeState
  "KK"
  noiseKKI
  ""
  (Just initStatic)
  Nothing
  (Just (snd respStatic))
  Nothing

noiseNEIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNEIHS =
  handshakeState
  "NE"
  noiseNEI
  ""
  Nothing
  Nothing
  (Just (snd respStatic))
  (Just (snd respEphemeral))

noiseKEIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKEIHS =
  handshakeState
  "KE"
  noiseKEI
  ""
  (Just initStatic)
  Nothing
  (Just (snd respStatic))
  (Just (snd respEphemeral))

noiseNXIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNXIHS =
  handshakeState
  "NX"
  noiseNXI
  ""
  Nothing
  Nothing
  Nothing
  Nothing

noiseKXIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKXIHS =
  handshakeState
  "KX"
  noiseKXI
  ""
  (Just initStatic)
  Nothing
  (Just (snd respStatic))
  Nothing

noiseXNIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXNIHS =
  handshakeState
  "XN"
  noiseXNI
  ""
  (Just initStatic)
  Nothing
  Nothing
  Nothing

noiseINIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseINIHS =
  handshakeState
  "IN"
  noiseINI
  ""
  (Just initStatic)
  Nothing
  Nothing
  Nothing

noiseXKIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXKIHS =
  handshakeState
  "XK"
  noiseXKI
  ""
  (Just initStatic)
  Nothing
  (Just (snd respStatic))
  Nothing

noiseIKIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseIKIHS =
  handshakeState
  "IK"
  noiseIKI
  ""
  (Just initStatic)
  Nothing
  (Just (snd respStatic))
  Nothing

noiseXEIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXEIHS =
  handshakeState
  "XE"
  noiseXEI
  ""
  (Just initStatic)
  Nothing
  (Just (snd respStatic))
  (Just (snd respEphemeral))

noiseIEIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseIEIHS =
  handshakeState
  "IE"
  noiseIEI
  ""
  (Just initStatic)
  Nothing
  (Just (snd respStatic))
  (Just (snd respEphemeral))

noiseXXIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXXIHS =
  handshakeState
  "XX"
  noiseXXI
  ""
  (Just initStatic)
  Nothing
  Nothing
  Nothing

noiseIXIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseIXIHS =
  handshakeState
  "IX"
  noiseIXI
  ""
  (Just initStatic)
  Nothing
  Nothing
  Nothing

noiseNIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNIHS =
  handshakeState
  "N"
  noiseNI
  ""
  Nothing
  Nothing
  (Just (snd respStatic))
  Nothing

noiseKIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKIHS =
  handshakeState
  "K"
  noiseKI
  ""
  (Just initStatic)
  Nothing
  (Just (snd respStatic))
  Nothing

noiseXIHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXIHS =
  handshakeState
  "X"
  noiseXI
  ""
  (Just initStatic)
  Nothing
  (Just (snd respStatic))
  Nothing

noiseNNRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNNRHS =
  handshakeState
  "NN"
  noiseNNR
  ""
  Nothing
  Nothing
  Nothing
  Nothing

noiseKNRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKNRHS =
  handshakeState
  "KN"
  noiseKNR
  ""
  Nothing
  Nothing
  (Just (snd initStatic))
  Nothing

noiseNKRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNKRHS =
  handshakeState
  "NK"
  noiseNKR
  ""
  (Just respStatic)
  Nothing
  Nothing
  Nothing

noiseKKRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKKRHS =
  handshakeState
  "KK"
  noiseKKR
  ""
  (Just respStatic)
  Nothing
  (Just (snd initStatic))
  Nothing

noiseNERHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNERHS =
  handshakeState
  "NE"
  noiseNER
  ""
  (Just respStatic)
  (Just respEphemeral)
  Nothing
  Nothing

noiseKERHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKERHS =
  handshakeState
  "KE"
  noiseKER
  ""
  (Just respStatic)
  (Just respEphemeral)
  (Just (snd initStatic))
  Nothing

noiseNXRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNXRHS =
  handshakeState
  "NX"
  noiseNXR
  ""
  (Just respStatic)
  Nothing
  Nothing
  Nothing

noiseKXRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKXRHS =
  handshakeState
  "KX"
  noiseKXR
  ""
  (Just respStatic)
  Nothing
  (Just (snd initStatic))
  Nothing

noiseXNRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXNRHS =
  handshakeState
  "XN"
  noiseXNR
  ""
  Nothing
  Nothing
  Nothing
  Nothing

noiseINRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseINRHS =
  handshakeState
  "IN"
  noiseINR
  ""
  Nothing
  Nothing
  Nothing
  Nothing

noiseXKRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXKRHS =
  handshakeState
  "XK"
  noiseXKR
  ""
  (Just respStatic)
  Nothing
  Nothing
  Nothing

noiseIKRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseIKRHS =
  handshakeState
  "IK"
  noiseIKR
  ""
  (Just respStatic)
  Nothing
  Nothing
  Nothing

noiseXERHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXERHS =
  handshakeState
  "XE"
  noiseXER
  ""
  (Just respStatic)
  (Just respEphemeral)
  Nothing
  Nothing

noiseIERHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseIERHS =
  handshakeState
  "IE"
  noiseIER
  ""
  (Just respStatic)
  (Just respEphemeral)
  Nothing
  Nothing

noiseXXRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXXRHS =
  handshakeState
  "XX"
  noiseXXR
  ""
  (Just respStatic)
  Nothing
  Nothing
  Nothing

noiseIXRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseIXRHS =
  handshakeState
  "IX"
  noiseIXR
  ""
  (Just respStatic)
  Nothing
  Nothing
  Nothing

noiseNRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseNRHS =
  handshakeState
  "N"
  noiseNR
  ""
  (Just respStatic)
  Nothing
  Nothing
  Nothing

noiseKRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseKRHS =
  handshakeState
  "K"
  noiseKR
  ""
  (Just respStatic)
  Nothing
  (Just (snd initStatic))
  Nothing

noiseXRHS :: HandshakeState ChaChaPoly1305 Curve25519 SHA512
noiseXRHS =
  handshakeState
  "X"
  noiseXR
  ""
  (Just respStatic)
  Nothing
  Nothing
  Nothing
