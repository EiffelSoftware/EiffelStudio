indexing
	description	: "Dialog to ask the user if he want to launch a C compilation upon finalization"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_FINALIZE_DIALOG

inherit
	EB_CONFIRM_FREEZE_DIALOG
		redefine
			confirmation_message_label,
			assume_ok,
			save_check_button_state
		end

create
	default_create

feature {NONE} -- Deferred Constants

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Warning_messages.w_Finalize_warning
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		do
			Result := not confirm_finalize
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			set_confirm_finalize (not check_button_checked)
			resources.save
		end

end -- class EB_CONFIRM_FINALIZE_DIALOG
