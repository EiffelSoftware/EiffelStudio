--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Rectangle with scrollbars or not which contains a list of
-- selectable strings.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCROLL_L_M 

inherit

	SCROLL_L_I
		export
			{NONE} all
		end;

	PRIMITIVE_M
		rename
			get_int as p_get_int,
			set_int as p_set_int,
			set_unsigned_char as p_set_unsigned_char
		redefine
			action_target
		end;

	FONTABLE_M
		rename
			resource_name as MfontList,
			screen_object as list_screen_object
		end;

	LIST_MAN_M
		
creation

	make

feature -- Creation

	make (a_list: SCROLL_LIST) is
            -- Create a motif list, get screen_object value of srolled
            -- window which contains current list.
        local
            ext_name: ANY
        do
            ext_name := a_list.identifier.to_c;
            list_screen_object := create_scroll_list ($ext_name,
					a_list.parent.implementation.screen_object);
            screen_object := m_xtparent (list_screen_object);
            a_list.set_list_imp (Current);
            a_list.set_font_imp (Current);
        end;

feature {NONE}

	action_target: POINTER is
		do
			Result := list_screen_object
		end;

feature 

	is_output_only_mode: BOOLEAN is
			-- Is scale mode output only mode?
		do
			Result :=  xt_is_sensitive (screen_object)
		end;

	set_input_output is
			-- Set scale mode to input output.
		do
			xt_set_sensitive (screen_object, True)
		ensure
			input_output_mode: not is_output_only_mode
		end;

	set_output_only is
			-- Set scale mode to output only.
		do
			xt_set_sensitive (screen_object, False)
		ensure
			output_only_mode: is_output_only_mode
		end

feature {NONE} -- External features

	create_scroll_list (l_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	m_xtparent (value: POINTER): POINTER is
		external
			"C"
		end;

end

