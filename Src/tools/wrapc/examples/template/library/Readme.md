# How to generate the code?

## Requirements
You need to have a binary version of WrapC tool and be able to execute it from the library folder.

Before to regenerate the generated code, remove the folder `generated_wrapper`. If you are using geant, just run `geant clean` in other 
case remove it manually.

## Using Automated scripts
Automated scripts will run wrapc with pre and post processing scripts and compiling the C glue code
needed for the library.

### Windows
```
generator.bat
```
### Linux
```
./generator.sh
```

## Using WrapC with geant
$LIB_PATH is the path to the library folder where you checkout the WrapC source code. For example c:/WrapC/examples/$template.

### Wrap libusb library

Go to the $LIB_PATH/library

```
    geant wrap_c  -- Wrap C the c simple example and generate the code under the folder generated_wrapper
```

### Compile the C library
 ```
    geant compile -- Build the C library, in this case generate the eif_$template.(lib|a)
  ```
***

### Clean the generated code

```
   geant clean
```
 
## Using WrapC without geant
In this option, you will need to copy by hand the specific Makefiles and 
move the c code from manual_wrapper folder to the generated_wrapper to make it
work.

  
$LIB_PATH is the path to the library folder where you checkout the wrap_libusb library.
At the moment the tool require --output-dir and --full-header to be full paths.
$HEADER_TEMPLATE_PATH is the path to the library where the template header is located.

### WrapC 
  ```
    wrap_c --verbose --output-dir=$LIB_PATH/library/generated_wrapper --full-header=$HEADER_TEMPLATE_PATH config.xml
  ```

### Compile the C library
```
  cd generated_wrapper\c\src
  finish_freezing -library
```



  
