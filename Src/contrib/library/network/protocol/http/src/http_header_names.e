note
	description: "[
			See http://en.wikipedia.org/wiki/List_of_HTTP_headers
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_HEADER_NAMES

feature -- Request header name

	header_accept: STRING = "Accept"
			-- Content-Types that are acceptable
			--| Example: Accept: text/plain

	header_accept_charset:  STRING = "Accept-Charset"
			-- Character sets that are acceptable
			--| Example: Accept-Charset: utf-8

	header_accept_encoding:  STRING = "Accept-Encoding"
			-- Acceptable encodings. See HTTP compression.
			--| Example: Accept-Encoding: <compress | gzip | deflate | sdch | identity>

	header_accept_language:  STRING = "Accept-Language"
			-- Acceptable languages for response
			--| Example: Accept-Language: en-US

	header_authorization:  STRING = "Authorization"
			-- Authentication credentials for HTTP authentication
			--| Example: Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==

	header_cookie:  STRING = "Cookie"
			-- an HTTP cookie previously sent by the server with Set-Cookie (below)
			--| Example: Cookie: $Version=1; Skin=new;

	header_expect:  STRING = "Expect"
			-- Indicates that particular server behaviors are required by the client
			--| Example: Expect: 100-continue

	header_from:  STRING = "From"
			-- The email address of the user making the request
			--| Example: From: user@example.com

	header_host:  STRING = "Host"
			-- The domain name of the server (for virtual hosting), mandatory since HTTP/1.1
			--| Example: Host: en.wikipedia.org

	header_if_match:  STRING = "If-Match"
			-- Only perform the action if the client supplied entity matches the same entity on the server. This is mainly for methods like PUT to only update a resource if it has not been modified since the user last updated it.
			--| Example: If-Match: "737060cd8c284d8af7ad3082f209582d"

	header_if_modified_since:  STRING = "If-Modified-Since"
			-- Allows a 304 Not Modified to be returned if content is unchanged
			--| Example: If-Modified-Since: Sat, 29 Oct 1994 19:43:31 GMT

	header_if_none_match:  STRING = "If-None-Match"
			-- Allows a 304 Not Modified to be returned if content is unchanged, see HTTP ETag
			--| Example: If-None-Match: "737060cd8c284d8af7ad3082f209582d"

	header_if_range:  STRING = "If-Range"
			-- If the entity is unchanged, send me the part(s) that I am missing; otherwise, send me the entire new entity
			--| Example: If-Range: "737060cd8c284d8af7ad3082f209582d"

	header_if_unmodified_since:  STRING = "If-Unmodified-Since"
			-- Only send the response if the entity has not been modified since a specific time.
			--| Example: If-Unmodified-Since: Sat, 29 Oct 1994 19:43:31 GMT

	header_max_forwards:  STRING = "Max-Forwards"
			-- Limit the number of times the message can be forwarded through proxies or gateways.
			--| Example: Max-Forwards: 10

	header_proxy_authorization:  STRING = "Proxy-Authorization"
			-- Authorization credentials for connecting to a proxy.
			--| Example: Proxy-Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==

	header_range:  STRING = "Range"
			-- Request only part of an entity. Bytes are numbered from 0.
			--| Example: Range: bytes=500-999

	header_referer:  STRING = "Referer[sic]"
			-- This is the address of the previous web page from which a link to the currently requested page was followed. (The word “referrer” is misspelled in the RFC as well as in most implementations.)
			--| Example: Referer: http://en.wikipedia.org/wiki/Main_Page

	header_te:  STRING = "TE"
			-- The transfer encodings the user agent is willing to accept: the same values as for the response header Transfer-Encoding can be used, plus the "trailers" value (related to the "chunked" transfer method) to notify the server it accepts to receive additional headers (the trailers) after the last, zero-sized, chunk.
			--| Example: TE: trailers, deflate

	header_upgrade:  STRING = "Upgrade"
			-- Ask the server to upgrade to another protocol.
			--| Example: Upgrade: HTTP/2.0, SHTTP/1.3, IRC/6.9, RTA/x11

	header_user_agent:  STRING = "User-Agent"
			-- The user agent string of the user agent
			--| Example: User-Agent: Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)

