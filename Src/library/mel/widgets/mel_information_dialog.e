indexing

	description:
			"Unmanaged MEL_MESSAGE_BOX as child of a MEL_DIALOG_SHELL."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_INFORMATION_DIALOG 

inherit

	MEL_MESSAGE_DIALOG
		export
			{NONE} is_error_dialog, is_information_dialog, is_message_dialog,
			is_question_dialog, is_template_dialog, symbol_pixmap,
			set_error_dialog, set_information_dialog, set_message_dialog,
			set_question_dialog, set_template_dialog, set_symbol_pixmap
		redefine
			create_widget
		end;

create
	make

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create a motif information dialog with `auto_manage_flag'
		do
			if auto_manage_flag then
				screen_object := xm_create_information_dialog (p_so, $w_name, default_pointer, 0)
			else
				screen_object := xm_create_information_dialog (p_so, $w_name, auto_unmanage_arg, 1)
			end;
		end;

feature {NONE} -- Implementation

	xm_create_information_dialog (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/MessageB.h>"
		alias
			"XmCreateInformationDialog"
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_INFORMATION_DIALOG


