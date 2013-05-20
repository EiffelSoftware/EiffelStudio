note
	description: "Summary description for {HTTP_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CONSTANTS

feature

	http_version_1_1: STRING = "HTTP/1.1"
	http_version_1_0: STRING = "HTTP/1.0"
	crlf: STRING = "%/13/%/10/"

feature -- Status codes

	-- 1xx Informational -Request received, continuing process
	Continue : STRING = "100"
	Switching_Protocols : STRING = "101"


	-- 2xx Success - The action was successfully received, understood, and accepted
	Ok: STRING = "200"
	Created : STRING = "201"
	Accepted : STRING = "202"
	Non_Authoritative_Information : STRING = "203"
	No_Content : STRING = "204"
	Reset_Content : STRING = "205"
	Parcial_Content : STRING = "206"


	-- 3xx Redirection - Further Action must be taken in order to complete the request
	Multiple_Choices : STRING = "300"
	Moved_Permanently: STRING = "301"
	Found : STRING = "302"
	See_Other	: STRING = "303"
	Not_Modified : STRING  = "304"
	Use_Proxy	: STRING = "305"
	Temporary_Redirect : STRING = "307"


	--4xx Client Error - The request contains bad syntax or cannot be fulfilled
	Bad_Request : STRING = "400"
	Unauthorized : STRING = "401"
	Payment_Required : STRING = "402"
	Forbidden : STRING = "403"
	Not_Found : STRING = "404"
	Method_Not_Allowed : STRING = "405"
	Not_Acceptable : STRING = "406"
	Proxy_Authentication_Required : STRING = "407"
	Request_Time_out	: STRING = "408"
	Conflict : STRING = "409"
	Gone : STRING = "410"
	Length_Required : STRING = "411"
	Precondition_Failed : STRING = "412"
	Request_Entity_Too_Large : STRING = "413"
	Request_URI_Too_Large : STRING = "414"
	Unsupported_Media_Type : STRING = "415"
	Requested_range_not_satisfiable : STRING = "416"
	Expectation_Failed : STRING = "417"


	--5xx Server Error - The server failed to fulfill an apparently valid request
	server_error: STRING = "500"
	Internal_Server_Error : STRING = "500"
	Not_Implemented : STRING = "501"
	Bad_Gateway : STRING = "502"
	Service_Unavailable : STRING = "503"
	Gateway_Time_out : STRING = "504"
	HTTP_Version_not_supported : STRING = "505"


	-- messages
	ok_message: STRING = "OK"
	continue_message : STRING = "Continue"
	not_found_message: STRING = "URI not found"
	not_implemented_message: STRING = "Not Implemented"

feature -- content types

	text_html: STRING = "text/html"

feature -- General Header Fields

	-- There are a few header fields which have general applicability for both request and response messages,
	-- but which do not apply to the entity being transferred.
	-- These header fields apply only to the message being transmitted.

	Cache_control 		: STRING = "Cache-Control"
	Connection    		: STRING = "Connection"
	Date          		: STRING = "Date"
	Pragma		  		: STRING = "PRAGMA"
	Trailer       		: STRING = "Trailer"
	Transfer_encoding 	: STRING = "Transfer-Encoding"
	Upgrade           	: STRING = "Upgrade"
	Via               	: STRING = "Via"
	Warning           	: STRING = "Warning"


feature -- Request Header
	Accept	 			: STRING = "Accept"
	Accept_charset 		: STRING = "Accept-Charset"
	Accept_encoding 	: STRING = "Accept-Encoding"
	Accept_language 	: STRING = "Accept-Language"
	Authorization 		: STRING =  "Authorization"
	Expect 		  		: STRING = "Expect"
	From_header   		: STRING = "From"
	Host				: STRING = "Host"
	If_match			: STRING = "If-Match"
	If_modified_since 	: STRING = "If-Modified-Since"
	If_none_match		: STRING = "If-None-Match"
	If_range			: STRING = "If-Range"
	If_unmodified_since : STRING = "If-Unmodified-Since"
	Max_forwards 		: STRING = "Max-Forwards"
	Proxy_authorization	: STRING = "Proxy-Authorization"
	Range				: STRING = "Range"
    Referer             : STRING = "Referrer"
    TE					: STRING = "TE"
    User_agent 			: STRING = "User-Agent"


feature -- Entity Header

	Allow 				: STRING = "Allow"
	Content_encoding 	: STRING = "Content-Encoding"
	Content_language 	: STRING = "Content-Language"
	Content_length	 	: STRING = "Content-Length"
	Content_location 	: STRING = "Content-Location"
	Content_MD5			: STRING = "Content-MD5"
	Content_range 		: STRING = "Content-Range"
	Content_type		: STRING = "Content-Type"
	Expires				: STRING = "Expires"
	Last_modified		: STRING = "Last-Modified"


feature -- Http Method
	Options : STRING = "OPTIONS"
	Get : STRING = "GET"
	Head : STRING = "HEAD"
	Post : STRING = "POST"
	Put  : STRING = "PUT"
	Delete : STRING = "DELETE"
	Trace : STRING = "TRACE"
	Connect : STRING = "CONNECT"
note
	copyright: "2011-2011, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
