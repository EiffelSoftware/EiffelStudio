indexing

	description:
			"Manager widget that places a border around a single child.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FRAME

inherit

	MEL_FRAME_RESOURCES
		export
			{NONE} all
		end;

	MEL_MANAGER

creation 
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif frame widget.
		require
			a_name_exists: a_name /= Void
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_frame (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed
		end;

feature -- Status report

	margin_height: INTEGER is
			-- Spacing between the top or the bottom of a child
			-- and the shadow of Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginHeight)
		ensure
			margin_height_large_enough: Result >= 0
		end;

	margin_width: INTEGER is
			-- Spacing between the left or right side of a child
			-- and the shadow of Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginWidth)
		ensure
			margin_width_large_enough: Result >= 0
		end;

	is_shadow_in: BOOLEAN is
			-- Does Current appear inset?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char (screen_object, XmNshadowType) = XmSHADOW_IN) or
					  (get_xt_unsigned_char (screen_object, XmNshadowType) = XmSHADOW_ETCHED_IN)
		end;

	is_shadow_etched: BOOLEAN is
			-- Does Current appear with a double line shadow?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char (screen_object, XmNshadowType) = XmSHADOW_ETCHED_IN) or
					  (get_xt_unsigned_char (screen_object, XmNshadowType) = XmSHADOW_ETCHED_OUT)
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

	set_shadow_in (b: BOOLEAN) is
			-- Set `is_shadow_in' to `b' and `is_shadow_etched' to False.
		require
			exists: not is_destroyed
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_IN)
			else
				set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_OUT)
			end
		ensure
			shadow_type_set: is_shadow_in = b and not is_shadow_etched
		end;

	set_shadow_etched_in (b: BOOLEAN) is
			-- Set `is_shadow_in' to `b' and `is_shadow_etched' to True.
		require
			exists: not is_destroyed
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_ETCHED_IN)
			else
				set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_ETCHED_OUT)
			end
		ensure
			shadow_type_set: is_shadow_in = b and is_shadow_etched
		end;

