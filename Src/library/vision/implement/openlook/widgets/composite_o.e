--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- OpenLook composite implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class COMPOSITE_O 

inherit

	COMPOSITE_R_O
		export
			{NONE} all
		end;

	WIDGET_O
	
feature 

	children_count: INTEGER is
			-- Count of managed children
		local
			ext_name: ANY;
		do
			ext_name := OnumChildren.to_c;
			Result := get_cardinal (screen_object, $ext_name)
		end

feature {NONE} -- External features

	get_cardinal (scr_obj: POINTER; name: ANY): INTEGER is
		external
			"C"
		end; 

end 
