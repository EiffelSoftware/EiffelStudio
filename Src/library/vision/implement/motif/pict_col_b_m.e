--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohipixed --
--|---------------------------------------------------------------

-- Button represented with a pixmap.

indexing

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
			ext_name := a_push_b.identifier.to_c;
			screen_object := create_pict_color_b ($ext_name, a_push_b.parent.implementation.screen_object);
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
			if not (pixmap = Void) then
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

