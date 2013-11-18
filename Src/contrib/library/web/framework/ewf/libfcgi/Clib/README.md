# libFCGI for Eiffel libFCGI wrapper library

## On Windows

The Eiffel libFCGI wrapper needs a modified version of libFCGI (provided by http://www.fastcgi.com/devkit/libfcgi/)

To get the full source code:
  rd /q/s libfcgi
  git clone https://github.com/EiffelSoftware/libfcgi libfcgi

And then to build the needed .dll and .lib file, use either:
  build_win32.bat 
  or build_win64.bat

## On other platorms

You can use the original version of libfcgi

### Debian based system (Ubuntu, ...)
On Ubuntu (or any Debian based system):
> sudo apt-get install libfcgi-dev


### Mac OS X
On Mac OS X:
> sudo port install fcgi
