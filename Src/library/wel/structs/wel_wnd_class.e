indexing
	description: "Contains information about the window class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WND_CLASS

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make

feature {NONE} -- Initialization

	make (a_class_name: STRING) is
			-- Make a window class named `a_class_name'.
		require
			class_name_not_void: a_class_name /= Void
			class_name_not_empty: not a_class_name.is_empty
		do
			structure_make
			set_style (0)
			unset_window_procedure
			set_class_extra (0)
			set_window_extra (0)
			set_instance (main_args.current_instance)
			unset_icon
			unset_cursor
			unset_background
			unset_menu_name
			set_class_name (a_class_name)
		ensure
			style_set: style = 0
			window_procedure_unset: not window_procedure_set
			class_extra_set: class_extra = 0
			window_extra_set: window_extra = 0
			instance_set: instance.item = main_args.current_instance.item
			icon_unset: not icon_set
			cursor_unset: not cursor_set
			background_unset: not background_set							
			menu_nameunset: not menu_name_set
			class_name_set: class_name.is_equal (a_class_name)
			atom_set: atom = 0
		end

feature -- Access

	class_name: STRING is
			-- Class name
		do
			create Result.make_from_c (cwel_wnd_class_get_class_name (item))
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	atom: INTEGER
			-- Class atom that uniquely identifies class being registered.

	menu_name: STRING is
			-- Menu name to load from the resource
		require
			menu_name_set: menu_name_set
		do
			create Result.make_from_c (cwel_wnd_class_get_menu_name (item))
		ensure
			result_not_void: Result /= Void
		end

	style: INTEGER is
			-- Class style
		do
			Result := cwel_wnd_class_get_style (item)
		end

	window_procedure: POINTER is
			-- Window procedure to call
		require
			window_procedure_set: window_procedure_set
		do
			Result := cwel_wnd_class_get_wnd_proc (item)
		ensure
			Result /= default_pointer
		end

	class_extra: INTEGER is
			-- Class extra information size
		do
			Result := cwel_wnd_class_get_cls_extra (item)
		ensure
			positive_result: Result >= 0
		end

	window_extra: INTEGER is
			-- Window extra information size
		do
			Result := cwel_wnd_class_get_wnd_extra (item)
		ensure
			positive_result: Result >= 0
		end

	instance: WEL_INSTANCE is
			-- Instance of the class.
		require
			instance_set: instance_set
		do
			create Result.make (cwel_wnd_class_get_instance (item))
		ensure
			result_not_void: Result /= Void
		end

	icon: WEL_ICON is
			-- Icon to draw when the window is minimized.
		require
			icon_set: icon_set
		do
			create Result.make_by_pointer (
				cwel_wnd_class_get_icon (item))
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	cursor: WEL_CURSOR is
			-- Cursor to use when the mouse is into the window.
		require
			cursor_set: cursor_set
		do
			create Result.make_by_pointer (
				cwel_wnd_class_get_cursor (item))
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	background: WEL_BRUSH is
			-- Background color of the window
		require
			background_set: background_set
		do
			create Result.make_by_pointer (
				cwel_wnd_class_get_background (item))
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

feature -- Element change

	set_style (a_style: INTEGER) is
			-- Set `style' with `a_style'.
		do
			cwel_wnd_class_set_style (item, a_style)
		ensure
			style = a_style
		end

	set_window_extra (a_window_extra: INTEGER) is
			-- Set `window_extra' with `a_window_extra'.
		require
			positive_extra: a_window_extra >= 0
		do
			cwel_wnd_class_set_wnd_extra (item, a_window_extra)
		ensure
			window_extra = a_window_extra
		end

	set_instance (an_instance: WEL_INSTANCE) is
			-- Set `instance' with `an_instance'.
		require
			an_instance_not_void: an_instance /= Void
			an_instance_exists: an_instance.exists
		do
			cwel_wnd_class_set_instance (item, an_instance.item)
		ensure
			instance_equal: instance.item = an_instance.item
		end

	set_class_extra (a_class_extra: INTEGER) is
			-- Set `class_extra' with `a_class_extra'.
		require
			positive_extra: a_class_extra >= 0
		do
			cwel_wnd_class_set_cls_extra (item, a_class_extra)
		ensure
			class_extra = a_class_extra
		end

	set_window_procedure (a_window_procedure: POINTER) is
			-- Set `window_procedure' with `a_window_procedure'.
		do
			cwel_wnd_class_set_wnd_proc (item,
				a_window_procedure)
		ensure
			window_procedure_equal: window_procedure =
				a_window_procedure
		end

	set_icon (an_icon: WEL_ICON) is
			-- Set `icon' with `an_icon'.
		require
			an_icon_not_void: an_icon /= Void
			an_icon_exists: an_icon.exists
		do
			cwel_wnd_class_set_icon (item, an_icon.item)
			an_icon.set_shared
			--| Remove the shared status for this icon since
			--| Windows will destroy the icon by itself.
			--| The garbage collector must not call `destroy_item'.
		ensure
			icon_equal: icon.item = an_icon.item
		end

	set_cursor (a_cursor: WEL_CURSOR) is
			-- Set `cursor' with `a_cursor'.
		require
			a_cursor_not_void: a_cursor /= Void
			a_cursor_exists: a_cursor.exists
		do
			cwel_wnd_class_set_cursor (item, a_cursor.item)
			a_cursor.set_shared
			--| Windows will destroy the cursor by itself.
			--| The garbage collector must not call `destroy_item'.
		ensure
			cursor_equal: cursor.item = a_cursor.item
		end

	set_background (a_background: WEL_BRUSH) is
			-- Set `background' with `a_background'.
		require
			a_background_not_void: a_background /= Void
		do
			cwel_wnd_class_set_background (item, a_background.item)
		ensure
			background_equal: background.item = a_background.item
		end

	set_class_name (a_class_name: STRING) is
			-- Set `class_name' with `a_class_name'.
		require
			a_class_name_valid: a_class_name /= Void
			a_class_name_not_empty: not a_class_name.is_empty
		do
			create str_class_name.make (a_class_name)
			check
				str_class_name_not_void: str_class_name /= Void
				str_class_name_exists: str_class_name.exists
			end
			cwel_wnd_class_set_class_name (item,
				str_class_name.item)
		ensure
			class_name_set: class_name.is_equal (a_class_name)
		end

	set_menu_name (a_menu_name: STRING) is
			-- Set `menu_name' with `a_menu_name'.
		require
			a_menu_name_valid: a_menu_name /= Void
		do
			create str_menu_name.make (a_menu_name)
			check
				str_menu_name_not_void: str_menu_name /= Void
				str_menu_name_exists: str_menu_name.exists
			end
			cwel_wnd_class_set_menu_name (item,
				str_menu_name.item)
		ensure
			menu_name_equal: menu_name.is_equal (a_menu_name)
		end

	unset_window_procedure is
			-- Unset the window procedure (becomes null).
		do
			cwel_wnd_class_set_wnd_proc (item, default_pointer)
		ensure
			window_procedure_unset: not window_procedure_set
		end

	unset_icon is
			-- Unset the icon (becomes null).
		do
			cwel_wnd_class_set_icon (item, default_pointer)
		ensure
			icon_unset: not icon_set
		end

	unset_cursor is
			-- Unset the cursor (becomes null).
		do
			cwel_wnd_class_set_cursor (item, default_pointer)
		ensure
			cursor_unset: not cursor_set
		end

	unset_background is
			-- Unset the background (becomes null).
		do
			cwel_wnd_class_set_background (item, default_pointer)
		ensure
			background_unset: not background_set
		end

	unset_menu_name is
 			-- Unset the menu (becomes null).
		do
			cwel_wnd_class_set_menu_name (item, default_pointer)
		ensure
			menu_name_unset: not menu_name_set
		end

