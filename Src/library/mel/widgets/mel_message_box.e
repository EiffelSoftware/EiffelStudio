indexing

	description:
			"Composite widget used for creating message disalogs.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MESSAGE_BOX

inherit

	MEL_MESSAGE_BOX_RESOURCES
		export
			{NONE} all
		end;

	MEL_BULLETIN_BOARD
		redefine
			cancel_button, create_widget
		end

creation
	make, 
	make_no_auto_unmanage,
	make_from_existing

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create message box with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object := xm_create_message_box (p_so, $w_name, default_pointer, 0)
			else
				screen_object := xm_create_message_box (p_so, $w_name, auto_unmanage_arg, 1)
			end;
		end

feature -- Access

	cancel_button: MEL_PUSH_BUTTON_GADGET is
			-- Cancel button
		local
			w: POINTER
		do
			w := xm_message_box_get_child (screen_object, XmDIALOG_CANCEL_BUTTON);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	help_button: MEL_PUSH_BUTTON_GADGET is
			-- Help button
		local
			w: POINTER
		do
			w := xm_message_box_get_child (screen_object, XmDIALOG_HELP_BUTTON);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	ok_button: MEL_PUSH_BUTTON_GADGET is
			-- Ok button
		local
			w: POINTER
		do
			w := xm_message_box_get_child (screen_object, XmDIALOG_OK_BUTTON);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	separator: MEL_SEPARATOR_GADGET is
			-- Separator used
		local
			w: POINTER
		do
			w := xm_message_box_get_child (screen_object, XmDIALOG_SEPARATOR);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	message_label: MEL_LABEL_GADGET is
			-- Message label where message is displayed
		local
			w: POINTER
		do
			w := xm_message_box_get_child (screen_object, XmDIALOG_MESSAGE_LABEL);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	symbol_label: MEL_LABEL_GADGET is
			-- Symbol widget representing the pixmap
		local
			w: POINTER
		do
			w := xm_message_box_get_child (screen_object, XmDIALOG_SYMBOL_LABEL);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	ok_command: MEL_COMMAND_EXEC is
			-- Command set for the ok callback
		do
			Result := motif_command (XmNokCallback)
		end;

	cancel_command: MEL_COMMAND_EXEC is
			-- Command set for the cancel callback
		do
			Result := motif_command (XmNcancelCallback)
		end

