note
	description: "[
					Dialog which exists when initlized.
					EV_DIALOG only exists after show.
														]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DIALOG

inherit
	WEL_MODELESS_DIALOG
		redefine
			internal_dialog_make
		end

create
	make

feature {NONE} -- Initlization

	make (a_parent: WEL_WINDOW)
				-- Creation method.
		require
			not_void: a_parent /= Void
		do
			create dialog_children.make
			internal_dialog_make (a_parent, 0, Void)
			hide
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;	a_name: STRING_GENERAL)
				-- Create the dialog
		local
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
			tmp_result: POINTER
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

			cwin_show_window (item, Sw_show)
		end

	cwin_create_dialog_indirect (hinst, lptemplate, hparent, dlgprc: POINTER): POINTER
			-- SDK DialogBoxIndirect
		external
			"C [macro <wel.h>] (HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC): HWND"
		alias
			"CreateDialogIndirect"
        end

	dlg_template: WEL_DLG_TEMPLATE
			-- Dialog template, so we can created a dialog which not included in resource.
		do
			create Result.make_with_global_alloc
			Result.set_style ({WEL_WS_CONSTANTS}.ws_popupwindow)
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
