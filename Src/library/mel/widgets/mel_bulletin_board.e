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

feature -- Access

	focus_command: MEL_COMMAND_EXEC is
			-- Command set for the focus callback
		do
			Result := motif_command (XmNfocusCallback)
		end;

	map_command: MEL_COMMAND_EXEC is
			-- Command set for the map callback
		do
			Result := motif_command (XmNmapCallback)
		end;

	unmap_command: MEL_COMMAND_EXEC is
			-- Command set for the unmap callback
		do
			Result := motif_command (XmNunmapCallback)
		end

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
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

	label_font_list: MEL_FONT_LIST is
			-- Font list of the label children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNlabelFontList)
		ensure
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

	text_font_list: MEL_FONT_LIST is
			-- Font list of the text children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNtextFontList)
		ensure
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
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

	is_default_position: BOOLEAN is
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

	has_resize_control: BOOLEAN is
			-- Does MWM include resize controls in the window manager frame of `parent'?
		require
			exists: not is_destroyed
		do
			Result := not get_xt_boolean (screen_object, XmNnoResize)
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
			-- Is Current widget appear inset?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char
					(screen_object, XmNshadowType) = XmSHADOW_IN)
		end;

	is_shadow_out: BOOLEAN is
			-- Is Current widget appear raised?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char
					(screen_object, XmNshadowType) = XmSHADOW_OUT)
		end;

	is_shadow_etched_in: BOOLEAN is
			-- Does Current appear with a double line shadow inset?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char
						(screen_object, XmNshadowType) = XmSHADOW_ETCHED_IN)
		end;

	is_shadow_etched_out: BOOLEAN is
			-- Does Current appear with a double line shadow raised?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char
						(screen_object, XmNshadowType) = XmSHADOW_ETCHED_OUT)
		end;

feature -- Status setting

	enable_overlap is
			-- Set `overlap_allowed' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNallowOverlap, True)
		ensure
			overlap_is_allowed: overlap_allowed 
		end;

	forbid_overlap is
			-- Set `overlap_allowed' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNallowOverlap, False)
		ensure
			overlap_is_not_allowed: not overlap_allowed 
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

	enable_default_positioning is
			-- Set `is_default_position' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNdefaultPosition, True)
		ensure
			default_position_enabled: is_default_position 
		end;

	disable_default_positioning is
			-- Set `is_default_position' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNdefaultPosition, False)
		ensure
			default_position_disabled: not is_default_position 
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

	allow_resize_control is
			-- Set `has_resize_control' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNnoResize, False)
		ensure
			resize_allowed: has_resize_control 
		end;

	forbid_resize_control is
			-- Set `has_resize_control' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNnoResize, True)
		ensure
			resize_not_allowed: not has_resize_control 
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

	set_shadow_in is
			-- Set `is_shadow_in' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_IN)
		ensure
			is_shadow_in: is_shadow_in
		end;

	set_shadow_out is
			-- Set `is_shadow_in' to False.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_OUT)
		ensure
			is_shadow_out: is_shadow_out
		end;

	set_shadow_etched_in is
			-- Set `is_shadow_etched_in' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_ETCHED_IN)
		ensure
			is_shadow_etched_in: is_shadow_etched_in
		end;

	set_shadow_etched_out is
			-- Set `is_shadow_etched_out' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_ETCHED_OUT)
		ensure
			is_shadow_etched_out: is_shadow_etched_out
		end;

feature -- Element change

	set_focus_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the widget or one of
			-- its descendants receives the input focus. 
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNfocusCallback, a_command, an_argument)
		ensure
			command_set: command_set (focus_command, a_command, an_argument)
		end;

	set_map_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the widget is mapped, 
			-- if the widget is a child of a dialog shell.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNmapCallback, a_command, an_argument)
		ensure
			command_set: command_set (map_command, a_command, an_argument)
		end;

	set_unmap_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the widget is unmapped, 
			-- if the widget is a child of a dialog shell.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNunmapCallback, a_command, an_argument)
		ensure
			command_set: command_set (unmap_command, a_command, an_argument)
		end;

feature -- Removal

	remove_focus_callback is
			-- Remove the command for the focus callback.
		do
			remove_callback (XmNfocusCallback)
		ensure
			removed: focus_command = Void
		end;

	remove_map_callback is
			-- Remove the command for the map callback.
		do
			remove_callback (XmNmapCallback)
		ensure
			removed: map_command = Void
		end;

	remove_unmap_callback is
			-- Remove the command for the unmap callback.
		do
			remove_callback (XmNunmapCallback)
		ensure
			removed: unmap_command = Void
		end;

feature {MEL_DISPATCHER} -- Implementation

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
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/BulletinB.h>"
		alias
			"XmCreateBulletinBoard"
		end;

end -- class MEL_BULLETIN_BOARD


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

