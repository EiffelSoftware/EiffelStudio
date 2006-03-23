indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP_MODAL

inherit
	EV_DIALOG_IMP_COMMON
		redefine
			hide,
			is_modal,
			common_dialog_imp
		end

create
	make_with_dialog_window

feature -- Status report

	is_modal: BOOLEAN is
			-- Is `Current' shown modally to another window?
			-- If `True' then `Current' must be closed before
			-- application can receive user events again?
		do
			if not is_destroyed then
				Result := is_show_requested
			end
		end

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

feature {EV_WINDOW_IMP} -- Implementation

	execute_show_actions is
			-- Execute `show_actions_internal'.
			--| Needs to be called externally from within EV_WINDOW_IMP
			--| as the notification we use, is received by the parent window.
		do
			if show_actions_internal /= Void then
				show_actions_internal.call (Void)
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
			destroy_item_from_context (False)
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER; a_name: STRING_GENERAL) is
			-- Create the dialog
		local
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
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
				if
					return_value = default_pointer or
					return_value = cwel_integer_to_pointer (-1)
				then
					create err
					err.display_last_error
				end
			end
		end

	common_dialog_imp: EV_DIALOG_IMP_MODAL is
			-- Dialog implementation type common to all descendents.
		do
		end


feature {NONE} -- Externals

	cwin_dialog_box_indirect (hinst, lptemplate, hparent, dlgprc: POINTER): POINTER is
				-- SDK DialogBoxIndirect
			external
				"C [macro <wel.h>] (HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC): INT_PTR"
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




end -- class EV_DIALOG_IMP_MODAL

