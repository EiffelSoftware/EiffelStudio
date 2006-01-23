indexing
	description: "Dialog constants. Standard strings displayed on "
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class EV_DIALOG_CONSTANTS

