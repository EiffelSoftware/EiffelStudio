indexing

	description: 
		"Xt functions that can be used on objects.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_XT_FUNCTIONS

inherit

	SHARED_MEL_WIDGET_MANAGER

feature {NONE} -- Implementation

	get_xt_boolean (a_target: POINTER; a_resource_name: POINTER): BOOLEAN is
			-- Value of X boolean resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_get_boolean"
		end;

	set_xt_boolean (a_target: POINTER; a_resource_name: POINTER; a_boolean: BOOLEAN) is
			-- Assign a_boolean to target boolean resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_set_boolean"
		end;

	get_xt_dimension (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X dimension resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_get_dimension"
		end;

	set_xt_dimension (a_target: POINTER; a_resource_name: POINTER; a_dimension: INTEGER) is
			-- Assign a_dimension to target dimension resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_set_dimension"
		end;

	get_xt_position (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X position resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_get_position"
		end;

	set_xt_position (a_target: POINTER; a_resource_name: POINTER; a_position: INTEGER) is
			-- Assign a_position to target position resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_set_position"
		end;

	get_xt_int (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X integer resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_get_int"
		end;

	set_xt_int (a_target: POINTER; a_resource_name: POINTER; an_integer: INTEGER) is
			-- Assign an_integer to target integer resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_set_int"
		end;

	get_xt_cardinal (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X cardinal resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_get_cardinal"
		end;

	set_xt_cardinal (a_target: POINTER; a_resource_name: POINTER; a_cardinal: INTEGER) is
			-- Assign a_cardinal to target cardinal resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_set_cardinal"
		end;

	get_xt_short (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X short resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_get_short"
		end;

	set_xt_short (a_target: POINTER; a_resource_name: POINTER; a_short: INTEGER) is
			-- Assign a_short to target resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_set_short"
		end;

	get_xt_string_no_free (a_target: POINTER; a_resource_name: POINTER): STRING is
			-- Value of X string resource with a_resource_name
			-- as name. Call a C function that does not free the pointer
			-- returned by XtVaGetValues.
		require
			not_a_resource_name_void: a_resource_name /= Void
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C (EIF_POINTER, char *): EIF_REFERENCE"
		alias
			"c_get_string_no_free"
		end;

	get_xt_string (a_target: POINTER; a_resource_name: POINTER): STRING is
			-- Value of X string resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_void: a_resource_name /= Void
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C (EIF_POINTER, char *): EIF_REFERENCE"
		alias
			"c_get_string"
		end;

	set_xt_string (a_target: POINTER; a_resource_name: POINTER; a_string: STRING) is
			-- Assign a_string to target string resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		local
			resource_string: ANY
		do
			resource_string := a_string.to_c;
			c_set_string (a_target, a_resource_name, $resource_string)
		end;

	set_xt_allocated_string (a_target: POINTER; a_resource_name: POINTER; a_string: STRING) is
			-- Assign a_string to target string resource
			-- with a_resource_name as name. Allocate a C string but do not
			-- free it.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		local
			resource_string: ANY
		do
			resource_string := a_string.to_c;
			c_set_allocated_string (a_target, a_resource_name, $resource_string)
		end;

	get_xt_unsigned_char (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X unsigned char resource with a_resource_name
			-- as name
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_get_unsigned_char"
		end;

	set_xt_unsigned_char (a_target: POINTER; a_resource_name: POINTER; an_unsigned_char: INTEGER) is
			-- Assign an_unsigned_char to target unsigned char resource
			-- with a_resource_name as name.
		require
			value_large_enough: an_unsigned_char >= 0;
			value_small_enough: an_unsigned_char <= 255;
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_set_unsigned_char"
		end;

	get_xt_widget (a_target: POINTER; a_resource_name: POINTER): MEL_OBJECT is
			-- Value of X widget resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		local
			w: POINTER
		do
			w := c_get_widget (a_target, a_resource_name);
			if w /= default_pointer then
				Result := Mel_widgets.item (w)
			end
		end;

	set_xt_widget (a_target: POINTER; a_resource_name: POINTER; a_widget: POINTER) is
			-- Assign a_widget to widget resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_set_widget"
		end;

	get_xt_pixel (a_target: MEL_OBJECT; a_resource_name: POINTER): MEL_PIXEL is
			-- Value of X pixel resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			!! Result.make_from_existing (a_target.display,
				c_get_pixel (a_target.screen_object, a_resource_name))
		end;

	set_xt_pixel (a_target: POINTER; a_resource_name: POINTER; a_pixel: MEL_PIXEL) is
			-- Assign a_pixel to pixel resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer;
			valid_pixel: a_pixel /= Void and a_pixel.is_valid
		do	
			c_set_pixel (a_target, a_resource_name, a_pixel.identifier)
		end;

	get_xt_pixmap (a_target: MEL_OBJECT; a_resource_name: POINTER): MEL_PIXMAP is
			-- Value of X pixmap resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		local
			mel_widget: MEL_WIDGET;
			a_depth: INTEGER
		do
			mel_widget ?= a_target;
			if mel_widget = Void then
				a_depth := a_target.parent.depth
			else
				a_depth := mel_widget.depth
			end
			!! Result.make_from_existing (a_target.display, 
					c_get_pixmap (a_target.screen_object, a_resource_name), a_depth)
		end;

	set_xt_pixmap (a_target: POINTER; a_resource_name: POINTER; a_pixmap: MEL_PIXMAP) is
			-- Assign a_pixmap to pixmap resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_pixmap (a_target, a_resource_name, a_pixmap.identifier)
		end;

	get_xt_keysym (a_target: POINTER; a_resource_name: POINTER): CHARACTER is
			-- Value of X pixmap resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_get_keysym"
		end;

	set_xt_keysym (a_target: POINTER; a_resource_name: POINTER; a_character: CHARACTER) is
			-- Assign a_pixmap to pixmap resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		external
			"C"
		alias
			"c_set_keysym"
		end;

feature {NONE} -- External features

	xt_is_composite (w: POINTER): BOOLEAN is
		external
			"C [macro <X11/Intrinsic.h>] (Widget): EIF_BOOLEAN"
		alias
			"XtIsComposite"
		end;

feature {NONE} -- External features

	c_set_allocated_string (scr_obj: POINTER; resource: POINTER; val: POINTER) is
		external
			"C"
		end;

	c_set_string (scr_obj: POINTER; resource: POINTER; val: POINTER) is
		external
			"C"
		end;

	c_set_pixel (scr_obj: POINTER; resource: POINTER; val: POINTER) is
		external
			"C"
		end;

	c_set_pixmap (scr_obj: POINTER; resource: POINTER; val: POINTER) is
		external
			"C"
		end;

	c_get_widget (scr_obj: POINTER; resource: POINTER): POINTER is
		external
			"C"
		end;

	c_get_pixel (scr_obj: POINTER; resource: POINTER): POINTER is
		external
			"C"
		end;

	c_get_pixmap (scr_obj: POINTER; resource: POINTER): POINTER is
		external
			"C"
		end;

feature {NONE} -- Implementation

	xt_destroy_widget (scr_obj: POINTER) is
		external
			"C (Widget) | <X11/Intrinsic.h>"
		alias
			"XtDestroyWidget"
		end;

	xt_realize_widget (scr_obj: POINTER) is
		external
			"C (Widget) | <X11/Intrinsic.h>"
		alias
			"XtRealizeWidget"
		end;

	xt_unrealize_widget (scr_obj: POINTER) is
		external
			"C (Widget) | <X11/Intrinsic.h>"
		alias
			"XtUnrealizeWidget"
		end;

	xt_manage_child (scr_obj: POINTER) is
		external
			"C (Widget) | <X11/Intrinsic.h>"
		alias
			"XtManageChild"
		end;

	xt_unmanage_child (scr_obj: POINTER) is
		external
			"C (Widget) | <X11/Intrinsic.h>"
		alias
			"XtUnmanageChild"
		end;

	xt_set_sensitive (scr_obj: POINTER; bool: BOOLEAN) is
		external
			"C (Widget, Boolean) | <X11/Intrinsic.h>"
		alias
			"XtSetSensitive"
		end;

	xt_map_widget (scr_obj: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget)"
		alias
			"XtMapWidget"
		end;

	xt_unmap_widget (scr_obj: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget)"
		alias
			"XtUnmapWidget"
		end;

	xt_free (obj: POINTER) is
		external
			"C (XtPointer) | <X11/Intrinsic.h>"
		alias
			"XtFree"
		end;

	xt_display (scr_obj: POINTER): POINTER is
		external
			"C (Widget): EIF_POINTER | <X11/Intrinsic.h>"
		alias
			"XtDisplay"
		end;

	xt_is_realized (scr_obj: POINTER): BOOLEAN is
		external
			"C (Widget): EIF_BOOLEAN | <X11/Intrinsic.h>"
		alias
			"XtIsRealized"
		end;

	xt_is_managed (scr_obj: POINTER): BOOLEAN is
		external
			"C (Widget): EIF_BOOLEAN | <X11/Intrinsic.h>"
		alias
			"XtIsManaged"
		end;

	xt_is_sensitive (scr_obj: POINTER): BOOLEAN is
		external
			"C (Widget): EIF_BOOLEAN | <X11/Intrinsic.h>"
		alias
			"XtIsSensitive"
		end;

	xt_is_visible (scr_obj: POINTER): BOOLEAN is
		external
			"C"
		end;

	xt_window (a_target: POINTER): POINTER is
		external
			"C (Widget): EIF_POINTER | <X11/Intrinsic.h>"
		alias
			"XtWindow"
		end;

	xt_parent (a_target: POINTER): POINTER is
		external
			"C (Widget): EIF_POINTER | <X11/Intrinsic.h>"
		alias
			"XtParent"
		end;

	xt_name (a_target: POINTER): POINTER is
		external
			"C (Widget): EIF_POINTER | <X11/Intrinsic.h>"
		alias
			"XtName"
		end;

	xt_widget_to_application_context (a_target: POINTER): POINTER is
		external
			"C (Widget): EIF_POINTER | <X11/Intrinsic.h>"
		alias
			"XtWidgetToApplicationContext"
		end;

end -- class MEL_XT_FUNCTIONS

--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

