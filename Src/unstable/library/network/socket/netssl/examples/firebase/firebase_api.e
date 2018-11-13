note
	description: "Simple example Firebase Database REST API"
	date: "$Date$"
	revision: "$Revision$"
	EIS:"name=REST API", "src=https://firebase.google.com/docs/reference/rest/database/", "protocol=URI"

class
	FIREBASE_API

inherit

	INET_ADDRESS_FACTORY

create
	make

feature -- Initialization

	make
		local
			address: detachable INET_ADDRESS
		do
			auth := ""
			address := create_from_name (host)
			if address = Void then
				io.put_string ("Unknown host " + host)
				io.put_new_line
				has_error := True
			else
					-- Create the socket connection to the Echo Server.
				create socket.make_client_by_address_and_port (address, port)
					-- Connect to the Server
				if attached socket as l_socket then
					l_socket.connect
				else
					has_error := True
				end
			end
		end

feature -- API

	get (a_path: detachable READABLE_STRING_32): detachable STRING
			-- Reading Data
		require
			not_error: not has_error
		do
			Result := do_method (a_path, "GET", Void)
		end

	put (a_path: detachable READABLE_STRING_32; a_body: STRING): detachable STRING
			-- Put
		require
			not_error: not has_error
		do
			Result := do_method (a_path, "PUT", a_body)
		end

	post (a_path: detachable READABLE_STRING_32; a_body: STRING): detachable STRING
			-- Post
		require
			not_error: not has_error
		do
			Result := do_method (a_path, "POST", a_body)
		end

	patch (a_path: detachable READABLE_STRING_32; a_body: STRING): detachable STRING
			-- Patch
		require
			not_error: not has_error
		do
			Result := do_method (a_path, "PATCH", a_body)
		end

	delete (a_path: detachable READABLE_STRING_32): detachable STRING
			-- Delete
		require
			not_error: not has_error
		do
			Result := do_method (a_path, "DELETE", Void)
		end

feature -- Access

	host: STRING = "[PROJECT_ID].firebaseio.com"
			-- Update to use your [PROJECT-ID].

	port: INTEGER = 443

	has_error: BOOLEAN

	auth: READABLE_STRING_32

	Firebase_api_json_extension: STRING_32 = ".json"

feature -- Close

	close
			-- Close connection
		require
			not_error: not has_error
		do
			if attached socket as l_socket then
				l_socket.close
			end
		end

feature {NONE} -- Implementation

	socket: detachable SSL_NETWORK_STREAM_SOCKET

	new_uri (a_path: detachable READABLE_STRING_32): STRING_32
			-- new uri (host + a_path)
		local
			l_path: STRING_32
		do
			if attached a_path as ll_path then
				l_path := ll_path
			else
				l_path := ""
			end
			if not l_path.is_empty and then not (l_path.starts_with ("/") or l_path.starts_with ("\")) then
				l_path.prepend ("/")
			end
			Result := l_path + Firebase_api_json_extension
			if not auth.is_empty then
				Result.append ("?auth=" + auth)
			end
		end

	do_method (a_path: detachable READABLE_STRING_32; a_method: STRING; a_body: detachable STRING): detachable STRING
		local
			l_request: HTTP_REQUEST_PARSER
			l_message: STRING
			l_utf8: UTF_CONVERTER
			l_result: STRING
		do
			if attached socket as l_socket then
				create l_message.make_from_string (a_method + " ")
				l_message.append (new_uri (a_path))
				l_message.append (" HTTP/1.1")
				l_message.append ("%R%N")
				l_message.append ("Host: " + host)
				l_message.append ("%R%N")
				l_message.append ("Cache-Control: max-age=0")
				l_message.append ("%R%N")
				l_message.append ("Accept:*/*;q=0.8")
				l_message.append ("%R%N")
				l_message.append ("Connection: keep-alive")
				l_message.append ("%R%N")
				if attached a_body as l_body then
					l_message.append ("Content-Length: " + l_body.count.out)
					l_message.append ("%R%N")
				end
				l_message.append ("Content-Type: application/json")
				l_message.append ("%R%N")
				l_message.append ("%R%N")
				if attached a_body as l_body then
					l_message.append (a_body)
				end
				l_socket.put_string (l_message)
				create l_request.make
				l_request.parse (l_socket)
				if attached l_request.header_map.item ("Content-Length") as l_length and then l_length.is_integer then
					l_request.read_response (l_length.to_integer, l_socket)
					create l_result.make_empty
					Result := l_request.header
					Result.append ("%N")
					Result.append (l_utf8.escaped_utf_32_string_to_utf_8_string_8 (l_request.last_string))
				end
			end
		end

end
