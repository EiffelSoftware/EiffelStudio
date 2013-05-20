note
	description: "Summary description for {HTTP_CONNECTION_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_CONNECTION_HANDLER

inherit
	HTTP_CONNECTION_HANDLER

create
	make

feature -- Request processing

	process_request (a_handler: HTTP_CONNECTION_HANDLER; a_socket: TCP_STREAM_SOCKET)
			-- Process request ...
		local
			a_method: STRING
		do
			a_method := a_handler.method

			if a_method.is_equal (Get) then
				execute_get_request (a_handler.uri, a_handler.request_header_map, a_handler.request_header, a_socket)
			elseif a_method.is_equal (Post) then
				execute_post_request (a_handler.uri, a_handler.request_header_map, a_handler.request_header, a_socket)
			elseif a_method.is_equal (Put) then
			elseif a_method.is_equal (Options) then
			elseif a_method.is_equal (Head) then
			elseif a_method.is_equal (Delete) then
			elseif a_method.is_equal (Trace) then
			elseif a_method.is_equal (Connect) then
			else
				debug
					print ("Method [" + a_method + "] not supported")
				end
			end
		end

	execute_get_request (a_uri: STRING; a_headers_map: HASH_TABLE [STRING, STRING]; a_headers_text: STRING; a_socket: TCP_STREAM_SOCKET)
		local
			l_http_request : HTTP_REQUEST_HANDLER
		do
			create {GET_REQUEST_HANDLER} l_http_request.make (a_socket)
			l_http_request.set_uri (a_uri)
			l_http_request.process
		end

	execute_post_request (a_uri: STRING; a_headers_map: HASH_TABLE [STRING, STRING]; a_headers_text: STRING; a_socket: TCP_STREAM_SOCKET)
		local
			l_http_request : HTTP_REQUEST_HANDLER
		do
			check not_yet_implemented: False end
			create {POST_REQUEST_HANDLER} l_http_request.make (a_socket)
			l_http_request.set_uri (a_uri)
			l_http_request.process
		end

end
