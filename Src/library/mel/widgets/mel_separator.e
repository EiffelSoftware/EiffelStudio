indexing

	description:
			"Widget that draws a line to separate other widget visually.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SEPARATOR

inherit

	MEL_SEPARATOR_RESOURCES
		export
			{NONE} all
		end;

	MEL_PRIMITIVE

creation 
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif separator.
		require
			a_name_exists: a_name /= Void;
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_separator (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed
		end;

feature -- Status report

	is_horizontal: BOOLEAN is
			-- Is separator orientation horizontal?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNorientation) = XmHORIZONTAL
		end;

	is_no_line: BOOLEAN is
			-- Is Current displayed as nothing?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNseparatorType) = XmNO_LINE
		end;

	is_single_line: BOOLEAN is
			-- Is Current displayed as a single line?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNseparatorType) = XmSINGLE_LINE
		end;

	is_double_line: BOOLEAN is
			-- Is Current displayed as a double line?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNseparatorType) = XmDOUBLE_LINE
		end;

	is_single_dashed_line: BOOLEAN is
			-- Is Current displayed as a single dashed line?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNseparatorType) = XmSINGLE_DASHED_LINE
		end;

	is_double_dashed_line: BOOLEAN is
			-- Is Current displayed as a double dashed line?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNseparatorType) = XmDOUBLE_DASHED_LINE
		end;

	is_shadow_etched_in: BOOLEAN is
			-- Is Current displayed as a deeper line?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNseparatorType) = XmSHADOW_ETCHED_IN
		end;

feature -- Status setting

	set_horizontal (b: BOOLEAN) is
			-- Set `is_horizontal' to `b'.
		require
			exists: not is_destroyed
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNorientation, XmHORIZONTAL)
			else
				set_xt_unsigned_char (screen_object, XmNorientation, XmVERTICAL)
			end
		ensure
			orientation_set: is_horizontal = b
		end;

	set_no_line is
			-- Set `is_no_line'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNseparatorType, XmNO_LINE)
		ensure
			invisible: is_no_line
		end;

	set_single_line is
			-- Set `is_single_line'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNseparatorType, XmSINGLE_LINE)
		ensure
			single_line_set: is_single_line
		end;

	set_double_line is
			-- Set `is_double_line'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNseparatorType, XmDOUBLE_LINE)
		ensure
			double_line_set: is_double_line
		end;

	set_single_dashed_line is
			-- Set `is_single_dashed_line'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNseparatorType, XmSINGLE_DASHED_LINE)
		ensure
			single_dashed_line_set: is_single_dashed_line
		end;

	set_double_dashed_line is
			-- Set `is_double_dashed_line'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNseparatorType, XmDOUBLE_DASHED_LINE)
		ensure
			double_dashed_line_set: is_double_dashed_line
		end;

	set_shadow_etched_in (b: BOOLEAN) is
			-- Set `is_shadow_etched_in' to `b'.
		require
			exists: not is_destroyed
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNseparatorType, XmSHADOW_ETCHED_IN)
			else
				set_xt_unsigned_char (screen_object, XmNseparatorType, XmSHADOW_ETCHED_OUT)
			end
		ensure
			shadow_etched_in_set: is_shadow_etched_in = b
		end;

feature {NONE} -- Implementation

	xm_create_separator (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/Separator.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateSeparator"
		end;

end -- class MEL_SEPARATOR

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
