indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP_MODELESS

inherit
	EV_DIALOG_IMP_COMMON
		redefine
			setup_dialog
		end

create
	make_with_dialog_window

feature -- Basic operations

	show_modal_to_window (a_parent_window: EV_WINDOW) is
			-- Show `Current' and wait until window is closed.
		do
			promote_to_dialog_window
			interface.implementation.show_modal_to_window (a_parent_window)
		end

	show_relative_to_window (a_parent_window: EV_WINDOW) is
			-- Show `Current' and wait until window is closed.
		local
			parent_window_imp: WEL_WINDOW
				-- Create the dialog.
		do
			if exists then
					-- We handle the case where `Current' has already been
					-- shown relative to a window, hidden and now is being shown
					-- relative to a new window.
				if a_parent_window /= parent_window then
					promote_to_dialog_window
					interface.implementation.show_relative_to_window (a_parent_window)
					parent_window := a_parent_window
					parent_window_imp ?= a_parent_window.implementation
				else
					show
				end
				if show_actions_internal /= Void then
					show_actions_internal.call ([])
				end
			else
				parent_window := a_parent_window
				parent_window_imp ?= a_parent_window.implementation
				internal_dialog_make (parent_window_imp, 0, Void)
				if show_actions_internal /= Void then
					show_actions_internal.call ([])
				end
			end
		end

	terminate (a_result: INTEGER) is
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		do
			result_id := a_result
			cwin_destroy_window (wel_item)
		end

feature {NONE} -- Implementation

	setup_dialog is
   			-- Setup the dialog and its children.
		do
			Precursor {EV_DIALOG_IMP_COMMON}
			result_id := Idcancel
		end

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;
			a_name: STRING) is
			-- Create the dialog
		local
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
			tmp_result: INTEGER
			err: WEL_ERROR
		do
				-- Initialise the common controls
			create common_controls_dll.make	

				-- Register the dialog to set `wel_item' later.
			register_dialog

				-- Launch the right dialog box modeless.
			result_id := 0
			tmp_result := cwin_create_dialog_indirect (
				main_args.current_instance.item,
				dlg_template.item, 
				a_parent.item,
				cwel_dialog_procedure_address
				)

			debug ("VISION2_WINDOWS")
				if tmp_result = 0 or tmp_result = -1 then
					create err
					err.display_last_error
				end
			end

				-- Display the window
			show
		end
		
feature {NONE} -- External

	cwin_create_dialog_indirect (hinst, lptemplate, hparent, dlgprc: POINTER): INTEGER is
			-- SDK DialogBoxIndirect
		external
			"C [macro <wel.h>] (HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC): EIF_INTEGER"
		alias
			"CreateDialogIndirect"
        end
                         

end -- class EV_DIALOG_IMP_MODELESS

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------
