
-- DRAW_B_O: not implemented in OpenLook version of EiffelVision

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DRAW_B_O 

inherit

	DRAW_B_I;

	DRAW_B_R_O
		export
			{NONE} all
		end;

	PUSH_B_O
		rename
			make as push_make
		export
			{NONE} all
		end;

	DRAWING_X
		export
			{NONE} all
		end

creation

	make

feature 

	make (a_draw_b: DRAW_B) is
			-- Create a openlook draw button.
		local
			ext_name: ANY		
		do
			ext_name := a_draw_b.identifier.to_c;
			screen_object := create_push_b ($ext_name, a_draw_b.parent.implementation.screen_object);
			display_pointer := xt_display (screen_object);
			create_gc
		end; 
	
feature {NONE}

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current draw button is exposed.`
		do
		end; 
	
	window_object: POINTER is
		do
			Result := xt_window (screen_object);
		end

feature 

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current draw button is exposed.
		do
		end 

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
