indexing

	description: "This class represents a MS_WINDOWS standard dialog";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	STANDARD_DIALOG_WINDOWS

inherit
	DIALOG_IMP
		redefine
			default_style,
			default_ex_style,
			popup,
			on_paint,
			on_size,
			on_set_focus,
			realize_current,
			realize,	
			set_x_y,
			set_x,
			set_y,
			x,
			y
		end

	BASIC_ROUTINES
		export
			{NONE} all
		end

	WEL_BM_CONSTANTS
		export
			{NONE} all
		end

	WEL_SS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

	COLORED_FOREGROUND_WINDOWS

feature -- Initialization

	realize_current is
			-- Realize the dialog.
		require else
			parent_not_void: parent /= Void
			not_exists: not exists
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			wc ?= parent
			make_with_coordinates (wc, title, x, y, width, height)
			create_buttons
			create_controls
			set_fonts
			set_default_button
		end

	realize is
			-- Realize the dialog and its children
		do
			if not realized then
				realize_current
			end
				-- set initial focus
			if initial_focus /= Void then
				initial_focus.wel_set_focus
			end					
		end

feature -- Access

	x: INTEGER is
			-- X position of dialog
		do
			Result := private_attributes.x
		end

	y: INTEGER is
			-- Y position of dialog
		do
			Result := private_attributes.y
		end

feature -- Basic operations

	popup is
			-- Popup the dialog.
		do
			if not is_popped_up then
				realize
				adjust_dialog
				determine_focus
				set_modality
				set_position
				wel_show
				shown := True
			end
		end

feature -- Status setting

	set_x (new_x: INTEGER) is
			-- Set `x' to `new_x'.
		do
			private_attributes.set_x (new_x)
			if exists then
				wel_set_x (new_x)
			end
		end

	set_x_y (new_x, new_y: INTEGER) is
			-- Set `x' to `new_x', `y' to `new_y'.
		do
			private_attributes.set_y (new_y)
			private_attributes.set_x (new_x)
			if exists then
				wel_move (new_x, new_y)
			end
		end

	set_y (new_y: INTEGER) is
			-- Set `y' to `new_y'.
		do
			private_attributes.set_y (new_y)
			if exists then
				wel_set_y (new_y)
			end
		end

	set_left_alignment is
			-- Align message to the left side of the dialog.
		do
			alignment := Left_alignment
			adjust_dialog
		ensure
			alignment_set: alignment = Left_alignment
		end

	set_center_alignment is
			-- Align message to the center of the dialog.
		do
			alignment := Center_alignment
			adjust_dialog
		ensure
			alignment_set: alignment = Center_alignment
		end

	set_right_alignment is
			-- Align message to the right side of the dialog.
		do
			alignment := Right_alignment
			adjust_dialog
		ensure
			alignment_set: alignment = Right_alignment
		end

	hide_ok_button is
			-- Hide the `ok_button'.
		do
			if exists and then not ok_button_hidden then
				ok_button.hide
				ok_button_hidden := True
				adjust_dialog
			else
				ok_button_hidden := True
			end
		ensure
			hidden: ok_button_hidden
			exists_implies_hidden: exists implies not ok_button.shown
		end

	hide_cancel_button is
			-- Hide the `cancel_button'.
		do
			if exists and then not cancel_button_hidden then
				cancel_button.hide
				cancel_button_hidden := True
				adjust_dialog
			else
				cancel_button_hidden := True
			end
		ensure
			hidden: cancel_button_hidden
			exists_implies_hidden: exists implies not cancel_button.shown
		end

	hide_help_button is
			-- Hide the `help_button'.
		do
			if exists and then not help_button_hidden then
				help_button.hide
				help_button_hidden:= True
				adjust_dialog
			else
				help_button_hidden := True
			end
		ensure
			hidden: help_button_hidden
			exists_implies_hidden: exists implies not help_button.shown
		end

	show_ok_button is
			-- Show the `ok_button'.
		do
			if exists and then ok_button_hidden then
				ok_button.show
				ok_button_hidden := False
				adjust_dialog
			else
				ok_button_hidden := False
			end
		ensure
			button_not_hidden: not ok_button_hidden
			exists_implies_shown: exists implies ok_button.shown
		end

	show_cancel_button is
			-- Show the `cancel_button'.
		do
			if exists and then cancel_button_hidden then
				cancel_button.show
				cancel_button_hidden := False
				adjust_dialog
			else
				cancel_button_hidden := False
			end
		ensure
			button_not_hidden: not cancel_button_hidden
			exists_implies_shown: exists implies cancel_button.shown
		end

	show_help_button is
			-- Show the `help_button'.
		do
			if exists and then help_button_hidden then
				help_button.show
				help_button_hidden := False
				adjust_dialog
			else
				help_button_hidden := False
			end
		ensure
			button_not_hidden: not help_button_hidden
			exists_implies_shown: exists implies help_button.shown
		end

	set_text_font (a_font: FONT) is
			-- Change the font of the message.
		do
			text_font := a_font
			if exists then
				set_font_on_text
				adjust_dialog
			end
		end

	set_button_font (a_font: FONT) is
			-- Change the font of the buttons.
		do
			button_font := a_font
			if exists then
				set_font_on_buttons
				adjust_dialog
			end
		ensure
			font_is_set: button_font = a_font
		end

