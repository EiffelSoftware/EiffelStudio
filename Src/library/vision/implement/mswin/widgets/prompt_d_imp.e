indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	PROMPT_D_IMP

inherit
	STANDARD_DIALOG_WINDOWS
		rename
			set_font_on_buttons as set_font_on_default_buttons,
			create_buttons as create_default_buttons,
			update_visibility as standard_update_visibility
		redefine
			on_control_id_command,
			on_key_down,
			class_name
		end

	STANDARD_DIALOG_WINDOWS
		redefine
			create_buttons,
			on_control_id_command,
			on_key_down,
			class_name,
			update_visibility,
			set_font_on_buttons
		select
			create_buttons,
			set_font_on_buttons,
			update_visibility
		end

	PROMPT_D_I
		rename
			forbid_recompute_size as forbid_resize,
			allow_recompute_size as allow_resize
		end

creation
	make

feature {NONE} -- Initialization

	make (a_prompt_dialog: PROMPT_D; oui_parent: COMPOSITE) is
			-- Initialization of message box
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			set_default_attributes
			a_prompt_dialog.set_dialog_imp (Current)
			managed  := True
			shell_height := title_bar_height + 2 * dialog_window_frame_height +
				window_border_height + window_frame_height
			shell_width := 2 * window_frame_width
			max_width := full_screen_client_area_width 
			max_height := full_screen_client_area_height
			default_position := True
		end

feature -- Status report

	selection_text: STRING is
			-- Text in the selection edit
		do
			if exists and then selection_edit /= Void and then selection_edit.exists then
				Result := selection_edit.text
			else
				Result := the_selection_text
			end
		end

feature -- Status setting

	 hide_apply_button is
			-- Hide the `apply_button'.
		do
			if exists and then not apply_button_hidden then
				apply_button.hide
				apply_button_hidden:= True
				adjust_dialog
			else
				apply_button_hidden := True
			end
		ensure then
			hidden: apply_button_hidden
			exists_implies_not_shown: exists implies not apply_button.shown
		end

	show_apply_button is
			-- Show the `apply_button'.
		do
			if exists and then apply_button_hidden then
				apply_button.show
				apply_button_hidden := False
				adjust_dialog
			else
				apply_button_hidden := False
			end
		ensure then
			button_not_hidden: not apply_button_hidden
			exists_implies_shown: exists implies apply_button.shown
		end

feature -- Element change

	add_apply_action (c: COMMAND; a: ANY) is
			-- Add command `c' to `apply_button'
		do
			apply_actions.add (Current, c, a)
		end

	set_selection_text (s: STRING) is
			-- Set text for `selection_edit'
		do
			the_selection_text := clone (s)
			if exists then
				selection_edit.set_text (s)
			end
		end

	set_apply_label (s: STRING) is
			-- Replace the text on the `apply_button' with `s'
		do
			if exists then
				apply_label := clone (s)
				apply_button.set_text (apply_label)
				if not apply_button_hidden then
					adjust_dialog
				end
			else
				apply_label := clone (s)
			end
		ensure then
			apply_label_is_equal_to_s: apply_label.is_equal (s)
		end

	set_selection_label (s: STRING) is
			-- Set the text for the `selection_label'.
		require else
			s_not_void: s /= Void
		do
			selection_label := clone (s)
			if exists then
				set_text_on_control (s, selection_static)
			end
		end

	set_label_font (a_font: FONT) is
			-- Set the font for the `selection_label'.
		do
			label_font := a_font
			if exists then
				set_font_on_label
				adjust_dialog
			end
		end

feature -- Removal

	remove_apply_action (c: COMMAND; a: ANY) is
			-- Remove command `c' from `apply_button'
		do
			apply_actions.remove (Current, c, a)
		end

