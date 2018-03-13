# OpenSSL support for EiffelNet #

Status: working on Windows and Linux

Contributors:
- Guus Leeuw jr. (itpassion.com)
- Jocelyn Fiat (eiffel.com)
- Javier Velilla (eiffel.com)


Supported Version
=================
OpenSSL version 1.1.0f.



1. How to get precompiled OpenSSL
================================

To get the precompiled libraries for Windows check the following
link https://www.npcglib.org/~stathis/blog/precompiled-openssl/
It has 32 and 64 version for different versions of Microsoft Visual Studio.


2. Static Library (/MT) or Dynamic Library(/MD)
================================================
For static library use the configuration file <<net_ssl-safe.ecf>> or <<net_ssl.ecf>>
Copy the static libraries (libcryptoMT.lib and libsslMT.lib) that you get from step 1
to $(ISE_LIBRARY)\unstable\library\network\socket\netssl\spec\$(ISE_PLATFORM)\lib\$(ISE_C_COMPILER)\

If you want to use the static version check if you have in your path <<crypt32.lib>>, 
in other case check the following link to learn more about how to install Windows Platform SDK.
https://msdn.microsoft.com/en-us/library/ms759194(v=vs.85).aspx.


For dynamic library use the configuration file <<net_ssl_dynamic.ecf>>
Copy the dynamic library (libcryptoMT.lib and libsslMT.lib) that you get from step 1
to $(ISE_LIBRARY)\unstable\library\network\socket\netssl\spec\$(ISE_PLATFORM)\lib\$(ISE_C_COMPILER)\)
When you use this option does not forget to have the dll in the PATH of the corresponding project,
you can get the dll's files from step1.

3. How to complile OpenSSL
===========================

How to build OpenSSL on Windows.
================================

Requirements.
	* Perl Installation    : http://www.activestate.com/activeperl/downloads
	* OpenSSL source code  : http://www.openssl.org/source/
	* C compiler (for example: Visual Studio)
	* Netwide Assembler, a.k.a. NASM, available from http://www.nasm.us,is required if you intend to utilize assembler modules.


How to build OpenSSL with VisualStudio  
======================================.

Setting up for the build

Unzip the OpenSSL source code into two different folders, one for the 32-bit build and one for the 64-bit build. 
So, for example, you might end up with C:\openssl-src-32 and C:\openssl-src-64.

Example:
Building the 64-bit static libraries

To build a 64-Bit static library (/MT) use the option <<no-shared>> with VC-WIN64A

Note: To build a 64-Bit shared library (/MD) use the option <<shared>> with VC-WIN64A

Open the Visual Studio Command Prompt. (Be sure to open the corrent command prompt)
Check Configure file under OpenSSL distribution to read different types of configurations.
or the following link https://wiki.openssl.org/index.php/Compilation_and_Installation


1: perl Configure { VC-WIN32 | VC-WIN64A | VC-WIN64I | VC-CE }
-- for example 
1.1 perl Configure VC-WIN64A no-shared --prefix=C:\Build-OpenSSL-VC-64
2: nmake
3: nmake test

Your outputs will be in C:\Build-OpenSSL-VC-64

For 32-bit the proccess is similar just change the VC-WIN64A for VC-WIN32.


Eiffel OpenSSL GCM and ECDSA Wrapper
============================

Proof of concpet

Documentation
=============
https://www.openssl.org/docs/man1.1.0/crypto/ECDSA_do_sign.html
https://wiki.openssl.org/index.php/Elliptic_Curve_Cryptography
https://wiki.openssl.org/index.php/Elliptic_Curve_Diffie_Hellman



#How to use the latest OpenSSL 1.1.0g on Ubuntu
================================================

$>wget https://www.openssl.org/source/openssl-1.1.0g.tar.gz
$>tar xzvf openssl-1.1.0f.tar.gz
$>cd openssl-1.1.0g
$>./Configure is now
	$>./config -Wl,--enable-new-dtags,-rpath,`$(LIBRPATH)`
	$>make
	$>sudo make install

	$>openssl version -a    

	If you have an already installed OpenSSL library remove it using

	$>sudo apt-get remove libssl-dev


