indexing
	description	: "WEL Horizontal Split area"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "2000/05/04"
	revision	: "0.99"

class
	WEL_SPLIT_AREA

inherit
	WEL_WINDOW
		redefine
			on_size,
			on_mouse_move,
			on_left_button_down,
			on_left_button_up,
			default_process_message
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_name: STRING;
			a_x, a_y, a_width, a_height, a_pos: INTEGER) is
			-- Make a split area with `a_pos' as splitter position.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_name_not_void: a_name /= Void
			a_pos_valid: a_pos >= 0
		do
				-- Register the class & create the window.
			register_class
			internal_window_make (a_parent, a_name,
				default_style, a_x, a_y, a_width, a_height,
				0, default_pointer)

				-- Set up x-position of the splitter.
			splitter_position := a_pos
		ensure
			parent_set: parent = a_parent
			exists: exists
			name_set: text.is_equal (a_name)
		end

feature -- Access

	left_control: WEL_WINDOW
			-- Control in the left part of the split area.
			-- Void if none
	
	right_control: WEL_WINDOW
			-- Control in the right part of the split area.
			-- Void if none
	
feature -- Element change

	set_splitter_position (a_pos: INTEGER) is
			-- Set the width of the splitter (or also
			-- the width of the left part of the split area)
		require
			valid_position: a_pos >= 0
		do
			splitter_position := a_pos
		ensure
			position_set: splitter_position = a_pos
		end

	set_left_control (a_control: WEL_WINDOW) is
			-- Put `a_control' in the left part of the split area
		do
			left_control := a_control
			left_control.set_parent (Current)
			left_control.move_and_resize (0, 0, splitter_position, height, True)
		end

	set_right_control (a_control: WEL_WINDOW) is
			-- Put `a_control' in the right part of the split area
		do
			right_control := a_control
			right_control.set_parent (Current)
			right_control.move_and_resize (0, 0, splitter_position + separator_width, height, True)
		end

feature {NONE} -- Implementation

	separator_width: INTEGER is 3
			-- Width of the splitter.
	
	splitter_position: INTEGER
			-- Width of the left control. Also the x-position of the
			-- splitter.

feature {NONE} -- Windows message handling

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message handling
		do
				-- Start to move the splitter. We capture
				-- the mouse message to be able to move
				-- the mouse over the left or right control
				-- without losing the "mouse focus".
			if not has_capture then
				set_capture
			end
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message handling
		do
				-- Stop to move the splitter. 
			if has_capture then
				release_capture
			end
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mousemove message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
				-- Are we moving the splitter?
			if has_capture then
					-- Move the splitter. The splitter position
					-- is now the mouse position
				splitter_position := x_pos
					
					-- Resize the left & right controls.
				on_size (0, width, height)
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		do
				-- Resize the left control if there is any.
				--
				-- Modify this line if you don't want the split
				-- area to resize the left control (if it's a button
				-- for example)
			if left_control /= Void and then left_control.exists then
				left_control.move_and_resize (
					0, 0, 
					splitter_position, a_height, 
					True
					)
			end

				-- Resize the right control if there is any.
				--
				-- Modify this line if you don't want the split
				-- area to resize the right control (if it's a button
				-- for example)
			if right_control /= Void and then right_control.exists then
				right_control.move_and_resize (
					splitter_position + separator_width, 0, 
					a_width - (splitter_position + separator_width), a_height, 
					True
					)
			end
		end

	on_wm_paint (wparam: INTEGER) is
			-- Wm_paint message handling
			-- A WEL_DC and WEL_PAINT_STRUCT are created and
			-- passed to the `on_paint' routine.
		require
			exists: exists
		local
			paint_dc: WEL_PAINT_DC
		do
			create paint_dc.make_by_pointer (Current, cwel_integer_to_pointer(wparam))
			paint_dc.get
				-- We draw here the splitter. Add your code here to improve the
				-- look of the splitter
			paint_dc.fill_rect (paint_dc.paint_struct.rect_paint, class_background)
			paint_dc.release
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = Wm_paint then
				on_wm_paint (wparam)
			end
		end

feature -- Standard window class values

	class_icon: WEL_ICON is
			-- Standard application icon used to create the
			-- window class.
			-- Can be redefined to return a user-defined icon.
		once
			create Result.make_by_predefined_id (Wel_idi_constants.Idi_application)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_cursor: WEL_CURSOR is
			-- Standard arrow cursor used to create the window
			-- class.
			-- Can be redefined to return a user-defined cursor.
		once
			create Result.make_by_predefined_id (Wel_idc_constants.Idc_sizewe)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_background: WEL_BRUSH is
			-- Standard window background color used to create the
			-- window class.
			-- Can be redefined to return a user-defined brush.
		once
			create Result.make_by_sys_color (Wel_color_constants.Color_btnface + 1)
		end

	class_style: INTEGER is
			-- Standard style used to create the window class.
			-- Can be redefined to return a user-defined style.
		once
			Result := 
				Wel_cs_constants.Cs_hredraw + 
				Wel_cs_constants.Cs_vredraw + 
				Wel_cs_constants.Cs_dblclks
		end

	class_menu_name: STRING is
			-- Window's menu used to create the window class.
			-- Can be redefined to return a user-defined menu.
			-- (None by default).
		once
			create Result.make (0)
		ensure
			result_not_void: Result /= Void
		end

	class_name: STRING is
			-- Window class name used to create the window class.
			-- Can be redefined to return a user-defined class name.
		once
			Result := "WELSplitAreaClass"
		end

	class_window_procedure: POINTER is
			-- Standard window procedure
		once
			Result := cwel_window_procedure_address
		ensure
			result_not_null: Result /= default_pointer
		end

feature {NONE} -- Implementation

	register_class is
			-- Register the window class if the class is not already registered.
			-- The routines `class_style', `class_window_procedure',
			-- `class_icon', `class_cursor', `class_background', and
			-- `class_menu_name' are called before the registration
			-- to set all the window class information.
		local
			wnd_class: WEL_WND_CLASS
		do
			create wnd_class.make (class_name)
			if not wnd_class.registered then
				wnd_class.set_style (class_style)
				wnd_class.set_window_procedure (class_window_procedure)
				wnd_class.set_icon (class_icon)
				wnd_class.set_cursor (class_cursor)
				wnd_class.set_background (class_background)
				wnd_class.set_menu_name (class_menu_name)
				wnd_class.register
			end
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_clipchildren
		end

feature {NONE} -- Constants

	Wel_idi_constants: WEL_IDI_CONSTANTS is
			-- Default Icons constants
		once
			create Result
		end

	Wel_idc_constants: WEL_IDC_CONSTANTS is
			-- Default Cursors constants
		once
			create Result
		end

	Wel_color_constants: WEL_COLOR_CONSTANTS is
			-- System color constants
		once
			create Result
		end

	Wel_cs_constants: WEL_CS_CONSTANTS is
			-- Class style constants.
		once
			create Result
		end

invariant
	valid_splitter_position: exists implies 
		(splitter_position >= 0 and splitter_position <= width)

end -- class WEL_SPLIT_AREA

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

