indexing

	decription: 
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
		do
			Result := c_get_boolean (a_target, a_resource_name)
		end;

	set_xt_boolean (a_target: POINTER; a_resource_name: POINTER; a_boolean: BOOLEAN) is
			-- Assign a_boolean to target boolean resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_boolean (a_target, a_resource_name, a_boolean)
		end;

	get_xt_dimension (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X dimension resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_dimension (a_target, a_resource_name)
		end;

	set_xt_dimension (a_target: POINTER; a_resource_name: POINTER; a_dimension: INTEGER) is
			-- Assign a_dimension to target dimension resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_dimension (a_target, a_resource_name, a_dimension)
		end;

	get_xt_position (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X position resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_position (a_target, a_resource_name)
		end;

	set_xt_position (a_target: POINTER; a_resource_name: POINTER; a_position: INTEGER) is
			-- Assign a_position to target position resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_position (a_target, a_resource_name, a_position)
		end;

	get_xt_int (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X integer resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_int (a_target, a_resource_name)
		end;

	set_xt_int (a_target: POINTER; a_resource_name: POINTER; an_integer: INTEGER) is
			-- Assign an_integer to target integer resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_int (a_target, a_resource_name, an_integer)
		end;

	get_xt_cardinal (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X cardinal resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_cardinal (a_target, a_resource_name)
		end;

	set_xt_cardinal (a_target: POINTER; a_resource_name: POINTER; a_cardinal: INTEGER) is
			-- Assign a_cardinal to target cardinal resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_cardinal (a_target, a_resource_name, a_cardinal)
		end;

	get_xt_short (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X short resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_short (a_target, a_resource_name)
		end;

	set_xt_short (a_target: POINTER; a_resource_name: POINTER; a_short: INTEGER) is
			-- Assign a_short to target resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_short (a_target, a_resource_name, a_short)
		end;

	get_xt_string_no_free (a_target: POINTER; a_resource_name: POINTER): STRING is
			-- Value of X string resource with a_resource_name
			-- as name. Call a C function that does not free the pointer
			-- returned by XtVaGetValues.
		require
			not_a_resource_name_void: a_resource_name /= Void
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_string_no_free (a_target, a_resource_name)
		end;

	get_xt_string (a_target: POINTER; a_resource_name: POINTER): STRING is
			-- Value of X string resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_void: a_resource_name /= Void
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_string (a_target, a_resource_name)
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

	get_xt_unsigned_char (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of X unsigned char resource with a_resource_name
			-- as name
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			Result := c_get_unsigned_char (a_target, a_resource_name)
		end;

	set_xt_unsigned_char (a_target: POINTER; a_resource_name: POINTER; an_unsigned_char: INTEGER) is
			-- Assign an_unsigned_char to target unsigned char resource
			-- with a_resource_name as name.
		require
			value_large_enough: an_unsigned_char >= 0;
			value_small_enough: an_unsigned_char <= 255;
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_unsigned_char (a_target, a_resource_name, an_unsigned_char)
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
		do
			c_set_widget (a_target, a_resource_name, a_widget)
		end;

	get_xt_pixel (a_target: POINTER; a_resource_name: POINTER): MEL_PIXEL is
			-- Value of X pixel resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			!! Result.make_from_existing (c_get_pixel (a_target, a_resource_name), Mel_widgets.item (a_target).screen)
		end;

	set_xt_pixel (a_target: POINTER; a_resource_name: POINTER; a_pixel: MEL_PIXEL) is
			-- Assign a_pixel to pixel resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_pixel (a_target, a_resource_name, a_pixel.id)
		end;

	get_xt_pixmap (a_target: POINTER; a_resource_name: POINTER): MEL_PIXMAP is
			-- Value of X pixmap resource with a_resource_name
			-- as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			!! Result.make_from_existing (c_get_pixmap (a_target, a_resource_name), Mel_widgets.item (a_target).screen)
		end;

	set_xt_pixmap (a_target: POINTER; a_resource_name: POINTER; a_pixmap: MEL_PIXMAP) is
			-- Assign a_pixmap to pixmap resource
			-- with a_resource_name as name.
		require
			not_a_resource_name_null: a_resource_name /= default_pointer
		do
			c_set_pixmap (a_target, a_resource_name, a_pixmap.id)
		end;

feature {NONE} -- External features

	c_get_dimension (scr_obj: POINTER; resource: POINTER): INTEGER is
		external
			"C"
		end;

	c_get_boolean (scr_obj: POINTER; resource: POINTER): BOOLEAN is
		external
			"C"
		end;

	c_set_boolean (scr_obj: POINTER; resource: POINTER; val: BOOLEAN) is
		external
			"C"
		end;

	c_set_dimension (scr_obj: POINTER; resource: POINTER; val: INTEGER) is
		external
			"C"
		end;

	c_get_position (scr_obj: POINTER; resource: POINTER): INTEGER is
		external
			"C"
		end;

	c_set_position (scr_obj: POINTER; resource: POINTER; val: INTEGER) is
		external
			"C"
		end;

	c_get_int (scr_obj: POINTER; resource: POINTER): INTEGER is
		external
			"C"
		end;

	c_set_int (scr_obj: POINTER; resource: POINTER; val: INTEGER) is
		external
			"C"
		end;

	c_get_cardinal (scr_obj: POINTER; resource: POINTER): INTEGER is
		external
			"C"
		end;

	c_set_cardinal (scr_obj: POINTER; resource: POINTER; val: INTEGER) is
		external
			"C"
		end;

	c_get_short (scr_obj: POINTER; resource: POINTER): INTEGER is
		external
			"C"
		end;

	c_set_short (scr_obj: POINTER; resource: POINTER; val: INTEGER) is
		external
			"C"
		end;

	c_get_string_no_free (scr_obj: POINTER; resource: POINTER): STRING is
		external
			"C"
		end;

	c_get_string (scr_obj: POINTER; resource: POINTER): STRING is
		external
			"C"
		end;

	c_set_string (scr_obj: POINTER; resource: POINTER; val: POINTER) is
		external
			"C"
		end;

	c_get_unsigned_char (scr_obj: POINTER; resource: POINTER): INTEGER is
		external
			"C"
		end;

	c_set_unsigned_char (scr_obj: POINTER; resource: POINTER; val: INTEGER) is
		external
			"C"
		end;

	c_get_widget (scr_obj: POINTER; resource: POINTER): POINTER is
		external
			"C"
		end;

	c_set_widget (scr_obj: POINTER; resource: POINTER; val: POINTER) is
		external
			"C"
		end;

	c_get_pixel (scr_obj: POINTER; resource: POINTER): INTEGER is
		external
			"C"
		end;

	c_set_pixel (scr_obj: POINTER; resource: POINTER; val: INTEGER) is
		external
			"C"
		end;

	c_get_pixmap (scr_obj: POINTER; resource: POINTER): INTEGER is
		external
			"C"
		end;

	c_set_pixmap (scr_obj: POINTER; resource: POINTER; val: INTEGER) is
		external
			"C"
		end;

feature {NONE} -- Implementation

	xt_destroy_widget (scr_obj: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget)"
		alias
			"XtDestroyWidget"
		end;

	xt_realize_widget (scr_obj: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget)"
		alias
			"XtRealizeWidget"
		end;

	xt_unrealize_widget (scr_obj: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget)"
		alias
			"XtUnrealizeWidget"
		end;

	xt_manage_child (scr_obj: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget)"
		alias
			"XtManageChild"
		end;

	xt_unmanage_child (scr_obj: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget)"
		alias
			"XtUnmanageChild"
		end;

	xt_set_sensitive (scr_obj: POINTER; bool: BOOLEAN) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget, Boolean)"
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
			"C [macro <X11/Intrinsic.h>] (XtPointer)"
		alias
			"XtFree"
		end;

	xt_display (scr_obj: POINTER): POINTER is
		external
			"C [macro <X11/Intrinsic.h>] (Widget): EIF_POINTER"
		alias
			"XtDisplay"
		end;

	xt_va_get_values (scr_obj, resource, var, end_ptr: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget, String, XtPointer, XtPointer)"
		alias
			"XtVaGetValues"
		end;

	xt_is_realized (scr_obj: POINTER): BOOLEAN is
		external
			"C [macro <X11/Intrinsic.h>] (Widget): EIF_BOOLEAN"
		alias
			"XtIsRealized"
		end;

	xt_is_managed (scr_obj: POINTER): BOOLEAN is
		external
			"C [macro <X11/Intrinsic.h>] (Widget): EIF_BOOLEAN"
		alias
			"XtIsManaged"
		end;

	xt_is_sensitive (scr_obj: POINTER): BOOLEAN is
		external
			"C [macro <X11/Intrinsic.h>] (Widget): EIF_BOOLEAN"
		alias
			"XtIsSensitive"
		end;

	xt_is_visible (scr_obj: POINTER): BOOLEAN is
		external
			"C"
		end;

	xt_window (a_target: POINTER): INTEGER is
		external
			"C [macro <X11/Intrinsic.h>] (Widget): EIF_INTEGER"
		alias
			"XtWindow"
		end;

	xt_parent (a_target: POINTER): POINTER is
		external
			"C [macro <X11/Intrinsic.h>] (Widget): EIF_POINTER"
		alias
			"XtParent"
		end;

	xt_name (a_target: POINTER): POINTER is
		external
			"C [macro <X11/Intrinsic.h>] (Widget): EIF_POINTER"
		alias
			"XtName"
		end;

	xt_widget_to_application_context (a_target: POINTER): POINTER is
		external
			"C [macro <X11/Intrinsic.h>] (Widget): EIF_POINTER"
		alias
			"XtWidgetToApplicationContext"
		end;

end -- class MEL_XT_FUNCTIONS

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
