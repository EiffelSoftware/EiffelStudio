indexing
	description:
		"EiffelVision scrollable area, mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit
	EV_SCROLLABLE_AREA_I

	EV_SINGLE_CHILD_CONTAINER_IMP

	EV_WEL_CONTROL_CONTAINER_IMP
		redefine
			make,
			default_ex_style,
			move_and_resize,
			top_level_window_imp
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a scrollable area container.
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor
			set_text ("Scrollable Area")
			!! scroller.make_with_options (Current, 0, 10, 0, 10, 10, 30, 10, 30)
		end

feature -- Access

	top_level_window_imp: EV_UNTITLED_WINDOW_IMP
			-- Top level window that contains the current widget.

	horizontal_step: INTEGER is
			-- Step of the horizontal scrolling
			-- ie : the user clicks on a horizontal arrow
		do
			Result := scroller.horizontal_line
		end

	horizontal_leap: INTEGER is
			-- Leap of the horizontal scrolling
			-- ie : the user clicks on the horizontal scroll bar
		do
			Result := scroller.horizontal_page
		end

	vertical_step: INTEGER is
			-- Step of the vertical scrolling
			-- ie : the user clicks on a vertical arrow
		do
			Result := scroller.vertical_line
		end

	vertical_leap: INTEGER is
			-- Leap of the vertical scrolling
			-- ie : the user clicks on the vertical scroll bar
		do
			Result := scroller.vertical_page
		end

	horizontal_value: INTEGER is
			-- Current position of the horizontal scroll bar
		do
			if horizontal_bar_shown then
				if minimal_horizontal_position /= 0 then
					Result := 100 * horizontal_position // (maximal_horizontal_position - minimal_horizontal_position)
				else
					Result := 100 * horizontal_position // maximal_horizontal_position
				end
			end
		end

	vertical_value: INTEGER is
			-- Current position of the vertical scroll bar
		do
			if vertical_bar_shown then
				if minimal_vertical_position /= 0 then
					Result := 100 * vertical_position // (maximal_vertical_position - minimal_vertical_position)
				else
					Result := 100 * vertical_position // maximal_vertical_position
				end
			end
		end

	horizontal_minimum: INTEGER is
			-- Minimal position on the horizontal scroll bar
		do
			Result := minimal_horizontal_position
		end

	vertical_minimum: INTEGER is
			-- Maximal position on the vertical scroll bar
		do
			Result := minimal_vertical_position
		end

	horizontal_maximum: INTEGER is
			-- Maximal position on the horizontal scroll bar
		do
			Result := maximal_horizontal_position
		end

	vertical_maximum: INTEGER is
			-- Maximal position on the vertical scroll bar
		do
			Result := maximal_vertical_position
		end

feature -- Status report

	horizontal_bar_shown: BOOLEAN is
			-- Is the horizontal scrool-bar shown?
		do
			Result := minimal_horizontal_position /= maximal_horizontal_position
		end

	vertical_bar_shown: BOOLEAN is
			-- Is the vertical scrool-bar shown?
		do
			Result := minimal_vertical_position /= maximal_vertical_position
		end

feature -- Element change

	set_top_level_window_imp (a_window: EV_UNTITLED_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			top_level_window_imp := a_window
			if child /= Void then
				child.set_top_level_window_imp (a_window)
			end
		end

	set_horizontal_step (value: INTEGER) is
			-- Make `value' the new horizontal step.
		do
			scroller.set_horizontal_line (value)
		end

	set_vertical_step (value: INTEGER) is
			-- Make `value' the new vertical step.
		do 
			scroller.set_vertical_line (value)
		end

	set_horizontal_leap (value: INTEGER) is
			-- Make `value' the new horizontal leap.
		do
			scroller.set_horizontal_page (value)
		end

	set_vertical_leap (value: INTEGER) is
			-- Make `value' the new vertical leap.
		do
			scroller.set_vertical_page (value)
		end

	set_horizontal_value (value: INTEGER) is
			-- Make `value' the new horizontal value where `value' is given in percentage.
		local
			step: INTEGER
		do
			if horizontal_bar_shown then
				step := (maximal_horizontal_position - minimal_horizontal_position) * value // 100
				step := step + minimal_horizontal_position
				horizontal_update (horizontal_position - step, step)
			end
		end

	set_vertical_value (value: INTEGER) is
			-- Make `value' the new vertical value where `value' is given in percentage.
		local
			step: INTEGER
		do
			if vertical_bar_shown then
				step := (maximal_vertical_position - minimal_vertical_position) * value // 100
				step := step + minimal_vertical_position
				vertical_update (vertical_position - step, step)
			end
		end

feature {NONE} -- Implementation

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

feature {NONE} -- WEL Implementation

	default_ex_style: INTEGER is
			-- The default ex-style of the window.
		do
			Result := {EV_WEL_CONTROL_CONTAINER_IMP} Precursor + Ws_ex_clientedge
		end

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
