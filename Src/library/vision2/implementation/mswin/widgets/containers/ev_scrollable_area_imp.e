indexing
	description: "Eiffel Vision scrollable area. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit
	EV_SCROLLABLE_AREA_I
		redefine
			interface
		end

	EV_VIEWPORT_IMP
		redefine
			interface,	
			make,
			initialize,
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
			Precursor (an_interface)
		end

	initialize is
		do
			Precursor
			create scroller.make_with_options (Current, 0, 10, 0, 10, 10, 30, 10, 30)
			show_scroll_bars
		end

feature -- Access

	horizontal_step: INTEGER is
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on the horizontal scrollbar.
		do
			Result := scroller.horizontal_line
		end

	vertical_step: INTEGER is
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on the vertical scrollbar.
		do
			Result := scroller.vertical_line
		end

	is_horizontal_scroll_bar_visible: BOOLEAN is
			-- Should horizontal scroll bar be displayed?
		do
			Result := minimal_horizontal_position /= maximal_horizontal_position
		end

	is_vertical_scroll_bar_visible: BOOLEAN is
			-- Should vertical scrollbar be displayed?
		do
			Result := minimal_vertical_position /= maximal_vertical_position
		end

feature -- Element change

	set_horizontal_step (a_step: INTEGER) is
			-- Set `horizontal_step' to `a_step'.
		do
			scroller.set_horizontal_line (a_step)
		end

	set_vertical_step (a_step: INTEGER) is
			-- Set `vertical_step' to `a_step'.
		do
			scroller.set_vertical_line (a_step)
		end

feature -- Obsolete

	set_horizontal_value (value: INTEGER) is
			-- Make `value' the new horizontal value where `value' is given in percentage.
		local
			step: INTEGER
		do
		--	if horizontal_bar_shown then
		--		step := (maximal_horizontal_position - minimal_horizontal_position) * value // 100
		--		step := step + minimal_horizontal_position
		--		horizontal_update (horizontal_position - step, step)
		--	end
		end

	set_vertical_value (value: INTEGER) is
			-- Make `value' the new vertical value where `value' is given in percentage.
		local
			step: INTEGER
		do
		--	if vertical_bar_shown then
		--		step := (maximal_vertical_position - minimal_vertical_position) * value // 100
		--		step := step + minimal_vertical_position
		--		vertical_update (vertical_position - step, step)
		--	end
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
		do
			Result := Ws_child +
				Ws_clipchildren +
				Ws_clipsiblings +
				Ws_visible +
				Ws_vscroll +
				Ws_hscroll
		end

	default_ex_style: INTEGER is
			-- The default ex-style of the window.
		do
			Result := Ws_ex_controlparent + Ws_ex_clientedge + Ws_ex_rightscrollbar
		end

	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		local
			ch, cw: INTEGER
		do
			wel_cw_move_and_resize (a_x, a_y, a_width, a_height, repaint)
	
			if child /= Void then
				child.parent_ask_resize (client_width, client_height)
				cw := child.width - client_width
				ch := child.height - client_height

				if cw > 0 then
					enable_horizontal_scroll_bar
					set_horizontal_range (0, cw)
				else
					disable_horizontal_scroll_bar
				end

				if ch > 0 then
					enable_vertical_scroll_bar
					set_vertical_range (0, ch)
				else
					disable_vertical_scroll_bar
				end
			end
		end

	interface: EV_VIEWPORT

end -- class EV_SCROLLABLE_AREA_IMP

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
--| Revision 1.23  2000/04/21 23:07:57  brendel
--| scrollbar -> scroll_bar.
--|
--| Revision 1.22  2000/04/21 22:02:49  brendel
--| Removed FIXME.
--|
--| Revision 1.21  2000/04/21 18:14:06  brendel
--| Mixed up width and height.
--|
--| Revision 1.20  2000/04/21 00:50:09  brendel
--| Scrollbars are always visible, but disabled. To be implemented tomorrow.
--|
--| Revision 1.19  2000/03/09 16:29:34  brendel
--| Added `show_scroll_bars' to initialization but does not seem to make a
--| difference.
--|
--| Revision 1.18  2000/03/09 01:19:48  brendel
--| Useable, but features are not yet implemented.
--| Scrollbars (dis)appear dynamically.
--|
--| Revision 1.17  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.16  2000/02/14 11:40:43  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.10.3  2000/01/29 01:02:48  brendel
--| Implemented in compliance with new interface.
--|
--| Revision 1.15.10.2  2000/01/27 19:30:22  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.10.1  1999/11/24 17:30:28  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.6.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
