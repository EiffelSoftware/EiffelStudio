
-- SCALE_M: implementation of scale.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCALE_M 

inherit

	SCALE_I;

	SCALE_R_M
		export
			{NONE} all
		end;

	PRIMITIVE_M
		rename 
			set_size as p_set_size,
			set_width as p_set_width,
			set_height as p_set_height,
			height as p_height,
			width as p_width
		export
			{NONE} all
		redefine
			set_foreground,
			update_foreground, action_target, set_background_color,
			update_background_color
		end;

	PRIMITIVE_M
		export
			{NONE} all
		redefine
			set_size, set_width, set_height, action_target,
			set_foreground, update_foreground, set_background_color,
			update_background_color, width, height
		select
			set_size, set_width, set_height, width, height
		end;
	
	FONTABLE_M
		rename
			resource_name as MfontList
		export
			{NONE} all
		end

creation

	make

feature -- Creation

	make (a_scale: SCALE) is
            -- Create a motif scale.
        local
            ext_name: ANY
        do
            ext_name := a_scale.identifier.to_c;
            screen_object := create_scale ($ext_name,
					a_scale.parent.implementation.screen_object);
            a_scale.set_font_imp (Current);
            granularity := 10
        ensure
            mamimum_set: maximum = 100;
            minimum_set: minimum = 0;
            gradularity_set: granularity = 10;
            value_equal_0: value = 0;
            --not_horizontal: not is_horizontal;
            --not_value_shown: not is_value_shown;
            --not_max_right_bottom: not is_maximum_right_bottom
        end;

feature 

	action_target: POINTER is
		do
			Result := slide_widget;
		end;

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (move_actions = Void) then
				!! move_actions.make (screen_object, Mdrag, widget_oui)
			end;
			move_actions.add (a_command, argument)
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (value_changed_actions = Void) then
				!! value_changed_actions.make (screen_object, MvalueChanged, widget_oui)
			end;
			value_changed_actions.add (a_command, argument)
		end;

	granularity: INTEGER;
			-- Value of the amount to move the slider and modifie value
			-- when a move action occurs
			--| We don't use a C function for now on, because of a
			--| motif bug, when it will be fixed, read file MOTIFBUG
			--| to update this feature.

	is_horizontal: BOOLEAN is
			-- Is scale orientation horizontal?
		do
			Result := xt_unsigned_char 
					(screen_object, Morientation) = MHORIZONTAL
		end;

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		local
			side: INTEGER
		do
			side := xt_unsigned_char (screen_object, MprocessingDirection);
			Result := (side = MMAX_ON_BOTTOM) or (side = MMAX_ON_RIGHT)
		end;

	is_output_only: BOOLEAN is
			-- Is scale mode output only mode?
		do
			Result :=  xt_is_sensitive (screen_object);
		end;

	is_value_shown: BOOLEAN is
			-- Is value shown on the screen?
		do
			Result := xt_boolean (screen_object, MshowValue)
		end;

	maximum: INTEGER is
			-- Maximum value of the slider
		do
			Result := xt_int (screen_object, Mmaximum)
		ensure then
			maximum_greater_than_minimum: Result >= minimum
		end;

	minimum: INTEGER is
			-- Minimum value of the slider
		do
			Result := xt_int (screen_object, Mminimum)
		ensure then
			minimum_smaller_than_maximum: Result <= maximum
		end;

	
feature {NONE}

	move_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when slide is moved

    value_changed_actions: EVENT_HAND_M;

