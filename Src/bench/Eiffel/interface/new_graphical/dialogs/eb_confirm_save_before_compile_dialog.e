indexing
	description	: "Dialog asking the user if he wants to save all files before compiling"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_SAVE_BEFORE_COMPILE_DIALOG

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
			Result := Interface_names.l_Discard_save_before_compile_dialog
		end

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Warning_messages.w_Files_not_saved_before_compiling
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		do
			Result := not confirm_save_before_compile
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			set_confirm_save_before_compile (not check_button_checked)
			resources.save
		end

end -- class EB_CONFIRM_SAVE_BEFORE_COMPILE_DIALOG
