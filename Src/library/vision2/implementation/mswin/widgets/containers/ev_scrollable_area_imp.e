--| FIXME Not for release
indexing
	description: "Eiffel Vision scrollable area, Mswindows implementation."
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
			default_ex_style,
			move_and_resize,
			top_level_window_imp,
			make
		select
			move_to
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			default_ex_style,
			move_and_resize,
			top_level_window_imp
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Initialize. 
		do
			base_make (an_interface)

			check
				to_be_implemented: False
			end

			--{EV_WEL_CONTROL_CONTAINER_IMP} Precursor
			--set_text ("Scrollable Area")
			--!! scroller.make_with_options (Current, 0, 10, 0, 10, 10, 30, 10, 30)
		end

feature -- Access

	horizontal_step: INTEGER is
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on the horizontal scrollbar.
		do
			check
				to_be_implemented: False
			end
			--Result := scroller.horizontal_line
		end

	vertical_step: INTEGER is
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on the vertical scrollbar.
		do
			check
				to_be_implemented: False
			end
			--Result := scroller.vertical_line
		end

	is_horizontal_scrollbar_visible: BOOLEAN is
			-- Should horizontal scrollbar be displayed?
		do
			check
				to_be_implemented: False
			end
			--Result := minimal_horizontal_position /= maximal_horizontal_position
		end

	is_vertical_scrollbar_visible: BOOLEAN is
			-- Should vertical scrollbar be displayed?
		do
			check
				to_be_implemented: False
			end
			--Result := minimal_vertical_position /= maximal_vertical_position
		end

feature -- Element change

	set_horizontal_step (a_step: INTEGER) is
			-- Set `horizontal_step' to `a_step'.
		do
			check
				to_be_implemented: False
			end
			--scroller.set_horizontal_line (a_step)
		end

	set_vertical_step (a_step: INTEGER) is
			-- Set `vertical_step' to `a_step'.
		do
			check
				to_be_implemented: False
			end
			--scroller.set_vertical_line (a_step)
		end

	show_horizontal_scrollbar is
			-- Display horizontal scrollbar.
		do
			check
				to_be_implemented: False
			end
		end

	hide_horizontal_scrollbar is
			-- Do not display horizontal scrollbar.
		do
			check
				to_be_implemented: False
			end
		end

	show_vertical_scrollbar is
			-- Display vertical scrollbar.
		do
			check
				to_be_implemented: False
			end
		end

	hide_vertical_scrollbar is
			-- Do not display vertical scrollbar.
		do
			check
				to_be_implemented: False
			end
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

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		local
			cd: EV_WIDGET_IMP
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor (a_x, a_y, a_width, a_height, repaint)
	
			if child /= Void then
				cd := child

				-- If the container is bigger than the child, it simply resize it
				if client_width >= cd.minimum_width and client_height >= cd.minimum_height then
					set_vertical_range (0, 0)
					set_horizontal_range (0, 0)
					cd.set_move_and_size (0, 0, client_width, client_height)

				-- Only a vertical scroll bar, we adapt it
				elseif client_width >= cd.minimum_width then
					set_horizontal_range (0, 0)
					if cd.y < 0 then
						-- If it grows, we need to move the child.
						if client_height > cd.minimum_height + cd.y then
							vertical_update (client_height - cd.minimum_height - cd.y, 0)
						end
						cd.set_move_and_size (0, cd.y, client_width, cd.minimum_height)
						set_vertical_range (cd.y, (cd.minimum_height - client_height + cd.y).abs)
						set_vertical_position (0)
					else
						cd.set_move_and_size (0, 0, client_width, cd.minimum_height)
						set_vertical_range (0, cd.minimum_height - client_height)
					end

				-- Only an horizontal scroll bar, we adapt it
				elseif client_height >= cd.minimum_height then
					set_vertical_range (0, 0)
					if cd.x < 0 then
						-- If it grows, we need to move the child.
						if client_width > cd.minimum_width + cd.x then
							horizontal_update (client_width - cd.width - cd.x, 0)
						end
						cd.set_move_and_size (cd.x, 0, cd.minimum_width, client_height)
						set_horizontal_range (cd.x, (cd.minimum_width - client_width + cd.x).abs)
						set_horizontal_position (0)
					else
						cd.set_move_and_size (0, 0, cd.minimum_width, client_height)
						set_horizontal_range (0, cd.minimum_width - client_width)
					end

				-- Both scroll bars are shown
				else
					if cd.x < 0 and cd.y < 0 then
							-- If it grows, we need to move the child.
						if client_width > cd.minimum_width + cd.x then
							horizontal_update (client_width - cd.width - cd.x, 0)
						end
						if client_height > cd.minimum_height + cd.y then
							vertical_update (client_height - cd.height - cd.y, 0)
						end
						cd.set_move_and_size (cd.x, cd.y, cd.minimum_width, cd.minimum_height)
						set_horizontal_range (cd.x, (cd.minimum_width - client_width + cd.x).abs)
						set_vertical_range (cd.y, (cd.minimum_height - client_height + cd.y).abs)
						set_horizontal_position (0)
						set_vertical_position (0)
					elseif cd.x < 0 then
						if client_width > cd.minimum_width + cd.x then
							horizontal_update (client_width - cd.width - cd.x, 0)
						end
						cd.set_move_and_size (cd.x, 0, cd.minimum_width, cd.minimum_height)
						set_horizontal_range (cd.x, (cd.minimum_width - client_width + cd.x).abs)
						set_vertical_range (0, cd.minimum_height - client_height)
						set_horizontal_position (0)
					elseif cd.y <= 0 then
						if client_height > cd.minimum_height + cd.y then
							vertical_update (client_height - cd.height - cd.y, 0)
						end
						cd.set_move_and_size (0, cd.y, cd.minimum_width, cd.minimum_height)
						set_horizontal_range (0, cd.minimum_width - client_width)
						set_vertical_range (cd.y, (cd.minimum_height - client_height + cd.y).abs)
						set_vertical_position (0)
					else
						cd.set_move_and_size (0, 0, cd.minimum_width, cd.minimum_height)
						set_horizontal_range (0, cd.minimum_width - client_width)
						set_vertical_range (0, cd.minimum_height - client_height)
					end
				end
			end
		end

	default_ex_style: INTEGER is
			-- The default ex-style of the window.
		do
			Result := {EV_WEL_CONTROL_CONTAINER_IMP} Precursor + Ws_ex_clientedge
		end

feature {NONE} -- Implementation

	interface: EV_VIEWPORT

	top_level_window_imp: EV_WINDOW_IMP

end -- class EV_SCROLLABLE_AREA_IMP

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