feature -- Status report

	registered: BOOLEAN is
			-- Is the class registered?
		local
			p, null: POINTER
		do
			p := c_calloc (1, structure_size)
			if p /= null then
				if atom = 0 then
						-- Not yet registered or already unregistered
					Result := cwin_get_class_info (default_pointer,
						cwel_wnd_class_get_class_name (item), p) 
						or else  cwin_get_class_info (
							main_args.current_instance.item,
							cwel_wnd_class_get_class_name (item), p)
				else
						-- Already registered. Simply check that it is still
						-- registered.
					Result := cwin_get_class_info (default_pointer,
						cwel_integer_to_pointer (atom), p) 
						or else cwin_get_class_info (
							main_args.current_instance.item,
							cwel_integer_to_pointer (atom), p) 
				end
				c_free (p)
			end
		end

	icon_set: BOOLEAN is
			-- Is the icon set?
		do
			Result := cwel_wnd_class_get_icon (item) /= default_pointer
		end

	cursor_set: BOOLEAN is
			-- Is the cursor set?
		do
			Result := cwel_wnd_class_get_cursor (item) /= default_pointer
		end

	background_set: BOOLEAN is
			-- Is the background set?
		do
			Result := cwel_wnd_class_get_background (item) /= default_pointer
		end

	menu_name_set: BOOLEAN is
			-- Is the menu name set?
		do
			Result := cwel_wnd_class_get_menu_name (item) /= default_pointer
		end

	window_procedure_set: BOOLEAN is
			-- Is the window procedure set?
		do
			Result := cwel_wnd_class_get_wnd_proc (item) /= default_pointer
		end

	instance_set: BOOLEAN is
			-- Is the instance set?
		do
			Result := cwel_wnd_class_get_instance (item) /= default_pointer
		end

