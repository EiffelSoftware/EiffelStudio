indexing
	description: "[
		A dialog prompt base, to inform the user or to ask them as question.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_PROMPT

inherit
	ES_DIALOG
		rename
			make as make_dialog
		export
			{NONE} set_is_modal, is_modal, icon
		redefine
			dialog_border_width,
			is_size_and_position_remembered,
			on_before_show,
			on_handle_key
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_text: like text; a_buttons: like buttons; a_default: like default_button; a_default_confirm: like default_confirm_button; a_default_cancel: like default_cancel_button)
			-- Initialize a prompt using required information
			--
			-- `a_text': The text to display on the prompt; empty or void to display none
			-- `a_buttons': A list of button ids corresponding created from {ES_DIALOG_BUTTONS}.
			-- `a_default': The prompt's default active button.
			-- `a_default_confirm': The prompt's default confirmation button (selected using CTRL+ENTER).
			-- `a_default_cancel': The prompt's default cancel button (selected using ESC).
		require
			a_text_attached: a_text /= Void
			a_buttons_attached: a_buttons /= Void
			not_a_buttons_is_empty: not a_buttons.is_empty
			a_buttons_contains_valid_ids: a_buttons.for_all (agent dialog_buttons.is_valid_button_id)
			a_buttons_contains_a_default: a_buttons.has (a_default)
			a_buttons_contains_a_default_confirm: a_buttons.has (a_default_confirm)
			a_buttons_contains_a_default_cancel: a_buttons.has (a_default_cancel)
		local
			l_init: BOOLEAN
		do
			l_init := is_initializing
			is_initializing := True

			buttons := a_buttons

				-- Set default buttons
			set_default_button (a_default)
			set_default_confirm_button (a_default_confirm)
			set_default_cancel_button (a_default_cancel)

			make_dialog

			set_text (a_text)

				-- Prompts cannot be resized (can't do it here, there's a bug in EiffelVision2)
			--dialog.disable_user_resize

			is_initializing := l_init
		ensure
			text_set: format_text (a_text).is_equal (text)
			default_button_set: default_button = a_default
			buttons_set: buttons = a_buttons
		end

	make_standard (a_text: like text)
			-- Initialize a standard warning prompt using required information.
			--
			-- `a_text': The text to display on the prompt.
		require
			a_text_attached: a_text /= Void
		do
			make (a_text, standard_buttons, standard_default_button, standard_default_confirm_button, standard_default_cancel_button)
		ensure
			text_set: format_text (a_text).is_equal (text)
			default_button_set: default_button = standard_default_button
			buttons_set: buttons = standard_buttons
		end

feature {NONE} -- User interface initialization

	frozen build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			l_vbox, l_container: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			l_icon: EV_PIXMAP
			l_large_icon: EV_PIXEL_BUFFER
			l_can_lock: BOOLEAN
		do
			create l_vbox
			create l_hbox
			create l_container

			a_container.set_background_color (colors.prompt_banner_color)

				-- Prompt icon
			l_large_icon := large_icon
			create l_icon.make_with_size (l_large_icon.width, l_large_icon.height)
			l_icon.set_background_color (colors.prompt_banner_color)
			l_icon.clear
			l_icon.draw_sub_pixel_buffer (0, 0, l_large_icon, create {EV_RECTANGLE}.make (0, 0, l_large_icon.width, l_large_icon.height))
			l_icon.set_minimum_size (l_large_icon.width, l_large_icon.height)
			l_vbox.extend (l_icon)
			l_vbox.disable_item_expand (l_icon)

				-- Box for icon with room for expansion
			l_hbox.set_padding ({ES_UI_CONSTANTS}.prompt_horizontal_icon_spacing)
			l_hbox.extend (l_vbox)
			l_hbox.disable_item_expand (l_vbox)

			l_container.set_padding ({ES_UI_CONSTANTS}.prompt_vertical_padding)
			l_hbox.extend (l_container)

				-- Build prompt interface
			build_prompt_interface (l_container)

				-- Create padding for right of prompt
			create l_cell
			l_cell.set_minimum_width (25)
			l_hbox.extend (l_cell)
			l_hbox.disable_item_expand (l_cell)

			a_container.extend (l_hbox)
			a_container.parent.extend (create {EV_HORIZONTAL_SEPARATOR})
			l_vbox ?= a_container.parent
			check l_vbox_attached: l_vbox /= Void end
			if l_vbox /= Void then
				l_vbox.disable_item_expand (l_vbox.last)
			end

			l_can_lock := (ev_application.locked_window = Void)

			if internal_dialog /= Void and l_can_lock then
				internal_dialog.lock_update
			end
			propagate_prompt_background_color (a_container, colors.prompt_banner_color)
			if internal_dialog /= Void and l_can_lock then
				internal_dialog.unlock_update
			end
		end

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		require
			a_container_attached: a_container /= Void
			not_a_container_is_destoryed: not a_container.is_destroyed
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		do
				-- Prompt sub title
			create prompt_sub_title_label.make
			prompt_sub_title_label.align_text_left
			prompt_sub_title_label.set_font (fonts.prompt_sub_title_font)
			prompt_sub_title_label.set_foreground_color (colors.prompt_sub_title_foreground_color)
			prompt_sub_title_label.set_is_text_wrapped (True)
			prompt_sub_title_label.hide

				-- Prompt text
			create prompt_text.make
			prompt_text.align_text_left
			prompt_text.set_font (fonts.prompt_text_font)
			prompt_text.set_foreground_color (colors.prompt_text_foreground_color)
			prompt_text.set_is_text_wrapped (True)
			prompt_text.hide

				-- Extend widgets
			a_container.extend (prompt_sub_title_label)
			a_container.disable_item_expand (prompt_sub_title_label)
			a_container.extend (prompt_text)
			a_container.disable_item_expand (prompt_text)
		ensure
			prompt_sub_title_label_attached: prompt_sub_title_label /= Void
			prompt_text_attached: prompt_text /= Void
		end

