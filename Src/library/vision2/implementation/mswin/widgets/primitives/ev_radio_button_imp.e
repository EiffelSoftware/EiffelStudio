indexing
	description: "Eiffel Vision radio button. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_BUTTON_IMP

inherit
	EV_RADIO_BUTTON_I
		redefine
			interface
		end
		
	EV_SELECT_BUTTON_IMP
		undefine
			default_style,
			on_key_down,
			on_bn_clicked
		redefine
			interface,
			initialize,
			enable_select
		select
			wel_make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

	WEL_RADIO_BUTTON
		rename
			make as wel_radio_make,
			parent as wel_window_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			shown as is_displayed,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			text as wel_text,
			item as wel_item,
			enabled as is_sensitive,
			move as move_to
		undefine
			make_by_id,
			window_process_message,
			remove_command,
			set_width,
			set_height,
			on_bn_clicked,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_up,
			on_key_down,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			process_notification,
			set_text,
			show,
			hide
		redefine
			on_key_down
		end
		
create
	make

feature {NONE} -- Initalization

	initialize is
		do
			Precursor
			set_checked
		end			

feature -- Status setting
	
	enable_select is
			-- Set `Current' as selected.
			--| On WEL, this happens automatically in a WEL_CONTROL, but we
			--| want it to work over multiple controls (see: EV_CONTAINER).
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					radio_group.item.set_unchecked
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			Precursor
		end

feature {NONE} -- Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{WEL_RADIO_BUTTON} Precursor (virtual_key, key_data)
			process_tab_and_arrows_keys (virtual_key)
		end

	on_bn_clicked is
			-- Called when button is pressed.
		do
			enable_select
			{EV_SELECT_BUTTON_IMP} Precursor
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_IMP

--!----------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.24  2000/03/04 04:19:22  pichery
--| Modified the inheritance since WEL_BITMAP_BUTTON now redefine make
--| and make_by_id
--|
--| Revision 1.23  2000/02/29 00:40:44  brendel
--| Added redefinition of `enable_select', see comments on feature.
--| Added redefinition of `on_bn_clicked', to call `enable_select' first.
--|
--| Revision 1.22  2000/02/25 20:26:07  brendel
--| Now redefined initialize instead of make.
--|
--| Revision 1.21  2000/02/25 02:17:44  brendel
--| Added inheritance of EV_RADIO_PEER_IMP.
--| Redefined make to set default `is_selected' `True'.
--|
--| Revision 1.20  2000/02/24 20:40:22  brendel
--| Revised.
--| Changed --| to --! for copyright notice.
--|
--| Revision 1.19  2000/02/17 02:18:47  oconnor
--| released
--|
--| Revision 1.18  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.10.3  2000/01/27 19:30:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.10.2  2000/01/10 19:58:50  rogers
--| Altered to comply with the major Vision2 changes. See diff for redefinitions. Added set_peer and remove_from_group which should not be called as they are not yet implemented. I am not sure if this is possible on Windows. This needs to be fixed soon.
--|
--| Revision 1.17.10.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
