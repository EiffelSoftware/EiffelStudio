--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- SCALE_M: implementation of scale.

indexing

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
		export
			{NONE} all
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
            maximum = 100;
            minimum = 0;
            granularity = 10;
            value = 0;
            not is_horizontal;
            not is_value_shown;
            not is_maximum_right_bottom
        end;

feature 

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
			Result := xt_unsigned_char (screen_object, Morientation) = MHORIZONTAL
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
			Result :=  xt_is_sensitive (screen_object)
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
			maximum_greater_than_minimum: Result > minimum
		end;

	minimum: INTEGER is
			-- Minimum value of the slider
		do
			Result := xt_int (screen_object, Mminimum)
		ensure then
			minimum_smaller_than_maximum: Result < maximum
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
        do
			if flag then
				set_xt_unsigned_char (screen_object, MHORIZONTAL, Morientation)
			else
				set_xt_unsigned_char (screen_object, MVERTICAL, Morientation)
			end
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
			to_left_xm_string (screen_object, $ext_name_text,
						$ext_name)
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

end

