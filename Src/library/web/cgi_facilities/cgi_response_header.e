indexing
	description: "Class which deals with the output header"
	date: "$Date$"
	revision: "$Revision$"

class
	CGI_RESPONSE_HEADER

inherit

	CGI_COMMON_STATUS_TYPES

	CGI_IN_AND_OUT

feature -- Basic Operations

	send_to_browser is
			-- Send the header to browser.
			-- This operation has to be performed before
			-- you send anything else to the browser.
		require
			header_exists: header /= Void
			not_yet_sent: not is_sent
		do
			output.put_string (header + "%N%N")
			is_sent := TRUE
		ensure
			header_sent: is_sent
		end

	generate_text_header is
			-- Generate header for a future text (generally HTML) 
			-- you are going to send.
		require
			header_void: header = Void  
			not_yet_sent: not is_sent
		do
			header := "Content-type: text/html"
			is_complete_header := TRUE
		end

	generate_http_redirection (an_url: STRING;is_secure: BOOLEAN) is	
			-- Generate CGI secure re-direction, via 'https' protocol if secure,
			--	via http if not.
		require
			not_yet_sent: not is_sent
			url_not_void_and_not_empty: an_url /= Void and then not an_url.is_empty
			header_void: header = Void  
		do
			if is_secure then
				header := "location:https://" + an_url
			else
				header := "location:http://" + an_url
			end
		end

	return_status (a_status: INTEGER;a_message: STRING) is
				-- Set the status of the user request.
				-- A complete list of status may be found at : 
				-- http://www.w3.org/hypertext/WWW/protocols/HTTP/HTRESP.html
				-- See also CGI_COMMON_STATUS_TYPES
	 	require
	 		not_yet_sent: not is_sent
			message_exists: a_message /= Void
			header_void: header /= Void  
		do
			header.append ("%NStatus: " + a_status.out + " " + a_message)
		end	

	reinitialize_header is
			-- Re-initialize header.
			-- May be called if the header built sor far 
			-- has to be re-build from scratch.
		require
			not_yet_sent: not is_sent
		do
			header := Void
			is_complete_header := FALSE
		ensure
			reinitialized: header = Void and not is_complete_header and not is_sent
		end

feature {CGI_ERROR_HANDLING} -- Exception handling

	send_trace (s: STRING) is
			-- Send the exception trace 's' to the browser, when
			-- possible ( most cases ).
		do
			if not is_sent then
				reinitialize_header
				generate_text_header
			end
			if s = Void or else s.is_empty then
				output.put_string ("No trace available")
			else
				output.put_string ("<PRE>" + s + "</PRE>")
			end
			is_sent := TRUE
		end

feature -- Advanced Settings

	set_expiration (a_date: STRING) is
			-- Set the expiration date before which the page needs to be 
			-- refreshed
		 require
			not_yet_sent: not is_sent
			date_exists: a_date /= Void
			header_exists: header /= Void
			header_is_complete: is_complete_header  
		do
			header.append ("%NExpires: " + a_date)
		end

	set_pragma (a_pragma: STRING) is
			-- Set the pragma which indicates whether
			-- the page accepts to be cached
			-- or not. An example of pragam is "no-cache"
		 require
			not_yet_sent: not is_sent
			pragma_exists: a_pragma /= Void
			header_exists: header /= Void
			header_is_complete: is_complete_header  
		do
			header.append ("%NPragma: " + a_pragma)
		end	

	set_cookie (key, value, expiration, path, domain, secure: STRING) is
			-- Set a cookie on the client's machine
			-- with key 'key' and value 'value'.
		require
			not_yet_sent: not is_sent
			make_sense: (key /= Void and value /= Void) and then 
						(not key.is_empty and not value.is_empty)
			header_exists: header /= Void
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
		
end -- class CGI_RESPONSE_HEADER


--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

