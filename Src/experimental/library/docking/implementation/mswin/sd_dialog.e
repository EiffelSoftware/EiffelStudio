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
			internal_dialog_make (a_parent, 0, "")
			hide
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: detachable WEL_WINDOW; an_id: INTEGER;	a_name: detachable READABLE_STRING_GENERAL)
				-- Create the dialog
		local
			l_parent_item: POINTER
		do
				-- Initialise the common controls
			;(create {WEL_COMMON_CONTROLS_DLL}.make).do_nothing

				-- Register the dialog to set `wel_item' later.
			register_dialog

				-- Launch the right dialog box modeless.
			result_id := 0
			if attached a_parent then
				l_parent_item := a_parent.item
			end
			cwin_create_dialog_indirect (
				main_args.current_instance.item,
				dlg_template.item,
				l_parent_item,
				cwel_dialog_procedure_address
			).do_nothing

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
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
