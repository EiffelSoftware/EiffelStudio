indexing 
	description: "Implementation of a scrollbar widget on Windows";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	SCROLLBAR_IMP
 
inherit

	SCROLLBAR_I

	PRIMITIVE_IMP
		redefine
			set_width, 
			set_height,
			set_size
		end

	WEL_SCROLL_BAR
		rename
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			shown as wel_shown,
			parent as wel_parent,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			move as wel_move,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture, 
			release_capture as wel_release_capture,
			item as wel_item,
			position as wel_position,
			set_position as wel_set_position,
			minimum as wel_minimum,
			maximum as wel_maximum,
			font as wel_font,
			set_font as wel_set_font,
			foreground_color as wel_foreground_color,
			background_color as wel_background_color,
			is_horizontal as wel_is_horizontal
		undefine
			on_hide,
			on_show,
			on_size,
			on_move,
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_destroy,
			on_set_cursor,
			on_key_up,
			on_key_down,
			background_brush
		redefine
			on_scroll
		end

	SIZEABLE_WINDOWS

creation

	make

feature {NONE} -- Initialization

	make (a_scrollbar: SCROLLBAR; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a scrollbar with `a_scrollbar' as identifier,
			-- `oui_parent' as parent managed or unmanaged and call `set_default'.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			identifier := a_scrollbar.identifier
			managed := man
			set_default
		end
 
feature -- Access

	line_increment: INTEGER
			-- Distance (amount) to scroll on arrows

	page_increment: INTEGER
			-- Distance (amount) to scroll on page down or up

	minimum, maximum: INTEGER
			-- Minimum and maximum position of scrollbar

	position: INTEGER
			-- Current position

	initial_delay: INTEGER
			-- Amount of time to wait (milliseconds) before starting
			-- continuous slider movement

	repeat_delay: INTEGER
			-- Amount of time to wait (milliseconds) between subsequent
			-- slider movements after the initial delay

	slider_size: INTEGER
			-- Size of slider.

feature -- Status report

	is_maximum_right_bottom: BOOLEAN
			-- Is maximum on right/bottom?

	is_horizontal : BOOLEAN
			-- Is scrollbar horizontal or vertical

feature -- Status setting

	realize is
			-- Create a scrollbar and display it
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				wc ?= parent
				check
					wc /= void
				end
				resize_for_shell
				if is_horizontal then
					if not has_height then set_height (20) end
					if not has_width then set_width (100) end
					make_horizontal (wc, x, y, width, height, id_default);
				else
					if not has_height then set_height (100) end
					if not has_width then set_width (20) end
					make_vertical (wc, x, y, width, height, id_default)
				end
				wel_set_minimum (minimum)
				wel_set_maximum (maximum)
				set_position (position)
			end
		end

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum to be on bottom or right if 'flag'
			-- set maximum to be on left or top otherwise
		do
			is_maximum_right_bottom := flag
		end

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if flag /= is_horizontal then
				is_horizontal := flag
				if realized then
					wel_destroy
					wc ?= parent
					check
						wc /= void
					end
					if is_horizontal then
						make_horizontal (wc, x, y, width, height, id_default)
					else
						make_vertical (wc, x, y, width, height, id_default)
					end
					wel_set_minimum (minimum)
					wel_set_maximum (maximum)
					set_position (position)
				end
			end
		end

	set_initial_delay (a_time: INTEGER) is
			-- Set the amount of time to wait (milliseconds) before
			-- starting continuous slider movement to `new_delay'.

		do
			initial_delay := a_time
		end

	set_repeat_delay (a_time: INTEGER) is
			-- Set the amount of time to wait (milliseconds) between
			-- subsequent movements after the initial delay to 'new_delay'.
		do
			repeat_delay := a_time
		end

	set_slider_size (a_size: INTEGER) is
			-- Set size of slider to 'a_size'.
		do
			slider_size := a_size
		end

	set_height (new_height: INTEGER) is
			-- Set the height to `new_height'
		do
			has_height := True
			if private_attributes.height /= new_height then
				private_attributes.set_height (new_height)
				if exists then
					wel_set_height (new_height)
				end
			end
		end

	set_size (new_width, new_height : INTEGER) is
				-- Set the height to `new_height' 
				-- and the width to `new_width'.
		do
			has_width := True
			has_height := True
			if private_attributes.width /= new_width
			or else private_attributes.height /= new_height then
				private_attributes.set_width (new_width)
				private_attributes.set_height (new_height)
				if exists then
					resize (new_width, new_height)
				end
			end
		end

	set_width (new_width: INTEGER) is
			-- Set the width to `new_width'
		do
			has_width := True
			if private_attributes.width /= new_width then
				private_attributes.set_width (new_width)
				if exists then
					wel_set_width (new_width)
				end
			end
		end

	set_minimum (m: INTEGER) is
			-- Set minimum value of the scrollbar
		do
			minimum := m
			if exists then
				wel_set_minimum (m)
			end
		end

	set_maximum (m: INTEGER) is
			-- Set maximum value of the scrollbar
		do
			maximum := m
			if exists then
				wel_set_maximum (m)
			end
		end

feature -- Element change

	set_position (p: INTEGER) is
			-- Set scrollbar position
		do
			position := p
			if exists then
				if is_maximum_right_bottom then
					wel_set_position (p)
				else
					wel_set_position (maximum - p)
				end
			end
		end;

	set_line_increment (inc: INTEGER) is
			-- Set amount (distance) to move when arrow is pressed
		do
			line_increment := inc
		end

	set_page_increment (inc: INTEGER) is
			--Set amount (distance) to move for page down or up
		do
			page_increment := inc
		end

	add_move_action (c: COMMAND; arg: ANY) is
		do
			move_actions.add (Current, c, arg)
		end

	add_value_changed_action (c: COMMAND; arg: ANY) is
		do
			value_changed_actions.add (Current, c, arg)
		end

 	remove_move_action (c: COMMAND; arg: ANY) is
		do
			move_actions.remove (Current, c, arg)
		end

	remove_value_changed_action (c: COMMAND; arg: ANY) is
		do
			value_changed_actions.remove (Current, c, arg)
		end	

feature {NONE} -- Implementation

	set_default is
		do
			set_maximum (100)
			set_minimum (0)
			page_increment := 10
			line_increment := 1
		end

	has_height: BOOLEAN
		-- Has height been set?

	has_width: BOOLEAN
		-- Has width been set?

	identifier: STRING

	on_scroll (notification_code, a_position: INTEGER) is
		do
			if is_maximum_right_bottom then 
				if notification_code = Sb_pagedown then
					set_position ((position + page_increment).min (maximum))
					on_position_change (notification_code, position)
				elseif notification_code = Sb_linedown then
					set_position ((position + line_increment).min (maximum))
					on_position_change (notification_code, position)
				elseif notification_code = Sb_pageup then
					set_position ((position - page_increment).max (minimum))
					on_position_change (notification_code, position)
				elseif notification_code = Sb_lineup then
					set_position ((position - line_increment).max (minimum))
					on_position_change (notification_code, position)
				elseif notification_code = Sb_top then
					set_position (minimum)
					on_position_change (notification_code, position)
				elseif notification_code = Sb_bottom then
					set_position (maximum)
					on_position_change (notification_code, position)
				elseif notification_code = Sb_thumbposition then
					set_position (a_position)
					on_position_change (notification_code, a_position)
				elseif notification_code = Sb_thumbtrack then
					set_position (a_position)
					on_track (notification_code, a_position)
				end
			else
				if notification_code = Sb_pagedown then
					set_position ((position - page_increment).max (minimum))
					on_position_change (notification_code, position)
				elseif notification_code = Sb_linedown then
					set_position ((position - line_increment).max (minimum))
					on_position_change (notification_code, position)
				elseif notification_code = Sb_pageup then
					set_position ((position + page_increment).min (maximum))
					on_position_change (notification_code, position)
				elseif notification_code = Sb_lineup then
					set_position ((position + line_increment).min (maximum))
					on_position_change (notification_code, position)
				elseif notification_code = Sb_top then
					set_position (maximum)
					on_position_change (notification_code, position)
				elseif notification_code = Sb_bottom then
					set_position (minimum)
					on_position_change (notification_code, position)
				elseif notification_code = Sb_thumbposition then
					set_position (maximum - a_position)
					on_position_change (notification_code, a_position)
				elseif notification_code = Sb_thumbtrack then
					set_position (maximum - a_position)
					on_track (notification_code, a_position)
				end
			end
		end;	

	on_position_change (a_code, a_position: INTEGER) is
		local
			cd: SCROLLING_DATA_WINDOWS
		do
			!! cd.make (owner, a_code, a_position, not is_horizontal)
			value_changed_actions.execute (Current, cd)
		end

	on_track (a_code, a_position: INTEGER) is
		local
			cd: SCROLLING_DATA_WINDOWS
		do
			!! cd.make (owner, a_code, a_position, not is_horizontal)
			move_actions.execute (Current, cd)
		end

	wel_set_maximum (m: INTEGER) is
		do
			set_range (minimum, m)
		end

	wel_set_minimum (m: INTEGER) is
		do
			set_range (m, maximum)
		end

end -- class SCROLLBAR_IMP
 
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