feature -- Basic operations

	register is
			-- Register the window class.
		do
			atom := cwin_register_class (item)
		ensure
			registered: registered
		end

	unregister is
			-- Unregister the window class.
			-- All windows using this class must be destroyed.
		require
			registered: registered
		local
			success: BOOLEAN
		do
			if atom /= 0 then
				success := cwin_unregister_class (cwel_integer_to_pointer (atom),
					main_args.current_instance.item)
			else
				success := cwin_unregister_class (cwel_wnd_class_get_class_name (item),
					main_args.current_instance.item)
			end
			if success then
				atom := 0
			end
		ensure
			no_registered: not registered
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_wnd_class
		end

feature {NONE} -- Implementation

	str_class_name: WEL_STRING
			-- C string to save the class name

	str_menu_name: WEL_STRING
			-- C string to save the menu name

	main_args: WEL_MAIN_ARGUMENTS is
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	c_size_of_wnd_class: INTEGER is
		external
			"C [macro <wndclass.h>]"
		alias
			"sizeof (WNDCLASS)"
		end

	cwel_wnd_class_set_style (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_wnd_extra (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_cls_extra (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_instance (ptr: POINTER; value: POINTER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_wnd_proc (ptr: POINTER; value: POINTER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_icon (ptr: POINTER; value: POINTER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_background (ptr: POINTER; value: POINTER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_cursor (ptr: POINTER; value: POINTER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_class_name (wnd_class, value: POINTER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_menu_name (wnd_class, value: POINTER) is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_get_wnd_extra (ptr: POINTER): INTEGER is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_get_cls_extra (ptr: POINTER): INTEGER is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_get_style (ptr: POINTER): INTEGER is
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_get_instance (ptr: POINTER): POINTER is
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER" 
		end

	cwel_wnd_class_get_wnd_proc (ptr: POINTER): POINTER is
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_icon (ptr: POINTER): POINTER is
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_cursor (ptr: POINTER): POINTER is
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_background (ptr: POINTER): POINTER is
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_menu_name (ptr: POINTER): POINTER is
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_class_name (ptr: POINTER): POINTER is
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwin_register_class (ptr: POINTER): INTEGER is
			-- SDK RegisterClass
		external
			"C [macro <wel.h>] (WNDCLASS *): EIF_INTEGER"
		alias
			"RegisterClass"
		end

	cwin_unregister_class (cls_name, hinstance: POINTER): BOOLEAN is
			-- SDK UnregisterClass
		external
			"C [macro <wel.h>] (LPCSTR, HINSTANCE): EIF_BOOLEAN"
		alias
			"UnregisterClass"
		end

	cwin_get_class_info (hinstance, cls_name, ptr: POINTER): BOOLEAN is
			-- SDK GetClassInfo
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR, %
				%WNDCLASS *): EIF_BOOLEAN"
		alias
			"GetClassInfo"
		end



end -- class WEL_WND_CLASS


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

