--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
		rename
			interface as ev_button_imp_interface
		redefine
			default_style,
			on_bn_clicked
		select
			ev_button_imp_interface
		end

creation
	make

feature -- Status report
	
	state: BOOLEAN is
			-- Is toggle pressed
		do
			Result := cwin_send_message_result (wel_item,
				Bm_getcheck, 0, 0) = 1
		end 

feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Set Current toggle on and set
			-- pressed to True.
		do
			if flag then
				cwin_send_message (wel_item, Bm_setcheck, 1, 0)
			else
				cwin_send_message (wel_item, Bm_setcheck, 0, 0)
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			set_state (not state)
		end

feature -- Event - command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands executed
			-- when `Current' is selected.
		do
			add_command (Cmd_select, cmd, arg)
		end

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands executed
			-- when `Current' is unselected'
		do
			add_command (Cmd_unselect, cmd, arg)
		end
	
	add_toggle_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add 'cmd' to the list of commands to be executed
			-- when the button is toggled.
		do
			add_command (Cmd_toggle, cmd, arg)
		end	

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands executed
			-- when `Current' is selected.
		do
			remove_command (Cmd_unselect)
		end

	remove_unselect_commands is
			-- Empty the list of commands executed
			-- when `Current' is unselected.
		do
			remove_command (Cmd_unselect)
		end

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
			--execute_command (Cmd_click, Void)
			--execute_command (Cmd_toggle, Void)
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.15  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.14.4.5  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.14.4.4  2000/01/27 19:30:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.4.3  2000/01/27 00:35:41  rogers
--| Commented out old command execution.
--|
--| Revision 1.14.4.2  2000/01/10 19:03:36  rogers
--| Changed to comply with major Vision2 changes. see diff for redefinitions. make_with_text is removed. All references to item are replaced with wel_item.
--|
--| Revision 1.14.4.1  1999/11/24 17:30:35  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
