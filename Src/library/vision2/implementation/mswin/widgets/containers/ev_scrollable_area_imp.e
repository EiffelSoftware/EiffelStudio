indexing
	description: "Eiffel Vision scrollable area. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit
	EV_SCROLLABLE_AREA_I
		undefine
			set_offset
		redefine
			interface
		end

	EV_VIEWPORT_IMP
		redefine
			show_horizontal_scroll_bar,
			show_vertical_scroll_bar,
			hide_horizontal_scroll_bar,
			hide_vertical_scroll_bar,
			interface,	
			make,
			initialize,
			default_style,
			default_ex_style,
			x_offset,
			y_offset,
			set_x_offset,
			set_y_offset,
			ev_apply_new_size,
			on_size_requested
		end

	WEL_RGN_CONSTANTS
		export {NONE}
			all
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
			create scroller.make (Current, 50, 50, 10, 30)
			enable_horizontal_scroll_bar
			enable_vertical_scroll_bar
			hide_horizontal_scroll_bar
			hide_vertical_scroll_bar
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

	is_horizontal_scroll_bar_visible: BOOLEAN
			-- Should horizontal scroll bar be displayed?

	is_vertical_scroll_bar_visible: BOOLEAN
			-- Should vertical scrollbar be displayed?

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

	show_horizontal_scroll_bar is
			-- Display horizontal scroll bar.
		do
			Precursor {EV_VIEWPORT_IMP}
			is_horizontal_scroll_bar_visible := True
		end

	hide_horizontal_scroll_bar is
			-- Do not display horizontal scroll bar.
		do
			Precursor {EV_VIEWPORT_IMP}
			is_horizontal_scroll_bar_visible := False
		end

	show_vertical_scroll_bar is
			-- Display vertical scroll bar.
		do
			Precursor {EV_VIEWPORT_IMP}
			is_vertical_scroll_bar_visible := True
		end

	hide_vertical_scroll_bar is
			-- Do not display vertical scroll bar.
		do
			Precursor {EV_VIEWPORT_IMP}
			is_vertical_scroll_bar_visible := False
		end

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			if item /= Void then
				Result := horizontal_position
			end
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			if item /= Void then
				Result := vertical_position
			end
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Set `x_offset' to `an_x'.
		do
			if item /= Void then
				set_horizontal_position (an_x)
				Precursor (an_x)
			end
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			if item /= Void then
				set_vertical_position (a_y)
				Precursor (a_y)
			end
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
			Result := Ws_ex_controlparent + Ws_ex_rightscrollbar
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			Precursor {EV_VIEWPORT_IMP} (a_x_position, a_y_position,
				a_width, a_height, repaint)
			if item_imp = Void then
				hide_vertical_scroll_bar
				hide_horizontal_scroll_bar
			end
		end

	is_in_size_call: BOOLEAN
			-- Avoid recursive calls to `on_size_requested' if True.

	on_size_requested (originator: BOOLEAN) is
			-- Compute position of item in Current
		local
			ch, cw: INTEGER
			imp: like item_imp
			cl_width, cl_height: INTEGER
			imp_h, imp_w: INTEGER
			new_x, new_y: INTEGER
		do
			if not is_in_size_call then
					-- Avoid recursive call when performing resizing
				is_in_size_call := True

					-- Local variables for fast access later in computation
				imp := item_imp
				imp_w := imp.width
				imp_h := imp.height
				cl_width := client_width
				cl_height := client_height
				cw := imp_w - cl_width
				ch := imp_h - cl_height

				if cw > 0 then
						-- Item is too big to fit in width.
					show_horizontal_scroll_bar

						-- Recompute new `ch' that takes into account the new
						-- client_height which could changed due to the apparition
						-- of the horizontal scroll bar.
					cl_height := client_height
					ch := imp_h - cl_height
					if ch > 0 then
							-- Item is too big to fit in height.
						show_vertical_scroll_bar
					else
						hide_vertical_scroll_bar
					end

						-- Recompute new client_width which could have changed
						-- due to apparition/removal of vertical scrollbar.
					cl_width := client_width
					cw := imp_w - cl_width
				else
					hide_horizontal_scroll_bar

						-- Recompute new `ch' that takes into account the new
						-- client_height which could changed due to the removal
						-- of the horizontal scroll bar.
					cl_height := client_height
					ch := imp_h - cl_height

					if ch > 0 then
						show_vertical_scroll_bar
					else
						hide_vertical_scroll_bar
					end

						-- Recompute new client_width which could have changed
						-- due to apparition/removal of vertical scrollbar.
					cl_width := client_width
					cw := imp_w - cl_width
				end

				if cw > 0 then
						-- Here client_width is too small to contain `item', we
						-- need to reposition `item' at the correct place. Meaning
						-- its right part has to touch the right part of scrollable
						-- area.

						-- Compute old position.
					new_x := imp.x_position
					if -new_x + cl_width > imp_w then
							-- We are bigger so we need to go right a little bit
						new_x := -cw
					end

						-- In our current configuration the right of `item' has to be
						-- at most at the very left of scrollable area, not after.
					new_x := new_x.min (0)

						-- Set scrolling values to reflect new settings
					set_horizontal_position (new_x.abs)
					set_horizontal_range (0, imp_w)
					scroller.set_horizontal_page (cl_width)

					if ch > 0 then
							-- Here client_height isn't too small to contain `item', we need
							-- to move down `item' at the correct place. Meaning that the
							-- bottom part has to touch the bottom of scrollable area.

							-- Compute old position.
						new_y := imp.y_position
						if -new_y + cl_height > imp_h then
								-- We are bigger so we need to go down a little bit
							new_y := -ch
						end
							-- In our current configuration the top of `item' has to be
							-- at most at the very top of scrollable area, not below.
						new_y := new_y.min (0)

							-- Set scrolling values to reflect new settings.
						set_vertical_range (0, imp_h)
						set_vertical_position (new_y.abs)
						scroller.set_vertical_page (cl_height)

						if originator then
								-- Move item at new position
							imp.set_move_and_size (new_x,
								new_y, imp_w, imp_h)
						else
								-- Move item at new position
							imp.ev_apply_new_size (new_x,
								new_y, imp_w, imp_h, True)
						end
					else
						if originator then
							imp.set_move_and_size (new_x,
								(-ch) // 2, imp_w, imp_h)
						else
							imp.ev_apply_new_size (new_x,
								(-ch) // 2, imp_w, imp_h, True)
						end
					end
				else
					if ch > 0 then
							-- See above comments, same implementation, but with
							-- a different x.
						new_y := imp.y_position
						if -new_y + cl_height > imp_h then
								-- We are bigger so we need to go down a little bit
							new_y := -ch
						end
						new_y := new_y.min (0)
						set_vertical_range (0, imp_h)
						set_vertical_position (new_y.abs)
						scroller.set_vertical_page (cl_height)
						if originator then
							imp.set_move_and_size ((-cw) // 2,
								new_y, imp_w, imp_h)
						else
							imp.ev_apply_new_size ((-cw) // 2,
								new_y, imp_w, imp_h, True)
						end
					else
							-- Scrollable area is bigger than widget, we put it in
							-- center.
						if originator then
							imp.set_move_and_size ((-cw) // 2,
								(-ch) // 2, imp_w, imp_h)
						else
							imp.ev_apply_new_size ((-cw) // 2,
								(-ch) // 2, imp_w, imp_h, True)
						end
					end
				end
				is_in_size_call := False
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.32  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.31  2001/06/07 23:08:15  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.15.8.9  2001/02/19 21:00:55  manus
--| By default scrollbars are always enabled and hidden at creation.
--| During resizing we hide/show them.
--| Fixed a bug in resizing code because if from time t1 to t2 a scrollbar
--| had to be added it changes the size of the client area and we did not
--| take that into account. Now we find out if we hide/show a scrollbar, then
--| recompute our sizes and then do the positionning and scrollbar update.
--|
--| Revision 1.15.8.8  2001/01/30 19:53:22  rogers
--| Ev_apply_new_size redefined to hide scroll bars if item_imp = Void.
--|
--| Revision 1.15.8.7  2001/01/30 19:26:44  manus
--| Fixed the non-implemented `ev_apply_new_size' feature so that it calls
--| `on_size_requested' with a new arguments telling the origin of the call
--|  (which is either a user resize event or an internal one due to vision2 code).
--|
--| Revision 1.15.8.6  2000/11/29 00:42:41  rogers
--| Comment changed.
--|
--| Revision 1.15.8.5  2000/10/09 05:03:03  manus
--| Removed `Ws_ex_clientedge' style since if we want a special border we can put it in a frame.
--|
--| Revision 1.15.8.4  2000/09/06 02:29:58  manus
--| Cosmetics on Precursor
--|
--| Revision 1.15.8.3  2000/08/08 16:05:23  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| New behavior of scrolling area, where contents is not resized to fit the scrollable area. It
--| will be automatically centered.
--|
--| Revision 1.15.8.2  2000/05/03 22:16:27  pichery
--| - Cosmetics / Optimization with local variables
--| - Replaced calls to `width' to calls to `wel_width'
--|   and same for `height'.
--|
--| Revision 1.15.8.1  2000/05/03 19:09:37  oconnor
--| mergred from HEAD
--|
--| Revision 1.29  2000/04/26 21:01:29  brendel
--| child -> item or item_imp.
--|
--| Revision 1.28  2000/04/26 18:35:06  brendel
--| Replaced obsolete call.
--|
--| Revision 1.27  2000/04/24 16:02:55  brendel
--| Undefine set_offset.
--|
--| Revision 1.26  2000/04/22 01:23:47  brendel
--| Improved wel_move_and_resize.
--|
--| Revision 1.25  2000/04/22 00:58:49  brendel
--| Implemented.
--|
--| Revision 1.24  2000/04/22 00:06:17  brendel
--| Started implementation of interface features.
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
