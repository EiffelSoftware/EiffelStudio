indexing
	description: "Help engine, displays help context, Windows implementation"

class
	EB_HELP_ENGINE_IMP

inherit
	EB_HELP_ENGINE_I
	
	EIFFEL_ENV
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create HTML Help handler.
		do
			create hh_handler
			internal_show_successful := True
		ensure
			hh_handler /= Void
			last_show_successful: last_show_successful
		end

feature -- Status Report

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		do
			Result := internal_show_successful
		end
	
	last_error_message: STRING is
			-- Last error message, if any
		do
			Result := internal_error_message
		end
			
feature -- Basic Operations

	show (a_help_context: EB_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			hh_handler.show (Url_prefix + a_help_context.url)
			internal_show_successful := hh_handler.last_show_successful
			if not internal_show_successful then
				internal_error_message := Generic_error_message
			end
		end

feature {NONE} -- Implementation

	internal_show_successful: BOOLEAN
			-- Was last call to `show' successful?

	internal_error_message: STRING
			-- Last error message, if any

	hh_handler: EB_HTML_HELP_HANDLER
			-- Control content of Microsoft HTML Help

	Generic_error_message: STRING is "Could not display the help topic, please check your Eiffel installation."
			-- Error message displayed when topic could not be displayed

	Url_prefix: STRING is 
			-- URL prefix for $EiffelGraphicalCompiler$ help files
		once
			Result := Eiffel_installation_dir_name + "\docs\eiffel.chm::"
		end

end -- class EB_HELP_ENGINE