note
	description: "Dialog box which can be loaded from a resource. Common %
		%ancestor to modal and modeless dialog box."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_DIALOG

inherit
	WEL_COMPOSITE_WINDOW
		export
			{NONE} register_current_window
		redefine
			on_wm_control_id_command,
			on_wm_menu_command,
			process_message,
			destroy
		end

	WEL_DIALOG_MANAGER
		export
			{NONE} all
		end

	WEL_ID_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make_by_id (a_parent: detachable WEL_WINDOW; an_id: INTEGER)
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

	make_by_name (a_parent: detachable WEL_COMPOSITE_WINDOW; a_name: STRING_GENERAL)
			-- Initialize a loadable dialog box identified by
			-- `a_name' using `a_parent' as parent.
		require
			parent_exists: a_parent /= Void implies a_parent.exists
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			parent := a_parent
			resource_name := a_name.twin
			create dialog_children.make
		ensure
			parent_set: parent = a_parent
			resource_name_set: attached resource_name as l_name and then l_name.same_string (a_name)
			dialog_children_not_void: dialog_children /= Void
		end

	make_by_template (a_parent: detachable WEL_COMPOSITE_WINDOW; a_template: WEL_DLG_TEMPLATE)
		require
			parent_exists: a_parent /= Void implies a_parent.exists
		local
			l_parent_item: POINTER
		do
			parent := a_parent
			create dialog_children.make
			register_dialog
			if a_parent /= Void then
				l_parent_item := a_parent.item
			end
			item := cwin_dialog_box_indirect (main_args.current_instance.item, a_template.item,
				l_parent_item, cwel_dialog_procedure_address)
		ensure
			dialog_children_not_void: dialog_children /= Void
		end

feature -- Access

	result_id: INTEGER
			-- Last control id used to close the dialog.
			-- See class WEL_ID_CONSTANTS for the different values.

feature -- Status report

	ok_pushed: BOOLEAN
			-- Has the OK button been pushed?
		do
			Result := result_id = Idok
		end

feature -- Basic operations

	activate
			-- Activate the dialog box.
			-- Can be called several times.
		require
			parent_exists: attached parent as l_parent implies l_parent.exists
			not_exists: not exists
		do
			internal_dialog_make (parent, resource_id, resource_name)
		end

	setup_dialog
			-- May be redefined to setup the dialog and its
			-- children.
		require
			exists: exists
		do
		end

	terminate (a_result: INTEGER)
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		require
			exists: exists
		deferred
		ensure
			result_id_set: result_id = a_result
		end

	destroy
			-- Terminate the dialog.
		do
			terminate (Idcancel)
		end

	on_ok
			-- Button Ok has been pressed.
		require
			exists: exists
		do
			terminate (Idok)
		end

	on_cancel
			-- Button Cancel has been pressed.
		require
			exists: exists
		do
			terminate (Idcancel)
		end

	on_abort
			-- Button Abort has been pressed.
		require
			exists: exists
		do
			terminate (Idabort)
		end

	on_retry
			-- Button Retry has been pressed.
		require
			exists: exists
		do
			terminate (Idretry)
		end

	on_ignore
			-- Button Ignore has been pressed.
		require
			exists: exists
		do
			terminate (Idignore)
		end

	on_yes
			-- Button Yes has been pressed.
		require
			exists: exists
		do
			terminate (Idyes)
		end

	on_no
			-- Button No has been pressed.
		require
			exists: exists
		do
			terminate (Idno)
		end

feature {NONE} -- Implementation

	register_dialog
			-- Register `dialog' in window manager.
		do
			new_dialog_cell.put (Current)
		ensure
			registered: new_dialog = Current
		end

	resource_name: detachable STRING_GENERAL
			-- Name of the dialog in the resource.
			-- Void if the dialog is identified by an
			-- id (`resource_id').

	resource_id: INTEGER
			-- Id of the dialog in the resource.
			-- Zero if the dialog is identified by
			-- a name (`resource_name').

	frozen dialog_process_message, process_message (hwnd: POINTER;
			msg: INTEGER; wparam, lparam: POINTER): POINTER
		do
			Result := composite_process_message (hwnd, msg,
				wparam, lparam)
			if msg = Wm_initdialog then
				on_wm_init_dialog
			end
		end

	on_wm_control_id_command (control_id: INTEGER)
			-- Wm_command from a standard button idenfied by
			-- `control_id'.
		do
			on_control_id_command (control_id)
			inspect control_id
			when Idok then
				on_ok
			when Idcancel then
				on_cancel
			when Idabort then
				on_abort
			when Idretry then
				on_retry
			when Idignore then
				on_ignore
			when Idyes then
				on_yes
			when Idno then
				on_no
			else
			end
		end

	on_wm_menu_command (menu_id: INTEGER)
			-- Wm_command from a `menu_id'.
		do
			on_menu_command (menu_id)
			if menu_id = Idcancel then
				on_cancel
			end
		end

	on_wm_init_dialog
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
				control.register_current_window
				control.set_default_window_procedure
				dialog_children.forth
			end
			setup_dialog
		end

feature {NONE} -- Implementation

	internal_dialog_make (a_parent: detachable WEL_WINDOW; an_id: INTEGER;
			a_name: detachable STRING_GENERAL)
			-- Create the dialog
		deferred
		end

	class_name: STRING_32
			-- No class name
		once
			create Result.make_empty
		end

	default_style: INTEGER
			-- No style
		do
			Result := 0
		end

feature {WEL_CONTROL} -- Implementation

	dialog_children: LINKED_LIST [WEL_CONTROL]
			-- Temporary children list

feature {NONE} -- Externals

	cwin_dialog_box_indirect (hinst, template, hwnd, dlgproc: POINTER): POINTER
		external
			"C [macro <wel.h>] (HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC): EIF_POINTER"
		alias
			"DialogBoxIndirect"
		end

	cwel_dialog_procedure_address: POINTER
		external
			"C [macro <disptchr.h>]"
		end

	cwin_make_int_resource (an_id: INTEGER): POINTER
			-- Convert `id' to a pointer
			-- SDK MAKEINTRESOURCE
		external
			"C [macro <wel.h>] (WORD): EIF_POINTER"
		alias
			"MAKEINTRESOURCE"
		end

	cwel_temp_dialog_value: POINTER
		external
			"C [macro <wel.h>]: EIF_POINTER"
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




end -- class WEL_DIALOG

