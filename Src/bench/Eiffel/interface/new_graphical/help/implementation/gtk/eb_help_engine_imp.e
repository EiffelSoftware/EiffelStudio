indexing
	description: "Help engine, displays help context, GTK implementation"

class
	EB_HELP_ENGINE_IMP

inherit
	EB_HELP_ENGINE_I
	
	SHARED_RESOURCES

	EB_CONSTANTS
	
create
	make
	
feature {NONE} -- Initialization

	make is
		do
		end

feature -- Status Report

	last_show_successful: BOOLEAN
			-- Was last call to `show' successful?
	
	last_error_message: STRING
			-- Last error message, if any
			
feature -- Basic Operations

	show (a_help_context: EB_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		local
			cmd: STRING
			url: FILE_NAME
			root: STRING
			exists: BOOLEAN
		do
			cmd := string_resource_value ("internet_browser", "")
			if cmd.is_empty then
				last_show_successful := False
				last_error_message := warning_messages.w_No_internet_browser_selected
			elseif cmd.substring_index ("$url", 1) <= 0 then
				last_show_successful := False
				last_error_message := Warning_messages.w_No_url_to_replace
			else
				cmd.append_character (' ')
				root := (create {EXECUTION_ENVIRONMENT}).get ("ISE_EIFFEL")
				if root /= Void then
					create url.make_from_string (root)
					url.extend ("docs")
					url.set_file_name (a_help_context.url)
					if (create {DIRECTORY}.make (url)).exists then
						url.set_file_name ("index")
						url.add_extension ("html")
					end
					exists := (create {RAW_FILE}.make (url)).exists
					if exists then
						cmd.append (url)
						(create {EXECUTION_ENVIRONMENT}).launch (cmd)
						last_show_successful := True
					else
						last_show_successful := False
						last_error_message := Warning_messages.w_Page_not_exist
					end
				else
					last_show_successful := False
					last_error_message := warning_messages.w_No_ise_eiffel
				end
			end
		end

end -- class EB_HELP_ENGINE_IMP
