indexing
	description: "Dialog Warning that text is loading and therefore is not editable"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TEXT_LOADING_WARNING_DIALOG

inherit
	EB_DISCARDABLE_WARNING_DIALOG

create
	make

feature {NONE} -- Initialisation

	make is
			-- Initialize Current
		do
			default_create
			ok_action := close_request_actions~call
		end


feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		do
			Result := Interface_names.l_Dont_ask_me_again
		end

	warning_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Interface_names.l_Text_loading
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		do
			Result := not acknowledge_not_loaded
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			set_acknowledge_not_loaded (not check_button_checked)
		end

end -- class EB_TEXT_LOADING_WARNING_DIALOG