feature -- Access

	title: STRING_32 assign set_title
			-- The prompt's dialog title
		do
			Result := dialog.title
			if Result = Void then
				create Result.make_empty
			end
		end

	sub_title: STRING_32 assign set_sub_title
			-- The prompt's sub text
		do
			Result := prompt_sub_title_label.text
			if Result = Void then
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	text: STRING_32 assign set_text
			-- The prompt's main text
		do
			Result := prompt_text.text
			if Result = Void then
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.

	default_button: INTEGER assign set_default_button
			-- The dialog's default action button

	default_confirm_button: INTEGER assign set_default_confirm_button
			-- The dialog's default confirm button

	default_cancel_button: INTEGER assign set_default_cancel_button
			-- The dialog's default cancel button

feature {NONE} -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's large icon, shown on the left
		do
			Result := large_icon
		end

	large_icon: EV_PIXEL_BUFFER
			-- The dialog's large icon, shown on the left
		deferred
		ensure
			result_attached: Result /= Void
		end

	standard_buttons: DS_HASH_SET [INTEGER]
			-- Standard set of buttons for a current prompt
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent dialog_buttons.is_valid_button_id)
		end

	standard_default_button: INTEGER
			-- Standard buttons `standard_buttons' default button
		deferred
		ensure
			result_is_valid_button_id: dialog_buttons.is_valid_button_id (Result)
			standard_buttons_contains_result: standard_buttons.has (Result)
		end

	standard_default_confirm_button: INTEGER
			-- Standard buttons `standard_buttons' default confirm button
		deferred
		ensure
			result_is_valid_button_id: dialog_buttons.is_valid_button_id (Result)
			standard_buttons_contains_result: standard_buttons.has (Result)
		end

	standard_default_cancel_button: INTEGER
			-- Standard buttons `standard_buttons' default cancel button
		deferred
		ensure
			result_is_valid_button_id: dialog_buttons.is_valid_button_id (Result)
			standard_buttons_contains_result: standard_buttons.has (Result)
		end

	dialog_border_width: INTEGER
			-- Dialog border width
		do
			Result := {ES_UI_CONSTANTS}.prompt_border
		end

feature -- Element change

	set_title (a_text: like title)
			-- Sets prompt's title text.
			--
			-- `a_text': Window title to set on the prompt.
		require
			a_text_attached: a_text /= Void
		do
			dialog.set_title (a_text)
		ensure
			title_set: a_text.is_equal (title)
		end

	set_text (a_text: like text)
			-- Sets prompt's main text.
			--
			-- `a_text': Text to set on the prompt.
		require
			a_text_attached: a_text /= Void
		do
			set_label_text (prompt_text, a_text)
		ensure
			text_set: format_text (a_text).is_equal (text)
			prompt_text_label_visible_respected: prompt_text.is_show_requested = not a_text.is_empty
		end

	set_sub_title (a_text: like sub_title)
			-- Sets prompt's sub text.
			--
			-- `a_text': Sub title text to set on the prompt
		require
			a_text_attached: a_text /= Void
		do
			set_label_text (prompt_sub_title_label, a_text)
		ensure
			sub_title_set: a_text.is_equal (sub_title)
			prompt_sub_title_label_visible_respected: prompt_sub_title_label.is_show_requested = not a_text.is_empty
		end

	set_default_button (a_id: INTEGER)
			-- Sets prompt's default button.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_contains_a_id: buttons.has (a_id)
		do
			default_button := a_id
			if is_initialized then
				dialog.set_default_push_button (dialog_window_buttons.item (a_id))
			end
		ensure
			default_button_set: default_button = a_id
		end

	set_default_confirm_button (a_id: INTEGER)
			-- Sets prompt's default confirmation button (when CTRL+ENTER is pressed).
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_contains_a_id: buttons.has (a_id)
		do
			default_confirm_button := a_id
		ensure
			default_confirm_button_set: default_confirm_button = a_id
		end

	set_default_cancel_button (a_id: INTEGER)
			-- Sets prompt's default cancel button (when ESC is pressed).
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_contains_a_id: buttons.has (a_id)
		do
			default_cancel_button := a_id
			if is_initialized then
				dialog.set_default_cancel_button (dialog_window_buttons.item (a_id))
			end
		ensure
			default_cancel_button_set: default_cancel_button = a_id
		end

