indexing

	description: "Motif button implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BUTTON_M 

inherit

	XM_STRING_R_M
		export
			{NONE} all
		end;

	LABEL_R_M
		export
			{NONE} all
		end;

	PRIMITIVE_M

feature 

	allow_recompute_size is
			-- Allow current button to recompute its  size according to
			-- some changes on its text.
		do
			set_xt_boolean (screen_object, True, MrecomputeSize)
		end;

	forbid_recompute_size is
			-- Forbid current button to recompute its size according to
			-- some changes on its text.
		do
			set_xt_boolean (screen_object, False, MrecomputeSize)
		end; -- forbid_recompute_size

feature {NONE}

	is_gadget_valid (a_parent: COMPOSITE): BOOLEAN is
			-- Does `a_parent' manage a gadget implementation for current
			-- button?
		do
			Result := True
		end; -- is_gadget_valid

feature -- Text

	text: STRING is
			-- Text of button
		local
			ext_name_label: ANY
		do
			ext_name_label := MlabelString.to_c;
			Result := from_xm_string (screen_object, $ext_name_label)
		end; -- text

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		require
			not_text_void: not (a_text = Void)
		local
			ext_name_text, ext_name_label: ANY
		do
			ext_name_text := a_text.to_c;
			ext_name_label := MlabelString.to_c;
			to_left_xm_string (screen_object, ext_name_text, ext_name_label)
		ensure
			text.is_equal (a_text)
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


feature {NONE} -- External features

	from_xm_string (scr_obj: POINTER; l_name: POINTER): STRING is
		external
			"C"
		end;

	to_left_xm_string (scr_obj: POINTER; t_name, l_name: ANY) is
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
