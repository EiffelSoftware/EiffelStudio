indexing
	description: "Thanks form Processing"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	<FL_CLASS_NAME>

inherit
	SCRIPT
		redefine
			load_resources
		end

creation
	make

feature -- Basic Operations

	check_fields is
			-- Check that the users entered valid entries
		do
			entries_checked := TRUE
		end

	load_resources is
			-- Load xml source.
		local
			fi: PLAIN_TEXT_FILE
		do
			cgi_handler.text_field_value("contactname")
		end	
	
	process is
			-- Terminate the sale process.
		local
			s: STRING
		do

		end

	reply_browser is
			-- Re-direct the browser to the 'index' page.
		do
			response_header.generate_http_redirection(cgi_handler.text_field_value("index"), FALSE)
			response_header.send_to_browser
		end
			
feature -- Implementation

end -- class THANKS
