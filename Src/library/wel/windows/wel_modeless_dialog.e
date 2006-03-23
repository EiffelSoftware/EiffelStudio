indexing
	description: "Modeless dialog box that allows the user to switch %
		%between the dialog box and the application."
	legal: "See notice at end of class."
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
		do
			result_id := a_result
			destroy_item_from_context (False)
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;
			a_name: STRING_GENERAL) is
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
			end
		end

feature {NONE} -- Externals

	cwin_create_dialog (hinstance, template, hparent,
			dlgproc: POINTER): POINTER is
			-- SDK CreateDialog
		external
			"C [macro <wel.h>] (HINSTANCE, LPCTSTR, HWND, %
				%DLGPROC): EIF_POINTER"
		alias
			"CreateDialog"
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




end -- class WEL_MODELESS_DIALOG

