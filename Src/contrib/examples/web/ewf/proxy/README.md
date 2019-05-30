Proxy example
=============

Via the `wsf_proxy` library, it is possible to implement a simple reverse proxy service. 

This example forwards request based on server name, or location as described below:
- if server name is `foo`, forwards to `http://localhost:8080/foo`
- if server name is `bar`, forwards to `http://localhost:8080/bar`
- if path starts with "/search/", forwards to `http://www.google.com/search?q=`

For instance:
- http://foo/a/test -> http://localhost:8080/foo/a/test
- http://localhost:9090/search/eiffel -> http://www.google.com/search?q=eiffel

Notes:
- look at `{APPLICATION_EXECUTION}.execute` for the implementation.
- the `send_proxy_response` implements a general forwarding, but for more advanced need, this could be customized per forwarding. For instance, a specific forwarding, may need the X-Forwarded headers, or to keep the `Host` from the client, ...

