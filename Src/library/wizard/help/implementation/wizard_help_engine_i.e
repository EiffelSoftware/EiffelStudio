indexing
	description: "Help engine, displays help context, implementation interface"

deferred class
	WIZARD_HELP_ENGINE_I

feature -- Status Report

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		deferred
		ensure
			message_if_failed: not Result implies (last_error_message /= Void and then not last_error_message.is_empty)
		end
	
	last_error_message: STRING is
			-- Last error message, if any
		deferred
		end
			
feature -- Basic Operations

	show (a_help_context: WIZARD_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		deferred
		end

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

