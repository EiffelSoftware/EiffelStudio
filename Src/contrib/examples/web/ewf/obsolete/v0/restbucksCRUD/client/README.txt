Make sure to have the Clib generated in the related cURL library

- if you use EiffelStudio >= 7.0
  check %ISE_LIBRARY%\library\cURL\spec\%ISE_C_COMPILER%\$ISE_PLATFORM
  or    $ISE_LIBRARY/library/cURL/spec/$ISE_PLATFORM

- otherwise if you use earlier version
  check under ext/ise_library/curl/spec/...

And on Windows, be sure to get the libcurl.dll from  %ISE_LIBRARY%\studio\spec\%ISE_PLATFORM%\bin\libcurl.dll

