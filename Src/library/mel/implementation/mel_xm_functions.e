indexing

	decription: 
		"Motif functions that can be used on objects.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_XM_FUNCTIONS

feature {NONE} -- Implementation

	xm_change_color (a_target: POINTER; a_pixel: INTEGER) is
			-- Change all of the colors for the specified widget
			-- based on the new background color.
		external
			"C [macro <Xm/Xm.h>] (Widget, Pixel)"
		alias
			"XmChangeColor"
		end;

	get_xm_string_direction (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of string direction resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_string_direction (a_target, a_resource_name)
		end;

	set_xm_string_direction (a_target: POINTER; a_resource_name: POINTER; a_direction: INTEGER) is
			-- Assign a_direction to target string direction resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_string_direction (a_target, a_resource_name, a_direction)
		end;

	get_xm_string_table (a_target: POINTER; a_resource_name: POINTER): POINTER is
			-- Value of string direction resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_string_table (a_target, a_resource_name)
		end;

	set_xm_string_table (a_target: POINTER; a_resource_name: POINTER; a_string_table: POINTER) is
			-- Assign a_direction to target string direction resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_string_table (a_target, a_resource_name, a_string_table)
		end;

	get_xm_string (a_target: POINTER; a_resource_name: POINTER): MEL_STRING is
			-- Value of X string resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			!! Result.make_from_existing (c_get_xmstring (a_target, a_resource_name))
		end;

	set_xm_string (a_target: POINTER; a_resource_name: POINTER; a_compound_string: MEL_STRING) is
			-- Assign a_compound_string to target string resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_xmstring (a_target, a_resource_name, a_compound_string.handle)
		end;

feature {NONE} -- External features

	c_get_string_direction (scr_obj: POINTER; resource: POINTER): INTEGER is
		external
			"C"
		end;

	c_set_string_direction (scr_obj: POINTER; resource: POINTER; val: INTEGER) is
		external
			"C"
		end;

	c_get_string_table (scr_obj: POINTER; resource: POINTER): POINTER is
		external
			"C"
		end;

	c_set_string_table (scr_obj: POINTER; resource: POINTER; val: POINTER) is
		external
			"C"
		end;

	c_set_xmstring (scr_obj: POINTER; resource: POINTER; val: POINTER) is
		external
			"C"
		end;

	c_get_xmstring (scr_obj: POINTER; resource: POINTER): POINTER is
		external
			"C"
		end;

	xm_process_traversal (a_target: POINTER; dir: INTEGER): BOOLEAN is
		external
			"C [macro <Xm/Xm.h>] (Widget, XmTraversalDirection): EIF_BOOLEAN"
		alias
			"XmProcessTraversal"
		end;

end -- class MEL_XM_FUNCTIONS

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
