indexing

	description:
		"Put your description here.";
	date: "$Date$";
	revision: "$Revision$"

class TWO_STATE_CMD_HOLDER

inherit
	EB_HOLDER
		rename
			set_selected as change_state
		redefine
			change_state, associated_command
		end

creation
	make, make_plain

feature -- State Changing

	change_state (b: BOOLEAN) is
			-- Change pixmap on `associated_button' to
			-- reflect `b'.
		do
			if b then
				associated_button.set_insensitive
				if associated_button.pixmap /= associated_command.inactive_symbol then
					associated_button.set_symbol (associated_command.inactive_symbol)
				end	
			else
				associated_button.set_sensitive
				if associated_button.pixmap /= associated_command.active_symbol then
					associated_button.set_symbol (associated_command.active_symbol)
				end
			end
		end

feature -- Access

	associated_command: TWO_STATE_CMD

end -- class TWO_STATE_CMD_HOLDER
