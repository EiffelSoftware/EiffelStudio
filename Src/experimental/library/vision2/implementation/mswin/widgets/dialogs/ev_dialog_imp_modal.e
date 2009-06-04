note
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

	is_modal: BOOLEAN
			-- Is `Current' shown modally to another window?
			-- If `True' then `Current' must be closed before
			-- application can receive user events again?
		do
			if not is_destroyed then
				Result := is_show_requested
			end
		end

feature -- Basic operations

	show_modal_to_window (a_parent_window: EV_WINDOW)
			-- Show `Current' and wait until window is closed.
		local
			parent_window_imp: detachable WEL_WINDOW
				-- Create the dialog.
		do
			if exists then
				show_internal
			else
				parent_window := a_parent_window
				parent_window_imp ?= a_parent_window.implementation
				check parent_window_imp /= Void end
				internal_dialog_make (parent_window_imp, 0, Void)
			end
		end

	show_relative_to_window (a_parent_window: EV_WINDOW)
			-- Show `Current' and wait until window is closed.
		do
			promote_to_dialog_window
			attached_interface.implementation.show_relative_to_window (a_parent_window)
		end

	hide
			-- Hide `Current' if displayed.
		do
			if is_show_requested then
				promote_to_dialog_window
				attached_interface.implementation.hide
			end
		end

feature {EV_WINDOW_IMP} -- Implementation

	execute_show_actions
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

	terminate (a_result: INTEGER)
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		do
			result_id := a_result
			cwin_end_dialog (wel_item, a_result)
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: detachable WEL_WINDOW; an_id: INTEGER; a_name: detachable STRING_GENERAL)
			-- Create the dialog
		local
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
			err: WEL_ERROR
		do
			check a_parent /= Void end
				-- Initialise the common controls
			create common_controls_dll.make

				-- Register the dialog to set `wel_item' later.
			register_dialog

				-- Launch the right dialog box modal
			result_id := cwin_dialog_box_indirect (
				main_args.current_instance.item,
				dlg_template.item,
				a_parent.item,
				cwel_dialog_procedure_address
				)
			debug ("VISION2_WINDOWS")
				if result_id = 0 or result_id = -1 then
					create err
					err.display_last_error
				end
			end
		end

	common_dialog_imp: detachable EV_DIALOG_IMP_MODAL
			-- Dialog implementation type common to all descendents.
		do
		end


feature {NONE} -- Externals

	cwin_dialog_box_indirect (hinst, lptemplate, hparent, dlgprc: POINTER): INTEGER
				-- SDK DialogBoxIndirect
			external
				"C [macro <wel.h>] (HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC): INT_PTR"
			alias
				"DialogBoxIndirect"
			end

	cwin_end_dialog (hwnd: POINTER; a_result: INTEGER)
			-- SDK EndDialog
		external
			"C [macro <wel.h>] (HWND, INT_PTR)"
		alias
			"EndDialog"
		end

note
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