feature {NONE} -- Implementation

	label_font: FONT
			-- Font for the `selection_static'

	selection_label: STRING
			-- Selection label

	the_selection_text: STRING
			-- Selection edit text

	apply_button: WEL_PUSH_BUTTON
			-- Apply button

	apply_button_hidden: BOOLEAN
			-- Is the `apply_button' hiddden?

	apply_label: STRING
			-- Label for `apply_button'

	apply_id: INTEGER is 4
			-- Id for `apply_button'.

	selection_edit_id: INTEGER is 4001
			-- Id for `selection_edit'

	selection_static: WEL_STATIC
			-- Static for label

	selection_edit: WEL_SINGLE_LINE_EDIT
			-- Edit control

	Minimum_width: INTEGER is 100
			-- Minimum width of dialog

	Minimum_height: INTEGER is 100
			-- Minimum height of dialog

	set_font_on_buttons is
			-- Set the font on the buttons.
		require else
			button_font_not_void: button_font /= Void
		local
			windows_font: FONT_IMP
		do
			windows_font ?= button_font.implementation
			set_font_on_default_buttons
			apply_button.set_font (windows_font.wel_font)
		end

	set_font_on_text is
			-- Set the font on the `selection_edit'
		require else
			text_font_not_void: text_font /= Void
		local
			windows_font: FONT_IMP
		do
			windows_font ?= text_font.implementation
			selection_edit.set_font (windows_font.wel_font)
		end

	total_buttons_width: INTEGER is
			-- Total width of the buttons.
		local
			number_of_buttons_shown: INTEGER
		do
			if not ok_button_hidden then
				number_of_buttons_shown := number_of_buttons_shown + 1
				Result := ok_button.width
			end
			if not cancel_button_hidden then
				number_of_buttons_shown := number_of_buttons_shown + 1
				Result := Result + cancel_button.width
			end
			if not help_button_hidden then
				number_of_buttons_shown := number_of_buttons_shown + 1
				Result := Result + help_button.width
			end
			if not apply_button_hidden then
				number_of_buttons_shown := number_of_buttons_shown + 1
				Result := Result + apply_button.width
			end
			if number_of_buttons_shown /= 0 then
				Result := Result + (number_of_buttons_shown + 3) * Dialog_unit
			else
				Result := Result + 4 * Dialog_unit
			end
		end

	set_font_on_label is
			-- Set the font on the `selection_label'.
		require else
			label_font_not_void: label_font /= Void
		local
			windows_font: FONT_IMP
		do
			windows_font ?= label_font.implementation
			selection_static.set_font (windows_font.wel_font)
		end

	dialog_width: INTEGER is
			-- Width of the dialog
		do
			Result := total_buttons_width.max (label_width.max (Minimum_width))
		ensure then
			result_greater_equal_minimum: Result >= Minimum_width
		end

	label_width: INTEGER is
			-- Width of the label
		do
			Result := text_width (selection_label, label_font) + 4 * Dialog_unit
		end

	label_height: INTEGER is
			-- Height of the `selection_label'
		do
			if the_selection_text /= Void then
				Result := text_height (selection_label, label_font) +
					2 * Dialog_unit
			end
		end

	dialog_height: INTEGER is
			-- Height of the dialog
		do
			Result := (selection_edit.height + button_height +
				label_height + 6 * Dialog_unit).max (minimum_height)
		end

	reposition_children is
			-- Move the children if necessary.
		require else
			exists: exists
		do
			reposition_buttons
			reposition_selection_edit
			reposition_selection_label
			set_text_on_control (selection_label, selection_static)
		end

	determine_focus is
			-- Focus on the default
		do
			selection_edit.set_focus
		end

	reposition_selection_label is
			-- Reposition the and resize `selection_edit'
		require
			selection_static_not_void: selection_static /= Void
		do
			selection_static.move_and_resize (2 * Dialog_unit, 2 * Dialog_unit,
				client_rect.width - 4 * Dialog_unit, selection_static.height, True)
		end

	reposition_selection_edit is
			-- Reposition and resize the `selection_label'
		require
			selection_edit_not_void: selection_edit /= Void
		do
			selection_edit.move_and_resize (2 * Dialog_unit,
				selection_static.height + 2 * Dialog_unit, 
				client_rect.width - 4 * Dialog_unit,
				selection_edit.height, True)
		end

	reposition_buttons is
			-- Move the buttons if necessary.
		require else
			ok_button_exists: ok_button.exists
			cancel_button_exists: cancel_button.exists
			help_button_exists: help_button.exists
			apply_button_exists: apply_button.exists
			exists: exists
		local
			width_used: INTEGER
			b_height: INTEGER
		do
			b_height := button_height
			width_used := (client_rect.width - total_buttons_width) // 2 + 2 * Dialog_unit
			if not ok_button_hidden then
				ok_button.move (width_used, client_rect.height - b_height - 2 * Dialog_unit)
				width_used := width_used + ok_button.width + Dialog_unit
			end
			if not apply_button_hidden then
				apply_button.move (width_used, client_rect.height - b_height - 2 * Dialog_unit)
				width_used := width_used + apply_button.width + Dialog_unit
			end
			if not cancel_button_hidden then
				cancel_button.move (width_used, client_rect.height - b_height - 2 * Dialog_unit)
				width_used := width_used + cancel_button.width + Dialog_unit
			end
			if not help_button_hidden then
				help_button.move (width_used, client_rect.height - b_height - 2 * Dialog_unit)
				width_used := width_used + help_button.width + Dialog_unit
			end
		end

	resize_buttons is
			-- Resize the buttons according to the button
			-- which is visible and has the largest label.
		require else
			ok_button_exists: ok_button.exists
			cancel_button_exists: cancel_button.exists
			help_button_exists: help_button.exists
			apply_button_exists: apply_button.exists
			exists: exists
		local
			maximum_width: INTEGER
			help_width: INTEGER
			cancel_width: INTEGER
			ok_width: INTEGER
			apply_width: INTEGER
			b_height: INTEGER
		do
			if not apply_button_hidden then
				apply_width := button_width (apply_label)
			end
			if not ok_button_hidden then
				ok_width := button_width (ok_label)
			end
			if not cancel_button_hidden then
				cancel_width := button_width (cancel_label)
			end
			if not help_button_hidden then
				help_width := button_width (help_label)
			end
			maximum_width := ok_width.max (cancel_width.max (help_width.max (apply_width)))
			b_height := button_height
			ok_button.resize (maximum_width.min (Maximum_window_width),
				b_height.min (Maximum_window_height))
			cancel_button.resize (maximum_width.min (Maximum_window_width),
				b_height.min (Maximum_window_height))
			help_button.resize (maximum_width.min (Maximum_window_width),
				b_height.min (Maximum_window_height))
			apply_button.resize (maximum_width.min (Maximum_window_width),
				b_height.min (Maximum_window_height))
		end

	resize_selection_label is
			-- Resize the `selection_static'.
		do
			selection_static.resize (label_width.min (Maximum_window_width),
				label_height.min (Maximum_window_height))
		end

	resize_selection_edit is
			-- Resize the `selection_edit'
		do
			selection_edit.resize (selection_edit_width.min (Maximum_window_width),
				selection_edit_height.min (Maximum_window_height))
		end

	selection_edit_width: INTEGER is
			-- Width of the `selection_edit'
		local
			s: STRING
		do
			s := selection_text
			Result := (text_width (s, text_font)).max (Minimum_width)
		end

	selection_edit_height: INTEGER is
			-- Height of the `selection_edit'
		do
			Result := text_height ("Y", text_font) + Dialog_unit
		end

	update_visibility is
			-- Update visibilty of buttons
		do
			standard_update_visibility
			if apply_button_hidden then
				apply_button.hide
			else
				apply_button.show
			end
		end

	resize_children is
			-- Resize the children if necessary.
		do
			resize_buttons
			resize_selection_label
			resize_selection_edit
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Perform the "ok action" when user
			-- hits return key.
		do
			if virtual_key = Vk_return then
				ok_actions.execute (Current, Void)
				disable_default_processing
			end
		end

	on_control_id_command (an_id: INTEGER) is
		do
			inspect
				an_id
			when ok_id then
				ok_actions.execute (Current, Void)
			when cancel_id then
				cancel_actions.execute (Current, Void)
			when help_id then
				help_actions.execute (Current, Void)
			when apply_id then
				apply_actions.execute (Current, Void)
			when selection_edit_id then
				the_selection_text := selection_text
			else
			end
		end

	set_default_attributes is
			-- Set the attributes before creation
		local
			default_font: FONT
			default_windows_font: FONT_IMP
			wel_ansi_font: WEL_ANSI_VARIABLE_FONT
		do
			!! default_font.make
			!! wel_ansi_font.make
			default_windows_font ?= default_font.implementation
			default_windows_font.make_by_wel (wel_ansi_font)
			set_button_font (default_font)
			set_text_font (default_font)
			set_label_font (default_font)
			default_button_id := ok_id
			ok_label := "Ok"
			cancel_label := "Cancel"
			help_label := "Help"
			apply_label := "Apply"
			show_ok_button
			show_cancel_button
			show_help_button
			show_apply_button
			selection_label := "Selection"
			private_title := "Prompt"
			default_position := true
			alignment := Left_alignment
		end

	create_buttons is
			-- Create the buttons and hide them if necessary.
		do
			!! apply_button.make (Current, apply_label, 0, 0, 0, 0, apply_id)
			create_default_buttons
		end

	create_controls is
			-- Create the controls for this dialog.
		local
			a_dc: WEL_CLIENT_DC
			local_color: WEL_COLOR_REF
		do
			if the_selection_text = Void then
				the_selection_text := ""
			end
			!! selection_edit.make (Current, the_selection_text, 0, 0, 0, 0, selection_edit_id)
			!! selection_static.make (Current, "", 0, 0, 0, 0, 0)
			!! a_dc.make (selection_static)
			a_dc.get
			!! local_color.make_system (Color_window)
			a_dc.set_background_color (local_color)
			a_dc.release
			if selection_label = Void then
				!! selection_label.make (0)
			end
			set_selection_label (selection_label)
		end

	set_default_button is
			-- Set the default button for the dialog.
		local
			default_button_set: BOOLEAN
		do
			if ok_button_hidden then
				unset_default_button_style (ok_button)
			else
				set_default_button_style (ok_button)
				default_button_set := True
			end
			if not cancel_button_hidden and then not default_button_set then
				set_default_button_style (cancel_button)
				default_button_set := True
			else
				unset_default_button_style (cancel_button)
			end
			if not help_button_hidden and then not default_button_set then
				set_default_button_style (help_button)
				default_button_set := True
			else
				unset_default_button_style (help_button)
			end
			if not apply_button_hidden and then not default_button_set then
				set_default_button_style (apply_button)
			else
				unset_default_button_style (apply_button)
			end
		end

	set_fonts is
			-- Set the font's on the controls.
		do
			set_button_font (button_font)
			set_text_font (text_font)
			set_label_font (label_font)
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionPromptDialog"
		end

end -- PROMPT_D_IMP



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