feature -- Miscellaneous

	is_child_title (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' the title?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildType) = XmFRAME_TITLE_CHILD
		end;

	is_child_workarea (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' the work area?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildType) = XmFRAME_WORKAREA_CHILD
		end;

	is_child_generic (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' ignored?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildType) = XmFRAME_GENERIC_CHILD
		end;

	set_child_as_title (a_widget: MEL_RECT_OBJ) is
			-- Use `a_widget' as the title.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildType, XmFRAME_TITLE_CHILD)
		ensure
			child_is_now_the_title: is_child_title (a_widget)
		end;

	set_child_as_workarea (a_widget: MEL_RECT_OBJ) is
			-- Use `a_widget' as the work area.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildType, XmFRAME_WORKAREA_CHILD)
		ensure
			child_is_now_the_work_area: is_child_workarea (a_widget)
		end;

	set_child_generic (a_widget: MEL_RECT_OBJ) is
			-- Ignore `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildType, XmFRAME_GENERIC_CHILD)
		ensure
			child_is_now_ignored: is_child_generic (a_widget)
		end;

	is_child_horizontal_alignment_beginning (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' horizontally aligned with the beginning?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildHorizontalAlignment)
							= XmALIGNMENT_BEGINNING
		end;

	is_child_horizontal_alignment_center (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' horizontally aligned with the center?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildHorizontalAlignment)
							= XmALIGNMENT_CENTER
		end;

	is_child_horizontal_alignment_end (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' horizontally aligned with the end?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildHorizontalAlignment)
							= XmALIGNMENT_END
		end;

	set_child_horizontal_alignment_beginning (a_widget: MEL_RECT_OBJ) is
			-- Align `a_widget' with the beginning.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildHorizontalAlignment, XmALIGNMENT_BEGINNING)
		ensure
			alignment_set: is_child_horizontal_alignment_beginning (a_widget)
		end;

	set_child_horizontal_alignment_center (a_widget: MEL_RECT_OBJ) is
			-- Align `a_widget' with the center.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildHorizontalAlignment, XmALIGNMENT_CENTER)
		ensure
			alignment_set: is_child_horizontal_alignment_center (a_widget)
		end;

	set_child_horizontal_alignment_end (a_widget: MEL_RECT_OBJ) is
			-- Align `a_widget' with the end.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildHorizontalAlignment, XmALIGNMENT_END)
		ensure
			alignment_set: is_child_horizontal_alignment_end (a_widget)
		end;

	child_horizontal_spacing (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Minimun distance between the title text and Current's shadow
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			Result := get_xt_dimension (a_widget.screen_object, XmNchildHorizontalSpacing)
		ensure
			horizontal_spacing_large_enough: Result >= 0
		end;

	set_child_horizontal_spacing (a_widget: MEL_RECT_OBJ; a_spacing: INTEGER) is
			-- Set `child_horizontal_spacing' for `a_widget' to `a_spacing'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget);
			a_spacing_large_enough: a_spacing >= 0
		do
			set_xt_dimension (a_widget.screen_object, XmNchildHorizontalSpacing, a_spacing)
		ensure
			horizontal_spacing_set: child_horizontal_spacing (a_widget) = a_spacing
		end;

	is_child_vertical_alignment_baseline_bottom (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is baseline of `a_widget' aligned to the bottom of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment)
							= XmALIGNMENT_BASELINE_BOTTOM
		end;

	is_child_vertical_alignment_baseline_top (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is baseline of `a_widget' aligned to the top of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment)
							= XmALIGNMENT_BASELINE_TOP
		end;

	is_child_vertical_alignment_widget_top (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' aligned to the top of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment)
							= XmALIGNMENT_WIDGET_TOP
		end;

	is_child_vertical_alignment_center (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is center line of `a_widget' aligned to the top line of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment)
							= XmALIGNMENT_CENTER
		end;

	is_child_vertical_alignment_widget_bottom (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' aligned to the bottom of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment)
							= XmALIGNMENT_WIDGET_BOTTOM
		end;

	set_child_vertical_alignment_baseline_bottom (a_widget: MEL_RECT_OBJ) is
			-- Align baseline of `a_widget' to the bottom of Current.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment, XmALIGNMENT_BASELINE_BOTTOM)
		ensure
			placement_set: is_child_vertical_alignment_baseline_bottom (a_widget)
		end;

	set_child_vertical_alignment_baseline_top (a_widget: MEL_RECT_OBJ) is
			-- Align baseline of `a_widget' to the top of Current.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment, XmALIGNMENT_BASELINE_TOP)
		ensure
			placement_set: is_child_vertical_alignment_baseline_top (a_widget)
		end;

	set_child_vertical_alignment_widget_top (a_widget: MEL_RECT_OBJ) is
			-- Align `a_widget' to the top of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment, XmALIGNMENT_WIDGET_TOP)
		ensure
			placement_set: is_child_vertical_alignment_widget_top (a_widget)
		end;

	set_child_vertical_alignment_center (a_widget: MEL_RECT_OBJ) is
			-- Align center line of `a_widget' to the top line of Current.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment, XmALIGNMENT_CENTER)
		ensure
			placement_set: is_child_vertical_alignment_center (a_widget)
		end;

	set_child_vertical_alignment_widget_bottom (a_widget: MEL_RECT_OBJ) is
			-- Align `a_widget' to the bottom of Current.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_widget_is_the_title: is_child_title (a_widget)
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNchildVerticalAlignment, XmALIGNMENT_WIDGET_BOTTOM)
		ensure
			placement_set: is_child_vertical_alignment_widget_bottom (a_widget)
		end;

feature {NONE} -- Implementation

	xm_create_frame (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/Label.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateFrame"
		end;

end -- class MEL_FRAME

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