feature -- Response header name

	header_accept_ranges: STRING = "Accept-Ranges"
			-- "Accept-Ranges"	What partial content range types this server supports
			--| Example: Accept-Ranges: bytes

	header_age: STRING = "Age"
			-- The age the object has been in a proxy cache in seconds
			--| Example: Age: 12

	header_allow: STRING = "Allow"
			-- Valid actions for a specified resource. To be used for a 405 Method not allowed
			--| Example: Allow: GET, HEAD

	header_content_encoding: STRING = "Content-Encoding"
			-- The type of encoding used on the data. See HTTP compression.
			--| Example: Content-Encoding: gzip

	header_content_language: STRING = "Content-Language"
			-- The language the content is in
			--| Example: Content-Language: da

	header_content_location: STRING = "Content-Location"
			-- An alternate location for the returned data
			--| Example: Content-Location: /index.htm

	header_content_disposition: STRING = "Content-Disposition"
			-- An opportunity to raise a "File Download" dialogue box for a known MIME type
			--| Example: Content-Disposition: attachment; filename=fname.ext

	header_content_range: STRING = "Content-Range"
			-- Where in a full body message this partial message belongs
			--| Example: Content-Range: bytes 21010-47021/47022

	header_etag: STRING = "ETag"
			-- An identifier for a specific version of a resource, often a message digest
			--| Example: ETag: "737060cd8c284d8af7ad3082f209582d"

	header_expires: STRING = "Expires"
			-- Gives the date/time after which the response is considered stale
			--| Example: Expires: Thu, 01 Dec 1994 16:00:00 GMT

	header_last_modified: STRING = "Last-Modified"
			-- The last modified date for the requested object, in RFC 2822 format
			--| Example: Last-Modified: Tue, 15 Nov 1994 12:45:26 GMT

	header_link: STRING = "Link"
			-- Used to express a typed relationship with another resource, where the relation type is defined by RFC 5988
			--| Example: Link: </feed>; rel="alternate"

	header_location: STRING = "Location"
			-- Used in redirection, or when a new resource has been created.
			--| Example: Location: http://www.w3.org/pub/WWW/People.html

	header_p3p: STRING = "P3P"
			-- This header is supposed to set P3P policy, in the form of P3P:CP="your_compact_policy". However, P3P did not take off,[5] most browsers have never fully implemented it, a lot of websites set this header with fake policy text, that was enough to fool browsers the existence of P3P policy and grant permissions for third party cookies.
			--| Example: P3P: CP="This is not a P3P policy! See http://www.google.com/support/accounts/bin/answer.py?hl=en&answer=151657 for more info."


	header_proxy_authenticate: STRING = "Proxy-Authenticate"
			-- Request authentication to access the proxy.
			--| Example: Proxy-Authenticate: Basic

	header_refresh: STRING = "Refresh"
			-- Used in redirection, or when a new resource has been created. This refresh redirects after 5 seconds. This is a proprietary, non-standard header extension introduced by Netscape and supported by most web browsers.
			--| Example: Refresh: 5; url=http://www.w3.org/pub/WWW/People.html

	header_retry_after: STRING = "Retry-After"
			-- If an entity is temporarily unavailable, this instructs the client to try again after a specified period of time.
			--| Example: Retry-After: 120

	header_server: STRING = "Server"
			-- A name for the server
			--| Example: Server: Apache/1.3.27 (Unix) (Red-Hat/Linux)

	header_set_cookie: STRING = "Set-Cookie"
			-- an HTTP cookie
			--| Example: Set-Cookie: UserID=JohnDoe; Max-Age=3600; Version=1

	header_strict_transport_security: STRING = "Strict-Transport-Security"
			-- A HSTS Policy informing the HTTP client how long to cache the HTTPS only policy and whether this applies to subdomains.
			--| Example: Strict-Transport-Security: max-age=16070400; includeSubDomains

	header_trailer: STRING = "Trailer"
			-- The Trailer general field value indicates that the given set of header fields is present in the trailer of a message encoded with chunked transfer-coding.
			--| Example: Trailer: Max-Forwards

	header_transfer_encoding: STRING = "Transfer-Encoding"
			-- The form of encoding used to safely transfer the entity to the user. Currently defined methods are: chunked, compress, deflate, gzip, identity.
			--| Example: Transfer-Encoding: chunked

	header_vary: STRING = "Vary"
			-- Tells downstream proxies how to match future request headers to decide whether the cached response
			-- can be used rather than requesting a fresh one from the origin server.
			--| Example: Vary: *

	header_www_authenticate: STRING = "WWW-Authenticate"
			-- Indicates the authentication scheme that should be used to access the requested entity.
			--| Example: WWW-Authenticate: Basic

