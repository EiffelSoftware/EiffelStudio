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

create
	make_by_id,
	make_by_name,
	make_by_template

feature -- Basic operations

	terminate (a_result: INTEGER) is
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		local
			l_result: INTEGER
		do
			result_id := a_result
			l_result := cwin_destroy_window (item)
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;
			a_name: STRING) is
			-- Create the dialog
		local
			c_name: WEL_STRING
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
		do
				-- Initialise the common controls
			create common_controls_dll.make	

			register_dialog

			if a_name /= Void then
				-- Load by name
				create c_name.make (a_name)
				item := cwin_create_dialog (
					main_args.resource_instance.item,
					c_name.item, parent_item,
					cwel_dialog_procedure_address)
			else
				-- Load by id
				item := cwin_create_dialog (
					main_args.resource_instance.item,
					cwin_make_int_resource (an_id),
					parent_item,
					cwel_dialog_procedure_address)
			end
			if item /= default_pointer then
				if not shown then
					show
				end
			else
				destroy_item
			end
		end

feature {NONE} -- Externals

	cwin_create_dialog (hinstance, template, hparent,
			dlgproc: POINTER): POINTER is
			-- SDK CreateDialog
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR, HWND, %
				%DLGPROC): EIF_POINTER"
		alias
			"CreateDialog"
		end

end -- class WEL_MODELESS_DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

