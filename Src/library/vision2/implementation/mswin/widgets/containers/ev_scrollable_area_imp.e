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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

