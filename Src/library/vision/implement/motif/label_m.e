indexing

	description: "Motif label implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LABEL_M

inherit

	LABEL_R_M
		export
			{NONE} all
		end;

    LABEL_I
        export
            {NONE} all
        end;

	XM_STRING_R_M
		export
			{NONE} all
		end;

	PRIMITIVE_M;

	FONTABLE_M
		rename
			resource_name as MfontList
		export
			{NONE} all;
			{ANY} set_font, font
		end

creation

    make

feature {NONE} -- Creation

    make (a_label: LABEL; man: BOOLEAN) is
            -- Create a motif label.
        local
            ext_name: ANY
        do
			widget_index := widget_manager.last_inserted_position;
            ext_name := a_label.identifier.to_c;
            screen_object := create_label ($ext_name,
					parent_screen_object (a_label, widget_index),
					man);
            a_label.set_font_imp (Current)
        end;

feature 

	allow_recompute_size is
			-- Allow current label to recompute its  size according to
			-- some changes on its value.
		do
			set_xt_boolean (screen_object, True, MrecomputeSize)
		end;

	forbid_recompute_size is
			-- Forbid current label to recompute its size according to
			-- some changes on its value.
		do
			set_xt_boolean (screen_object, False, MrecomputeSize)
		end;

	set_right_alignment is
			-- Set text alignment to right.
		do
			set_xt_unsigned_char (screen_object, MALIGNMENT_END, Malignment)
		end;

	set_center_alignment is
			-- Set text alignment to center
		do
			set_xt_unsigned_char (screen_object, MALIGNMENT_CENTER, Malignment)
		end;

	set_left_alignment is
			-- Set text alignment to left.
		do
			set_xt_unsigned_char (screen_object, MALIGNMENT_BEGINNING, Malignment)
		end;

	set_text (a_text: STRING) is
			-- Set text label to `a_text'.
		require else
			not_a_text_void: not (a_text = Void)
		local
			ext_name, ext_name_text: ANY
		do
			ext_name := MlabelString.to_c;
			ext_name_text := a_text.to_c;
			to_left_xm_string (screen_object, ext_name_text, ext_name);
		ensure then
			text.is_equal (a_text)
		end;

	text: STRING is
			-- Text of current label
		local
			ext_name: ANY
		do
			ext_name := MlabelString.to_c;
			Result := from_xm_string (screen_object, $ext_name)
		end

feature {NONE} -- External features

	to_left_xm_string (scr_obj: POINTER; name1, name2: ANY) is
		external
			"C"
		end;

	from_xm_string (scr_obj: POINTER; l_name: POINTER): STRING is
		external
			"C"
		end;

    create_label (l_name: POINTER; scr_obj: POINTER;
				man: BOOLEAN): POINTER is
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
