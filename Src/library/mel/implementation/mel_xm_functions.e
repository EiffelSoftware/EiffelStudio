indexing

	decription: 
		"Motif functions that can be used on objects.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_XM_FUNCTIONS

feature {NONE} -- Implementation

	xm_change_color (a_target: POINTER; a_pixel: POINTER) is
			-- Change all of the colors for the specified widget
			-- based on the new background color.
		external
			"C (Widget, Pixel) | <Xm/Xm.h>"
		alias
			"XmChangeColor"
		end;

	get_xm_string_direction (a_target: POINTER; a_resource_name: POINTER): INTEGER is
			-- Value of string direction resource with a_resource_name
			-- as name.
		require
			target_not_null: a_target /= default_pointer;
			resource_name_not_null: a_resource_name /= default_pointer
		do
			Result := c_get_string_direction (a_target, a_resource_name)
		end;

	set_xm_string_direction (a_target: POINTER; a_resource_name: POINTER; a_direction: INTEGER) is
			-- Assign a_direction to target string direction resource
			-- with a_resource_name as name.
		require
			target_not_null: a_target /= default_pointer;
			resource_name_not_null: a_resource_name /= default_pointer
		do
			c_set_string_direction (a_target, a_resource_name, a_direction)
		end;

	get_xm_string_table (a_target: POINTER; a_resource_name: POINTER): POINTER is
			-- Value of string direction resource with a_resource_name
			-- as name.
		require
			target_not_null: a_target /= default_pointer;
			resource_name_not_null: a_resource_name /= default_pointer
		do
			Result := c_get_string_table (a_target, a_resource_name)
		end;

	set_xm_string_table (a_target: POINTER; a_resource_name: POINTER; a_string_table: POINTER) is
			-- Assign a_direction to target string direction resource
			-- with a_resource_name as name.
		require
			target_not_null: a_target /= default_pointer;
			resource_name_not_null: a_resource_name /= default_pointer
		do
			c_set_string_table (a_target, a_resource_name, a_string_table)
		end;

	get_xm_string (a_target: POINTER; a_resource_name: POINTER): MEL_STRING is
			-- Value of X string resource with a_resource_name
			-- as name.
		require
			target_not_null: a_target /= default_pointer;
			resource_name_not_null: a_resource_name /= default_pointer
		local
			p: POINTER
		do
			p := c_get_xmstring (a_target, a_resource_name);
			if p /= default_pointer then
				!! Result.make_from_existing (p)
			end
		end;

	set_xm_string (a_target: POINTER; a_resource_name: POINTER; a_compound_string: MEL_STRING) is
			-- Assign a_compound_string to target string resource
			-- with a_resource_name as name.
		require
			target_not_null: a_target /= default_pointer;
			not_a_resource_name_null: a_resource_name /= default_pointer;
			valid_compound_string: a_compound_string /= Void and then a_compound_string.is_valid
		do
			c_set_xmstring (a_target, a_resource_name, a_compound_string.handle)
		end;

	get_xm_font_list (a_target: POINTER; a_resource_name: POINTER): MEL_FONT_LIST is
			-- Value of X string resource with a_resource_name
			-- as name.
		require
			target_not_null: a_target /= default_pointer;
			resource_name_not_null: a_resource_name /= default_pointer
		do
			!! Result.make_from_existing (
				c_get_font_list (a_target, a_resource_name));
			Result.set_shared
		end;

	set_xm_font_list (a_target: POINTER; a_resource_name: POINTER; a_font: MEL_FONT_LIST) is
			-- Assign a_compound_string to target string resource
			-- with a_resource_name as name.
		require
			target_not_null: a_target /= default_pointer;
			a_resource_name_not_null: a_resource_name /= default_pointer;
			valid_font: a_font /= Void and then a_font.is_valid
		do
			c_set_font_list (a_target, a_resource_name, a_font.handle)
		end;

feature {NONE} -- Widget queries

    xm_is_scroll_bar (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/ScrollBar.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsScrollBar"
        end;

    xm_is_label (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/Label.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsLabel"
        end;

    xm_is_label_gadget (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/LabelG.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsLabelGadget"
        end;

    xm_is_arrow_button (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/ArrowB.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsArrowButton"
        end;

    xm_is_arrow_button_gadget (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/ArrowBG.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsArrowButtonGadget"
        end;

    xm_is_cascade_button (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/CascadeB.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsCascadeButton"
        end;

    xm_is_cascade_button_gadget (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/CascadeBG.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsCascadeButtonGadget"
        end;

    xm_is_push_button_gadget (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/PushBG.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsPushButtonGadget"
        end;

    xm_is_push_button (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/PushB.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsPushButton"
        end;

    xm_is_list (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/List.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsList"
        end;

    xm_is_sash (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/SashP.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsSash"
        end;

    xm_is_text (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/Text.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsText"
        end;

    xm_is_text_field (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/TextF.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsTextField"
        end;

    xm_is_toggle_button (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/ToggleB.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsToggleButton"
        end;

    xm_is_toggle_button_gadget (widget: POINTER): BOOLEAN is
        external
            "C [macro <Xm/ToggleBG.h>] (Widget): EIF_BOOLEAN"
        alias
            "XmIsToggleButtonGadget"
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

	c_set_font_list (scr_obj: POINTER; resource: POINTER; val: POINTER) is
		external
			"C"
		end;

	c_get_font_list (scr_obj: POINTER; resource: POINTER): POINTER is
		external
			"C"
		end;

end -- class MEL_XM_FUNCTIONS


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

