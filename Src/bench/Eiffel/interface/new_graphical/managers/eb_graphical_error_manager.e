indexing
	description	: "Objects that helps displaying error message"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_GRAPHICAL_ERROR_MANAGER

inherit
	EB_ERROR_MANAGER

	EB_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	catch_exception: BOOLEAN
			-- Should the current exception be catched?

feature -- Basic operations

	display_error_message (a_relative_window: EV_WINDOW) is
		local
			error_dialog: EV_ERROR_DIALOG
			error_string: STRING
		do
				-- Set up the error message.
			if error_messages.is_empty then
				error_string := "An unknown error has occured%N"
			else
				from
					error_messages.start
				until
					error_messages.after
				loop
					error_string := error_messages.item + "%N%N"
					error_messages.forth
				end
			end
			create error_dialog.make_with_text (error_string)
			error_dialog.set_buttons (<<Interface_names.b_Ok>>)
			set_catch_exception (True)
			debug ("display_exception_trace")
				error_dialog.set_buttons (<<Interface_names.b_Ok, Interface_names.b_Display_Exception_Trace>>)
				error_dialog.button (Interface_names.b_Display_Exception_Trace).select_actions.extend (~set_catch_exception(False))
			end
			error_dialog.set_default_push_button (error_dialog.button (Interface_names.b_Ok))
			error_dialog.set_default_cancel_button (error_dialog.button (Interface_names.b_Ok))
			error_dialog.show_modal_to_window (a_relative_window)
			clear_error_messages
		end

feature {NONE} -- Implementation

	set_catch_exception (new_state: BOOLEAN) is
			-- Set `catch_exception' to `new_state'.
		do
			catch_exception := new_state
		end
		
	
end -- class EB_GRAPHICAL_ERROR_MANAGER
