
-- RADIO_BOX_M: implementation of radio box.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class RADIO_BOX_M 

inherit

	RADIO_BOX_I
		export
			{NONE} all
		end;
	ROW_COLUMN_R_M
		export
			{NONE} all
		end;

	MANAGER_M

creation

	make

feature {NONE} -- Creation

	make (a_radio_box: RADIO_BOX; man: BOOLEAN) is
			-- Create a motif radio_box.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_radio_box.identifier.to_c;
			screen_object := create_radio_box ($ext_name,
					parent_screen_object (a_radio_box, widget_index),
					man);
		end;

feature

	set_always_one (flag: BOOLEAN) is
		do
			set_xt_boolean (screen_object, flag, MradioAlwaysOne);
		end;


feature {NONE} -- External features

	create_radio_box (b_name: ANY; scr_obj: POINTER;
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
