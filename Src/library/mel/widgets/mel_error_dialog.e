indexing

	description:
			"Unmanaged MEL_MESSAGE_BOX as a child of a MEL_DIALOG_SHELL.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_ERROR_DIALOG 

inherit

	MEL_MESSAGE_DIALOG
		export
			{NONE} is_error_dialog, is_information_dialog, is_message_dialog,
			is_question_dialog, is_template_dialog, is_warning_dialog,
			is_working_dialog, symbol_pixmap,
			set_error_dialog, set_information_dialog, set_message_dialog,
			set_question_dialog, set_template_dialog, set_warning_dialog,
			set_working_dialog, set_symbol_pixmap
		redefine
			create_widget
		end

creation
	make, 
	make_no_auto_unmanage

feature {NONE} -- Initialization

    create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
            -- Create error dialog with `auto_manage_flag'.
        do
            if auto_manage_flag then
                screen_object := 
                    xm_create_error_dialog (p_so, 
                        $w_name, default_pointer, 0)
            else
                screen_object := 
                    xm_create_error_dialog (p_so,
                        $w_name, auto_unmanage_arg, 1)
            end;
        end;

feature {NONE} -- Implementation

	xm_create_error_dialog (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/MessageB.h>"
		alias
			"XmCreateErrorDialog"
		end;

end -- class MEL_ERROR_DIALOG


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