feature 

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		require else
			not_a_command_void: not (a_command = Void)
		do
			move_actions.remove (a_command, argument)
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require else
			not_a_command_void: not (a_command = Void)
		do
			value_changed_actions.remove (a_command, argument)
		end;

	set_granularity (new_granularity: INTEGER) is
			-- Set amount to move the slider and modifie value when
			-- when a move action occurs to `new_granularity'.
		require else
			granularity_large_enough: new_granularity >= 1;
			granularity_small_enough: new_granularity <= (maximum - minimum)
		do
			set_xt_int (screen_object, new_granularity, MscaleMultiple);
			granularity := new_granularity
		ensure then
			granularity = new_granularity
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
				set_xt_unsigned_char (screen_object, MHORIZONTAL, Morientation)
			else
				set_xt_unsigned_char (screen_object, MVERTICAL, Morientation)
			end;  

			if old_length /= 0 then
				if is_horizontal then
					set_width (old_length);
				else
					set_height (old_length);
				end;
			end;   
		ensure then
			value_correctly_set: is_horizontal = flag
		end;

	set_maximum (new_maximum: INTEGER) is
			-- Set maximum value of the slider to `new_maximum'.
		require else
			maximum_greater_than_minimum: new_maximum > minimum
		do
			set_xt_int (screen_object, new_maximum, Mmaximum)
		ensure then
			maximum = new_maximum
		end;

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise.
		do
			if flag then
				if is_horizontal then
					set_xt_unsigned_char (screen_object, MMAX_ON_RIGHT, MprocessingDirection)
				else
					set_xt_unsigned_char (screen_object, MMAX_ON_BOTTOM, MprocessingDirection)
				end
			else
				if is_horizontal then
					set_xt_unsigned_char (screen_object, MMAX_ON_LEFT, MprocessingDirection)
				else
					set_xt_unsigned_char (screen_object, MMAX_ON_TOP, MprocessingDirection)
				end
			end
		ensure then
			maximum_value_on_right_bottom: is_maximum_right_bottom = flag
		end;

	set_minimum (new_minimum: INTEGER) is
			-- Set minimum value of the slider to `new_minimum'.
		require else
			minimum_smaller_than_maximum: new_minimum < maximum
		do
			set_xt_int (screen_object, new_minimum, Mminimum)
		ensure then
			minimum = new_minimum
		end;

	set_output_only (flag: BOOLEAN) is
            -- Set scale mode to output only if `flag' and to input/output
            -- otherwise.
        do
			if flag then
				xt_set_sensitive (screen_object, False)
			else
				xt_set_sensitive (screen_object, True)
			end
        ensure then
            output_only: is_output_only = flag
        end;

	set_text (a_text: STRING) is
			-- Set scale text to `a_text'.
		require else
			not_text_void: not (a_text = Void)
		local
			ext_name, ext_name_text: ANY
		do
			ext_name_text := a_text.to_c;
			ext_name := MtitleString.to_c;
			xt_unmanage_child (text_widget);
			to_left_xm_string (screen_object, ext_name_text, ext_name);
			xt_manage_child (text_widget);
		ensure then
		--	text.equal (a_text)
		end;


	set_value (new_value: INTEGER) is
			-- Set value to `new_value'.
		require else
			value_small_enough: new_value <= maximum;
			value_large_enough: new_value >= minimum
		do
			set_xt_int (screen_object, new_value, Mvalue)
		ensure then
			value = new_value
		end;

	show_value (flag: BOOLEAN) is
            -- Show scale value on the screen if `flag', hide it otherwise.
        do
			if flag then
				set_xt_boolean (screen_object, True, MshowValue)
			else
				set_xt_boolean (screen_object, False, MshowValue)
			end
        ensure then
            value_is_shown: is_value_shown = flag
        end;

	text: STRING is
			-- Scale text
		local
			ext_name: ANY
		do
			ext_name := MtitleString.to_c;
			Result := from_xm_string (screen_object, $ext_name)
		end;

	value: INTEGER is
			-- Value of the current slider position along the scale
		do
			Result := xt_int (screen_object, Mvalue)
		ensure then
			value_large_enough: Result >= minimum;
			value_small_enough: Result <= maximum
		end;

	set_size (new_width, new_height: INTEGER) is
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
					p_set_size (nw, nh + text_height);
				elseif not is_value_shown then
					p_set_size (nw, nh + text_height);
				else
					p_set_size (nw, nh + (2 * text_height));
				end;
			else
				!!vas.make(0);
				if is_value_shown and (text = Void or else text.empty) then
					vas.append_integer (maximum);
					tw := font_string_width(widget_oui, vas);
					p_set_size (nw + tw, nh);
				elseif not is_value_shown then
					p_set_size (nw + text_width, nh);
				else
					vas.append_integer (maximum);
					tw := font_string_width(widget_oui, vas);
					p_set_size (nw + text_width + tw, nh);
				end;
			end;
			set_scale_size (nw, nh);
		end;


	set_width (new_width: INTEGER) is
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
					p_set_width (nw + text_width);
				else 
					vas.append_integer (maximum);
					tw := font_string_width(widget_oui, vas);
					p_set_width (nw + text_width + tw);
				end;
			end;
			set_scale_width (nw);
		end;

	set_height (new_height: INTEGER) is
		local
			nh: INTEGER;
		do
			nh := new_height;
			if text = Void or else text.empty then
				p_set_height (nh);
			elseif is_horizontal then
				if is_value_shown and (text = Void or else text.empty) then
					p_set_height (nh + text_height);
				elseif not is_value_shown then
					p_set_height (nh + text_height);
				else
					p_set_height (nh + (2 * text_height));
				end;
			else
					p_set_height (nh);
			end;
			set_scale_height (nh);
		end;

	height: INTEGER is
		local
			temp_p: POINTER;
		do
			temp_p := screen_object;
			screen_object := slide_widget;
			Result := p_height;
			screen_object := temp_p;
		end;

	width: INTEGER is
		local
			temp_p: POINTER;
		do
			temp_p := screen_object;
			screen_object := slide_widget;
			Result := p_width;
			screen_object := temp_p;
		end;


	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		require else
			a_color_exists: not (a_color = Void)
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if not (background_pixmap = Void) then
				pixmap_implementation ?= background_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				background_pixmap := Void
			end;
			if not (background_color = Void) then
				color_implementation ?= background_color.implementation;
				color_implementation.remove_object (Current)
			end;
			bg_color := a_color;
			color_implementation ?= background_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mbackground.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name);
			c_set_color (slide_widget, color_implementation.pixel (screen), $ext_name);
		ensure then
			background_color = a_color;
			(background_pixmap = Void)
		end;

	set_foreground (a_color: COLOR) is
			-- Set `foreground' to `a_color'.
		require else
			a_color_exists: not (a_color = Void)
		
		local
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if not (foreground = Void) then
				color_implementation ?= foreground.implementation;
				color_implementation.remove_object (Current)
			end;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mforeground.to_c;
			c_set_color (slide_widget, color_implementation.pixel (screen), $ext_name);
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name);
		ensure then
			foreground = a_color
		end;

