indexing
	description	: "Dialog asking the user if he wants to clear all breakpoints"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_CLEAR_BREAKPOINTS_DIALOG

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
			Result := Warning_messages.w_Clear_breakpoints
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		do
			Result := not confirm_clear_breakpoints
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			set_confirm_clear_breakpoints (not check_button_checked)
		end

end -- class EB_CONFIRM_CLEAR_BREAKPOINTS_DIALOG
