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
				if associated_button.pixmap /= 
					associated_command.true_state_symbol
				then
					associated_button.set_symbol
						(associated_command.true_state_symbol)
				end	
			elseif associated_button.pixmap /=  
					associated_command.false_state_symbol
			then
				associated_button.set_symbol
					(associated_command.false_state_symbol)
			end
		end

feature -- Access

	associated_command: TWO_STATE_CMD

end -- class TWO_STATE_CMD_HOLDER
