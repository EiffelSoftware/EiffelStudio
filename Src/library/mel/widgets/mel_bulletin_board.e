indexing

	description:
			"Simple geometry-managing widget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_BULLETIN_BOARD

inherit

	MEL_BULLETIN_BOARD_RESOURCES
		export
			{NONE} all
		end;

	MEL_MANAGER
		redefine
			create_callback_struct
		end

creation 
	make, 
	make_no_auto_unmanage,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif bulletin board.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, True);
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

	make_no_auto_unmanage (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif bulletin board and set `auto_unmanage' to False.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, False);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			auto_unmanage: not auto_unmanage;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create bulletin with name `w_name' and manage it according to
			-- `auto_manage_flag'.
		require	
			non_void_args: p_so /= default_pointer and w_name /= Void
		do
			if auto_manage_flag then
				screen_object := 
					xm_create_bulletin_board (p_so, 
						$w_name, default_pointer, 0);
			else
				screen_object := 
					xm_create_bulletin_board (p_so, 
						$w_name, auto_unmanage_arg, 1);
			end
		end;

feature -- Status report

	overlap_allowed: BOOLEAN is
			-- Are the children allowed to overlap Current?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNallowOverlap)
		end;

	auto_unmanage: BOOLEAN is
			-- Is the bulletin board automatically unmanaged after a button is activated
			-- unless the button is an Apply or Help button?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNautoUnmanage)
		end;

	button_font_list: MEL_FONT_LIST is
			-- Font list of the button children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNbuttonFontList)
		ensure
			button_font_list_is_valid: Result /= Void and then Result.is_valid
		end;

	label_font_list: MEL_FONT_LIST is
			-- Font list of the label children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNlabelFontList)
		ensure
			label_font_list_is_valid: Result /= Void and then Result.is_valid
		end;

	text_font_list: MEL_FONT_LIST is
			-- Font list of the text children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNtextFontList)
		ensure
			text_font_list_is_valid: Result /= Void and then Result.is_valid
		end;

	cancel_button: MEL_RECT_OBJ is
			-- Widget of the Cancel button
		require
			exists: not is_destroyed
		do
			Result ?= get_xt_widget (screen_object, XmNcancelButton)
		end;

	default_button: MEL_RECT_OBJ is
			-- The widget of the default button
		require
			exists: not is_destroyed
		do
			Result ?= get_xt_widget (screen_object, XmNdefaultButton)
		end;

	default_position: BOOLEAN is
			-- Is Current centered relative to `parent'.
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNdefaultPosition)
		end;

	dialog_work_area: BOOLEAN is
			-- Is the dialog style a work area?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogStyle) = XmDIALOG_WORK_AREA
		end;

	dialog_modeless: BOOLEAN is
			-- Is the dialog style modeless?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogStyle) = XmDIALOG_MODELESS
		end;

	dialog_full_application_modal: BOOLEAN is
			-- Is the dialog style full application modal?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogStyle) = XmDIALOG_FULL_APPLICATION_MODAL
		end;

	dialog_application_modal: BOOLEAN is
			-- Is the dialog style application modal?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogStyle) = XmDIALOG_APPLICATION_MODAL
		end;

	dialog_primary_application_modal: BOOLEAN is
			-- Is the dialog style primary application modal?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogStyle) = XmDIALOG_PRIMARY_APPLICATION_MODAL
		end;

	dialog_system_modal: BOOLEAN is
			-- Is the dialog style system modal?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogStyle) = XmDIALOG_SYSTEM_MODAL
		end;

	dialog_title: MEL_STRING is
			-- Title
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNdialogTitle)
		end;

	margin_height: INTEGER is
			-- The minimun spacing between a bulletin board's top
			-- or bottom edge of any child widget
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginHeight)
		ensure
			not_margin_height_negative: Result >= 0
		end;

	margin_width: INTEGER is
			-- The minimun spacing between a bulletin board's left
			-- or right edge of any child widget
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginWidth)
		ensure
			not_margin_width_negative: Result >= 0
		end;

	resize: BOOLEAN is
			-- Does MWM include resize controls in the window manager frame of `parent'?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNnoResize)
		end;

	resize_none: BOOLEAN is
			-- Will the widget remain at fixed size?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNresizePolicy) = XmRESIZE_NONE
		end;

	resize_grow: BOOLEAN is
			-- Can the widget expand only?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNresizePolicy) = XmRESIZE_GROW
		end;

	resize_any: BOOLEAN is
			-- Can the widget shrink or expand as needed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNresizePolicy) = XmRESIZE_ANY
		end;

	is_shadow_in: BOOLEAN is
			-- Does Current appear inset?
		require
			exists: not is_destroyed
		local
			shadowtype: INTEGER
		do
			shadowtype := get_xt_unsigned_char (screen_object, XmNshadowType);
			Result := (shadowtype = XmSHADOW_IN) or (shadowtype = XmSHADOW_ETCHED_IN)
		end;

	is_shadow_etched: BOOLEAN is
			-- Does Current appear with a double line shadow?
		require
			exists: not is_destroyed
		local
			shadowtype: INTEGER
		do
			shadowtype := get_xt_unsigned_char (screen_object, XmNshadowType);
			Result := (shadowtype = XmSHADOW_ETCHED_IN) or (shadowtype = XmSHADOW_ETCHED_OUT)
		end;

feature -- Status setting

	set_overlap_allowed (b: BOOLEAN) is
			-- Set `overlap_allowed' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNallowOverlap, b)
		ensure
			overlap_is_allowed: overlap_allowed = b
		end;

	set_button_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `button_font_list' to a `a_font_list'.
		require
			exists: not is_destroyed
			a_font_list_is_valid: a_font_list /= Void and then a_font_list.is_valid
		do
			set_xm_font_list (screen_object, XmNbuttonFontList, a_font_list)
		end;

	set_label_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `label_font_list' to a `a_font_list'.
		require
			exists: not is_destroyed
			a_font_list_is_valid: a_font_list /= Void and then a_font_list.is_valid
		do
			set_xm_font_list (screen_object, XmNlabelFontList, a_font_list)
		end;

	set_text_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `text_font_list' to `a_font_list'.
		require
			exists: not is_destroyed
			a_font_list_is_valid: a_font_list /= Void and then a_font_list.is_valid
		do
			set_xm_font_list (screen_object, XmNtextFontList, a_font_list)
		end;

	set_cancel_button (a_button: like cancel_button) is
			-- Set `cancel_button' to `a_button'.
		require
			exists: not is_destroyed;
			a_button_exists: not a_button.is_destroyed
		do
			set_xt_widget (screen_object, XmNcancelButton, a_button.screen_object)
		ensure
			cancel_button_set: cancel_button.is_equal (a_button)
		end;

	set_default_button (a_button: like default_button) is
			-- Set `default_button' to `a_button'.
		require
			exists: not is_destroyed;
			a_button_exists: not a_button.is_destroyed
		do
			set_xt_widget (screen_object, XmNdefaultButton, a_button.screen_object)
		ensure
			default_button_set: default_button.is_equal (a_button)
		end;

	set_default_position (b: BOOLEAN) is
			-- Set `default_position' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNdefaultPosition, b)
		ensure
			default_position_enabled: default_position = b
		end;

	set_dialog_work_area is
			-- Set the dialog style to work area.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogStyle, XmDIALOG_WORK_AREA)
		ensure
			dialog_work_area_set: dialog_work_area
		end;

	set_dialog_modeless is
			-- Set the dialog style modeless.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogStyle, XmDIALOG_MODELESS)
		ensure
			dialog_modeless_set: dialog_modeless
		end;

	set_dialog_full_application_modal is
			-- Set the dialog style full application modal.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogStyle, XmDIALOG_FULL_APPLICATION_MODAL)
		ensure
			dialog_full_application_modal_set: dialog_full_application_modal
		end;

	set_dialog_application_modal is
			-- Set the dialog style application modal.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogStyle, XmDIALOG_APPLICATION_MODAL)
		ensure
			dialog_application_modal_set: dialog_application_modal
		end;

	set_dialog_primary_application_modal is
			-- Set the dialog style primary application modal.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogStyle, XmDIALOG_PRIMARY_APPLICATION_MODAL)
		ensure
			dialog_primary_application_modal_set: dialog_primary_application_modal
		end;

	set_dialog_system_modal is
			-- Set the dialog style system modal.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogStyle, XmDIALOG_SYSTEM_MODAL)
		ensure
			dialog_system_modal_set: dialog_system_modal
		end;

	set_dialog_title (a_compound_string: MEL_STRING) is
			-- Set `dialog_title' to `a_compound_string'.
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then
											not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNdialogTitle, a_compound_string)
		ensure
			dialog_title_set: dialog_title.is_equal (a_compound_string)
		end;

	set_margin_height (a_height: INTEGER) is
			-- Set `margin_height' to `a_height'.
		require
			exists: not is_destroyed;
			not_margin_height_negative: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNmarginHeight, a_height)
		ensure
			margin_height_set: margin_height = a_height
		end;

	set_margin_width (a_width: INTEGER) is
			-- Set `margin_width' to `a_width'.
		require
			exists: not is_destroyed;
			not_margin_width_negative: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNmarginWidth, a_width)
		ensure
			margin_width_set: margin_width = a_width
		end;

	set_resize (b: BOOLEAN) is
			-- Set `resize' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNnoResize, b)
		ensure
			resize_set: resize = b
		end;

	set_resize_none is
			-- The widget remains at fixed size.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNresizePolicy, XmRESIZE_NONE)
		ensure
			resize_none_set: resize_none
		end;

	set_resize_grow is
			-- Allow the widget to expand only.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNresizePolicy, XmRESIZE_GROW)
		ensure
			resize_grow_set: resize_grow
		end;

	set_resize_any is
			-- Allow the widget to shrink or expand as needed.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNresizePolicy, XmRESIZE_ANY)
		ensure
			resize_any_set: resize_any
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

feature -- Element change

	add_focus_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget or one of its descendants
			-- receives the input focus.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNfocusCallback, a_callback, an_argument)
		end;

	add_map_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget is mapped, if the
			-- widget is a child of a dialog shell.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNmapCallback, a_callback, an_argument)
		end;

	add_unmap_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget is unmapped, if the
			-- widget is a child of a dialog shell.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNunmapCallback, a_callback, an_argument)
		end;

feature -- Removal

	remove_focus_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget or one of its descendants
			-- receives the input focus.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNfocusCallback, a_callback, an_argument)
		end;

	remove_map_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget is mapped, if the
			-- widget is a child of a dialog shell.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNmapCallback, a_callback, an_argument)
		end;

	remove_unmap_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget is unmapped, if the
			-- widget is a child of a dialog shell.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNunmapCallback, a_callback, an_argument)
		end;

	create_callback_struct (a_callback_struct_ptr,
				resource_name: POINTER): MEL_ANY_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
		   	!! Result.make (Current, a_callback_struct_ptr);
		end;

feature {NONE} -- Implementation

	auto_unmanage_arg: POINTER is
			-- C pointer value of Arg value of
			-- XmNautoUnmanage which is set to False
		once
			Result := c_auto_unmanage_arg
		end;

feature {NONE} -- External features

	c_auto_unmanage_arg: POINTER is
			-- Set the `XmNautoUnmanage' arg to False.
		external
			"C"
		end;

	xm_create_bulletin_board (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/BulletinB.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateBulletinBoard"
		end;

end -- class MEL_BULLETIN_BOARD

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