feature -- Status report

	message_string: MEL_STRING is
			-- The string that appears in the message
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNmessageString)
		ensure
			result_is_valid: Result /= Void and then not Result.is_destroyed
		end;

	cancel_label_string: MEL_STRING is
			-- The string that labels the cancel button
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNcancelLabelString)
		ensure
			result_is_valid: Result /= Void and then not Result.is_destroyed
		end;

	help_label_string: MEL_STRING is
			-- The string that labels the help button.
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNhelpLabelString)
		ensure
			result_is_valid: Result /= Void and then not Result.is_destroyed
		end;

	ok_label_string: MEL_STRING is
			-- The string that labels the ok button.
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNokLabelString)
		ensure
			result_is_valid: Result /= Void and then not Result.is_destroyed
		end;

	is_cancel_button_default: BOOLEAN is
			-- Is `cancel_button' the default button?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdefaultButtonType) = XmDIALOG_CANCEL_BUTTON
		end;

	is_help_button_default: BOOLEAN is
			-- Is `help_button' the default button?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdefaultButtonType) = XmDIALOG_HELP_BUTTON
		end;

	is_ok_button_default: BOOLEAN is
			-- Is `ok_button' the default button?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdefaultButtonType) = XmDIALOG_OK_BUTTON
		end;

	is_error_dialog: BOOLEAN is
			-- Is type error dialog?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_ERROR
		end;

	is_information_dialog: BOOLEAN is
			-- Is type information dialog?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_INFORMATION
		end;

	is_message_dialog: BOOLEAN is
			-- Is type message dialog?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_MESSAGE
		end;

	is_question_dialog: BOOLEAN is
			-- Is type question dialog?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_QUESTION
		end;

	is_template_dialog: BOOLEAN is
			-- Is type template dialog?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_TEMPLATE
		end;

	is_warning_dialog: BOOLEAN is
			-- Is type warning dialog?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_WARNING
		end;

	is_working_dialog: BOOLEAN is
			-- Is type working dialog?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_WORKING
		end;

	is_alignment_beginning: BOOLEAN is
			-- Is alignment set to the beginning?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNmessageAlignment) = XmALIGNMENT_BEGINNING
		end;

	is_alignment_center: BOOLEAN is
			-- Is alignment set to the center?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNmessageAlignment) = XmALIGNMENT_CENTER
		end;

	is_alignment_end: BOOLEAN is
			-- Is alignment set to the end?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNmessageAlignment) = XmALIGNMENT_END
		end;

	buttons_minimized: BOOLEAN is
			-- Keep the buttons keep their prefered size?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNminimizeButtons)
		end;

	symbol_pixmap: MEL_PIXMAP is
			-- Pixmap label used as message symbol
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNsymbolPixmap);
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

feature -- Status setting

	set_message_string (a_compound_string: MEL_STRING) is
			-- Set `message_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNmessageString, a_compound_string)
		ensure
			-- message_label_string_set: message_string.is_equal (a_compound_string)
		end;

	set_cancel_label_string (a_compound_string: MEL_STRING) is
			-- Set `cancel_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNcancelLabelString, a_compound_string)
		ensure
			-- cancel_label_string_set: cancel_label_string.is_equal (a_compound_string)
		end;

	set_help_label_string (a_compound_string: MEL_STRING) is
			-- Set `help_label_string' as `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNhelpLabelString, a_compound_string)
		ensure
			-- help_label_string_set: help_label_string.is_equal (a_compound_string)
		end;

	set_ok_label_string (a_compound_string: MEL_STRING) is
			-- Set `ok_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNokLabelString, a_compound_string)
		ensure
			-- ok_label_string_set: ok_label_string.is_equal (a_compound_string)
		end;

	set_default_button_cancel is
			-- Set `cancel_button' as the default button.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdefaultButtonType, XmDIALOG_CANCEL_BUTTON)
		ensure
			default_button_cancel_set: is_cancel_button_default
		end;

	set_default_button_help is
			-- Set `help_button' as the default button.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdefaultButtonType, XmDIALOG_HELP_BUTTON)
		ensure
			default_button_help_set: is_help_button_default
		end;

	set_default_button_ok is
			-- Set `ok_button' as the default button.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdefaultButtonType, XmDIALOG_OK_BUTTON)
		ensure
			default_button_ok_set: is_ok_button_default
		end;

	set_error_dialog is
			-- Set `is_error_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_ERROR)
		ensure
			dialog_error_set: is_error_dialog
		end;

	set_information_dialog is
			-- Set `is_information_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_INFORMATION)
		ensure
			dialog_information_set: is_information_dialog
	   end;

	set_message_dialog is
			-- Set `is_message_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_MESSAGE)
		ensure
			dialog_message_set: is_message_dialog
		end;

	set_question_dialog is
			-- Set `is_question_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_QUESTION)
		ensure
			dialog_question_set: is_question_dialog
		end;

	set_template_dialog is
			-- Set `is_template_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_TEMPLATE)
		ensure
			dialog_template: is_template_dialog
		end;

	set_warning_dialog is
			-- Set `is_warning_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_WARNING)
		ensure
			dialog_warning_set: is_warning_dialog
		end;

	set_working_dialog is
			-- Set `is_working_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_WORKING)
		ensure
			dialog_working: is_working_dialog
		end;

	set_alignment_beginning is
			-- Set `is_alignment_beginning'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmessageAlignment, XmALIGNMENT_BEGINNING)
		ensure
			alignment_beginning_set: is_alignment_beginning
		end;

	set_alignment_center is
			-- Set `is_alignment_center'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmessageAlignment, XmALIGNMENT_CENTER)
		ensure
			alignment_center_set: is_alignment_center
		end;

	set_alignment_end is
			-- Set `is_alignment_end'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmessageAlignment, XmALIGNMENT_END)
		ensure
			alignment_end_set: is_alignment_end
	   end;

	minimize_button is
			-- Set `buttons_minimized' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNminimizeButtons, True)
		ensure
			buttons_minimized: buttons_minimized 
		end;

	maximize_button is
			-- Set `buttons_minimized' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNminimizeButtons, False)
		ensure
			buttons_maximized: not buttons_minimized 
		end;

	set_symbol_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `symbol_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNsymbolPixmap, a_pixmap)
		ensure
			symbol_pixmap_set: symbol_pixmap.is_equal (a_pixmap)
		end;

feature -- Element change

	set_cancel_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the user selects
			-- the `cancel_button'.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNcancelCallback, a_command, an_argument)
		ensure
			command_set (cancel_command, a_command, an_argument)
		end;

	set_ok_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the user selects
			-- the `ok_button'.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNokCallback, a_command, an_argument)
		ensure
			command_set (ok_command, a_command, an_argument)
		end;

feature -- Removal

	remove_cancel_callback is
			-- Remove the command for the cancel callback.
		do
			remove_callback (XmNcancelCallback)
		ensure
			removed: cancel_command = Void
		end;

	remove_ok_callback is
			-- Remove the command for the cancel callback.
		do
			remove_callback (XmNokCallback)
		ensure
			removed: cancel_command = Void
		end;

feature {NONE} -- Implementation

	xm_create_message_box (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/MessageB.h>"
		alias
			"XmCreateMessageBox"
		end;

	xm_message_box_get_child (scr_obj: POINTER; value: INTEGER): POINTER is
		external
			"C (Widget, unsigned char): EIF_POINTER | <Xm/MessageB.h>"
		alias
			"XmMessageBoxGetChild"
		end;

end -- class MEL_MESSAGE_BOX


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

