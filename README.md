# cacophony

[![Build Status](https://travis-ci.org/centromere/cacophony.svg?branch=master)](https://travis-ci.org/centromere/cacophony)
[![Haskell](http://b.repl.ca/v1/language-haskell-blue.png)](http://www.haskell.org)

This library implements the [Noise](https://noiseprotocol.org) protocol.

## Basic Usage

1. Import the modules for the kind of handshake you'd like to use.

   For example, if you want to use `Noise_IK_25519_AESGCM_SHA256`, your imports would be:

   ```haskell
   import Crypto.Noise
   import Crypto.Noise.Cipher.AESGCM
   import Crypto.Noise.DH
   import Crypto.Noise.DH.Curve25519
   import Crypto.Noise.Hash.SHA256
   import Crypto.Noise.HandshakePatterns (noiseIK)
   ```

2. Set the handshake parameters.

   Select a handshake pattern to use. Patterns are defined in the `Crypto.Noise.HandshakePatterns` module.
   Ensure that you provide the keys which are required by the handshake pattern you choose. For example,
   the `Noise_IK` pattern requires that the initiator provides a local static key and a remote static key,
   while the responder is only responsible for a local static key. You can use `defaultHandshakeOpts` to
   return a default set of options in which all keys are set to `Nothing`. You must set the local ephemeral
   key for all handshake patterns, and it should never be re-used.

   Functions for manipulating DH keys can be found in the `Crypto.Noise.DH` module.

   ```haskell
   -- Initiator
   localEphemeralKey <- dhGenKey :: IO (KeyPair Curve25519)

   let dho = defaultHandshakeOpts InitiatorRole "prologue" :: HandshakeOpts Curve25519
       iho = setLocalStatic      (Just localStaticKey)
             . setLocalEphemeral (Just localEphemeralKey)
             . setRemoteStatic   (Just remoteStaticKey) -- communicated out-of-band
             $ dho

   -- Responder
   localEphemeralKey <- dhGenKey :: IO (KeyPair Curve25519)

   let dho = defaultHandshakeOpts ResponderRole "prologue" :: HandshakeOpts Curve25519
       rho = setLocalStatic      (Just localStaticKey)
             . setLocalEphemeral (Just localEphemeralKey)
             $ dho
   ```

3. Create the Noise state.

   ```haskell
   -- Initiator
   let ins = noiseState iho noiseIK :: NoiseState AESGCM Curve25519 SHA256

   -- Responder
   let rns = noiseState rho noiseIK :: NoiseState AESGCM Curve25519 SHA256
   ```

4. Send and receive messages.

   ```haskell
   -- Initiator
   let writeResult = writeMessage "They must find it difficult -- those who have taken authority as the truth, rather than truth as the authority." ins
   case writeResult of
     NoiseResultMessage ciphertext ins' -> ciphertext
     NoiseResultNeedPSK ins' -> case writeMessage "PSK" ins' of
       NoiseResultMessage ciphertext ins' -> ciphertext
       _ -> error "something terrible happened"
     NoiseResultException ex -> error "something terrible happened"

   -- Responder
   let readResult = readMessage ciphertext rns
   case readResult of
     NoiseResultMessage plaintext rns' -> plaintext
     NoiseResultNeedPSK rns' -> case readMessage "PSK" rns' of
       NoiseResultMessage plaintext rns' -> plaintext
       _ -> error "something terrible happened"
     NoiseResultException ex -> error "something terrible happened"
   ```

   **Ensure that you never re-use a NoiseState to send more than one message.**

   Decrypted messages are stored internally as `ScrubbedBytes` and will be wiped from memory when they are
   destroyed.

### Helper Functions

The following functions are found in `Crypto.Noise` and can be helpful when designing an application which uses
Noise:

  * `remoteStaticKey` -- For handshake patterns where the remote party's static key is transmitted, this function
    can be used to retrieve it. This allows for the creation of public key-based access-control lists.

  * `handshakeComplete` -- Returns `True` if the handshake is complete.

  * `handshakeHash` -- Retrieves the `h` value associated with the conversation's SymmetricState. This value is
    intended to be used for channel binding. For example, the initiator might cryptographically sign this value
    as part of some higher-level authentication scheme. See section 11.2 of the protocol for details.

  * `rekeySending` and `rekeyReceiving` -- Rekeys the given NoiseState according to section 11.3 of the protocol.

## Vectors

Test vectors can be generated and verified using the `vectors` program. It accepts no arguments. When run,
it will check for the existence of `vectors/cacophony.txt` within the current working directory. If it is not
found, it is generated. If it is found, it is verified. All files within the `vectors/` directory (regardless
of their name) are also verified.

The generated vectors are minified JSON. There is a small python script within the `tools/` directory that
formats the JSON-blob in to something more readable.

## Custom Handshakes

If the built-in handshake patterns are insufficient for your application, you can define your own. Note that
this should be done with care.

Example:

```haskell
noiseFOOpsk0 :: HandshakePattern
noiseFOOpsk0 = handshakePattern "FOOpsk0" $
  preInitiator s            *>
  preResponder s            *>
  initiator (psk *> e *> es *> ss) *>
  responder (e *> ee *> se)
```

## Handshake Validation

`HandshakePattern`s can be validated for compliance as described in sections 7.1 and 9.3 of the protocol:

```
λ> let noiseBAD = handshakePattern "BAD" $ preResponder ss *> initiator (e *> se *> e)
[DHInPreMsg (0,0),InitMultipleETokens (1,2),InitSecretNotRandom (1,3)]

λ> validateHandshakePattern noiseKKpsk0
[]
```
