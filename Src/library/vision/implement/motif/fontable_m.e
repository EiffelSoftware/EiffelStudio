--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Motif implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class FONTABLE_M

inherit

	FONTABLE_X

feature {NONE}

	set_implement_font (font_ptr: POINTER) is
		local
			ext_name: ANY;
		do
			ext_name := resource_name.to_c;
			set_motif_font (screen_object, font_ptr, $ext_name)
		end;

feature {NONE} -- external feature

	set_motif_font (scr_obj: POINTER; font_ptr: POINTER; resource: ANY) is
		external
			"C"
		end; 

end