feature {NONE} -- Element change

	set_label_text (a_label: EVS_LABEL; a_text: like text)
			-- Sets a wrappable/expandable label's text and adjusts the dialog's position to account for the change
			-- in position.
			--
			-- `a_label': Label widget to set text on.
			-- `a_text': The text to set.
		require
			is_interface_usable: is_interface_usable
			a_label_attached: a_label /= Void
			not_a_label_is_destroyed: not a_label.is_destroyed
			a_text_attached: a_text /= Void
		local
			l_old_width: INTEGER
			l_width: INTEGER
			l_old_height: INTEGER
			l_height: INTEGER
			l_x_offset: INTEGER
			l_y_offset: INTEGER
			l_dialog: like dialog
		do
			if a_text.is_empty then
				a_label.set_text ("")
				a_label.hide
			else
				if is_shown then
					l_old_width := dialog.width
					l_old_height := dialog.height
					a_label.set_maximum_width (maximum_prompt_text_width)
				end

					-- Set actul text
				a_label.set_text (format_text (a_text))

				if not a_label.is_displayed then
						-- Ensure the label is display
					a_label.show
				else
					a_label.hide

						-- Adjust prompt text widths to ensure they are not too big for the screen.
						-- This will cause long text to be wrapped.
					l_width := prompt_text.font.string_width (prompt_text.text)
					a_label.set_maximum_width (l_width.min (maximum_prompt_text_width))
					a_label.calculate_size
					a_label.refresh_now

					a_label.show

					l_dialog := dialog
					l_width := l_dialog.width
					l_height := l_dialog.height
					if l_old_width /= l_width then
							-- Calculate new X offset
						l_x_offset := ((l_old_width - l_width) / 2).floor
					end
					if l_old_height /= l_height then
							-- Calculate new Y offset
						l_y_offset := ((l_old_height - l_height) / 2).floor
					end
					if l_x_offset /= 0 then
						l_dialog.set_x_position (l_x_offset + l_dialog.x_position)
					end
				end
			end
		ensure
			text_set: format_text (a_text).is_equal (a_label.text)
			a_label_visible_respected: a_label.is_show_requested = not a_text.is_empty
		end

feature {NONE} -- Status report

	is_size_and_position_remembered: BOOLEAN
			-- Indicates if the size and position information is remembered for the dialog
		do
				-- Prompts should not remember size and position information.
			Result := False
		end

