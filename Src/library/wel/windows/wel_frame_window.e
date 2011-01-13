note
	description: "An overlapped window with a frame."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FRAME_WINDOW

inherit
	WEL_COMPOSITE_WINDOW

	WEL_CS_CONSTANTS
		export
			{NONE} all
		end

	WEL_IDI_CONSTANTS
		export
			{NONE} all
		end

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

create
	make_child, make_top

feature {NONE} -- Initialization

	make_child (a_parent: WEL_WINDOW; a_name: READABLE_STRING_GENERAL)
			-- Make the window as a child of `a_parent' and
			-- `a_name' as a title.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_name_not_void: a_name /= Void
		do
			register_class
			internal_window_make (a_parent, a_name,
				default_style,
				default_x, default_y,
				default_width, default_height,
				default_id, default_pointer)
		ensure
			parent_set: parent = a_parent
			exists: exists
			name_set: text.same_string_general (a_name)
		end

	make_top (a_name: detachable READABLE_STRING_GENERAL)
			-- Make a top window (without parent) with `a_name'
			-- as a title.
		do
			register_class
			internal_window_make (Void, a_name,
				default_style,
				default_x, default_y,
				default_width, default_height,
				default_id, default_pointer)
		ensure
			parent_set: parent = Void
			exists: exists
			name_set: a_name /= Void implies text.same_string_general (a_name)
		end

feature -- Standard window class values

	class_icon: WEL_ICON
			-- Standard application icon used to create the
			-- window class.
			-- Can be redefined to return a user-defined icon.
		once
			create Result.make_by_predefined_id (Idi_application)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_cursor: WEL_CURSOR
			-- Standard arrow cursor used to create the window
			-- class.
			-- Can be redefined to return a user-defined cursor.
		once
			create Result.make_by_predefined_id (Idc_arrow)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_background: WEL_BRUSH
			-- Standard window background color used to create the
			-- window class.
			-- Can be redefined to return a user-defined brush.
		require
			background_brush_not_set: background_brush = Void
		once
			create Result.make_by_sys_color (Color_window + 1)
		ensure
			result_not_void: Result /= Void
		end

	class_style: INTEGER
			-- Standard style used to create the window class.
			-- Can be redefined to return a user-defined style.
		once
			Result := Cs_hredraw + Cs_vredraw + Cs_dblclks
		end

	class_menu_name: STRING_32
			-- Window's menu used to create the window class.
			-- Can be redefined to return a user-defined menu.
			-- (None by default).
		once
			create Result.make (0)
		ensure
			result_not_void: Result /= Void
		end

	class_name: STRING_32
			-- Window class name used to create the window class.
			-- Can be redefined to return a user-defined class name.
		once
			Result := "WELFrameWindowClass"
		end

	class_window_procedure: POINTER
			-- Standard window procedure
		once
			Result := cwel_window_procedure_address
		ensure
			result_not_null: Result /= default_pointer
		end

	class_requires_icon: BOOLEAN
			-- Does `Current' require an icon to be registered?
			-- If `True' `register_class' assigns a class icon, otherwise
			-- no icon is assigned.
		do
			Result := True
		end

feature -- Default creation values

	default_style: INTEGER
			-- Overlapped window style.
			-- By default, a frame window is not visible
			-- at the creation time. `show' needs to be called.
			-- This solution avoids a bad visual effect when
			-- the children are created one by one inside
			-- the window.
		once
			Result := Ws_overlappedwindow
		end

	default_x, default_y, default_width, default_height: INTEGER
			-- Default position and dimension when the window is
			-- created.
		once
			Result := Cw_usedefault
		end

	default_id: INTEGER
			-- Default window id.
			-- (Zero by default).
		once
			Result := 0
		end

feature {NONE} -- Implementation

	register_class
			-- Register the window class if
			-- the class is not already registered.
			-- The routines `class_style', `class_window_procedure',
			-- `class_icon', `class_cursor', `class_background', and
			-- `class_menu_name' are called before the registration
			-- to set all the window class information.
		do
			create wnd_class.make (class_name)
			if not wnd_class.registered then
				wnd_class.set_style (class_style)
				wnd_class.set_window_procedure (class_window_procedure)
				if class_requires_icon then
					wnd_class.set_icon (class_icon)
				end
				wnd_class.set_cursor (class_cursor)
				if
					background_brush = Void and then
					class_background /= Void
				then
						--| If class_background attribute is not
						--| Void, we do not use the class_background
						--| once function.
					wnd_class.set_background (class_background)
				end
				wnd_class.set_menu_name (class_menu_name)
				wnd_class.register
			end
		end

	wnd_class: WEL_WND_CLASS;
			-- Associated windows class of current window.

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class FRAME_WINDOW

