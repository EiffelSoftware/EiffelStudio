indexing

	description:
			"Simple manager widget for interactive drawing.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DRAWING_AREA 

inherit

	MEL_DRAWING_AREA_RESOURCES
		export
			{NONE} all
		end;

	MEL_DRAWING;

	MEL_COMPOSITE
		redefine
			create_callback_struct
		end

creation
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif drawing area widget.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_drawing_area (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Status report

	margin_height: INTEGER is
			-- Space between the top and bottom side and any child
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginHeight)
		ensure
			vlaid_result: Result >= 0
		end;

	margin_width: INTEGER is
			-- Space between the left and right side and any child
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginWidth)
		ensure
			valid_result: Result >= 0
		end;

	is_resize_none: BOOLEAN is
			-- Will the widget remain at fixed size?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNresizePolicy) = XmRESIZE_NONE
		end;

	is_resize_grow: BOOLEAN is
			-- Can the widget only expand?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNresizePolicy) = XmRESIZE_GROW
		end;

	is_resize_any: BOOLEAN is
			-- Can the widget shrink or expand as needed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNresizePolicy) = XmRESIZE_ANY
		end;

feature -- Status setting

	set_margin_height (a_height: INTEGER) is
			-- Set `margin_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNmarginHeight, a_height)
		ensure
			margin_height_set: margin_height = a_height
		end;

	set_margin_width (a_width: INTEGER) is
			-- Set `margin_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNmarginWidth, a_width)
		ensure
			margin_width_set: margin_width = a_width
		end;

	set_resize_none is
			-- The widget remains at fixed size.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNresizePolicy, XmRESIZE_NONE)
		ensure
			resize_none_set: is_resize_none
		end;

	set_resize_grow is
			-- Allow the widget to expand only.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNresizePolicy, XmRESIZE_GROW)
		ensure
			resize_grow_set: is_resize_grow
		end;

	set_resize_any is
			-- Allow the widget to shrink or expand as needed.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNresizePolicy, XmRESIZE_ANY)
		ensure
			resize_any_set: is_resize_any
		end;

feature -- Element change

	add_expose_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget receives an exposure
			-- event.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNexposeCallback, a_callback, an_argument)
		end;

	add_input_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget receives a keyboard
			-- or mouse event.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNinputCallback, a_callback, an_argument)
		end;

	add_resize_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget receives a resize
			-- event.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNresizeCallback, a_callback, an_argument)
		end;

feature -- Removal

	remove_expose_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget receives an exposure
			-- event.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNexposeCallback, a_callback, an_argument)
		end;

	remove_input_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget receives a keyboard
			-- or mouse event.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNinputCallback, a_callback, an_argument)
		end;

	remove_resize_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget receives a resize
			-- event.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNresizeCallback, a_callback, an_argument)
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER;
			 resource_name: POINTER): MEL_DRAWING_AREA_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	xm_create_drawing_area (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/DrawingA.h>"
		alias
			"XmCreateDrawingArea"
		end

end -- class MEL_DRAWING_AREA

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
