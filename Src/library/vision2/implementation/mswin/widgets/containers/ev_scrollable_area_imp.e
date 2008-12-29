note
	description: "Eiffel Vision scrollable area. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		rename
			show_horizontal_scroll_bar as wel_show_horizontal_scroll_bar,
			show_vertical_scroll_bar as wel_show_vertical_scroll_bar,
			hide_horizontal_scroll_bar as wel_hide_horizontal_scroll_bar,
			hide_vertical_scroll_bar as wel_hide_vertical_scroll_bar
		redefine
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

	make (an_interface: like interface)
			-- Initialize current with `interface' `an_interface'. 
		do
			Precursor {EV_VIEWPORT_IMP} (an_interface)
		end

	initialize
			-- Perform post creation initialization.
		do
			Precursor {EV_VIEWPORT_IMP}
			create scroller.make (Current, 50, 50, 10, 30)
			enable_horizontal_scroll_bar
			enable_vertical_scroll_bar
			
			wel_hide_horizontal_scroll_bar
			wel_hide_vertical_scroll_bar
				-- Ensure that the scroll bars will be displayed
				-- when required.
			is_horizontal_scroll_bar_visible := True
			is_vertical_scroll_bar_visible := True
		end

feature -- Access

	horizontal_step: INTEGER
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on the horizontal scrollbar.
		do
			Result := scroller.horizontal_line
		end

	vertical_step: INTEGER
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on the vertical scrollbar.
		do
			Result := scroller.vertical_line
		end

feature -- Element change

	set_horizontal_step (a_step: INTEGER)
			-- Set `horizontal_step' to `a_step'.
		do
			scroller.set_horizontal_line (a_step)
		end

	set_vertical_step (a_step: INTEGER)
			-- Set `vertical_step' to `a_step'.
		do
			scroller.set_vertical_line (a_step)
		end

	show_horizontal_scroll_bar
			-- Display horizontal scroll bar.
		do
			is_horizontal_scroll_bar_visible := True
			wel_show_horizontal_scroll_bar
		end

	hide_horizontal_scroll_bar
			-- Do not display horizontal scroll bar.
		do
			is_horizontal_scroll_bar_visible := False
			wel_hide_horizontal_scroll_bar
		end

	show_vertical_scroll_bar
			-- Display vertical scroll bar.
		do
			is_vertical_scroll_bar_visible := True
			wel_show_vertical_scroll_bar
		end

	hide_vertical_scroll_bar
			-- Do not display vertical scroll bar.
		do
			is_vertical_scroll_bar_visible := False
			wel_hide_vertical_scroll_bar
		end
		
	internal_show_vertical_scroll_bar
			-- Display vertical scroll bar if `is_vertical_scroll_bar_visible'.
		do
			if is_vertical_scroll_bar_visible then
				show_vertical_scroll_bar
			end
		end
		
	internal_show_horizontal_scroll_bar
			-- Display horizontal scroll bar if `is_horizontal_scroll_bar_visible'.
		do
			if is_horizontal_scroll_bar_visible then
				show_horizontal_scroll_bar
			end
		end

feature -- Access

	x_offset: INTEGER
			-- Horizontal position of viewport relative to `item'.
		do
			if item /= Void then
				Result := horizontal_position
			end
		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
		do
			if item /= Void then
				Result := vertical_position
			end
		end

feature -- Element change

	set_x_offset (an_x: INTEGER)
			-- Set `x_offset' to `an_x'.
		do
			if item /= Void then
				set_horizontal_position (an_x)
				Precursor {EV_VIEWPORT_IMP} (an_x)
			end
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		do
			if item /= Void then
				set_vertical_position (a_y)
				Precursor {EV_VIEWPORT_IMP} (a_y)
			end
		end

feature {NONE} -- Implementation

	default_style: INTEGER
		do
			Result := Ws_child +
				Ws_clipchildren +
				Ws_clipsiblings +
				Ws_visible +
				Ws_vscroll +
				Ws_hscroll
		end

	default_ex_style: INTEGER
			-- The default ex-style of the window.
		do
			Result := Ws_ex_controlparent + Ws_ex_rightscrollbar
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			Precursor {EV_VIEWPORT_IMP} (a_x_position, a_y_position,
				a_width, a_height, repaint)
			if item_imp = Void then
				wel_hide_vertical_scroll_bar
				wel_hide_horizontal_scroll_bar
			end
		end

	is_in_size_call: BOOLEAN
			-- Avoid recursive calls to `on_size_requested' if True.

	on_size_requested (originator: BOOLEAN)
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
					internal_show_horizontal_scroll_bar

						-- Recompute new `ch' that takes into account the new
						-- client_height which could changed due to the apparition
						-- of the horizontal scroll bar.
					cl_height := client_height
					ch := imp_h - cl_height
					if ch > 0 then
							-- Item is too big to fit in height.
						internal_show_vertical_scroll_bar
					else
						wel_hide_vertical_scroll_bar
					end

						-- Recompute new client_width which could have changed
						-- due to apparition/removal of vertical scrollbar.
					cl_width := client_width
					cw := imp_w - cl_width
				else
					wel_hide_horizontal_scroll_bar

						-- Recompute new `ch' that takes into account the new
						-- client_height which could changed due to the removal
						-- of the horizontal scroll bar.
					cl_height := client_height
					ch := imp_h - cl_height

					if ch > 0 then
						internal_show_vertical_scroll_bar
					else
						wel_hide_vertical_scroll_bar
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
					if is_horizontal_scroll_bar_visible then
						set_horizontal_position (new_x.abs)
						set_horizontal_range (0, imp_w)
						scroller.set_horizontal_page (cl_width)	
					end			
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
						if is_vertical_scroll_bar_visible then
							set_vertical_range (0, imp_h)
							set_vertical_position (new_y.abs)
							scroller.set_vertical_page (cl_height)				
						end

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
						if is_vertical_scroll_bar_visible then
							set_vertical_range (0, imp_h)
							set_vertical_position (new_y.abs)
							scroller.set_vertical_page (cl_height)
						end
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SCROLLABLE_AREA_IMP

