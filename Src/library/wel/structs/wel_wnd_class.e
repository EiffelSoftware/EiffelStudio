note
	description: "Contains information about the window class."
	legal: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make (a_class_name: STRING_GENERAL)
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

	class_name: STRING_32
			-- Class name
		do
			Result := (create {WEL_STRING}.share_from_pointer (cwel_wnd_class_get_class_name (item))).string
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	atom: INTEGER
			-- Class atom that uniquely identifies class being registered.

	menu_name: STRING_32
			-- Menu name to load from the resource
		require
			menu_name_set: menu_name_set
		do
			Result := (create {WEL_STRING}.share_from_pointer (cwel_wnd_class_get_menu_name (item))).string
		ensure
			result_not_void: Result /= Void
		end

	style: INTEGER
			-- Class style
		do
			Result := cwel_wnd_class_get_style (item)
		end

	window_procedure: POINTER
			-- Window procedure to call
		require
			window_procedure_set: window_procedure_set
		do
			Result := cwel_wnd_class_get_wnd_proc (item)
		ensure
			Result /= default_pointer
		end

	class_extra: INTEGER
			-- Class extra information size
		do
			Result := cwel_wnd_class_get_cls_extra (item)
		ensure
			positive_result: Result >= 0
		end

	window_extra: INTEGER
			-- Window extra information size
		do
			Result := cwel_wnd_class_get_wnd_extra (item)
		ensure
			positive_result: Result >= 0
		end

	instance: WEL_INSTANCE
			-- Instance of the class.
		require
			instance_set: instance_set
		do
			create Result.make (cwel_wnd_class_get_instance (item))
		ensure
			result_not_void: Result /= Void
		end

	icon: WEL_ICON
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

	cursor: WEL_CURSOR
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

	background: WEL_BRUSH
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

	set_style (a_style: INTEGER)
			-- Set `style' with `a_style'.
		do
			cwel_wnd_class_set_style (item, a_style)
		ensure
			style = a_style
		end

	set_window_extra (a_window_extra: INTEGER)
			-- Set `window_extra' with `a_window_extra'.
		require
			positive_extra: a_window_extra >= 0
		do
			cwel_wnd_class_set_wnd_extra (item, a_window_extra)
		ensure
			window_extra = a_window_extra
		end

	set_instance (an_instance: WEL_INSTANCE)
			-- Set `instance' with `an_instance'.
		require
			an_instance_not_void: an_instance /= Void
			an_instance_exists: an_instance.exists
		do
			cwel_wnd_class_set_instance (item, an_instance.item)
		ensure
			instance_equal: instance.item = an_instance.item
		end

	set_class_extra (a_class_extra: INTEGER)
			-- Set `class_extra' with `a_class_extra'.
		require
			positive_extra: a_class_extra >= 0
		do
			cwel_wnd_class_set_cls_extra (item, a_class_extra)
		ensure
			class_extra = a_class_extra
		end

	set_window_procedure (a_window_procedure: POINTER)
			-- Set `window_procedure' with `a_window_procedure'.
		do
			cwel_wnd_class_set_wnd_proc (item,
				a_window_procedure)
		ensure
			window_procedure_equal: window_procedure =
				a_window_procedure
		end

	set_icon (an_icon: WEL_ICON)
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

	set_cursor (a_cursor: WEL_CURSOR)
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

	set_background (a_background: WEL_BRUSH)
			-- Set `background' with `a_background'.
		require
			a_background_not_void: a_background /= Void
		do
				-- It is ok to have `background.item' being the NULL pointer
				-- thus the lack of precondition `background.exists'.
			cwel_wnd_class_set_background (item, a_background.item)
		ensure
			background_equal: background.item = a_background.item
		end

	set_class_name (a_class_name: STRING_GENERAL)
			-- Set `class_name' with `a_class_name'.
		require
			a_class_name_valid: a_class_name /= Void
			a_class_name_not_empty: not a_class_name.is_empty
		local
			l_name: like str_class_name
		do
			create l_name.make (a_class_name)
			str_class_name := l_name
			check
				str_class_name_exists: l_name.exists
			end
			cwel_wnd_class_set_class_name (item, l_name.item)
		ensure
			class_name_set: class_name.is_equal (a_class_name)
		end

	set_menu_name (a_menu_name: STRING_GENERAL)
			-- Set `menu_name' with `a_menu_name'.
		require
			a_menu_name_valid: a_menu_name /= Void
		local
			l_name: like str_menu_name
		do
			create l_name.make (a_menu_name)
			str_menu_name := l_name
			check
				str_menu_name_exists: l_name.exists
			end
			cwel_wnd_class_set_menu_name (item, l_name.item)
		ensure
			menu_name_equal: menu_name.is_equal (a_menu_name)
		end

	unset_window_procedure
			-- Unset the window procedure (becomes null).
		do
			cwel_wnd_class_set_wnd_proc (item, default_pointer)
		ensure
			window_procedure_unset: not window_procedure_set
		end

	unset_icon
			-- Unset the icon (becomes null).
		do
			cwel_wnd_class_set_icon (item, default_pointer)
		ensure
			icon_unset: not icon_set
		end

	unset_cursor
			-- Unset the cursor (becomes null).
		do
			cwel_wnd_class_set_cursor (item, default_pointer)
		ensure
			cursor_unset: not cursor_set
		end

	unset_background
			-- Unset the background (becomes null).
		do
			cwel_wnd_class_set_background (item, default_pointer)
		ensure
			background_unset: not background_set
		end

	unset_menu_name
 			-- Unset the menu (becomes null).
		do
			cwel_wnd_class_set_menu_name (item, default_pointer)
		ensure
			menu_name_unset: not menu_name_set
		end

