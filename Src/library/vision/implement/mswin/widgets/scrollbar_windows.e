indexing 
	description: "This represents a scrollbar";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	SCROLLBAR_WINDOWS
  
inherit

	SCROLLBAR_I

	PRIMITIVE_WINDOWS
		redefine
			set_width, 
			set_height,
			set_size
		end

	WEL_SBS_CONSTANTS
		-- temporary
	
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
			set_font as wel_set_font
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
			on_key_down
		end

	SIZEABLE_WINDOWS

creation

	make

feature {NONE} -- Initialization

	make (a_scrollbar: SCROLLBAR; man: BOOLEAN;  oui_parent: COMPOSITE) is
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			identifier := a_scrollbar.identifier
			managed := man
			set_default
		end
 
feature -- Access

	granularity: INTEGER

	minimum, maximum: INTEGER

	position: INTEGER

	initial_delay: INTEGER
			-- Amount of time to wait (milliseconds) before starting
			-- continuous slider movement

	repeat_delay: INTEGER
			-- Amount of time to wait (milliseconds) between subsequent
			-- slider movements after the initial delay

	slider_size: INTEGER
			-- Size of slider.

feature -- Status report

	is_horizontal : BOOLEAN

	vertical: BOOLEAN is
		do
			Result := not is_horizontal
		end

	is_maximum_right_bottom : BOOLEAN

feature -- Status setting

	set_maximum_right_bottom (flag: BOOLEAN) is
		do
			is_maximum_right_bottom := flag
		end

	set_position (p: INTEGER) is
		do
			position := p
			if exists then
				wel_set_position (p)
			end
		end

	realize is
			-- Create a scrollbar and display it
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				wc ?= parent
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
				set_minimum (minimum)
				set_maximum (maximum)
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
                        -- Set size of slider to 'new_size'.
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
                        -- Set the height to `new_height' and the
                        -- width to `new_width'.
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

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		local
			a_style: INTEGER
			wc: WEL_COMPOSITE_WINDOW
		do
			if flag /= is_horizontal then
				is_horizontal := flag
				if realized then
					a_style := Ws_child + Ws_tabstop + Ws_visible
					if is_horizontal then
						a_style := a_style + Sbs_horz
					else
						a_style := a_style + Sbs_vert
					end
					wel_destroy
					wc ?= parent
					make_horizontal (wc, x, y, width, height, id_default)
					set_height (width)
					set_width (height)
				end
			end
		end

	set_minimum (m: INTEGER) is
		do
			minimum := m
			if exists then
				wel_set_minimum (m)
			end
		end

	set_maximum (m: INTEGER) is
		do
			maximum := m
			if exists then
				wel_set_maximum (m)
			end
		end

feature -- Element change

	set_granularity (g: INTEGER) is
		do
			granularity := g
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
			set_granularity (1)
			page_delta := 10
			line_delta := 1
		end

	has_height: BOOLEAN

	has_width: BOOLEAN

	identifier: STRING

	process_scroll_notification (notification_code, a_position: INTEGER) is
		do
			debug ("SCROLLBAR")
				print ("SCROLLBAR.process_scroll_notification")
			end
			if notification_code = sb_pagedown then
				wel_set_position ((wel_position + page_delta).min (maximum))
				on_position_change (notification_code, a_position)
			elseif notification_code = sb_linedown then
				wel_set_position ((wel_position + line_delta).min (maximum))
				on_position_change (notification_code, a_position)
			elseif notification_code = sb_pageup then
				wel_set_position ((wel_position - page_delta).max (minimum))
				on_position_change (notification_code, a_position)
			elseif notification_code = sb_lineup then
				wel_set_position ((wel_position - line_delta).max (minimum))
				on_position_change (notification_code, a_position)
			elseif notification_code = sb_top then
				wel_set_position (maximum)
				on_position_change (notification_code, a_position)
			elseif notification_code = sb_bottom then
				wel_set_position (minimum)
				on_position_change (notification_code, a_position)
			elseif notification_code = sb_thumbposition then
				wel_set_position (a_position)
				io.put_string ("thumbposition%N")
				on_position_change (notification_code, a_position)
			elseif notification_code = sb_thumbtrack then
				wel_set_position (a_position)
				io.put_string ("thumbtrack%N")
				on_track (notification_code, a_position)
			end
		end;	

	page_delta, line_delta: INTEGER

	on_position_change (a_code, a_position: INTEGER) is
		local
			cd: SCROLLING_DATA_WINDOWS
		do
			!! cd.make (owner, a_code, a_position, vertical)
			value_changed_actions.execute (Current, cd)
		end

	on_track (a_code, a_position: INTEGER) is
		local
			cd: SCROLLING_DATA_WINDOWS
		do
			!! cd.make (owner, a_code, a_position, vertical)
			move_actions.execute (Current, cd)
		end

	wel_set_maximum (m: INTEGER) is
		do
			set_range (minimum, m)
		end

	wel_set_minimum  (m: INTEGER) is
		do
			set_range (m, maximum)
		end

end -- class SCROLLBAR_WINDOWS
 
--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
