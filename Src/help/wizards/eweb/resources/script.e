indexing
	description: "Base Script"
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCRIPT

inherit
	CGI_ENVIRONMENT

	CGI_FORMS

	CGI_IN_AND_OUT

	CGI_ERROR_HANDLING

feature {CGI_HANDLER} -- Initialize

	make(cgi_h: CGI_HANDLER) is
			-- Initialize script with caller 'cgi_h'.
			-- Also perform check if the form is recognized.
		require
			cgi_h /= Void
		do
			cgi_handler := cgi_h
			check_field_required("current_url","Form not recognized")
			check_field_required("form_type","Form not recognized")
		ensure
			set: cgi_handler = cgi_h
		end
	
feature {CGI_HANDLER} -- Basic Operations

	check_fields is
			-- Check if the user correctly filled out
			-- the different entry fields. 
		require
			not entries_checked
		deferred 
		ensure
			entries_checked
		end

	load_resources is
			-- Load resources, if any needed.
		do

		end

	process is
			-- Process user entries.
			-- Return a message to the calling browser.
		require
			entries_checked
		deferred
		end

	prepare_reply is
			-- Prepare response that is going to be sent
			-- to the browser.
		do
		
		end

	reply_browser is
			-- Answer the browser
		require
			not response_header.is_sent
		deferred
		ensure
			response_header.is_sent
		end

feature {SCRIPT} -- Common Operations

--	build_xml_generation is
			-- Build XML text which is going to be used 
			-- for information storage purposes.
--		require
--			xml_generation = Void
--		deferred
--		ensure
--			xml_generation /= Void
--		end

	check_field_required (field_name,message:STRING) is
			-- Check that the user has entered at least one character within the 
			-- text field whose name is 'field_name'.
		require
			field_name_exists: field_name /= Void
			message_exists: message /= Void
		do
			-- This should be coded directly on the HTML page,
			-- for example with Javascript.
		end

feature -- Access 

	entries_checked: BOOLEAN
		-- Are user entries checked ?

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

	form_data: HASH_TABLE[LINKED_LIST[STRING],STRING] is	
			-- Data extracted from the html page.			
		once
			Result := cgi_handler.form_data
		ensure then
			Result_exists: Result /= Void
		end

feature  -- Access

	cgi_handler: CGI_HANDLER
		-- Handler 

	xml_generation: STRING 
		-- XML generation, if any.

	html_page: HTML_PAGE
		-- Page sent back to the browser.

feature {NONE} -- Resources

	tmp_path: STRING is "/london/www/pages/eiffel/webforms"
		-- Path where all the templates may be found.

--	xml_path: STRING is "/london/tmp"
		-- Path from which is extracted and written XML files.
		
	resource_path: STRING is "/london/www/cgi/bin/auto"
		-- Path from which resources are extracted.
			
invariant
	cgi_handler /= Void	 	
end -- class SCRIPT