feature -- Status report

	registered: BOOLEAN
			-- Is the class registered?
		local
			p, null: POINTER
		do
			p := p.memory_calloc (1, Structure_size)
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
				p.memory_free
			end
		end

	icon_set: BOOLEAN
			-- Is the icon set?
		do
			Result := cwel_wnd_class_get_icon (item) /= default_pointer
		end

	cursor_set: BOOLEAN
			-- Is the cursor set?
		do
			Result := cwel_wnd_class_get_cursor (item) /= default_pointer
		end

	background_set: BOOLEAN
			-- Is the background set?
		do
			Result := cwel_wnd_class_get_background (item) /= default_pointer
		end

	menu_name_set: BOOLEAN
			-- Is the menu name set?
		do
			Result := cwel_wnd_class_get_menu_name (item) /= default_pointer
		end

	window_procedure_set: BOOLEAN
			-- Is the window procedure set?
		do
			Result := cwel_wnd_class_get_wnd_proc (item) /= default_pointer
		end

	instance_set: BOOLEAN
			-- Is the instance set?
		do
			Result := cwel_wnd_class_get_instance (item) /= default_pointer
		end

feature -- Basic operations

	register
			-- Register the window class.
		do
			atom := cwin_register_class (item)
		ensure
			registered: registered
		end

	unregister
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

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_wnd_class
		end

feature {NONE} -- Implementation

	str_class_name: detachable WEL_STRING
			-- C string to save the class name

	str_menu_name: detachable WEL_STRING
			-- C string to save the menu name

	main_args: WEL_MAIN_ARGUMENTS
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	c_size_of_wnd_class: INTEGER
		external
			"C [macro <wndclass.h>]"
		alias
			"sizeof (WNDCLASS)"
		end

	cwel_wnd_class_set_style (ptr: POINTER; value: INTEGER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_wnd_extra (ptr: POINTER; value: INTEGER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_cls_extra (ptr: POINTER; value: INTEGER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_instance (ptr: POINTER; value: POINTER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_wnd_proc (ptr: POINTER; value: POINTER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_icon (ptr: POINTER; value: POINTER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_background (ptr: POINTER; value: POINTER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_cursor (ptr: POINTER; value: POINTER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_class_name (wnd_class, value: POINTER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_set_menu_name (wnd_class, value: POINTER)
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_get_wnd_extra (ptr: POINTER): INTEGER
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_get_cls_extra (ptr: POINTER): INTEGER
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_get_style (ptr: POINTER): INTEGER
		external
			"C [macro <wndclass.h>]"
		end

	cwel_wnd_class_get_instance (ptr: POINTER): POINTER
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_wnd_proc (ptr: POINTER): POINTER
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_icon (ptr: POINTER): POINTER
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_cursor (ptr: POINTER): POINTER
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_background (ptr: POINTER): POINTER
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_menu_name (ptr: POINTER): POINTER
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwel_wnd_class_get_class_name (ptr: POINTER): POINTER
		external
			"C [macro <wndclass.h>] (WNDCLASS*): EIF_POINTER"
		end

	cwin_register_class (ptr: POINTER): INTEGER
			-- SDK RegisterClass
		external
			"C [macro <wel.h>] (WNDCLASS *): EIF_INTEGER"
		alias
			"RegisterClass"
		end

	cwin_unregister_class (cls_name, hinstance: POINTER): BOOLEAN
			-- SDK UnregisterClass
		external
			"C [macro <wel.h>] (LPCTSTR, HINSTANCE): EIF_BOOLEAN"
		alias
			"UnregisterClass"
		end

	cwin_get_class_info (hinstance, cls_name, ptr: POINTER): BOOLEAN
			-- SDK GetClassInfo
		external
			"C [macro <wel.h>] (HINSTANCE, LPCTSTR, %
				%WNDCLASS *): EIF_BOOLEAN"
		alias
			"GetClassInfo"
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

end
