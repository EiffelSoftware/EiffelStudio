File response example
=====================

This demonstrates how to return a file to the client. In this example you will learn how to dispatch manually the URL thanks to the `request.path_info` value.
You will also learn how to use the `WSF_RESPONSE.send (message)` interface that does not require you to know that much about http protocol since you will build `WSF_FILE_RESPONSE` and `WSF_NOT_FOUND_MESSAGE` objects.

