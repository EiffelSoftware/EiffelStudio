indexing
	description: "Dialog box which can be loaded from a resource. Common %
		%ancestor to modal and modeless dialog box."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_DIALOG

inherit
	WEL_COMPOSITE_WINDOW
		export
			{NONE} register_window, register_current_window
		redefine
			on_wm_control_id_command,
			on_wm_menu_command,
			process_message,
			destroy
		end

	WEL_ID_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make_by_id (a_parent: WEL_WINDOW; an_id: INTEGER) is
			-- Initialize a loadable dialog box identified by
			-- `an_id' using `a_parent' as parent.
		require
			parent_exists: a_parent /= Void implies a_parent.exists
		do
			parent := a_parent
			resource_id := an_id
			create dialog_children.make
		ensure
			parent_set: parent = a_parent
			resource_id_set: resource_id = an_id
			dialog_children_not_void: dialog_children /= Void
		end

	make_by_name (a_parent: WEL_COMPOSITE_WINDOW; a_name: STRING) is
			-- Initialize a loadable dialog box identified by
			-- `a_name' using `a_parent' as parent.
		require
			parent_exists: a_parent /= Void implies a_parent.exists
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			parent := a_parent
			resource_name := clone (a_name)
			create dialog_children.make
		ensure
			parent_set: parent = a_parent
			resource_name_set: resource_name.is_equal (a_name)
			dialog_children_not_void: dialog_children /= Void
		end

	make_by_template (a_parent: WEL_COMPOSITE_WINDOW; a_template: WEL_DLG_TEMPLATE) is
		do
			register_dialog
			create dialog_children.make
			item := cwin_dialog_box_indirect (main_args.current_instance.item, a_template.item,
				a_parent.item, cwel_dialog_procedure_address)
		ensure
			dialog_children_not_void: dialog_children /= Void		
		end

feature -- Access

	result_id: INTEGER
			-- Last control id used to close the dialog.
			-- See class WEL_ID_CONSTANTS for the different values.

feature -- Status report

	ok_pushed: BOOLEAN is
			-- Has the OK button been pushed?
		do
			Result := result_id = Idok
		end

feature -- Basic operations

	activate is
			-- Activate the dialog box.
			-- Can be called several times.
		require
			parent_exists: parent /= Void implies parent.exists
			not_exists: not exists
		do
			internal_dialog_make (parent, resource_id,
				resource_name)
		end

	setup_dialog is
			-- May be redefined to setup the dialog and its
			-- children.
		require
			exists: exists
		do
		end

	terminate (a_result: INTEGER) is
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		require
			exists: exists
		deferred
		ensure
			result_id_set: result_id = a_result
		end

	destroy is
			-- Terminate the dialog.
		do
			terminate (Idcancel)
		end

	on_ok is
			-- Button Ok has been pressed.
		require
			exists: exists
		do
			terminate (Idok)
		end

	on_cancel is
			-- Button Cancel has been pressed.
		require
			exists: exists
		do
			terminate (Idcancel)
		end

	on_abort is
			-- Button Abort has been pressed.
		require
			exists: exists
		do
			terminate (Idabort)
		end

	on_retry is
			-- Button Retry has been pressed.
		require
			exists: exists
		do
			terminate (Idretry)
		end

	on_ignore is
			-- Button Ignore has been pressed.
		require
			exists: exists
		do
			terminate (Idignore)
		end

	on_yes is
			-- Button Yes has been pressed.
		require
			exists: exists
		do
			terminate (Idyes)
		end

	on_no is
			-- Button No has been pressed.
		require
			exists: exists
		do
			terminate (Idno)
		end

feature {NONE} -- Implementation

	register_dialog is
			-- Register `dialog' in window manager.
		do
			new_dialog_cell.put (Current)
		ensure
			registered: new_dialog = Current
		end

	resource_name: STRING
			-- Name of the dialog in the resource.
			-- Void if the dialog is identified by an
			-- id (`resource_id').

	resource_id: INTEGER
			-- Id of the dialog in the resource.
			-- Zero if the dialog is identified by
			-- a name (`resource_name').

	frozen dialog_process_message, process_message (hwnd: POINTER; msg,
			wparam, lparam: INTEGER): INTEGER is
		do
			Result := composite_process_message (hwnd, msg,
				wparam, lparam)
			if msg = Wm_initdialog then
				on_wm_init_dialog
			end
		end

	on_wm_control_id_command (control_id: INTEGER) is
			-- Wm_command from a standard button idenfied by
			-- `control_id'.
		do
			on_control_id_command (control_id)
			if control_id = Idok then
				on_ok
			elseif control_id = Idcancel then
				on_cancel
			elseif control_id = Idabort then
				on_abort
			elseif control_id = Idretry then
				on_retry
			elseif control_id = Idignore then
				on_ignore
			elseif control_id = Idyes then
				on_yes
			elseif control_id = Idno then
				on_no
			end
		end

	on_wm_menu_command (menu_id: INTEGER) is
			-- Wm_command from a `menu_id'.
		do
			on_menu_command (menu_id)
			if menu_id = Idcancel then
				on_cancel
			end
		end

	on_wm_init_dialog is
			-- Wm_initdialog message.
		require
			exists: exists
		local
			control: WEL_CONTROL
		do
			from
				dialog_children.start
			until
				dialog_children.off
			loop
				control := dialog_children.item
				control.set_item (cwin_get_dlg_item (item,
					control.id))
				register_window (control)
				control.set_default_window_procedure
				dialog_children.forth
			end
			setup_dialog
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;
			a_name: STRING) is
			-- Create the dialog
		deferred
		end

	class_name: STRING is
			-- No class name
		once
			Result := ""
		end

	default_style: INTEGER is
			-- No style
		do
			Result := 0
		end

feature {WEL_CONTROL} -- Implementation

	dialog_children: LINKED_LIST [WEL_CONTROL]
			-- Temporary children list

feature {NONE} -- Externals

	cwin_dialog_box_indirect (hinst, template, hwnd, dlgproc: POINTER): POINTER is
		external
			"C [macro <wel.h>] (HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC): EIF_POINTER"
		alias
			"DialogBoxIndirect"
		end

	cwin_get_dlg_item (hwnd: POINTER; an_id: INTEGER): POINTER is
			-- SDK GetDlgItem
		external
			"C [macro <wel.h>] (HWND, int): EIF_POINTER"
		alias
			"GetDlgItem"
		end

	cwel_dialog_procedure_address: POINTER is
		external
			"C [macro <disptchr.h>]"
		end

	cwin_make_int_resource (an_id: INTEGER): POINTER is
			-- Convert `id' to a pointer
			-- SDK MAKEINTRESOURCE
		external
			"C [macro <wel.h>] (WORD): EIF_POINTER"
		alias
			"MAKEINTRESOURCE"
		end

	cwel_temp_dialog_value: POINTER is
		external
			"C [macro <wel.h>]: EIF_POINTER"
		end

end -- class WEL_DIALOG


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

