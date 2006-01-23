indexing
	description: "Class which returns the name the user entered, in upper case."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SAMPLE

inherit
	CGI_INTERFACE

create
	make

feature -- Access

	Debug_mode: BOOLEAN is True
			-- Should exception trace be displayed in case a crash occurs?

	return_message: HTML_PAGE
			-- Message which is sent back to the browser.

feature -- Basic Operations

	execute is
			-- Perform form entries processing, and send back the answer
			-- to the browser.
		do
			if field_defined ("name") then
				create return_message.make
					-- Add the <head> and <title> tags.
				return_message.add_html_code ("<HEAD><TITLE>EiffelWEB Example</TITLE></HEAD>")
					-- Display the name entered in the body of the page.
				return_message.add_html_code ("<BODY><H1>Hello " + text_field_value ("name") +
					"</H1><P>You have just processed a web form using EiffelWEB!</P></BODY>")
			end
			response_header.generate_text_header
			response_header.send_to_browser
			response_header.Output.put_string (return_message.out)
		rescue
			io.error.putstring ("crash in `compute' from DOWNLOAD_INTERACTION%N")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SAMPLE
