
-- SEPARATOR_M: Motif implementation of separator.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SEPARATOR_M

inherit

	SEPARATOR_R_M
		export
			{NONE} all
		end;

    SEPARATOR_I
        export
            {NONE} all
        end;

	PRIMITIVE_M

creation

    make

feature

    make (a_separator: SEPARATOR) is
            -- Create a motif separator.
        local
            ext_name: ANY
        do
			widget_index := widget_manager.last_inserted_position;
            ext_name := a_separator.identifier.to_c;
            screen_object := create_separator ($ext_name,
					parent_screen_object (a_separator, widget_index));
        ensure
            is_horizontal: is_horizontal
        end

feature 

	is_horizontal: BOOLEAN is
			-- Is separator orientation horizontal?
		do
			Result := xt_unsigned_char (screen_object, Morientation) = MHORIZONTAL
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

	set_single_line is
			-- Set separator display to be single line.
		do
			set_xt_unsigned_char (screen_object, MSINGLE_LINE, MseparatorType)
		end;

	set_double_line is
			-- Set separator display to be double line.
		do
			set_xt_unsigned_char (screen_object, MDOUBLE_LINE, MseparatorType)
		end;

	set_single_dashed_line is
			-- Set separator display to be single dashed line.
		do
			set_xt_unsigned_char (screen_object, MSINGLE_DASHED_LINE, MseparatorType)
		end;

	set_double_dashed_line is
			-- Set separator display to be double dashed line.
		do
			set_xt_unsigned_char (screen_object, MDOUBLE_DASHED_LINE, MseparatorType)
		end;

	set_no_line is
			-- Make current separator invisible.
		do
			set_xt_unsigned_char (screen_object, MNO_LINE, MseparatorType)
		end;

feature {NONE} -- External features

    create_separator (s_name: ANY; scr_obj: POINTER): POINTER is
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
