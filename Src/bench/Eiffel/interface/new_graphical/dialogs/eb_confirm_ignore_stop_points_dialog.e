indexing
	description	: "Dialog warning the user that the breakpoints will be ignored."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_IGNORE_ALL_BREAKPOINTS_DIALOG

inherit
	EB_DISCARDABLE_CONFIRMATION_DIALOG

	EB_GENERAL_DATA
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature -- Access
	
	Buttons_count: INTEGER is 2

feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		do
			Result := Interface_names.l_Dont_ask_me_again
		end

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Warning_messages.w_Ignoring_all_stop_points
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		do
			Result := not confirm_ignore_all_breakpoints
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			set_confirm_ignore_all_breakpoints (not check_button_checked)
		end

end -- class EB_CONFIRM_IGNORE_ALL_BREAKPOINTS_DIALOG
