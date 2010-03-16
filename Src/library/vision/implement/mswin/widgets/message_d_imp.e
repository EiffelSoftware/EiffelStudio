note
	description: "This class represents a MS_IMPmessage dialog box"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MESSAGE_D_IMP

inherit
	WEL_IDI_CONSTANTS
		export
			{NONE} all
		end

	STANDARD_DIALOG_WINDOWS
		redefine
			on_control_id_command,
			class_name
		end

	MESSAGE_D_I
		rename
			forbid_recompute_size as forbid_resize,
			allow_recompute_size as allow_resize
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_message: MESSAGE_D; oui_parent: COMPOSITE)
			-- Initialize a message box.
		do
			create private_attributes
			parent ?= oui_parent.implementation
			private_title := a_message.identifier
			check
				valid_parent: parent /= Void
			end
			set_default_attributes
			a_message.set_dialog_imp (Current)
			shell_height := title_bar_height + 2 * dialog_window_frame_height +
				window_border_height + window_frame_height
			shell_width := 2 * window_frame_width
			max_width := full_screen_client_area_width
			max_height := full_screen_client_area_height
			managed := True
			default_position := True
		end

feature -- Element change

	set_message (s: STRING)
			-- Set the message in the dialog.
		require else
			message_not_void: s /= Void
		do
			message := s.twin
			if exists then
				set_text_on_control (message, message_static)
				adjust_dialog
			end
		ensure then
			message_is_equal_to_s: message.is_equal (s)
		end
feature -- Update display

	update_display
			-- No implementation on windows, because
			-- display is updated automatically
		do
		end

