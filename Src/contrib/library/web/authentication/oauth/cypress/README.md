Cypress
=======

Is an OAuth protocol implementation in Eiffel.

- Consumer: the client library and support OAtuh1.0a and 2.0.
- Server: is not done.


Note: This is a work in progress, and the API could change in a future.

## SSL/https concerns

Cypress is using the `http_client` library, and by default it uses the libcurl implementation. But if you use the EiffelNet implementation of the `http_client`, be sure to have `<variable name="ssl_enabled" value="true"/>` in your ecf file.
When using the libcurl implementation on Windows, make sue the associated .dll files are in accessible by the application.


