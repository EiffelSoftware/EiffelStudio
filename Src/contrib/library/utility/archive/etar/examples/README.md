# Example usages of the etar library
## tar_ls
tar_ls lists the contents of one or more tar archives.

```
Usage:
	tar_ls archive...
```

## minipax
minipax is a tiny version of pax (the posix replacement for tar). It can be used
to list archive contents, create and extract archives. Calling just minipax from
a terminal will cause it to show the usage text which is:

```
Usage: 
    - minipax [-A] -f archive
        List mode: minipax prints the contents of the specified archive
    - minipax [-A] -r -f archive
        Read mode: minipax unarchives the contents of the specified archive
    - minipax [-A] -w -f archive file...
        Write mode: minipax archives the given list of files, creating the
                    archive if it does not exist, overriding it otherwise
Options
    -A      Allow absolute paths and parent directory identifiers in filenames
```
