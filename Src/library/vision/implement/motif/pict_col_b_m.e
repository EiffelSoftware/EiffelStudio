
-- Button represented with a pixmap.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PICT_COL_B_M 

inherit

	PICT_COL_B_I;

	PUSH_B_M
		rename
			make as push_b_m_make
		export
			{NONE} all
		end

creation

	make

feature 

	make (a_push_b: PICT_COLOR_B) is
			-- Create a motif push button.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_push_b.identifier.to_c;
			screen_object := create_pict_color_b ($ext_name, 
					parent_screen_object (a_push_b, widget_index));
			a_push_b.set_font_imp (Current)
		end;

	pixmap: PIXMAP;
			-- Font name of label

	set_pixmap (a_pixmap: PIXMAP) is
			-- Set pixmap to `a_pixmap'.
		require else
			a_pixmap_exists: not (a_pixmap = Void)
		local
			pixmap_implementation: PIXMAP_X;
			ext_name: ANY
		do
			if pixmap /= Void then
				pixmap_implementation ?= pixmap.implementation;
				pixmap_implementation.remove_object (Current)
			end;
			pixmap := a_pixmap;
			pixmap_implementation ?= pixmap.implementation;
			pixmap_implementation.put_object (Current);
			ext_name := MlabelPixmap.to_c;
			c_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
		ensure then
			pixmap = a_pixmap
		end;

feature {NONE}

	update_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			ext_name: ANY;
			pixmap_implementation: PIXMAP_X
		do
			ext_name := MlabelPixmap.to_c;
			pixmap_implementation ?= pixmap.implementation;
			c_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
		end

feature {NONE} -- External features

	create_pict_color_b (p_name: ANY; scr_obj: POINTER): POINTER is
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
