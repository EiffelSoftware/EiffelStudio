indexing

	description: 
		"EiffelVision implementation of a Motif scale.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	SCALE_IMP

inherit

	SCALE_I;

	FONTABLE_IMP;

	MANAGER_IMP
		rename 
			x as p_x,
			y as p_y,
			set_x as p_set_x,
			set_y as p_set_y,
			set_size as p_set_size,
			set_width as p_set_width,
			set_height as p_set_height,
			is_shown as shown
		undefine
			create_callback_struct
		redefine
			set_background_color_from_imp,
			width, height, real_x, real_y, set_x_y, 
			set_action, add_button_press_action,
			add_button_release_action, add_button_motion_action,
			add_enter_action, add_key_press_action, add_key_release_action,
			add_leave_action, add_pointer_motion_action,
			remove_button_motion_action, remove_button_press_action,
			remove_button_release_action, remove_enter_action, remove_key_press_action,
			remove_key_release_action, remove_leave_action,
			remove_pointer_motion_action, remove_action, grab, 
			ungrab
		end;

	MANAGER_IMP
		rename
			is_shown as shown
		undefine
			create_callback_struct
		redefine
			set_size, set_width, set_height, 
			set_background_color_from_imp,
			update_background_color, 
			width, height, x, y,
			real_x, real_y, set_x, set_y, set_x_y,
			set_action, add_button_press_action,
			add_button_release_action, add_button_motion_action,
			add_enter_action, add_key_press_action, add_key_release_action,
			add_leave_action, add_pointer_motion_action,
			remove_button_motion_action, remove_button_press_action,
			remove_button_release_action, remove_enter_action, remove_key_press_action,
			remove_key_release_action, remove_leave_action,
			remove_pointer_motion_action, remove_action, grab, 
			ungrab
		select
			set_size, set_width, set_height, x, y, set_x, set_y
		end;
	
	MEL_SCALE
		rename
			make as mel_scale_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			set_horizontal as mel_set_horizontal,
			set_vertical as mel_set_vertical,
			scale_multiple as granularity,
			set_scale_multiple as set_granularity,
			is_shown as shown
		redefine
			width, height, x, y, real_x, real_y, set_x, set_y,
			set_x_y, set_height, set_width, set_size
		end

creation

	make

