
-- Motif frame implementation.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FRAME_M 

inherit

	FRAME_I
		export
			{NONE} all
		end;

	FRAME_R_M
		export
			{NONE} all
		end;

	MANAGER_M

creation

	make

feature -- Creation

	make (a_frame: FRAME) is
			-- Create a motif frame.
		local
			ext_name_frame: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name_frame := a_frame.identifier.to_c;
			screen_object := create_frame ($ext_name_frame,
					parent_screen_object (a_frame, widget_index));
		end

feature {NONE} -- External features

	create_frame (f_name: ANY; scr_obj: POINTER): POINTER is
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
