indexing
	description: "Modeless dialog box that allows the user to switch %
		%between the dialog box and the application."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MODELESS_DIALOG

inherit
	WEL_DIALOG

creation
	make_by_id,
	make_by_name

feature -- Basic operations

	terminate (a_result: INTEGER) is
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		do
			from
				dialog_child.start
			until
				dialog_child.off
			loop
				unregister_window (dialog_child.item)
				dialog_child.item.set_exists (False)
				dialog_child.item.set_item (default_pointer)
				dialog_child.forth
			end
			result_id := a_result
			cwin_destroy_window (item)
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: WEL_COMPOSITE_WINDOW; an_id: INTEGER;
			a_name: STRING) is
			-- Create the dialog
		local
			c_name: ANY
		do
			item := cwel_temp_dialog_value
			exists := True
			register_window (Current)
			if a_name /= Void then
				-- Load by name
				c_name := a_name.to_c
				item := cwin_create_dialog (
					main_args.current_instance.item,
					$c_name, parent_item,
					cwel_dialog_procedure_address)
			else
				-- Load by id
				item := cwin_create_dialog (
					main_args.current_instance.item,
					cwin_make_int_resource (an_id),
					parent_item,
					cwel_dialog_procedure_address)
			end
			if not shown then
				show
			end
		end

feature {NONE} -- Externals

	cwin_create_dialog (hinstance, template, hparent,
			dlgproc: POINTER): POINTER is
			-- SDK CreateDialog
		external
			"C [macro <wel.h>] (HINSTANCE, LPCTSTR, HWND, %
				%DLGPROC): EIF_POINTER"
		alias
			"CreateDialog"
		end

end -- class WEL_MODELESS_DIALOG

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