feature {COLOR_X}

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X;
		do
			ext_name := Mbackground.to_c;
			color_implementation ?= background_color.implementation;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name);
			c_set_color (slide_widget, color_implementation.pixel (screen), $ext_name);
		end;

	update_foreground is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X
		do
			ext_name := Mforeground.to_c;
			color_implementation ?= foreground.implementation;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name);
			c_set_color (slide_widget, color_implementation.pixel (screen), $ext_name);
		end

feature {NONE} --features for manipulating scale children


	slide_widget: POINTER is
		local
			cn: INTEGER;
		do
			cn := 1;
			Result := get_ith_child (cn);
		end;

	text_widget: POINTER is
		local
			cn: INTEGER;
		do
			cn := 0;
			Result := get_ith_child (cn);
		end;

	text_height: INTEGER is
		local
			ext_name: ANY;
		do
			ext_name := Mheight.to_c;
			Result := get_dimension (text_widget, $ext_name);
		end;

	text_width: INTEGER is
		local
			ext_name: ANY;
		do
			ext_name := Mwidth.to_c;
			Result := get_dimension (text_widget, $ext_name);
		end;

	set_scale_size (new_width: INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		local
			ext_name_Mw, ext_name_Mh: ANY
		do
			ext_name_Mw := MscaleWidth.to_c;
			ext_name_Mh := MscaleHeight.to_c;
			set_dimension (screen_object, new_width, $ext_name_Mw);
			set_dimension (screen_object, new_height, $ext_name_Mh);
		end;

	set_scale_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		local
			ext_name: ANY
		do
			ext_name := MscaleHeight.to_c;
			set_dimension (screen_object, new_height, $ext_name);
		end;


	set_scale_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		local
			ext_name_Mw: ANY
		do
			ext_name_Mw := MscaleWidth.to_c;
			set_dimension (screen_object, new_width, $ext_name_Mw);
		end;


feature {NONE}

	children_count: INTEGER is
			-- Count of managed children
		local
			ext_name_child: ANY
		do
			ext_name_child := MnumChildren.to_c;
			Result := get_cardinal (screen_object, $ext_name_child)
		end;

	child_list: POINTER;
	MnumChildren: STRING is "numChildren";
	Mchildren: STRING is "children";

	set_child_list is
		local
			ext_name: ANY;
		do
			ext_name := Mchildren.to_c;
			child_list := get_widget_children (screen_object, $ext_name);
		ensure
			child_list_not_null: child_list /= null_pointer;
		end;

	get_ith_child (pos: INTEGER): POINTER is
		do
			if child_list = null_pointer then
				set_child_list;
			end;
			Result := get_i_widget_child (child_list, pos);

		end;

feature {NONE}
	
	null_pointer: POINTER;

feature {NONE} -- External features

	create_scale (s_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	from_xm_string (scr_obj: POINTER; name: ANY): STRING is
		external
			"C"
		end;

	to_left_xm_string (scr_obj: POINTER; name1, name2: ANY) is
		external
			"C"
		end;

	get_cardinal (scr_obj: POINTER; c_name: ANY): INTEGER is
		external
			"C"
		end;

	get_widget_children (scr_obj: POINTER; c_name: ANY): POINTER is
		external
			"C"
		end;

	get_i_widget_child (widget_list: POINTER; index: INTEGER): POINTER is
			--gets a single child from value returned by
			--get_widget_children.
		external
			"C"
		end;
end



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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
