
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class FONTABLE_O

inherit

	FONTABLE_X

feature {NONE}

	set_implement_font (resource_screen: POINTER) is
		local
			ext_name: ANY;
		do
			ext_name := resource_name.to_c;
			set_openlook_font (screen_object, resource_screen, $ext_name)
		end;

feature {NONE} -- External feature

	set_openlook_font (scr_obj, the_screen: POINTER; resource: ANY) is
		external
			"C"
		end; 

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
