--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision check button.%
			% Mswindows implementation"
	author: ""
	date: "$$"
	revision: "$$"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		select
			interface
		end
		
	EV_TOGGLE_BUTTON_IMP
		rename
			interface as toggle_button_imp_interface
		undefine
			default_process_message,
			default_style
		redefine
			make,
			state,
			set_state,
			toggle
		end

	WEL_CHECK_BOX
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			shown as is_displayed,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			text as wel_text,
			item as wel_item,
			move as move_to,
			enabled as is_sensitive
		undefine
			window_process_message,
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			on_bn_clicked,
			set_text,
			show,
			hide
		redefine
			default_style
		end	

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the label with an empty label.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			extra_width := 20
		end

feature -- Status report
	
	state: BOOLEAN is
			-- Is toggle pressed
		do
			Result := checked
		end 

feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Set Current toggle on and set
			-- pressed to True.
		do
			if flag then
				set_checked
			else
				set_unchecked
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			set_state (not state)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Not visible or child at creation
		do
			Result := Ws_child + Ws_visible + Ws_group
					+ Ws_tabstop + Bs_autocheckbox
		end

end -- class EV_CHECK_BUTTON_IMP

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
--| Revision 1.21  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.20.10.4  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.20.10.3  2000/01/27 19:30:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.20.10.2  2000/01/10 20:00:54  rogers
--| Altered to comply with the major Vision2 changes. See diff for redefinitions. Make now takes an interface and make_with_text has been removed.
--|
--| Revision 1.20.10.1  1999/11/24 17:30:31  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.20.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
