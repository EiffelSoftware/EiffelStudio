indexing

	description: 
		"Motif implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class FONTABLE_M

inherit

	FONTABLE_X

feature {NONE}

	resource_name: STRING is do end;

	set_implement_font (font_ptr: POINTER) is
		local
			ext_name: ANY;
		do
			ext_name := resource_name.to_c;
			set_motif_font (screen_object, font_ptr, ext_name)
		end;

	font_list_pointer: POINTER is
		local
			ext_name: ANY;
		do
			ext_name := resource_name.to_c;
			Result := get_default_font (screen_object, ext_name)
		end

feature {NONE} -- external feature

	set_motif_font (scr_obj: POINTER; font_ptr: POINTER; resource: ANY) is
		external
			"C"
		end; 

	get_default_font (scr_obj: POINTER; resource: ANY): POINTER is
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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
