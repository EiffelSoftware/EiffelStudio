indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP_MODAL

inherit
	EV_DIALOG_IMP_COMMON
		redefine
			hide,
			setup_dialog	
		end

create
	make_with_dialog_window

feature -- Basic operations

	show_modal_to_window (a_parent_window: EV_WINDOW) is
			-- Show `Current' and wait until window is closed.
		local
			parent_window_imp: WEL_WINDOW
				-- Create the dialog.
		do
			if exists then
				show
			else
				parent_window := a_parent_window
				parent_window_imp ?= a_parent_window.implementation
				internal_dialog_make (parent_window_imp, 0, Void)
			end
		end
		
	show_modal_to_hwnd (hwnd: INTEGER) is
			-- Show `Current' modally to Window with
			-- handle `hwnd'.
		do
			hwnd_internal_dialog_make (hwnd)
		end

	show_relative_to_window (a_parent_window: EV_WINDOW) is
			-- Show `Current' and wait until window is closed.
		do
			promote_to_dialog_window
			interface.implementation.show_relative_to_window (a_parent_window)
		end

	hide is
			-- Hide `Current' if displayed.
		do
			promote_to_dialog_window
			interface.implementation.hide
		end
		
	enable_maximize is
			-- Add maximize button to `Current'.
		local
			new_style: INTEGER
			bit_op: WEL_BIT_OPERATIONS
		do
				-- Change the style of the window.
			create bit_op
			new_style := style
			new_style := bit_op.set_flag (new_style, Ws_maximizebox)
			set_style (new_style)
		end
		
	disable_maximize is
			-- Remove maximize button from `Current'.
		local
			new_style: INTEGER
			bit_op: WEL_BIT_OPERATIONS
		do
				-- Change the style of the window.
			create bit_op
			new_style := style
			new_style := bit_op.clear_flag (new_style, Ws_maximizebox)
			set_style (new_style)
		end
		
feature {EV_WINDOW_IMP} -- Implementation
		
	execute_show_actions is
			-- Execute `show_actions_internal'.
			--| Needs to be called externally from within EV_WINDOW_IMP
			--| as the notification we use, is received by the parent window.
		do
			if show_actions_internal /= Void then
				show_actions_internal.call ([])
			end
				-- We assign `False' to `call_show_actions' so they
				-- will not be called again unless it is first set to `True'.
			call_show_actions := False
		end
	
feature {NONE} -- Implementation

	terminate (a_result: INTEGER) is
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		do
			result_id := a_result
			cwin_end_dialog (wel_item, a_result)
			destroy_item
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;
			a_name: STRING) is
			-- Create the dialog
		local
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
			tmp_res: INTEGER
			return_value: POINTER
			err: WEL_ERROR
		do
				-- Initialise the common controls
			create common_controls_dll.make	

				-- Register the dialog to set `wel_item' later.
			register_dialog

				-- Launch the right dialog box modal
			result_id := 0
			return_value := cwin_dialog_box_indirect (
				main_args.current_instance.item,
				dlg_template.item,
				a_parent.item,
				cwel_dialog_procedure_address
				)
			debug ("VISION2_WINDOWS")
				tmp_res := cwel_pointer_to_integer (return_value)
				if tmp_res = 0 or tmp_res = -1 then
					create err
					err.display_last_error
				end
			end
		end
	
	hwnd_internal_dialog_make (hwnd: INTEGER) is
			-- Create the dialog and display relative to `hwnd'.
		local
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
			tmp_res: INTEGER
			return_value: POINTER
			err: WEL_ERROR
		do
				-- Initialise the common controls
			create common_controls_dll.make	

				-- Register the dialog to set `wel_item' later.
			register_dialog

				-- Launch the right dialog box modal
			result_id := 0
			return_value := cwin_dialog_box_indirect (
				main_args.current_instance.item,
				dlg_template.item,
				cwel_integer_to_pointer (hwnd),
				cwel_dialog_procedure_address
				)
			debug ("VISION2_WINDOWS")
				tmp_res := cwel_pointer_to_integer (return_value)
				if tmp_res = 0 or tmp_res = -1 then
					create err
					err.display_last_error
				end
			end
		end
		
	setup_dialog is
			-- May be redefined to setup the dialog and its
			-- children.
		local
			button_imp: EV_BUTTON_IMP
			app_imp: EV_APPLICATION_IMP
		do
				-- Copy the attributes from the window to the dialog
			copy_attributes
			set_text (internal_title)

				-- Move the children from the hidden window to the dialog.
			move_children

				-- Change the style of the window and the window icon.
			update_style
			set_icon_pixmap (other_imp.icon_pixmap)

				-- Center the dialog relative to the parent window.
--			check
--					-- Parent_window should not be void due to the precondition
--					-- of `make_with_dialog_window_and_parent'.
--				has_parent: parent_window /= Void
--			end
--			if apply_center_dialog then
--				center_dialog
--				apply_center_dialog := false
--			else
--				set_position (other_imp.x_position, other_imp.y_position)
--			end

				-- Set the focus to the `default_push_button' if any
			if default_push_button /= Void and then 
				default_push_button.is_show_requested and then
				default_push_button.is_sensitive
			then
				button_imp ?= interface.default_push_button.implementation
				button_imp.enable_default_push_button
				button_imp.set_focus
			end

				-- Destroy the Dialog-window implementation
			other_imp.destroy_implementation

				-- Add this dialog as root window.
			app_imp ?= (create {EV_ENVIRONMENT}).application.implementation
			app_imp.add_root_window (Current)
		end

feature {NONE} -- Externals

	cwin_dialog_box_indirect (hinst, lptemplate, hparent, dlgprc: POINTER): POINTER is
				-- SDK DialogBoxIndirect
			external 
				"C [macro <wel.h>] (HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC): EIF_POINTER"
			alias
				"DialogBoxIndirect"
			end

	cwin_end_dialog (hwnd: POINTER; a_result: INTEGER) is
			-- SDK EndDialog
		external
			"C [macro <wel.h>] (HWND, int)"
		alias
			"EndDialog"
		end

end -- class EV_DIALOG_IMP_MODAL

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

