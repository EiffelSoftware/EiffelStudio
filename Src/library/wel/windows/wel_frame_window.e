indexing
	description: "An overlapped window with a frame."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FRAME_WINDOW

inherit
	WEL_COMPOSITE_WINDOW
		redefine
			process_message
		end

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

creation
	make_child, make_top

feature {NONE} -- Initialization

	make_child (a_parent: WEL_COMPOSITE_WINDOW; a_name: STRING) is
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
			name_set: text.is_equal (a_name)
		end

	make_top (a_name: STRING) is
			-- Make a top window (without parent) with `a_name'
			-- as a title.
		require
			a_name_not_void: a_name /= Void
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
			name_set: text.is_equal (a_name)
		end

feature -- Standard window class values

	class_icon: WEL_ICON is
			-- Standard application icon used to create the
			-- window class.
			-- Can be redefined to return a user-defined icon.
		once
			!! Result.make_by_predefined_id (Idi_application)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_cursor: WEL_CURSOR is
			-- Standard arrow cursor used to create the window
			-- class.
			-- Can be redefined to return a user-defined cursor.
		once
			!! Result.make_by_predefined_id (Idc_arrow)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_background: WEL_BRUSH is
			-- Standard window background color used to create the
			-- window class.
			-- Can be redefined to return a user-defined brush.
		require
			background_brush_not_set: background_brush = Void
		once
			!! Result.make_by_sys_color (Color_window + 1)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_style: INTEGER is
			-- Standard style used to create the window class.
			-- Can be redefined to return a user-defined style.
		once
			Result := Cs_hredraw + Cs_vredraw + Cs_dblclks
		end

	class_menu_name: STRING is
			-- Window's menu used to create the window class.
			-- Can be redefined to return a user-defined menu.
			-- (None by default).
		once
			!! Result.make (0)
		ensure
			result_not_void: Result /= Void
		end

	class_name: STRING is
			-- Window class name used to create the window class.
			-- Can be redefined to return a user-defined class name.
		once
			Result := "WELFrameWindowClass"
		end

	class_window_procedure: POINTER is
			-- Standard window procedure
		once
			Result := cwel_window_procedure_address
		ensure
			result_not_null: Result /= default_pointer
		end

feature -- Default creation values

	default_style: INTEGER is
			-- Overlapped window style.
			-- By default, a frame window is not visible
			-- at the creation time. `show' needs to be called.
			-- This solution avoids a bad visual effect when
			-- the children are created one by one inside
			-- the window.
		once
			Result := Ws_overlappedwindow
		end

	default_x, default_y, default_width, default_height: INTEGER is
			-- Default position and dimension when the window is
			-- created.
		once
			Result := Cw_usedefault
		end

	default_id: INTEGER is
			-- Default window id.
			-- (Zero by default).
		once
			Result := 0
		end

feature -- Background color

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background
		do
		end

feature -- Messages

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		require
			paint_dc_not_void: paint_dc /= Void
			paint_dc_exists: paint_dc.exists
			invalid_rect_not_void: invalid_rect /= Void
		do
			if background_brush /= Void then
				paint_dc.fill_rect (invalid_rect, background_brush)
			end
		end

feature {NONE} -- Implementation

	register_class is
			-- Register the window class if
			-- the class is not already registered.
			-- The routines `class_style', `class_window_procedure',
			-- `class_icon', `class_cursor', `class_background', and
			-- `class_menu_name' are called before the registration
			-- to set all the window class information.
		local
			wnd_class: WEL_WND_CLASS
		do
			!! wnd_class.make (class_name)
			if not wnd_class.registered then
				wnd_class.set_style (class_style)
				wnd_class.set_window_procedure (class_window_procedure)
				wnd_class.set_icon (class_icon)
				wnd_class.set_cursor (class_cursor)
				if class_background /= Void then
						--| Can be Void since the user maybe wants to catch
						--| the `WM_ERASEBKGND' message.
					wnd_class.set_background (class_background)
				end
				wnd_class.set_menu_name (class_menu_name)
				wnd_class.register
			end
		end

	on_wm_erase_background (wparam: INTEGER) is
			-- Wm_erasebkgnd message.
			-- A WEL_DC and WEL_PAINT_STRUCT are created and passed to the
			-- `on_erase_background' routine.
			-- To be more efficient when the windows does not have a `background_brush'
			-- attribute set, this routine does nothing.
		require
			exists: exists
		local
			paint_dc: WEL_PAINT_DC
		do
			if background_brush /= Void then
				!! paint_dc.make_by_pointer (Current, cwel_integer_to_pointer(wparam))
				if scroller /= Void then
					paint_dc.set_viewport_origin (-scroller.horizontal_position,
						-scroller.vertical_position)
				end
				on_erase_background (paint_dc, client_rect )
					--| Disable the default windows processing
				disable_default_processing
			end
		end

feature {WEL_DISPATCHER} -- Message handling

	process_message (hwnd: POINTER;	msg, wparam, lparam: INTEGER): INTEGER is
		do 
			Result := {WEL_COMPOSITE_WINDOW} Precursor (hwnd, msg, wparam, lparam)
			if msg = Wm_erasebkgnd then
				on_wm_erase_background (wparam)
			end
		end	

end -- class FRAME_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

