indexing

	description:
			"Unmanaged MEL_BULLETIN_BOARD as child of MEL_DIALOG_SHELL.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_BULLETIN_BOARD_DIALOG

inherit

	MEL_BULLETIN_BOARD
		rename
			make as bulletin_make,
			make_no_auto_unmanage as bulletin_make_no_auto_unmanage
		export
			{NONE} bulletin_make, bulletin_make_no_auto_unmanage
		redefine
			clean_up, create_widget
		end

creation
	make,
	make_no_auto_unmanage

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif bulletin dialog widget.
		do
			bulletin_make (a_name, a_parent, False)
		end;

	make_no_auto_unmanage (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif bulletin dialog widget and
			-- set `auto_unmanage' to False.
		do
			bulletin_make_no_auto_unmanage (a_name, a_parent, False)
		end;

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create bulletin with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object :=
					xm_create_bulletin_board_dialog (p_so,
						$w_name, default_pointer, 0);
			else
				screen_object :=
					xm_create_bulletin_board_dialog (p_so,
						$w_name, auto_unmanage_arg, 1);
			end;
			Mel_widgets.put (Current, screen_object);
			!! dialog_shell.make_from_existing (xt_parent (screen_object));
		end;

feature -- Access

	dialog_shell: MEL_DIALOG_SHELL;
			-- Dialog shell

feature -- Removal

	clean_up is
			-- Destroy the widget.
		do
			object_clean_up;
			dialog_shell.object_clean_up
		end;

feature {NONE} -- Implementation

	xm_create_bulletin_board_dialog (a_parent, a_name, arglist: POINTER; 
				argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/BulletinB.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateBulletinBoardDialog"
		end;

end -- class MEL_BULLETIN_BOARD_DIALOG

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
