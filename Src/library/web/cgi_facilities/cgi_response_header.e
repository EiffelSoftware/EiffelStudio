indexing
	description: "Class which deals with the output header"
	author: "pascalf"
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
		do
			output.put_string(header+"%N%N")
		end

	generate_text_header is
			-- Generate header for a future text (generally HTML) 
			-- you are going to send.
		require
			header_void: header = Void  
		do
			header := "Content-type: text/html"
			is_complete_header := TRUE
		end

	generate_http_redirection(an_url: STRING;is_secure: BOOLEAN) is	
			-- Generate CGI secure re-direction, via 'https' protocol if secure,
			--	via http if not.
		require
			url_not_void: an_url /= Void
			header_void: header = Void  
		do
			if is_secure then
				header := "location:https://"+an_url
			else
				header := "location:http://"+an_url
			end
		end

	return_status(a_status: INTEGER;a_message: STRING) is
				-- Set the status of the user request.
				-- A complete list of status may be found at : 
				-- http://www.w3.org/hypertext/WWW/protocols/HTTP/HTRESP.html
				-- See also CGI_COMMON_STATUS_TYPES
	 	require
			message_exists: a_message /= Void
			header_void: header = Void  
		do
			header.append("%NStatus: "+a_status.out+" "+a_message)
		end			

feature -- Advanced Settings

	set_expiration(a_date: STRING) is
			-- Set the expiration date before which the page needs to be 
			-- refreshed
		 require
			date_exists: a_date /= Void
			header_exists: header /= Void
			header_is_complete: is_complete_header  
		do
			header.append("%NExpires: "+a_date)
		end

	set_pragma(a_pragma: STRING) is
			-- Set the pragma which indicates whether the page accepts to be cached
			-- or not. An example of pragam is "no-cache"
		 require
			pragma_exists: a_pragma /= Void
			header_exists: header /= Void
			header_is_complete: is_complete_header  
		do
			header.append("%NPragma: "+a_pragma)
		end	

	set_cookie(key,value,expiration,path,domain,secure: STRING) is
			-- Set a cookie on the client's machine
			-- with key 'key' and value 'value'.
		require
			make_sense: key /= Void and value /= Void
			header_exists: header /= Void
			header_is_complete: is_complete_header  
		local
			s: STRING
		do
			s := "%NSet-Cookie:"+key+"="+value
			if expiration /= Void then
				s.append(";expires="+expiration)
			end
			if path /= Void then
				s.append(";path="+path)
			end
			if domain /= Void then
				s.append(";domain="+domain)
			end
			if secure /= Void then
				s.append(";secure="+secure)
			end
			header.append(s)			
		end

feature -- Implementation

	header: STRING
			-- Message Header which will be returned to the 
			-- the browser.

	is_complete_header: BOOLEAN
			-- IS Current header a complete header ?
		
end -- class CGI_RESPONSE_HEADER
