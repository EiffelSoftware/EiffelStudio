indexing
	description: "EiffelVision Toggle button.%
				% Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I

	EV_BUTTON_IMP
		redefine
			default_style,
			on_bn_clicked
		end

creation
	make,
	make_with_text

feature -- Status report
	
	state: BOOLEAN is
			-- Is toggle pressed
		do
			Result := cwin_send_message_result (item,
				Bm_getcheck, 0, 0) = 1
		end 

feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Set Current toggle on and set
			-- pressed to True.
		do
			if flag then
				cwin_send_message (item, Bm_setcheck, 1, 0)
			else
				cwin_send_message (item, Bm_setcheck, 0, 0)
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			set_state (not state)
		end

feature -- Event - command association
	
	add_toggle_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add 'cmd' to the list of commands to be executed
			-- when the button is toggled.
		do
			add_command (Cmd_toggle, cmd, arg)
		end	

feature -- Event -- removing command association

	remove_toggle_commands is	
			-- Empty the list of commands to be executed
			-- when the button is toggled.
		do
			remove_command (Cmd_toggle)
		end	

feature {NONE} -- Notification messages

	on_bn_clicked is
			-- When the button is pressed
		do
			execute_command (Cmd_click, Void)
			execute_command (Cmd_toggle, Void)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Not visible or child at creation
		do
			Result := Ws_child + Ws_visible + Ws_group
						+ Ws_tabstop + Bs_autocheckbox 
						+ Bs_pushlike
		end

end -- class EV_TOGGLE_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