feature {NONE} -- Query

	can_propagate_background_color_to_widget (a_widget: EV_WIDGET): BOOLEAN
			-- Determines if a widget's background color can be altered as part of a background color propagation.
			--
			-- `a_widget': Widget to determine if a background color can be propagated to
			-- `Result': True to indicate the widget's background color can be changed, False otherwise.
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
			a_widget_attached: a_widget /= Void
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		local
			l_container: EV_CONTAINER
			l_label: EV_LABEL
			l_check: EV_CHECK_BUTTON
			l_radio: EV_RADIO_BUTTON
		do
			l_container ?= a_widget
			Result := l_container /= Void
			if not Result then
				l_label ?= a_widget
				Result := l_label /= Void
				if not Result then
					l_check ?= a_widget
					Result := l_check /= Void
					if not Result then
						l_radio ?= a_widget
						Result := l_radio /= Void
					end
				end
			end
		end

feature {NONE} -- Helpers

	frozen os_stock_pixmaps: EV_STOCK_PIXMAPS
			-- Operation system stock pixmaps
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- User interface elements

	prompt_sub_title_label: EVS_LABEL
			-- Label for prompts main text

	prompt_text: EVS_LABEL
			-- Label for prompts sub-text, if any

feature {NONE} -- Basic operations

	activate_button_using_key (a_key: EV_KEY)
			-- Attempts to perform the activation (selection) of a button using the key `a_key'
			--
			-- `a_key': An EiffelVision 2 key to act upon.
		local
			l_keys: EV_KEY_CONSTANTS
			l_buttons: DS_SET_CURSOR [INTEGER]
			l_dialog_buttons: like dialog_window_buttons
			l_button_id: INTEGER
			l_button: EV_BUTTON
			l_string: STRING_32
			l_text: STRING_32
			l_used_character: DS_ARRAYED_LIST [CHARACTER_32]
			l_count, i: INTEGER
			l_bc, c: CHARACTER_32
			l_stop: BOOLEAN
		do
			create l_keys
			if l_keys.valid_key_code (a_key.code) then
				l_string := l_keys.key_strings [a_key.code]
				if l_string.count = 1 then
					c := l_string.item (1).as_lower
					create l_used_character.make (buttons.count)

					l_buttons := buttons.new_cursor
					l_dialog_buttons := dialog_window_buttons
					from l_buttons.start until l_buttons.after or l_stop loop
							-- Locate button
						l_button_id := l_buttons.item
						l_button := l_dialog_buttons.item (l_button_id)
						check l_button_attached: l_button /= Void end

							-- Retrieve and search text
						l_text := l_button.text
						l_count := l_text.count
						from i := 1 until i > l_count or l_stop loop
							l_bc := l_text.item (i).as_lower
							if l_bc.is_character_8 and then l_bc.to_character_8.is_alpha_numeric then
								if not l_used_character.has (l_bc) then
										-- Usable character
									l_stop := l_bc = c
									if not l_stop then
										l_used_character.force_last (l_bc)
											-- Force exit in searching text, as we have found a usable character
										i := l_count
									end
								end
							end
							i := i + 1
						end
						l_buttons.forth
					end
					l_buttons.go_after
				end
			end

			if l_stop and then l_button /= Void then
				l_button.select_actions.call ([])
			end
		end

	move_to_previous_dialog_button
			-- Moves to a previous dialog button, if a dialog button has focus
		local
			l_buttons: DS_SET_CURSOR [INTEGER]
			l_dialog_buttons: like dialog_window_buttons
			l_button: EV_BUTTON
			l_prev_button: EV_BUTTON
			l_stop: BOOLEAN
			l_count: INTEGER
		do
			l_count := buttons.count
			if l_count > 1 then
				l_buttons := buttons.new_cursor
				l_dialog_buttons := dialog_window_buttons
				from l_buttons.start until l_buttons.after or l_stop loop
					l_prev_button := l_button
					l_button := l_dialog_buttons.item (l_buttons.item)
					if l_button.has_focus then
						l_stop := True
						if l_buttons.is_first then
							from until l_buttons.after loop
								l_button := l_dialog_buttons.item (l_buttons.item)
								l_buttons.forth
							end
						else
							l_button := l_prev_button
						end
						check l_button_attached: l_button /= Void end
						l_button.set_focus
					else
						l_buttons.forth
					end
				end
				l_buttons.go_after
			end
		end

	move_to_next_dialog_button
			-- Moves to a previous dialog button, if a dialog button has focus
		local
			l_buttons: DS_SET_CURSOR [INTEGER]
			l_dialog_buttons: like dialog_window_buttons
			l_button: EV_BUTTON
			l_first_button: EV_BUTTON
			l_stop: BOOLEAN
			l_count: INTEGER
		do
			l_count := buttons.count
			if l_count > 1 then
				l_buttons := buttons.new_cursor
				l_dialog_buttons := dialog_window_buttons
				from l_buttons.start until l_buttons.after or l_stop loop
					l_button := l_dialog_buttons.item (l_buttons.item)
					if l_buttons.is_first then
						l_first_button := l_button
					end
					if l_button.has_focus then
						l_stop := True
						l_buttons.forth
						if l_buttons.after then
							l_button := l_first_button
						else
							l_button := l_dialog_buttons.item (l_buttons.item)
						end
						check l_button_attached: l_button /= Void end
						l_button.set_focus
					else
						l_buttons.forth
					end
				end
				l_buttons.go_after
			end
		end

	propagate_prompt_background_color (a_source_widget: EV_WIDGET; a_color: EV_COLOR)
			-- Propagates a background color to a widget and any widgets contained within.
			-- Note: Propagation can be vetoed in `can_propagate_background_color_to_widget'.
			--
			-- `a_source_widget': Widget to propagate a background color to.
			-- `a_color': Color to propagate.
		require
			is_initialized: is_initialized or is_initializing
			is_recycled: not is_recycled
			a_source_widget_attached: a_source_widget /= Void
			not_a_source_widget_is_destroyed: not a_source_widget.is_destroyed
			a_source_widget_has_parent: a_source_widget.has_parent
			a_color_attached: a_color /= Void
			not_a_color_is_destroyed: not a_color.is_destroyed
		local
			l_widgets: EV_WIDGET_LIST
		do
			if can_propagate_background_color_to_widget (a_source_widget) then
				a_source_widget.set_background_color (a_color)
				l_widgets ?= a_source_widget
				if l_widgets /= Void then
					l_widgets.do_all (agent propagate_prompt_background_color (?, a_color))
				end
			end
		end

feature {NONE} -- Formatting

	format_text (a_text: STRING_32): STRING_32
			-- Format text to remove trailing new lines
		require
			a_text_attached: a_text /= Void
		do
			Result := a_text.twin
			if not Result.is_empty then
				Result.prune_all_trailing ('%N')
			end
		ensure
			result_attached: Result /= Void
			result_free_of_trailing_new_lines: not Result.is_empty implies Result.item (Result.count) /= '%N'
		end

feature {NONE} -- Action handlers

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN
			-- Called when the dialog recieve a key event
			--
			-- `a_key': The key pressed.
			-- `a_alt': True if the ALT key was pressed; False otherwise
			-- `a_ctrl': True if the CTRL key was pressed; False otherwise
			-- `a_shift': True if the SHIFT key was pressed; False otherwise
			-- `a_released': True if the key event pertains to the release of a key, False to indicate a press.
		do
			if a_released and not a_alt and not a_ctrl and not a_shift then
				Result := True
				inspect a_key.code
				when {EV_KEY_CONSTANTS}.key_left then
					move_to_previous_dialog_button
				when {EV_KEY_CONSTANTS}.key_right then
					move_to_next_dialog_button
				else
					activate_button_using_key (a_key)
					Result := not is_shown
				end
			end

			if not Result and then is_interface_usable then
				Result := Precursor {ES_DIALOG} (a_key, a_alt, a_ctrl, a_shift, a_released)
			end
		end

feature {NONE} -- Action handlers

	on_before_show
			-- Called prior to the dialog being shown
		local
			l_width: INTEGER
		do
			Precursor {ES_DIALOG}

				-- Adjust prompt text widths to ensure they are not too big for the screen.
				-- This will cause long text to be wrapped.
			l_width := prompt_text.font.string_width (prompt_text.text)
			prompt_text.set_maximum_width (l_width.min (maximum_prompt_text_width))
			prompt_text.calculate_size

			l_width := prompt_sub_title_label.font.string_width (prompt_sub_title_label.text)
			prompt_sub_title_label.set_maximum_width (l_width.min (maximum_prompt_text_width))
			prompt_sub_title_label.calculate_size
		end

feature {NONE} -- Constants

	maximum_prompt_text_width: INTEGER = 500
			-- Maximum width for prompt text (text is wrapped if it extends beyond the width)

invariant
	prompt_sub_title_label_attached: prompt_sub_title_label /= Void
	prompt_text_attached: prompt_text /= Void
	not_is_size_and_position_remembered: not is_size_and_position_remembered

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
