When your Eiffel executable running, Eiffel cURL library needs 3 DLLs, they are:

libcurl.dll, libeay32.dll and ssleay32.dll

Please make sure the 3 DLLs files can be found in your environment PATH or in same folder of your executable.

cURL command line tool

The --libcurl command-line option will create a C program in the provided file name. 

Example: curl http://example.com --libcurl example.c
Will create a file example.c code of this command line

To learn more about the cURL check https://ec.haxx.se/libcurl--libcurl.html