feature {NONE} -- Initialization

	make (a_scale: SCALE; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif scale.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_scale_make (a_scale.identifier, mc, man);
			a_scale.set_font_imp (Current);
		end;

feature -- Status report

	real_x: INTEGER is
		do
			Result := scroll_bar.real_x
		end;

	real_y: INTEGER is
		do
			Result := scroll_bar.real_y
		end;

	x: INTEGER is
		do
			Result := p_x + scroll_bar.x
		end;

	y: INTEGER is
		do
			Result := p_y + scroll_bar.y
		end;

	height: INTEGER is
		do
			Result := scroll_bar.height
		end;

	width: INTEGER is
		do
			Result := scroll_bar.width
		end;

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		do
			Result := not is_maximum_on_left or else
				not is_maximum_on_top
		end;

	is_output_only: BOOLEAN is
			-- Is scale mode output only mode?
		do
			Result := not is_sensitive
		end;

	text: STRING is
			-- Scale text
		local
			ms: MEL_STRING
		do
			ms := title_string;
			if ms = Void then
				!! Result.make (0);
			else
				Result := ms.to_eiffel_string;
				ms.destroy
			end;
		end;

feature -- Status setting

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		local
			list: VISION_COMMAND_LIST
		do
			!! list.make;
			scroll_bar.set_translation (a_translation, list, Void);
			list.add_command (a_command, argument)
		end;

	set_value_shown (flag: BOOLEAN) is
		do
			if flag then	
				show_value
			else
				hide_value
			end
		end;

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		local
			old_length: INTEGER;
		do
			if is_horizontal then
				old_length := width;
			else
				old_length := height;
			end;

			if flag then
				mel_set_horizontal
			else
				mel_set_vertical
			end;

			if old_length /= 0 then
				if is_horizontal then
					set_width (old_length);
				else
					set_height (old_length);
				end;
			end;   
		end;

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise.
		do
			if flag then
				if is_horizontal then
					set_maximum_on_right
				else
					set_maximum_on_bottom
				end
			else
				if is_horizontal then
					set_maximum_on_left
				else
					set_maximum_on_top
				end
			end
		end;

	set_output_only (flag: BOOLEAN) is
			-- Set scale mode to output only if `flag' and to input/output
			-- otherwise.
		do
			set_insensitive (flag)
		end;

	set_text (a_text: STRING) is
			-- Set scale text to `a_text'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_text);
			label.unmanage;
			set_title_string (ms);
			label.manage;
			ms.destroy
		end;

	set_size (new_width, new_height: INTEGER) is
			-- Set size to `new_width' and `new_height'.
		local
			tw, nw, nh: INTEGER;
			vas: STRING;
		do
			nw := new_width;
			nh := new_height;
			if (text = Void or else text.empty) and not is_value_shown then
				p_set_size (nw, nh);
			elseif is_horizontal then
				if is_value_shown and (text = Void or else text.empty) then
					p_set_size (nw, nh + label.height);
				elseif not is_value_shown then
					p_set_size (nw, nh + label.height);
				else
					p_set_size (nw, nh + (2 * label.height));
				end;
			else
				!! vas.make(0);
				if is_value_shown and (text = Void or else text.empty) then
					vas.append_integer (maximum);
					tw := font_width_of_string (vas);
					p_set_size (nw + tw, nh);
				elseif not is_value_shown then
					p_set_size (nw + label.width, nh);
				else
					vas.append_integer (maximum);
					tw := font_width_of_string (vas);
					p_set_size (nw + label.width + tw, nh);
				end;
			end;
			set_scale_size (nw, nh);
		end;

	set_width (new_width: INTEGER) is
			-- Set `width' to `new_width'.
		local
			tw, nw: INTEGER;
			vas: STRING;
		do
			nw := new_width;
			if (text = Void or else text.empty) and not is_value_shown then
				p_set_width (nw);
			elseif is_horizontal then
				p_set_width (nw);
			else
				!!vas.make(0);
				if is_value_shown and (text = Void or else text.empty) then
					vas.append_integer (maximum);
					tw := font_width_of_string (vas);
					p_set_width (nw + tw);
				elseif not is_value_shown then
					p_set_width (nw + label.width);
				else 
					vas.append_integer (maximum);
					tw := font_width_of_string (vas);
					p_set_width (nw + label.width + tw);
				end;
			end;
			set_scale_width (nw);
		end;

	set_height (new_height: INTEGER) is
			-- Set `height' to `new_height'.
		local
			nh: INTEGER;
		do
			nh := new_height;
			if text = Void or else text.empty then
				p_set_height (nh);
			elseif is_horizontal then
				if is_value_shown and (text = Void or else text.empty) then
					p_set_height (nh + label.height);
				elseif not is_value_shown then
					p_set_height (nh + label.height);
				else
					p_set_height (nh + (2 * label.height));
				end;
			else
				p_set_height (nh);
			end;
			set_scale_height (nh);
		end;

	set_x (new_x: INTEGER) is
			-- Set `x' to `new_x'.
		do
			p_set_x (new_x - scroll_bar.x)
		end;

	set_y (new_y: INTEGER) is
			-- Set `y' to `new_y'.
		do
			p_set_y (new_y - scroll_bar.y)
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- Set `x' and `y' to `new_x' and `new_y'.
		do
			set_x (new_x);
			set_y (new_y)
		end;

feature -- Element change

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (drag_command);
			if list = Void then
				!! list.make;
				set_drag_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (value_changed_command);
			if list = Void then
				!! list.make;
				set_value_changed_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		local
			list: BUTTON_HAND_X
		do
			list := button_command (scroll_bar.event_command (ButtonPressMask));
			if list = Void then
				!! list.make;
				scroll_bar.set_event_handler (ButtonPressMask, list, Void)
			end;
			list.add_command (number, a_command, argument)
	   end;

	add_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		local
			list: BUTTON_HAND_X
		do
			list := button_command (scroll_bar.event_command (ButtonPressMask));
			if list = Void then
				!! list.make;
				scroll_bar.set_event_handler (ButtonReleaseMask, list, Void)
			end;
			list.add_command (number, a_command, argument)
		end;

	add_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		local
			a_mask: INTEGER
		do
			inspect number
			when 1 then
				a_mask := Button1MotionMask
			when 2 then
				a_mask := Button2MotionMask
			when 3 then
				a_mask := Button3MotionMask
			when 4 then
				a_mask := Button4MotionMask
			when 5 then
				a_mask := Button5MotionMask
			else
			end
			if a_mask /= 0 then
				add_scrollbar_xt_event_command (a_mask, a_command, argument)
			end
		end;

	add_enter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- pointer enter the window.
		do
			add_scrollbar_xt_event_command (EnterWindowMask, a_command, argument)
		end;

	add_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when a key
			-- is pressed.
		do
			add_scrollbar_xt_event_command (KeyPressMask, a_command, argument)
		end;

	add_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when a key
			-- is released.
		do
			add_scrollbar_xt_event_command (KeyReleaseMask, a_command, argument)
		end;

	add_leave_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- pointer leave the window.
		do
			add_scrollbar_xt_event_command (LeaveWindowMask, a_command, argument)
		end;

	add_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved.
		do
			add_scrollbar_xt_event_command (PointerMotionMask, a_command, argument)
		end;

	grab (a_cursor: SCREEN_CURSOR) is
			-- Grab the mouse and the keyboard.
			-- If `cursor' is not void, the pointer will have the shape
			-- set by cursor during the grab.
		local
			cursor_implementation: SCREEN_CURSOR_IMP;
		do
			if a_cursor /= Void then
				cursor_implementation ?= a_cursor.implementation
				cursor_implementation.allocate_cursor;
			end;
			scroll_bar.grab_pointer (cursor_implementation)
		end;

	ungrab is
			-- Release the mouse and the keyboard from an earlier grab.
		do
			scroll_bar.ungrab_pointer
		end;

feature -- Removal

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		do
			remove_command (drag_command, a_command, argument)
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		do
			remove_command (value_changed_command, a_command, argument)
		end;

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		do
			scroll_bar.remove_translation (a_translation)
		end;

	remove_button_motion_action (number: INTEGER; a_command: COMMAND;
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		local
			a_mask: INTEGER
		do
			inspect number
			when 1 then
				a_mask := Button1MotionMask
			when 2 then
				a_mask := Button2MotionMask
			when 3 then
				a_mask := Button3MotionMask
			when 4 then
				a_mask := Button4MotionMask
			when 5 then
				a_mask := Button5MotionMask
			else
			end
			if a_mask /= 0 then
				remove_command (scroll_bar.event_command (a_mask), a_command, argument)
			end
		end;

	remove_button_press_action (number: INTEGER; a_command: COMMAND;
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		local
			list: BUTTON_HAND_X
		do
			list := button_command (scroll_bar.event_command (ButtonPressMask));
			if list /= Void then
				list.remove_command (number, a_command, argument)
			end
		end;

	remove_button_release_action (number: INTEGER; a_command: COMMAND;
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		local
			list: BUTTON_HAND_X
		do
			list := button_command (scroll_bar.event_command (ButtonReleaseMask));
			if list /= Void then
				list.remove_command (number, a_command, argument)
			end
		end;

	remove_enter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when the
			-- pointer enter the window.
		do
			remove_command (scroll_bar.event_command (EnterWindowMask), 
					a_command, argument)
		end;

	remove_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when a key
			-- is pressed.
		do
			remove_command (scroll_bar.event_command (KeyPressMask), a_command, argument)
		end;

	remove_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when a key
			-- is released.
		do
			remove_command (scroll_bar.event_command (KeyReleaseMask), a_command, argument)
		end;

	remove_leave_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when the
			-- pointer leave the window.
		do
			remove_command (scroll_bar.event_command (LeaveWindowMask), a_command, argument)
		end;

	remove_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved.
		do
			remove_command (scroll_bar.event_command (PointerMotionMask), a_command, argument)
		end;

feature -- Color

	set_background_color_from_imp (color_imp: COLOR_IMP) is
			-- Set the background color from implementation `color_imp'.
		do
			mel_set_background_color (color_imp);
			scroll_bar.set_background_color (color_imp);
			scroll_bar.update_colors;
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end;

feature {NONE} -- Implementation

	add_scrollbar_xt_event_command (a_mask: INTEGER; 
					a_command: COMMAND; an_argument: ANY) is
			-- Add the EiffelVision command to the mel command list
			-- for event mask `mask' for `scroll_bar'.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (scroll_bar.event_command (a_mask));
			if list = Void then
				!! list.make;
				scroll_bar.set_event_handler (a_mask, list, an_argument)
			end;
			list.add_command (a_command, an_argument)
		end;

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

