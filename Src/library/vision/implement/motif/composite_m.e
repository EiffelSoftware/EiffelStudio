--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Motif composite implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class COMPOSITE_M 

inherit

	COMPOSITE_R_M
		export
			{NONE} all
		end;

	WIDGET_M

feature

	children_count: INTEGER is
			-- Count of managed children
		local
			ext_name_child: ANY
		do
			ext_name_child := MnumChildren.to_c;
			Result := get_cardinal (screen_object, $ext_name_child)
		end

feature {NONE} -- External features

	get_cardinal (scr_obj: POINTER; c_name: ANY): INTEGER is
		external
			"C"
		end;

end

