
-- OpenLook composite implementation.

indexing

	status: "See notice at end of class";
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
		end;

	child_list: POINTER is do end;

	set_child_list is do end;

	get_ith_child (i: INTEGER): POINTER is do end;

feature {NONE} -- External features

	get_cardinal (scr_obj: POINTER; name: ANY): INTEGER is
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
