
-- Motif bulletin implementation.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BULLETIN_M 

inherit

	BULLETIN_I
		export
			{NONE} all
		end;

    MANAGER_M;

    BULLETIN_R_M
        export
            {NONE} all
        end

creation

	make

feature 

	make (a_bulletin: BULLETIN) is
			-- Create a motif bulletin.
		local
			ext_name_bull: ANY
		do
			ext_name_bull := a_bulletin.identifier.to_c;
			screen_object := create_bulletin ($ext_name_bull, a_bulletin.parent.implementation.screen_object);
		end;

	set_default_button (but: POINTER) is
		do
			set_xt_widget (screen_object, but, MdefaultButton);
		end;

	set_default_position (flag: BOOLEAN) is 
		local
			ext_name: ANY;
		do
			ext_name := MdefaultPosition.to_c;
			set_boolean (screen_object, flag, $ext_name);
		end;

feature {NONE} -- External features

	create_bulletin (b_name: ANY; scr_obj: POINTER): POINTER is
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
