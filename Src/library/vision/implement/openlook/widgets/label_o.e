indexing

	description: "OpenLook label implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LABEL_O 

inherit

	LABEL_I
		
		export
			{NONE} all
		end;

	LABEL_R_O
		export
			{NONE} all
		end;

	PRIMITIVE_O;

	FONTABLE_O
		rename
			resource_name as OfontList
		export
			{NONE} all;
			{ANY} set_font, font
		end;

	SIZE_MAN_O
		export
			{NONE} all
		end

creation

	make
	
feature 

	make (a_label: LABEL) is
			-- Create an openlook label.
		
		local
			ext_name: ANY;
		do
			ext_name := a_label.identifier.to_c;
			screen_object := create_label ($ext_name, a_label.parent.implementation.screen_object);
			a_label.set_font_imp (Current);
			allow_recompute_size;
		end;

	set_center_alignment is
			-- Set text alignment to center
		do
			set_xt_unsigned_char (screen_object, OL_CENTER, Oalignment)
		end; 

	set_left_alignment is
			-- Set text alignment to left.
		do
			set_xt_unsigned_char (screen_object, OL_LEFT, Oalignment)
		end;

	text: STRING is
			-- Text of button
		do
			Result := xt_string (screen_object, OlabelString)
		end;

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		require else
			not_text_void: not (a_text = Void)
		
		local
			ext_string, ext_size, ext_text: ANY;
		do
			ext_string := OlabelString.to_c;
			ext_text := a_text.to_c;
--			if recompute_size then
--				ext_size := OrecomputeSize.to_c;
--				set_boolean (screen_object, True, $ext_size);
--				set_string (screen_object, $ext_text, $ext_string);
--				set_boolean (screen_object, False, $ext_size);
--			else
				set_string (screen_object, $ext_text, $ext_string);
--			end
		ensure then
			text.is_equal (a_text)
		end;

feature {NONE} -- External features

	create_label (name: POINTER; parent: POINTER): POINTER is
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
