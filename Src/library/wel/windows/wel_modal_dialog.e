indexing
	description: "Modal dialog box that does not allow the user to switch %
		%between the dialog box and other programs."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MODAL_DIALOG

inherit
	WEL_DIALOG

creation
	make_by_id,
	make_by_name,
	make_by_template

feature -- Basic operations

	terminate (a_result: INTEGER) is
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		do
				-- `cwin_end_dialog' does not send the WM_DESTROY message
				-- to its children and therefore we need to do it manually
			from
				dialog_children.start
			until
				dialog_children.off
			loop
				dialog_children.item.destroy_from_dialog
				dialog_children.forth
			end
			result_id := a_result
			cwin_end_dialog (item, a_result)
			destroy_item
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
				result_id := cwin_dialog_box (
					main_args.current_instance.item,
					c_name.item, 
					parent_item,
					cwel_dialog_procedure_address)
			else
				-- Load by id
				result_id := cwin_dialog_box (
					main_args.current_instance.item,
					cwin_make_int_resource (an_id),
					parent_item,
					cwel_dialog_procedure_address)
			end
			if result_id = -1 then
				destroy_item
			end
		end

	

feature {NONE} -- Externals

	cwin_dialog_box (hinst, name, hparent, dlgprc: POINTER): INTEGER is
			-- SDK DialogBox
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR, HWND, %
				%DLGPROC): EIF_INTEGER"
		alias
			"DialogBox"
		end

	cwin_end_dialog (hwnd: POINTER; a_result: INTEGER) is
			-- SDK EndDialog
		external
			"C [macro <wel.h>] (HWND, int)"
		alias
			"EndDialog"
		end

end -- class WEL_MODAL_DIALOG


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

