indexing
	description: "This class represents a MS_WINDOWS scale";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	SCALE_IMP

inherit
	SCALE_I
		redefine
			valid_minimum,
			valid_maximum
		end

	PRIMITIVE_IMP
		redefine
			set_width,
			on_size
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			height as wel_height,
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
			font as wel_control_font,
			set_font as wel_control_set_font
		export
			{SCALE_SCROLL_BAR_WINDOWS}
				on_left_button_down,
				on_left_button_up,
				on_right_button_down,
				on_right_button_up,
				on_mouse_move
		undefine
			on_hide,
			on_show,
			on_size,
			on_move,
			on_destroy,
			on_left_button_up,
			on_key_up,
			on_key_down,
			on_right_button_up,
			on_left_button_down,
			on_right_button_down,
			on_mouse_move,
			on_set_cursor,
			class_background,
			background_brush
		redefine
			on_size,
			on_vertical_scroll_control,
			on_horizontal_scroll_control,
			class_name
		end

	SIZEABLE_WINDOWS

	WEL_SS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_scale: SCALE; man: BOOLEAN; oui_parent: COMPOSITE) is
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			a_scale.set_font_imp (Current)
			managed := man
			set_default
		end

feature -- Access

	granularity: INTEGER
			-- Value of the amount to move the slider and modifie 
			-- the slide position value when a move action occurs

	value: INTEGER
			-- Return current position of the slider

	set_width (new_width: INTEGER) is
			-- Set width to `new_width'.
		do
			if private_attributes.width /= new_width then
				private_attributes.set_width (new_width)
				if exists then
					wel_set_width (new_width)
					scroll_bar.set_width (new_width)
				end;
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

feature -- Status report

	is_value_shown: BOOLEAN
			-- Is the value shown?

	is_output_only: BOOLEAN
			-- Is current widget output only?

	text: STRING
			-- Text of current widget

	is_horizontal: BOOLEAN 
			-- Is this slider horizontal?

	maximum: INTEGER
			-- Return the maximum value of the scroll bar

	minimum: INTEGER
			-- Return the minimum value of the scroll bar

	is_maximum_right_bottom: BOOLEAN 
			-- Is the maximum at the right/bottom?

feature -- Status setting

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		do
			is_horizontal := flag
			if exists then
				scroll_bar.destroy
				if flag then
					!! scroll_bar.make_horizontal (Current, 0, 0, 0, 0 , scroll_bar_id)
				else
					!! scroll_bar.make_vertical (Current, 0, 0, 0, 0, scroll_bar_id)
				end					
				on_size (0, width, height)
			end
		end

	set_output_only (f: BOOLEAN) is
			-- Set current output only
			-- if `f' and output read else.
		do
			is_output_only := f
		end

	set_text (t: STRING) is
			-- Set the text to `t'.
		do
			text := clone (t)
			if exists then
				text_static.set_text (text)
			end
		end

	realize is
			-- Realize current widget.
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not exists then
				resize_for_shell
				wc ?= parent
				make_with_coordinates (wc, "", x, y, width, height)
				if is_horizontal then
					if (height = 0) then
						set_height (20)
					end
					if (width = 0) then
						set_width (100)
					end
					!! text_static.make (Current, text, 0, value_height + scroll_height, width, (height - value_height - scroll_height).max (0), id_default)
					!! value_static.make (Current, "" , 0, 0, 0, 0, id_default)
					!! scroll_bar.make_horizontal (Current, 0, text_height, width, scroll_height, scroll_bar_id)
				else
					if height = 0 then set_height (100) end
					if width = 0 then set_width (20) end
					!! text_static.make (Current, text, scroll_width + value_width, 0,(width  - value_width - scroll_width).max (0), 0, id_default)
					!! value_static.make (Current, "", 0, 0, 0, 0, id_default)
					value_static.set_style (Ws_visible + Ws_child + Ws_group +
						Ws_tabstop + Ss_right)
					!! scroll_bar.make_vertical (Current, value_width, 0, scroll_width, height, scroll_bar_id)
				end
				if not is_value_shown then 
					value_static.hide
				end
				set_maximum (maximum)
				set_minimum (minimum)
				on_size (0, width, height)
				set_value (value)
				--update_value_static
			end
		end

	set_value_shown (f: BOOLEAN) is
			-- Show or hide the value.
		do
			is_value_shown := f
			if exists and shown then
				if f then
					value_static.show
				else
					value_static.hide
				end
			end
		end

	show_value (f: BOOLEAN) is
			-- Show or hide the value.
		do
			set_value_shown (f)
		end

feature -- Element change

	set_granularity (a_granularity: INTEGER) is
			-- Set amount to move the slider and modifie the slide
			-- position value when a move action occurs to
		do
			granularity := a_granularity
		end

	set_maximum (a_max: INTEGER) is
			-- Set maximum value of slider position to `a_max'.
		do
			maximum := a_max
			if exists  then
				scroll_bar.set_range (minimum, maximum)
			end
		ensure then
			maximum = a_max
		end

	set_minimum (a_min: INTEGER) is
			-- Set minimum value of slider position to `a_min'.
		do
			minimum := a_min
			if exists then
				scroll_bar.set_range (minimum, maximum)
			end
		end

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise
		do
			is_maximum_right_bottom := flag
		end

	set_value (a_value: INTEGER) is
			-- Set the position of the scroll bar to `a_value'.
		do
			value := a_value
			if exists then
				if is_maximum_right_bottom then
					scroll_bar.set_position (a_value)
				else
					scroll_bar.set_position (maximum - a_value + minimum)
				end
				update_value_static
			end
		end

	set_default is
			-- Set default values.
		do
			set_form_width (100)
			set_form_height (100)
			set_maximum (100)
			set_minimum (0)
			set_granularity (1)
			show_value (True)
			set_maximum_right_bottom (True)
			set_text ("")
		end

	add_move_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved
		do
				--| Guillaume added the test
			if managed then
				move_actions.add (Current, a_command, arg)
			end
		end

	add_value_changed_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		do
				--| Guillaume added the test
			if managed then
				value_changed_actions.add (Current, a_command, arg)
			end
		end

