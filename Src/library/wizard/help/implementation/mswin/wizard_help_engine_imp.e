indexing
	description: "Help engine, displays help context, Windows implementation"

class
	WIZARD_HELP_ENGINE_IMP

inherit
	WIZARD_HELP_ENGINE_I
	
	WIZARD_SHARED

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

	show (a_help_context: WIZARD_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			hh_handler.show (Url_prefix + a_help_context.url)
			internal_show_successful := hh_handler.last_show_successful
			if not internal_show_successful then
				internal_error_message := Generic_error_message
			end
		end

feature -- Access

	Eiffel_key: STRING is "ISE_EIFFEL"
			-- Environment variable for Eiffel delivery
	
	Url_prefix: STRING is 
			-- Path to `wizard.chm' (relatively to $ISE_EIFFEL value)
		once
			Result := wizard_source + "\wizard.chm::"
		ensure
			non_void_path: Result /= Void
			not_empty_path: not Result.is_empty
		end

feature {NONE} -- Implementation

	internal_show_successful: BOOLEAN
			-- Was last call to `show' successful?

	internal_error_message: STRING
			-- Last error message, if any

	hh_handler: WIZARD_HTML_HELP_HANDLER
			-- Control content of Microsoft HTML Help

	Generic_error_message: STRING is "Could not display the help topic, please check your Eiffel installation."
			-- Error message displayed when topic could not be displayed

end -- class WIZARD_HELP_ENGINE

--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
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