feature -- Element change

	set_help_label (s: STRING) is
			-- Replace the text on the `help_button' with `s'
		do
			if exists then
				help_label := clone (s)
				help_button.set_text (help_label)
				if not help_button_hidden then
					adjust_dialog
				end
			else
				help_label := clone (s)
			end
		ensure
			help_label_is_equal_to_s: help_label.is_equal (s)
		end

	set_cancel_label (s: STRING) is
			-- Replace the text on the `cancel_button' with `s'
		do
			if exists then
				cancel_label := clone (s)
				cancel_button.set_text (cancel_label)
				if not cancel_button_hidden then
					adjust_dialog
				end
			else
				cancel_label := clone (s)
			end
		ensure
			cancel_label_is_equal_to_s: cancel_label.is_equal (s)
		end

	set_ok_label (s: STRING) is
			-- Replace the text on the `ok_button' with `s'
		do
			if exists then
				ok_label := clone (s)
				ok_button.set_text (ok_label)
				if not ok_button_hidden then
					adjust_dialog
				end
			else
				ok_label := clone (s)
			end
		ensure
			ok_label_is_equal_to_s: ok_label.is_equal (s)
		end

	add_ok_action (c: COMMAND; arg: ANY) is
			-- Add an action to the `ok_button'.
		require
			command_not_void: c /= Void
		do
			ok_actions.add (Current, c, arg)
		end

	add_cancel_action (c: COMMAND; arg: ANY) is
			-- Add an action to the `cancel_button'.
		require
			command_not_void: c /= Void
		do
			cancel_actions.add (Current, c, arg)
		end

	add_help_action (c: COMMAND; arg: ANY) is
			-- Add an action to the `help_button'.
		require
			command_not_void: c /= Void
		do
			help_actions.add (current, c, arg)
		end

feature -- Removal

	remove_ok_action (c: COMMAND; arg: ANY) is
			-- Remove the action from the `ok_button'.
		require
			command_not_void: c /= Void
		do
			ok_actions.remove (Current, c, arg)
		end

	remove_cancel_action (c: COMMAND; arg: ANY) is
			-- Remove the action from the `cancel_button'.
		require
			command_not_void: c /= Void
		do
			cancel_actions.remove (Current, c, arg)
		end

	remove_help_action (c: COMMAND; arg: ANY) is
			-- Remove the action from the `help_button'.
		require
			command_not_void: c /= Void
		do
			help_actions.remove (Current, c, arg)
		end

