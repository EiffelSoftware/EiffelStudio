indexing
	description	: "Dialog asking the user if he wants to discard assertions when finalizing"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_FINALIZE_ASSERTIONS_DIALOG

inherit
	DISCARDABLE_CONFIRMATION_DIALOG
		rename
			Interface_names as preferences_names,
			Layout_constants as preferences_layout_constants
		redefine
			assume_cancel,
			no_button_label,
			ok_button_label
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature -- Access
	
	Buttons_count: INTEGER is 3

feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		do
			Result := Interface_names.l_Discard_finalize_assertions
		end

	no_button_label: STRING is
			-- Label for the No button.
		do
			Result := Interface_names.b_Keep_assertions
		end

	ok_button_label: STRING is
			-- Label for the Cancel/No button.
		do
			Result := Interface_names.b_Discard_assertions
		end

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Warning_messages.w_Assertion_warning
		end

feature {NONE} -- Deferred Implementation

	assume_cancel: BOOLEAN is False
			-- Should Keep assertions be assumed as selected?

	assume_ok: BOOLEAN is
			-- Should Discard assertions be assumed as selected?
		do
			Result := not preferences.dialog_data.confirm_finalize_assertions
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			preferences.dialog_data.confirm_finalize_assertions_preference.set_value (not check_button_checked)
		end

end -- class EB_CONFIRM_FINALIZE_ASSERTIONS_DIALOG