feature {NONE} -- implementation

	message: STRING
			-- The message text

	message_static: WEL_STATIC
			-- The message

	create_controls
			-- Create the controls for the dialog.
		local
			a_dc: WEL_CLIENT_DC
			local_color: WEL_COLOR_REF
		do
			create message_static.make (Current, "", 0, 0, 0, 0, 0)
			if message = Void then
				create message.make (0)
			end
			create a_dc.make (message_static)
			a_dc.get
			create local_color.make_system (Color_window)
			a_dc.set_background_color (local_color)
			a_dc.release
			set_message (message)
		end

	set_fonts
			-- Set the fonts on the controls.
		require else
			button_font_not_void: button_font /= Void
			text_font_not_void: text_font /= Void
		do
			set_button_font (button_font)
			set_text_font (text_font)
		end

	set_font_on_text
			-- Set the font on the message.
		local
			windows_font: FONT_IMP
		do
			windows_font ?= text_font.implementation
			message_static.set_font (windows_font.wel_font)
			message_static.invalidate
		end

	total_buttons_width: INTEGER
			-- The width of the visible buttons plus
			-- the offset to the sides of the dialog
			-- plus the possible offset between the buttons.
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
			if number_of_buttons_shown /= 0 then
				Result := Result + (number_of_buttons_shown + 3) * Dialog_unit
			else
				Result := Result + 4 * Dialog_unit
			end
		end

	message_width: INTEGER
			-- The width of the message plus the offset
			-- to the side of the dialog and the icon.
		do
			Result := text_width (message, text_font) + 4 * Dialog_unit
		end

	message_icon_width: INTEGER
			-- The width of the icon and the message.
		do
			if icon /= Void then
				Result := icon_width + 2 * Dialog_unit
			end
			Result := Result + message_width
		end

	reposition_message
			-- Reposition the message if necessary.
		local
			xx: INTEGER
			possible_width: INTEGER
		do
			if icon = Void then
				xx := 2 * Dialog_unit
				possible_width := client_rect.width - 4 * Dialog_unit
			else
				xx := 4 * Dialog_unit + icon_width
				possible_width := client_rect.width - 6 * Dialog_unit - icon_width
			end
			message_static.move_and_resize (xx, 2 * Dialog_unit,
				possible_width.min (Maximum_window_width),
				message_height, True)
		end

	resize_children
			-- Resize the children if necessary.
		do
			resize_buttons
			resize_message
		end

	resize_message
			-- Resize the message if necessary.
		require
			resize_allowed: not fixed_size_flag
		do
			message_static.resize (message_width.min (Maximum_window_width),
				message_height.min (Maximum_window_height))
		end

	on_control_id_command (an_id: INTEGER)
			-- Perform corresponding command
		do
			inspect
				an_id
			when ok_id then
				ok_actions.execute (Current, Void)
			when cancel_id then
				cancel_actions.execute (Current, Void)
			when help_id then
				help_actions.execute (Current, Void)
			else
			end
		end

	message_height: INTEGER
			-- The height of the message plus the offset
			-- to the top of the dialog and the buttons.
		do
			Result := text_height (message, text_font) +
				2 * Dialog_unit
		end

	dialog_width: INTEGER
			-- Width of the dialog
		do
			if icon /= Void then
				Result := total_buttons_width.max (message_icon_width.max (55)) + shell_width
			else
				Result := total_buttons_width.max (message_width.max (55)) + shell_width
			end
		end

	dialog_height: INTEGER
			-- Height of the dialog
		do
			if icon /= Void then
				Result := icon_height.max (message_height) +
					shell_height + button_height + Dialog_unit
			else
				Result := message_height + shell_height +
					button_height
			end
		end

	reposition_children
			-- Move the children if necessary.
		do
			reposition_message
			reposition_buttons
			determine_focus
			set_text_on_control (message, message_static)
		end

	determine_focus
			-- Focus on the default button.
		local
			focus_set: BOOLEAN
		do
			if not ok_button_hidden then
				if flag_set (ok_button.style, Bs_defpushbutton) then
					ok_button.set_focus
					focus_set := True
				end
			end
			if not focus_set and then not cancel_button_hidden then
				if flag_set (cancel_button.style, Bs_defpushbutton) then
					cancel_button.set_focus
					focus_set := True
				end
			end
			if not focus_set and then not help_button_hidden then
				 if flag_set (help_button.style, Bs_defpushbutton) then
					help_button.set_focus
				end
			end
		end

	set_default_button
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
			else
				unset_default_button_style (help_button)
			end
		end

	reposition_buttons
			-- Move the buttons if necessary.
		require else
			ok_button_exists: ok_button.exists
			cancel_button_exists: cancel_button.exists
			help_button_exists: help_button.exists
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
			if not cancel_button_hidden then
				cancel_button.move (width_used, client_rect.height - b_height - 2 * Dialog_unit)
				width_used := width_used + cancel_button.width + Dialog_unit
			end
			if not help_button_hidden then
				help_button.move (width_used, client_rect.height - b_height - 2 * Dialog_unit)
			end
		end

	resize_buttons
			-- Resize the buttons according to the button
			-- which is visible and has the largest label.
		require else
			ok_button_exists: ok_button.exists
			cancel_button_exists: cancel_button.exists
			help_button_exists: help_button.exists
		local
			maximum_width: INTEGER
			help_width: INTEGER
			cancel_width: INTEGER
			ok_width: INTEGER
			b_height: INTEGER
		do
			if not ok_button_hidden then
				ok_width := button_width (ok_label)
			end
			if not cancel_button_hidden then
				cancel_width := button_width (cancel_label)
			end
			if not help_button_hidden then
				help_width := button_width (help_label)
			end
			maximum_width := ok_width.max (cancel_width.max (help_width))
			b_height := button_height
			ok_button.resize (maximum_width.min (Maximum_window_width),
				b_height.min (Maximum_window_height))
			cancel_button.resize (maximum_width.min (Maximum_window_width),
				b_height.min (Maximum_window_height))
			help_button.resize (maximum_width.min (Maximum_window_width),
				b_height.min (Maximum_window_height))
		end

	set_default_attributes
			-- Set the attributes before creation
		local
			default_font: FONT
			default_windows_font: FONT_IMP
			wel_ansi_font: WEL_ANSI_VARIABLE_FONT
		do
			default_button_id := ok_id
			create default_font.make
			create wel_ansi_font.make
			default_windows_font ?= default_font.implementation
			default_windows_font.make_by_wel (wel_ansi_font)
			set_button_font (default_font)
			set_text_font (default_font)
			ok_label := "Ok"
			cancel_label := "Cancel"
			help_label := "Help"
			show_ok_button
			show_cancel_button
			show_help_button
			create message.make (0)
			alignment := Left_alignment
			default_position := true
		end

	class_name: STRING_32
			-- Class name
		once
			Result := "EvisionMessageDialog"
		end

feature {NONE} -- Inapplicable

	label_font: FONT
			-- Font specified for labels
		do
		end

	set_label_font (a_font: FONT)
			-- Set font of every labels to `a_font_name'.
		do
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




end -- MESSAGE_D_IMP