feature -- Cross-Origin Resource Sharing

	header_access_control_allow_origin: STRING = "Access-Control-Allow-Origin"
			-- Indicates whether a resource can be shared based by returning
			-- the value of the Origin request header in the response.
			-- | Example: Access-Control-Allow-Origin: http://example.org

	header_access_control_allow_methods: STRING = "Access-Control-Allow-Methods"
			-- Indicates, as part of the response to a preflight request,
			-- which methods can be used during the actual request.
			-- | Example: Access-Control-Allow-Methods: PUT, DELETE

	header_access_control_allow_headers: STRING = "Access-Control-Allow-Headers"
			-- Indicates, as part of the response to a preflight request,
			-- which header field names can be used during the actual request.
			-- | Example: Access-Control-Allow-Headers: Authorization

feature -- Request or Response header name

	header_cache_control:  STRING = "Cache-Control"
			-- Request: Used to specify directives that MUST be obeyed by all caching mechanisms along the request/response chain
			-- Response: Tells all caching mechanisms from server to client whether they may cache this object. It is measured in seconds
			--| Request example: Cache-Control: no-cache
			--| Response example: Cache-Control: max-age=3600

	header_connection: STRING = "Connection"
			-- Request: What type of connection the user-agent would prefer
			-- Response: Options that are desired for the connection[4]
			--| Example: Connection: close

	header_content_length:  STRING = "Content-Length"
			-- Request: The length of the request body in octets (8-bit bytes)
			-- Response: The length of the response body in octets (8-bit bytes)
			--| Example: Content-Length: 348

	header_content_md5:  STRING = "Content-MD5"
			-- Request: A Base64-encoded binary MD5 sum of the content of the request body
			-- Response: A Base64-encoded binary MD5 sum of the content of the response
			--| Example: Content-MD5: Q2hlY2sgSW50ZWdyaXR5IQ==

	header_content_type:  STRING = "Content-Type"
			-- Request: The mime type of the body of the request (used with POST and PUT requests)
			-- Response : The mime type of this content
			--| Request example: Content-Type: application/x-www-form-urlencoded
			--| Response example: Content-Type: text/html; charset=utf-8

	header_date:  STRING = "Date"
			-- The date and time that the message was sent
			--| Example: Date: Tue, 15 Nov 1994 08:12:31 GMT

	header_pragma:  STRING = "Pragma"
			-- Implementation-specific headers that may have various effects anywhere along the request-response chain.
			--| Example: Pragma: no-cache

	header_status:  STRING = "Status"
			-- CGI program can use this to return the HTTP status code to the client.	

	header_via:  STRING = "Via"
			-- Request: Informs the server of proxies through which the request was sent.
			-- Response: Informs the client of proxies through which the response was sent.
			--| Example: Via: 1.0 fred, 1.1 nowhere.com (Apache/1.1)

	header_warning:  STRING = "Warning"
			-- A general warning about possible problems with the entity body.
			--| Example: Warning: 199 Miscellaneous warning

feature -- MIME related

	header_content_transfer_encoding: STRING = "Content-Transfer-Encoding"

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
