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
		redefine
			is_frame
		end

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif frame widget.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_frame (a_parent.screen_object, $widget_name, default_pointer, 0);
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

feature -- Access

	is_frame: BOOLEAN is True
			-- Is Current a frame?

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
