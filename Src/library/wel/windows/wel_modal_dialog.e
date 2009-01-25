note
	description: "Modal dialog box that does not allow the user to switch %
		%between the dialog box and other programs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MODAL_DIALOG

inherit
	WEL_DIALOG

create
	make_by_id,
	make_by_name,
	make_by_template

feature -- Basic operations

	terminate (a_result: INTEGER)
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		do
			result_id := a_result
			is_result_id_set := True
			cwin_end_dialog (item, a_result)
			destroy_item_from_context (False)
		end

feature {NONE} -- Implementation

	is_result_id_set: BOOLEAN
			-- Is `result_id' set in `terminate'?

	internal_dialog_make (a_parent: ?WEL_WINDOW; an_id: INTEGER; a_name: ?STRING_GENERAL)
			-- Create the dialog
		local
			c_name: WEL_STRING
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
			l_result_id: INTEGER
		do
				-- Initialise the common controls
			create common_controls_dll.make
			is_result_id_set := False

			register_dialog
			if a_name /= Void then
				-- Load by name
				create c_name.make (a_name)
				l_result_id := cwin_dialog_box (
					main_args.resource_instance.item,
					c_name.item,
					parent_item,
					cwel_dialog_procedure_address)
			else
				-- Load by id
				l_result_id := cwin_dialog_box (
					main_args.resource_instance.item,
					cwin_make_int_resource (an_id),
					parent_item,
					cwel_dialog_procedure_address)
			end
			if not is_result_id_set then
				result_id := l_result_id
			end
			if l_result_id = -1  then
					-- The called fail, so we need to reclaim resources.
				destroy_item_from_context (False)
			end
		end

feature {NONE} -- Externals

	cwin_dialog_box (hinst, name, hparent, dlgprc: POINTER): INTEGER
			-- SDK DialogBox
		external
			"C [macro <wel.h>] (HINSTANCE, LPCTSTR, HWND, %
				%DLGPROC): INT_PTR"
		alias
			"DialogBox"
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




end -- class WEL_MODAL_DIALOG

