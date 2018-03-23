# Symmetric encryption
Symmetric encryption is a way to encrypt or hide the contents of material where the sender and receiver both use the same secret key. 
Note that symmetric encryption is not sufficient for most applications because it only provides secrecy but not authenticity. 
That means an attacker can’t see the message but an attacker can create bogus messages and force the application to decrypt them.

For this reason it is strongly recommended to combine encryption with a message authentication code, such as HMAC,