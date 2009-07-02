note
	description:
		"Files accessed via HTTP"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class XRPC_PROTOCOL

inherit
	HTTP_PROTOCOL
		rename
			make as make_http_protocol
		redefine
			initiate_transfer
		end

create
	make

feature {NONE} -- Initialization

	make (a_address: like address; a_xml: READABLE_STRING_8)
			-- Initializes the XML-RPC protocol with a request URL and content.
			--
			-- `a_address': URL to send request to.
			-- `a_xml': XML-RPC method call XML.
		require
			a_address_attached: attached a_address
			a_xml_attached: attached a_xml
			not_a_xml_is_empty: not a_xml.is_empty
		do
			create xml.make_from_string (a_xml)
			make_http_protocol (a_address)
			set_read_mode
		ensure
			address_set: address ~ a_address
			xml_set: xml.same_string (a_xml)
			read_mode: read_mode
		end

feature -- Access

	handler_uri: STRING
			-- XML-RPC URI, which does not have to be the URL.
		do
			if attached internal_handler_uri as l_result then
				Result := l_result
			else
				create Result.make (20)
				Result.append_character ('/')
				Result.append (address.path)
				internal_handler_uri := Result
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

	user_agent: STRING
			-- XML-RPC user agent.
		local
			l_count: INTEGER
			i: INTEGER
		do
			if attached internal_user_agent as l_result then
				Result := l_result
			else
				Result := (create {ARGUMENTS}).argument (0)
				l_count := Result.count
				i := Result.last_index_of (operating_environment.directory_separator, l_count)
				if i > 0 and i < l_count then
					Result.keep_tail (l_count - i)
				end
				Result.append_character ('/')
				Result.append ({XRPC_CONSTANTS}.library_version_string)
				internal_user_agent := Result
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

	xml: STRING
			-- XML-RPC method call XML.

feature -- Element change

	set_handler_uri (a_uri: READABLE_STRING_8)
			-- Sets the server's XML-RPC handler address.
			--
			-- `a_uri': A URI on the server that handles XML-RPC requests.
		require
			a_agent_attached: attached a_uri
			not_a_agent_is_empty: not a_uri.is_empty
		do
			create internal_handler_uri.make_from_string (a_uri)
		ensure
			handler_uri_set: handler_uri.same_string (a_uri)
		end

	set_user_agent (a_agent: READABLE_STRING_8)
			-- Sets a request user agent.
			--
			-- `a_agent': A user agent name.
		require
			a_agent_attached: attached a_agent
			not_a_agent_is_empty: not a_agent.is_empty
		do
			create internal_user_agent.make_from_string (a_agent)
		ensure
			user_agent_set: user_agent.same_string (a_agent)
		end

feature {NONE} -- Query

	http_request: STRING
			-- Creates a HTTP XML-RPC request string, including all required XML-RPC headers.
		local
			l_xml: like xml
			l_count: INTEGER
		do
			l_xml := xml.twin
			l_xml.replace_substring_all ("%N", http_end_of_header_line)
			l_count := l_xml.count

			create Result.make (256 + l_count)
			Result.append (http_post_command)
			Result.append_character (' ')
			Result.append (handler_uri)
			Result.append_character (' ')
			Result.append (http_version)
			Result.append (http_end_of_header_line)

			Result.append (http_user_agent_header)
			Result.append (http_header_separator)
			Result.append (user_agent)
			Result.append (http_end_of_header_line)

			Result.append (http_host_header)
			Result.append (http_header_separator)
			Result.append (address.host)
			Result.append (http_end_of_header_line)

			Result.append (http_content_type_header)
			Result.append (http_header_separator)
			Result.append (once "text/xml")
			Result.append (http_end_of_header_line)

			Result.append (http_content_length_header)
			Result.append (http_header_separator)
			Result.append_integer (l_count)

			Result.append (http_end_of_header_line)
			Result.append (http_end_of_header_line)
			Result.append (l_xml)

			Result.append (http_end_of_command)
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

feature -- Basic operations

	initiate_transfer
			-- <Precursor>
		local
			l_socket: like main_socket
		do
			if not error then
				l_socket := main_socket
				check l_socket_attached: l_socket /= Void end
				l_socket.put_string (http_request)
				debug ("eiffelnet")
					Io.error.put_string (http_request)
				end
				get_headers
				transfer_initiated := True
				is_packet_pending := True
			end
		rescue
			error_code := transfer_failed
		end

feature {NONE} -- Constants

	http_post_command: STRING = "POST"
	http_user_agent_header: STRING = "User-Agent"
	http_content_type_header: STRING = "Content-Type"
	http_content_length_header: STRING = "Content-Length"
	http_header_separator: STRING = ": "

feature {NONE} -- Implementation: Internal cache

	internal_handler_uri: detachable like handler_uri
			-- Cached version of `handler_uri'.
			-- Note: Do not use directly!

	internal_user_agent: detachable like user_agent
			-- Cached version of `user_agent'.
			-- Note: Do not use directly!

invariant
	xml_attached: attached xml
	not_xml_is_empty: not xml.is_empty

;note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HTTP_PROTOCOL

