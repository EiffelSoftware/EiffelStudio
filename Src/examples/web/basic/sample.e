indexing
	description: "Class which returns the name the user entered, in upper case."

class
	SAMPLE

inherit
	CGI_INTERFACE

create
	make

feature -- Access

	Debug_mode: BOOLEAN is True
			-- Should exception trace be displayed in case a crash occurs?

	reponse_header: CGI_RESPONSE_HEADER
			-- HTTP response header.

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
				return_message.add_html_code ("<BODY><H1>Hello " + text_field_value ("name") + "</H1><P>You have just processed a web form using EiffelWEB!</P></BODY>")
			end
			response_header.generate_text_header
			response_header.send_to_browser
			response_header.Output.put_string (return_message.out)
		rescue
			io.error.putstring ("crash in `compute' from DOWNLOAD_INTERACTION%N")
		end

	random_file_name: STRING is
			-- Return a file name, which is going to
			-- be unique.
		local
			da: DATE_TIME
		do
			Create da.make_now
			Result := da.date.compact_date.out
			Result.append("_")
			Result.append(da.time.compact_time.out)
			Result.append("_"+da.time.fractional_second.out+".html")
		ensure
			not_void: Result /= Void
		end

end -- class SAMPLE
