indexing

	description: "Motif composite implementation";
	status: "See notice at end of class";
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
		end;

	get_ith_child (pos: INTEGER): POINTER is
		local
			ext_name: ANY;
		do
			ext_name := Mchildren.to_c;
			Result := get_i_widget_child (
						get_widget_children (screen_object, $ext_name), 
						pos);
		end;

feature {NONE} -- External features

	get_cardinal (scr_obj: POINTER; c_name: POINTER): INTEGER is
		external
			"C"
		end;

	get_widget_children (scr_obj: POINTER; c_name: POINTER): POINTER is
		external
			"C"
		end;

	get_i_widget_child (widget_list: POINTER; index: INTEGER): POINTER is
			--gets a single child from value returned by
			--get_widget_children.
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
