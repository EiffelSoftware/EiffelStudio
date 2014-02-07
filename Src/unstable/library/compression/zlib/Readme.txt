Zlib Library based on http://elj.sourceforge.net/ 

Windows:

1. You can download it or compile it yourselft.


a: Download the library depends on ZLIB_WAPI from http://www.winimage.com/zLibDll/index.html
b. Copy the zlibwapi.lib to  $(ISE_LIBRARY)\unstable\library\compression\zlib\spec\$(ISE_PLATFORM)\lib\$(ISE_C_COMPILER)\zlibwapi.lib" 	
c. edit the ecf to use it  <external_object location="$(ISE_LIBRARY)\unstable\library\compression\zlib\spec\$(ISE_PLATFORM)\lib\$(ISE_C_COMPILER)\zlibwapi.lib">
d. Put the zlib dll in your path: zlibwapi.dll

2. DIY (you can build yoursefl a static library or a dinamyc library based on your needs)
a. Read this tutorial http://www.tannerhelland.com/5076/compile-zlib-winapi-wapi-stdcall/
b. Check the runtime: 
	Solution Explorer -> Properties -> Configuration Properties -> C/C++ -> Code Generation -> Runtime Library  (/MT /MD ...etc)




