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
	make_by_name

feature -- Basic operations

	terminate (a_result: INTEGER) is
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		do
			from
				dialog_children.start
			until
				dialog_children.off
			loop
				unregister_window (dialog_children.item)
				dialog_children.item.set_exists (False)
				dialog_children.item.set_item (default_pointer)
				dialog_children.forth
			end
			result_id := a_result
			cwin_end_dialog (item, a_result)
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;
			a_name: STRING) is
			-- Create the dialog
		local
			c_name: WEL_STRING
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
		do
			item := cwel_temp_dialog_value
			exists := True
			register_window (Current)

				-- Initialise the common controls
			create common_controls_dll.make	
	
			if a_name /= Void then
				-- Load by name
				!! c_name.make (a_name)
				result_id := cwin_dialog_box (
					main_args.current_instance.item,
					c_name.item, parent_item,
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
				exists := False
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
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