feature -- Removal

	remove_move_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' to the list of action to execute when slide
			-- is moved
		do
			move_actions.remove (Current, a_command, arg)
		end

	remove_value_changed_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		do
			value_changed_actions.remove (Current, a_command, arg)
		end

feature {NONE} -- Implementation

	on_size (a_type, a_width, a_height: INTEGER) is
			-- Respond to a resize of current window.
		local
			resize_data: RESIZE_CONTEXT_DATA
		do
			!! resize_data.make (owner, a_width, a_height, a_type)
			if is_horizontal then
				scroll_bar.resize (width, scroll_height)
				scroll_bar.move (0, text_height)
				text_static.resize (width, (height - value_height - scroll_height).max (0))
				text_static.move (0, value_height + scroll_height)
			else
				scroll_bar.resize (scroll_width, height)
				scroll_bar.move (value_width, 0)
				text_static.resize ((width  - value_width - scroll_width).max (0),  height)
				text_static.move (scroll_width + value_width, 0)
			end
			update_value_static
			private_attributes.set_width (a_width)
			private_attributes.set_height (a_height)
			resize_actions.execute (Current, resize_data)
		end

	on_vertical_scroll_control (scroll_code, a_position: INTEGER;
			bar: WEL_BAR) is
			-- Vertical scroll is received with a
			-- `scroll_code' type. `a_position' is
			-- the new scrollbox position. `bar'
			-- indicates the scrollbar or trackbar
			-- control activated.
		do
			if managed then
				on_scroll (scroll_code, a_position, bar) 
			end
		end

	on_horizontal_scroll_control (scroll_code, a_position: INTEGER;
			bar: WEL_BAR) is
			-- Horizontal scroll is received with a
			-- `scroll_code' type. `a_position' is
			-- the new scrollbox position. `bar'
			-- indicates the scrollbar or trackbar
			-- control activated.
		do
				on_scroll (scroll_code, a_position, bar) 
		end

	on_scroll  (scroll_code, a_position: INTEGER;
			bar: WEL_BAR) is
			-- Horizontal or vertical scroll is received with a
			-- `scroll_code' type. `a_position' is
			-- the new scrollbox position. `bar'
			-- indicates the scrollbar or trackbar
			-- control activated.
		local
			scale_data: CONTEXT_DATA
		do
			if not is_output_only then
				if is_maximum_right_bottom then
					if scroll_code = Sb_linedown or else scroll_code = Sb_lineright then
						value := (value + granularity).min (maximum)
					elseif  scroll_code = Sb_pagedown or else scroll_code = Sb_pageright then
						value := (value + granularity * 10).min (maximum)
					elseif  scroll_code = Sb_lineup or else scroll_code = Sb_lineleft then
						value := (value - granularity).max (minimum)
					elseif  scroll_code = Sb_pageup or else scroll_code = Sb_pageleft then
						value := (value - granularity * 10).max (minimum)
					elseif scroll_code = Sb_bottom or else scroll_code = Sb_right then
						value := maximum
					elseif scroll_code = Sb_top or else scroll_code = Sb_left then
						value := minimum
					elseif scroll_code = Sb_thumbposition then
						value := a_position
					elseif scroll_code = Sb_thumbtrack then
						value := a_position
						!! scale_data.make (widget_oui)
						move_actions.execute (Current, scale_data)
					end
					set_value (value)
				else
					if scroll_code = Sb_linedown or else scroll_code = Sb_lineright then
						value := (value - granularity).max (minimum)
					elseif  scroll_code = Sb_pagedown or else scroll_code = Sb_pageright then
						value := (value - granularity * 10).max (minimum)
					elseif  scroll_code = Sb_lineup or else scroll_code = Sb_lineleft then
						value := (value + granularity).min (maximum)
					elseif  scroll_code = Sb_pageup or else scroll_code = Sb_pageleft then
						value := (value + granularity * 10).min (maximum)
					elseif scroll_code = Sb_bottom or else scroll_code = Sb_right then
						value := minimum
					elseif scroll_code = Sb_top or else scroll_code = Sb_left then
						value := maximum
					elseif scroll_code = Sb_thumbposition then
						value := maximum - a_position
					elseif scroll_code = Sb_thumbtrack then
						value := maximum - a_position
						!! scale_data.make (widget_oui)
						move_actions.execute (Current, scale_data)
					end
					set_value (maximum - value)
				end
				--update_value_static
				!! scale_data.make (widget_oui)
				value_changed_actions.execute (Current, scale_data)
			end
		end

	update_value_static is
			-- update the text of the value static.
		require
			exists: exists
		do
			value_static.set_text (value.out)
			if is_horizontal then
				if not is_maximum_right_bottom then
					value_static.resize (value_width, text_height)
					value_static.move (((width - value_width) * (maximum - value)) // (maximum - minimum), 0)
				else
					value_static.resize (value_width, text_height)
					value_static.move (((width - value_width) * (value - minimum)) // (maximum - minimum), 0)
				end
			else
				if not is_maximum_right_bottom then
					value_static.resize (value_width, text_height)
					value_static.move (0, ((height - text_height) * (maximum - value)) // (maximum - minimum))
				else
					value_static.resize (value_width, text_height)
					value_static.move (0, ((height - text_height) * (value - minimum)) // (maximum - minimum))
				end
			end
		end	

	valid_minimum (a_minimum: INTEGER): BOOLEAN is
			-- Is `a_minimum' valid?
		do
			Result := precursor (a_minimum) and a_minimum >= -32768
		end

	valid_maximum (a_maximum: INTEGER): BOOLEAN is
			-- Is `a_maximum' valid?
		do
			Result := precursor (a_maximum) and a_maximum < 32768
		end

	scroll_bar: SCALE_SCROLL_BAR_WINDOWS
			-- Implementation of the scroll bar

	scroll_bar_id: INTEGER is 100
			-- Identifier of the scroll bar

	value_static: WEL_STATIC
			-- Static for the value

	text_static: WEL_STATIC
			-- Static for the text

	text_height: INTEGER is 20
			-- Default value of statics

	value_height: INTEGER is 20
			-- Default value of statics

	value_width: INTEGER is 45
			-- default value of the value static

	scroll_width: INTEGER is
			-- default width of a vertical scroll bar
		do
			Result := (width - value_width).max (15)
		end

	scroll_height: INTEGER is
			-- default width of a vertical scroll bar
		do
			Result := (height - 40).max (15)
		end

	wel_font: WEL_FONT

	wel_set_font (f:WEL_FONT) is
		do
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionScale"
		end

invariant
	valid_scroll_bar: exists implies (scroll_bar /= Void implies scroll_bar.exists)	
	valid_text_static: exists implies (text_static /= Void implies text_static.exists)	
	valid_value_static: exists implies (value_static /= Void implies value_static.exists)

end -- class SCALE_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

