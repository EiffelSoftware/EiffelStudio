
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_T_O 

inherit

	SCROLLED_T_I;

	PRIMITIVE_O
		export
			{NONE} all
		redefine
			action_target
		end;

	TEXT_O
		export
			{NONE} all
		undefine
			make 
		redefine
			action_target
		end;

	SCROLLED_T_R_O
		export
			{NONE} all
		end

creation

	make
	
feature {NONE}

	action_target: POINTER;
            		-- Widget ID on which action must be applied
	
feature 

	make (a_scrolled_text: TEXT) is
			-- Create an openlook scrolled text.
		
		local
			ext_name: ANY;
		do
			ext_name := a_scrolled_text.identifier.to_c;		
			action_target := create_scrolled_text ($ext_name, a_scrolled_text.parent.implementation.screen_object);
			screen_object := xt_parent (xt_parent (action_target));
			a_scrolled_text.set_font_imp (Current)
		end;

	hide_horizontal_scrollbar is
			-- There is no horizontal scrollbar in Openlook scrolled text
		do
			io.putstring ("*** hide_horizontal_scrollbar is not implemented in SCROLLED_T_O\n");
		end; 

	hide_vertical_scrollbar is
			-- Make vertical scrollbar invisible.
		do
			set_xt_boolean (action_target, False, OverticalSB);
		end; 

	is_horizontal_scrollbar: BOOLEAN is
			-- There is no horizontal scrollbar in Openlook scrolled text
		do
			io.putstring ("*** is_horizontal_scrollbar is not implemented in SCROLLED_T_O\n");
		end;

	is_vertical_scrollbar: BOOLEAN is
			-- Is vertical scrollbar visible?
		do
			Result := xt_boolean (action_target, OverticalSB)
		end; 

	show_horizontal_scrollbar is
			-- There is no horizontal scrollbar in Openlook scrolled text
		do
			io.putstring ("*** show_horizontal_scrollbar is not implemented in SCROLLED_T_O\n");
		end;

	show_vertical_scrollbar is
			-- Make vertical scrollbar visible.
		do
			set_xt_boolean (action_target, True, OverticalSB);
		end; 

feature {NONE} -- External features

	create_scrolled_text (name: POINTER; parent: POINTER): POINTER is
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
