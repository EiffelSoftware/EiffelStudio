indexing
	description	: "Dialog to ask the user if he really want to launch a freeze"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_FREEZE_DIALOG

inherit
	EB_DISCARDABLE_CONFIRMATION_DIALOG

create
	default_create

feature -- Access

	Buttons_count: INTEGER is 3

feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		do
			Result := Interface_names.l_Discard_freeze_dialog
		end

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Warning_messages.w_Freeze_warning
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		do
			Result := not confirm_freeze
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			set_confirm_freeze (not check_button_checked)
			resources.save
		end

end -- class EB_CONFIRM_FREEZE_DIALOG
