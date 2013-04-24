note
	description: "Class which deals with the output header"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CGI_RESPONSE_HEADER

inherit
	CGI_COMMON_STATUS_TYPES

	CGI_IN_AND_OUT

create
	make

feature {NONE} -- Initialization

	make
		do
			create header.make_empty
		end

feature -- Basic Operations

	send_to_browser
			-- Send the header to browser.
			-- This operation has to be performed before
			-- you send anything else to the browser.
		require
			not_yet_sent: not is_sent
			header_is_complete: is_complete_header
		do
			output.put_string (header + "%N%N")
			is_sent := True
		ensure
			header_sent: is_sent
		end

	generate_text_header
			-- Generate header for a future text (generally HTML)
			-- you are going to send.
		require
			not_yet_sent: not is_sent
			header_not_complete: not is_complete_header
		do
			header := "Content-type: text/html"
			is_complete_header := True
		end

	generate_http_redirection (an_url: STRING;is_secure: BOOLEAN)
			-- Generate CGI secure re-direction, via 'https' protocol if secure,
			--	via http if not.
		require
			not_yet_sent: not is_sent
			url_not_void_and_not_empty: an_url /= Void and then not an_url.is_empty
			header_not_complete: not is_complete_header
		do
			if is_secure then
				header := "location:https://" + an_url
			else
				header := "location:http://" + an_url
			end
		end

	return_status (a_status: INTEGER;a_message: STRING)
				-- Set the status of the user request.
				-- A complete list of status may be found at :
				-- http://www.w3.org/hypertext/WWW/protocols/HTTP/HTRESP.html
				-- See also CGI_COMMON_STATUS_TYPES
	 	require
	 		not_yet_sent: not is_sent
			message_exists: a_message /= Void
			header_is_complete: is_complete_header
		do
			header.append ("%NStatus: " + a_status.out + " " + a_message)
		end

	reinitialize_header
			-- Re-initialize header.
			-- May be called if the header built sor far
			-- has to be re-build from scratch.
		require
			not_yet_sent: not is_sent
		do
			is_complete_header := False
		ensure
			reinitialized: not is_complete_header and not is_sent
		end

feature {CGI_ERROR_HANDLING} -- Exception handling

	send_trace (s: detachable STRING)
			-- Send the exception trace 's' to the browser, when
			-- possible ( most cases ).
		do
			if not is_sent then
				reinitialize_header
				generate_text_header
				send_to_browser
			end
			if s = Void or else s.is_empty then
				output.put_string ("No trace available")
			else
				output.put_string ("<PRE>" + s + "</PRE>")
			end
			is_sent := True
		end

feature -- Advanced Settings

	set_expiration (a_date: STRING)
			-- Set the expiration date before which the page needs to be
			-- refreshed
		 require
			not_yet_sent: not is_sent
			date_exists: a_date /= Void
			header_is_complete: is_complete_header
		do
			header.append ("%NExpires: " + a_date)
		end

	set_pragma (a_pragma: STRING)
			-- Set the pragma which indicates whether
			-- the page accepts to be cached
			-- or not. An example of pragam is "no-cache"
		 require
			not_yet_sent: not is_sent
			pragma_exists: a_pragma /= Void
			header_is_complete: is_complete_header
		do
			header.append ("%NPragma: " + a_pragma)
		end

	set_cookie (key, value: STRING; expiration, path, domain, secure: detachable STRING)
			-- Set a cookie on the client's machine
			-- with key 'key' and value 'value'.
		require
			not_yet_sent: not is_sent
			make_sense: (key /= Void and value /= Void) and then
						(not key.is_empty and not value.is_empty)
			header_is_complete: is_complete_header
		local
			s: STRING
		do
			s := "%NSet-Cookie:" + key + "=" + value
			if expiration /= Void then
				s.append (";expires=" + expiration)
			end
			if path /= Void then
				s.append (";path=" + path)
			end
			if domain /= Void then
				s.append (";domain=" + domain)
			end
			if secure /= Void then
				s.append (";secure=" + secure)
			end
			header.append (s)
		end

feature -- Access

	header: STRING
			-- Message Header which will be returned to the
			-- the browser.

	is_sent: BOOLEAN
			-- Is current header sent to the browser ?

	is_complete_header: BOOLEAN
			-- Is Current header a complete header ?

invariant
	header_not_void: header /= Void
	header_not_empty: is_complete_header implies not header.is_empty

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CGI_RESPONSE_HEADER