feature {NONE} -- Implementation

	text_font: FONT
			-- Font used for the message or text.

	button_font: FONT
			-- Font used for the buttons.

	dialog_unit: INTEGER is 6
			-- Number of pixels for one `dialog_unit'

	ok_button_hidden: BOOLEAN
			-- Is the `ok_button' hidden?

	cancel_button_hidden: BOOLEAN
			-- Is the `cancel_button' hidden?

	help_button_hidden: BOOLEAN
			-- Is the `help_button' hidden?

	ok_label: STRING
			-- Label for the `ok_button'

	cancel_label: STRING
			-- Label for the `cancel_button'

	help_label: STRING
			-- Label for the `help_button'

	ok_button: WEL_PUSH_BUTTON
			-- The ok button

	cancel_button: WEL_PUSH_BUTTON
			-- The cancel button

	help_button: WEL_PUSH_BUTTON
			-- The help button

	alignment : INTEGER
			-- Type of alignment for text

	Left_alignment: INTEGER is 1
			-- Text is left aligned

	Center_alignment: INTEGER is 2
			-- Text is centered

	Right_alignment: INTEGER is 3
			-- Text is right aligned

	ok_id: INTEGER is 1
			-- Id for the `ok_button'

	cancel_id: INTEGER is 2
			-- Id for the `cancel_button'

	help_id: INTEGER is 3
			-- Id for the `help_button'

	default_button_id: INTEGER
			-- Indicates the button which has the default button style.

	set_modality is
			-- Simulate a modal dialog if necessary
		do
			if grab_style = Modal then
				set_windows_insensitive
			end
		end

	create_controls is
			-- Create the controls for the dialog.
		deferred
		end

	set_fonts is
			-- Set the font on the controls.
		deferred
		end

	set_font_on_text is
			-- Set the font on the text.
		deferred
		end

	set_default_button is
			-- Set default_button
		deferred
		end

	resize_children is
			-- Resize the children if necessary.
		require
			resize_allowed: not fixed_size_flag
		deferred
		end

	reposition_children is
			-- Move the children if necessary.
		deferred
		end

	reposition_buttons is
			-- Move the buttons if necessary.
		deferred
		end

	total_buttons_width: INTEGER is
			-- The width of the visible buttons plus
			-- the offset to the sides of the dialog
			-- plus the possible offset between the buttons.
		deferred
		ensure
			positive_result: Result >= 0
		end

	dialog_width: INTEGER is
			-- Width of the dialog
		deferred
		end

	dialog_height: INTEGER is
			-- Height of the dialog
		deferred
		end

	resize_buttons is
			-- Resize the buttons according to the button
			-- which is visible and has the largest label.
		require
			resizing_allowed: not fixed_size_flag
		deferred
		end

	determine_focus is
			-- Focus on default
		deferred
		end

	icon: WEL_ICON is
			-- The icon
		do
		end

	set_font_on_buttons is
			-- Set the font on the buttons.
		require
			button_font_not_void: button_font /= Void
		local
			windows_font: FONT_IMP
		do
			windows_font ?= button_font.implementation
			ok_button.set_font (windows_font.wel_font)
			cancel_button.set_font (windows_font.wel_font)
			help_button.set_font (windows_font.wel_font)
		end

	set_text_on_control (s: STRING; c: WEL_CONTROL) is
			-- Set the text on the control according to
			-- the alingment.
		require
			s_not_void: s /= Void
			c_not_void: c /= Void
			c_exist: c.exists
		do
			inspect
				alignment
			when Left_alignment then
				c.set_style (Ws_visible + Ws_child + Ws_group +
					Ws_tabstop + Ss_left)
				c.invalidate
				c.set_text (s)
			when Center_alignment then
				c.set_style (Ws_visible + Ws_child + Ws_group +
					Ws_tabstop + Ss_center)
				c.invalidate
				c.set_text (s)
			when Right_alignment then
				c.set_style (Ws_visible + Ws_child + Ws_group +
					Ws_tabstop + Ss_right)
				c.invalidate
				c.set_text (s)
			else
				c.set_text (s)
			end
		end

	text_height (a_text: STRING; a_font: FONT): INTEGER is
			-- The height of the font of the message
		require
			a_text_not_void: a_text /= Void
			a_font_not_void: a_font /= Void
		local
			a_font_windows: FONT_IMP
		do
			
			a_font_windows ?= a_font.implementation
			Result := a_font_windows.string_height (Current, a_text)
		end

	create_buttons is
			-- Create the buttons and hide them if necessary.
		do
			!! ok_button.make (Current, ok_label, 0, 0, 0, 0, ok_id)
			!! cancel_button.make (Current, cancel_label, 0, 0, 0, 0, cancel_id)
			!! help_button.make (Current, help_label, 0, 0, 0, 0, help_id)
			update_visibility
		end

	update_visibility is
			-- Show or hide buttons on state of dialog.
		do
			if ok_button_hidden then
				ok_button.hide
			else
				ok_button.show
			end
			if cancel_button_hidden then
				cancel_button.hide
			else
				cancel_button.show
			end
			if help_button_hidden then
				help_button.hide
			else
				help_button.show
			end
		end

	number_of_lines (a_message: STRING): INTEGER is
			-- Number of lines in the message
		do
			Result := a_message.occurrences ('%N') + 1
		end

	on_size (size_type: INTEGER; new_w, new_h: INTEGER) is
			-- When dialog is resized, the children need to be
			-- resized, if allowed, and repositioned.
		do
			if not fixed_size_flag then
				resize_children
			end
			reposition_children
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Redraw the icon if it exists.
		do
			if icon /= Void then
				paint_dc.draw_icon (icon, 2 * Dialog_unit, 2 * Dialog_unit)
			end
		end

	on_set_focus is
			-- Focus on default.
		do
			determine_focus
		end

	button_width (a_label: STRING): INTEGER is
			-- The width of a button in pixels with label `a_label'
		do
			Result := text_width (a_label, button_font) + 7 * Dialog_unit
		end

	button_height: INTEGER is
			-- The width of a button in pixels with label `a_label'
		do
			Result := text_height ("Y", button_font) + 2 * Dialog_unit
		end

	text_width (a_text: STRING; a_font: FONT): INTEGER is
			-- Width of a text using font `a_font' on control `a_control'.
		local
			a_font_windows: FONT_IMP
		do
			a_font_windows ?= a_font.implementation
			Result := a_font_windows.string_width (Current, a_text)
		end

	adjust_dialog is
			-- Adjust the dialog to reflect the changes.
		local
			valid_height: INTEGER
			valid_width: INTEGER
		do
			if not fixed_size_flag then
				resize_children
			end
			valid_width := ((dialog_width + shell_width).min
				(Maximum_window_width)).max (Minimum_window_width)
			valid_height := ((dialog_height + shell_height).min
				(Maximum_window_height)).max (Minimum_window_height)
			resize (valid_width ,valid_height)
			reposition_children
			update_visibility
			set_default_button
		end

	unset_default_button_style (a_button: WEL_PUSH_BUTTON) is
			-- Unset the default button style for `a_button'.
		do
			cwin_send_message (a_button.item, Bm_setstyle,
				Bs_pushbutton, cwin_make_long (1, 0))
		end

	set_default_button_style (a_button: WEL_PUSH_BUTTON) is
			-- Set the default button style for `a_button'.
		do
			cwin_send_message (a_button.item, Bm_setstyle,
				Bs_defpushbutton, cwin_make_long (1, 0))
		end

	set_position is
			-- set `x' and `y' according to
			-- it's parent or default.
		require
			exists: exists
		do
			if default_position then
				if parent /= Void and then parent.exists then
					wel_move (parent.real_x + ((parent.wel_width - wel_width) // 2),
						parent.real_y + (parent.wel_height - wel_height) // 2)
				else
					wel_move (((Maximum_window_width - wel_width) // 2),
						(Maximum_window_height - wel_height) // 2)
				end
			end
		end

	Maximum_window_width: INTEGER is
			-- Width of the client area for a full-screen window
		once
			Result := full_screen_client_area_width
		end

	Maximum_window_height: INTEGER is
			-- Height of the client area for a full-screen window
		once
			Result := full_screen_client_area_height
		end

	Minimum_window_width: INTEGER is
			-- Minimum width of a window
		once
			Result := window_minimum_width
		end

	Minimum_window_height: INTEGER is
			-- Minimum height of a window
		once
			Result := window_minimum_height
		end

	Default_button_style: INTEGER is
			-- Style of a default button
		once
			Result := Ws_visible + Ws_child +
				Ws_group + Ws_tabstop + Bs_defpushbutton
		end

	Button_style: INTEGER is
			-- Style of a regular button
		once
			Result := Ws_visible + Ws_child +
				Ws_group + Ws_tabstop + Bs_pushbutton
		end

	default_style: INTEGER is
			-- Default style of a dialog
		do
			Result := Ws_caption + Ws_popup
		end

	default_ex_style: INTEGER is
			-- Default extended style of a dialog
		do
			Result := Ws_ex_dlgmodalframe
		end

feature {NONE} -- Inapplicable

	build is
		do
		end

end -- class STANDARD_DIALOG_WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

