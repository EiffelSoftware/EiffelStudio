note
	description: "[
		Summary description for {SERVLET_HANDLER}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	SERVLET_HANDLER

create
	make

feature -- Implementation

	make
		do
			create {HASH_TABLE[STATELESS_SERVLET, STRING]} stateless_servlets.make (10)
		end

	stateless_servlets: TABLE [STATELESS_SERVLET, STRING]

	process (a_message: STRING; a_socket: NETWORK_STREAM_SOCKET)
			-- Processes an incoming request and sends it back to the server
		local
			request: REQUEST
		do
			request := build_request (a_message)
	       	a_socket.independent_store (handle_request(request))
	       	a_socket.close
		end

	build_request (message: STRING): REQUEST
			-- Transforms a plain text message into a {REQUEST} object
			-- for further use in he servlet.
			-- Session is retrieved and set
		do
			-- TODO: Proper session creation, management etc.
			create Result.make (extract_web_app_name (message).as_upper + "_SERVLET", create {SESSION})
		end

	handle_request (request: REQUEST): RESPONSE
			-- Routes the request to the appropriate controller
		local
			servlet: detachable SERVLET
		do
			servlet := find_servlet (request)
			if attached servlet then
				Result := servlet.handle_request (request)
			else
				create Result.make
				Result.text := "Application not found: %"" + request.file_identifier + "%""
			end
		end


	find_servlet (request: REQUEST): detachable SERVLET
			-- Searches for the servlet requested by `request'
			-- 1. Stateless servlet?
			-- 2. Servlet in session?
			-- 3. If not found := Void
		do
			if attached {STATELESS_SERVLET} stateless_servlets [request.file_identifier] as servlet then
				Result := servlet
			else
				Result := request.session.get_stateful_servlet
			end
		end

	extract_web_app_name (message: STRING): STRING
			-- Extracts the webapp name from the get-parameter.
		do
			Result := message.substring (16, message.count)
			Result := Result.substring (1, Result.substring_index (" ", 1)-1)
		end

end
