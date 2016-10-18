note
	description: "Summary description for {WEB_SOCKET_HANDSHAKE_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_HANDSHAKE_DATA


create
	make

feature {NONE} -- Initialization

	make
		do
			reset
		end


	reset
		do
			has_error := False
			version := Void
			create method.make_empty
			create uri.make_empty
			create request_header.make_empty
			create request_header_map.make (10)
		end


feature -- Access


	request_header: STRING
			-- Header' source

	request_header_map: HASH_TABLE [STRING, STRING]
			-- Contains key:value of the header

	has_error: BOOLEAN
			-- Error occurred during `analyze_request_message'

	method: STRING
			-- http verb

	uri: STRING
			--  http endpoint

	version: detachable STRING
			--  http_version

feature -- Change Element

	set_method (a_method: STRING)
			-- Set `method' with `a_method'
		do
			method := a_method
		ensure
			method_set: method = a_method
		end


	set_version (a_version: STRING)
			-- Set `version' with `a_version'
		do
			version := a_version
		ensure
			version_set: attached version as l_version implies l_version = a_version
		end

	mark_error
		do
			has_error := True
		end

	set_request_header (a_header: STRING)
			-- Set `request_header' with `a_header'
		do
			request_header := a_header
		ensure
			request_header_set: request_header = a_header
		end

	put_header (a_key: STRING; a_value : STRING)
		do
			 request_header_map.put (a_value, a_key)
		end
end
