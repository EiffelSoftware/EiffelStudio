indexing
	description: "Dialog constants. Standard strings displayed on "
	status: "See notice at end of file."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_CONSTANTS
	
feature -- Button Texts

	ev_ok: STRING is
			-- Text displayed on "ok" buttons.
		do
			Result := "OK"
		end
		
	ev_open: STRING is
			-- Text displayed on "open" buttons.
		do
			Result := "Open"
		end
		
	ev_save: STRING is
			-- Text displayed on "save" buttons.
		do
			Result := "Save"
		end

	ev_print: STRING is
			-- Text displayed on "print" buttons.
		do
			Result := "Print"
		end

	ev_cancel: STRING is
			-- Text displayed on "cancel" buttons.
		do
			Result := "Cancel"
		end
		
	ev_yes: STRING is
			-- Text displayed on "yes" buttons.
		do
			Result := "Yes"
		end
		
	ev_no: STRING is
			-- Text displayed on "no" buttons.
		do
			Result := "No"
		end
		
	ev_abort: STRING is
			-- Text displayed on "abort" buttons.
		do
			Result := "Abort"
		end
		
	ev_retry: STRING is
			-- Text displayed on "retry" buttons.
		do
			Result := "Retry"
		end
		
	ev_ignore: STRING is
			-- Text displayed on "ignore" buttons.
		do
			Result := "Ignore"
		end
		
feature -- Titles
		
	ev_warning_dialog_title: STRING is
			-- Title of EV_WARNING_DIALOG.
		do
			Result := "Warning"
		end
	
	ev_question_dialog_title: STRING is
			-- Title of EV_QUESTION_DIALOG.
		do
			Result := "Question"
		end
		
	ev_information_dialog_title: STRING is
			-- Title of EV_INFORMATION_DIALOG.
		do
			Result := "Information"
		end
		
	ev_error_dialog_title: STRING is
			-- Title of EV_ERROR_DIALOG.
		do
			Result := "Error"
		end
		
	ev_confirmation_dialog_title: STRING is
			-- Title of EV_CONFIRMATION_DIALOG.
		do
			Result := "Confirmation"
		end
		
end -- class EV_DIALOG_CONSTANTS

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

