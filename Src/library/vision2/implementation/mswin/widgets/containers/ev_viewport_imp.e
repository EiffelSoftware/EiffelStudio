indexing
	description: "Eiffel Vision viewport. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_VIEWPORT_IMP
	
inherit
	EV_VIEWPORT_I
		redefine
			interface,
			set_offset
		end
		
	EV_CELL_IMP
		undefine
			default_style,
			default_ex_style
		redefine
			interface,
			make,
			wel_move_and_resize
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_window_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text
		undefine
			window_process_message,
			set_width,
			set_height,
			remove_command,
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
			on_draw_item,
			background_brush,
			on_accelerator_command,
			on_color_control,
 			on_wm_vscroll,
 			on_wm_hscroll,
			show,
			hide,
			on_destroy,
			on_move,
			on_size
		redefine
			default_style,
			default_ex_style,
			wel_move_and_resize
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Initialize. 
		do
			base_make (an_interface)
			wel_make (Default_parent, "")
			set_minimum_size (100, 100)
		end	

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			if item /= Void then
				Result := - item.x_position
			end
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			if item /= Void then
				Result := - item.y_position
			end
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Set `x_offset' to `an_x'.
		do
			if item /= Void then
				item_imp.wel_move (- an_x, item.y_position)
			end
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			if item /= Void then
				item_imp.wel_move (item.x_position, - a_y)
			end
		end

	set_offset (an_x, a_y: INTEGER) is
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		do
			if item /= Void then
				item_imp.wel_move (- an_x, - a_y)
			end
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_clipchildren + Ws_clipsiblings + Ws_visible
		end

	default_ex_style: INTEGER is
			-- The default ex-style of the window.
		do
			Result := Ws_ex_controlparent + Ws_ex_clientedge
		end

	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
				repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		local
			ch, cw: INTEGER
		do
			{WEL_CONTROL_WINDOW} Precursor (
				a_x, a_y, a_width, a_height, repaint)
			if item_imp /= Void then
				item_imp.set_move_and_size (item_imp.x_position,
					item_imp.y_position, client_width, client_height)

				cw := item_imp.width - client_width
				ch := item_imp.height - client_height

				if x_offset > cw then
					set_x_offset (cw)
				end
				if y_offset > ch then
					set_y_offset (ch)
				end
			end
		end

	interface: EV_VIEWPORT

end -- class EV_VIEWPORT_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/05/03 20:13:25  brendel
--| Fixed resize_actions.
--|
--| Revision 1.12  2000/04/26 21:01:29  brendel
--| child -> item or item_imp.
--|
--| Revision 1.11  2000/04/24 16:02:16  brendel
--| Added redefinition of set_offset, to move x and y at the same time.
--|
--| Revision 1.10  2000/04/22 01:24:23  brendel
--| Improved wel_move_and_resize.
--|
--| Revision 1.9  2000/04/21 22:35:58  brendel
--| Improved implementation.
--|
--| Revision 1.8  2000/04/21 22:03:23  brendel
--| Implemented offset functions.
--|
--| Revision 1.7  2000/04/21 00:49:24  brendel
--| Scrollbars are not shown anymore.
--|
--| Revision 1.6  2000/03/29 21:28:45  brendel
--| Fixed compiler errors resulting from recent changes.
--|
--| Revision 1.5  2000/03/09 01:18:40  brendel
--| Useable, but features are not implemented yet.
--| Scrollbars (dis)appear dynamically at the moment.
--|
--| Revision 1.4  2000/02/22 18:39:46  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.2  2000/02/14 12:05:10  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/01/29 01:03:13  brendel
--| Changed GTK+ to Mswindows.
--|
--| Revision 1.1.2.1  2000/01/28 19:29:01  brendel
--| Initial. New ancestor for EV_SCROLLABLE_AREA.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
