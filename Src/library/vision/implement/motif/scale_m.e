indexing

	description: 
		"EiffelVision implementation of a Motif scale.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	SCALE_M 

inherit

	SCALE_I;

	FONTABLE_M;

	MANAGER_M
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
			set_background_color,
			update_background_color, width, height, 
			real_x, real_y, set_x_y
		end;

	MANAGER_M
        rename
            is_shown as shown
		undefine
			create_callback_struct
		redefine
			set_size, set_width, set_height, 
			set_background_color,
			update_background_color, 
			width, height, x, y,
			real_x, real_y, set_x, set_y,
			set_x_y
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
			screen as mel_screen,
			set_horizontal as mel_set_horizontal,
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
		do
			widget_index := widget_manager.last_inserted_position;
			mel_scale_make (a_scale.identifier,
					mel_parent (a_scale, widget_index),
					man);
			a_scale.set_font_imp (Current);
		end;

feature -- Status report

	real_x: INTEGER is
		do
			Result := scroll_bar_widget.real_x
		end;

	real_y: INTEGER is
		do
			Result := scroll_bar_widget.real_y
		end;

	x: INTEGER is
		do
			Result := p_x + scroll_bar_widget.x
		end;

	y: INTEGER is
		do
			Result := p_y + scroll_bar_widget.y
		end;

	height: INTEGER is
		do
			Result := scroll_bar_widget.height
		end;

	width: INTEGER is
		do
			Result := scroll_bar_widget.width
		end;

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		do
			if is_horizontal then
				Result := is_maximum_on_left
			else
				Result := is_maximum_on_top
			end
		end;

	is_output_only: BOOLEAN is
			-- Is scale mode output only mode?
		do
			Result := is_sensitive
		end;

	text: STRING is
			-- Scale text
		local
			ms: MEL_STRING
		do
			ms := title_string;
			Result := ms.to_eiffel_string;
			ms.free
		end;

feature -- Status setting

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

			mel_set_horizontal (flag);

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
					set_maximum_on_left (False)
				else
					set_maximum_on_top (False)
				end
			else
				if is_horizontal then
					set_maximum_on_left (True)
				else
					set_maximum_on_top (True)
				end
			end
		end;

	set_output_only (flag: BOOLEAN) is
			-- Set scale mode to output only if `flag' and to input/output
			-- otherwise.
		do
			set_sensitive (not flag)
		end;

	set_text (a_text: STRING) is
			-- Set scale text to `a_text'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_text);
			text_widget.unmanage;
			set_title_string (ms);
			text_widget.manage;
			ms.free
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
					p_set_size (nw, nh + text_widget.height);
				elseif not is_value_shown then
					p_set_size (nw, nh + text_widget.height);
				else
					p_set_size (nw, nh + (2 * text_widget.height));
				end;
			else
				!!vas.make(0);
				if is_value_shown and (text = Void or else text.empty) then
					vas.append_integer (maximum);
					tw := font_string_width(widget_oui, vas);
					p_set_size (nw + tw, nh);
				elseif not is_value_shown then
					p_set_size (nw + text_widget.width, nh);
				else
					vas.append_integer (maximum);
					tw := font_string_width(widget_oui, vas);
					p_set_size (nw + text_widget.width + tw, nh);
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
					tw := font_string_width(widget_oui, vas);
					p_set_width (nw + tw);
				elseif not is_value_shown then
					p_set_width (nw + text_widget.width);
				else 
					vas.append_integer (maximum);
					tw := font_string_width(widget_oui, vas);
					p_set_width (nw + text_widget.width + tw);
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
					p_set_height (nh + text_widget.height);
				elseif not is_value_shown then
					p_set_height (nh + text_widget.height);
				else
					p_set_height (nh + (2 * text_widget.height));
				end;
			else
				p_set_height (nh);
			end;
			set_scale_height (nh);
		end;

	set_x (new_x: INTEGER) is
			-- Set `x' to `new_x'.
		do
			p_set_y (new_x - scroll_bar_widget.x)
		end;

	set_y (new_y: INTEGER) is
			-- Set `y' to `new_y'.
		do
			p_set_y (new_y - scroll_bar_widget.y)
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
		do
			add_drag_callback (mel_vision_callback (a_command), argument)
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		do
			remove_value_changed_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Removal

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		do
            remove_drag_callback (mel_vision_callback (a_command), argument)
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		do
            remove_drag_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Color

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		require else
			a_color_exists: not (a_color = Void)
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			pix: POINTER
		do
			if private_background_pixmap /= Void then
				pixmap_implementation ?= private_background_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				private_background_pixmap := Void
			end;
			if private_background_color /= Void then
				color_implementation ?= private_background_color.implementation;
				color_implementation.remove_object (Current)
			end;
			private_background_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			pix := color_implementation.pixel (screen);
			--xm_change_bg_color (screen_object, pix);
			--xm_change_bg_color (slide_widget, pix);
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end;

feature {COLOR_X}

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			color_implementation: COLOR_X;
		do
			color_implementation ?= background_color.implementation;
			--xm_change_bg_color (screen_object, 
						--color_implementation.pixel (screen));
			--xm_change_bg_color (slide_widget, 
						--color_implementation.pixel (screen));
		end;

end -- class SCALE_M

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
