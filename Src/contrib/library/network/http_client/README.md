# simple HTTP client

## Overview
It provides simple routine to perform http requests, and get response.

## Requirements
* One of the following
	- Eiffel cURL library
		- cURL dynamic libraries in the PATH or the current directory (.dll or .so)
	- Eiffel Net library 
		- and optionally Eiffel NetSSL library to support `https://...`

* Note: set ciphers setting is supported only with libcurl implementation for now, net implementation
set all the ciphers as part of the OpenSSL initialization.

This means on Windows, do not forget to copy the libcurl.dll (and related) either in the same directory of the executable, or ensure the .dll are in the PATH environment.

It is possible to exclude the libcurl implementation xor the Eiffel Net implementation:
	In the .ecf configuration file of your project, you can use the following custom variables:

	* Disable the libcurl implementation
```
		<variable name="libcurl_http_client_disabled" value="True"/>
```

	* Disable the net implementation
```
		<variable name="net_http_client_disabled" value="True"/>
```

	* If you disabled both, the http client will not work as expected.

For the net implementation (using EiffelNet), if you need https:// support, you need to enabled the ssl support with the custom variables :
```
		<variable name="ssl_enabled" value="True"/>
```
	* By default, SSL is not included (mostly because it is sometime a pain to get the needed dynamic libraries .dll or .so)

## Usage
* To build code that is portable across the libcurl or net implementation of `http_client` library, use the `DEFAULT_HTTP_CLIENT`

```
	cl: DEFAULT_HTTP_CLIENT
	sess: HTTP_CLIENT_SESSION
	create cl
	sess := cl.new_session ("http://example.com")
	if attached sess.get ("/path-to-test") as l_response then
		if not l_response.error_occurred then
			if attached l_response.body as l_body then
				print (l_body)
			end
		end
	end
```

## Examples
* See the `tests/test-safe.ecf` project to see how to use.
* Examples will come in the future.

