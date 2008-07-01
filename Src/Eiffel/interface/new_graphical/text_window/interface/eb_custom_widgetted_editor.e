indexing
	description: "Editor that can have controls surrounded. Search and quick search bar is surported here."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOM_WIDGETTED_EDITOR

inherit
	EB_EDITOR
		rename
			make as make_editor
		redefine
			user_initialization,
			gain_focus,
			lose_focus,
			internal_recycle,
			on_mouse_move,
			on_mouse_button_down,
			on_key_down
		end

create
	make

feature {NONE} -- Initialization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialization
		do
			dev_window := a_dev_window
			check_search_bar_visible_procedure := agent check_search_bar_visible
			if dev_window /= Void then
				dev_window.window.focus_in_actions.extend (check_search_bar_visible_procedure)
			end
			make_editor
			initialize_customizable_commands
		end

	user_initialization is
			-- Initialization
		do
			Precursor {EB_EDITOR}
			build_surrounding_widgets
			if dev_window /= Void then
				build_search_bar
			end
		end

	initialize_customizable_commands is
			-- Create array of customizable commands.
		do
			create customizable_commands.make (6)
			customizable_commands.put (agent quick_search, "show_quick_search_bar")
			customizable_commands.put (agent replace, "show_search_and_replace_panel")
			customizable_commands.put (agent find_next_selection, "search_selection_forward")
			customizable_commands.put (agent find_previous_selection, "search_selection_backward")
			customizable_commands.put (agent find_next, "search_forward")
			customizable_commands.put (agent find_previous, "search_backward")
			customizable_commands.put (agent run_if_editable (agent comment_selection), "comment")
			customizable_commands.put (agent run_if_editable (agent uncomment_selection), "uncomment")
			customizable_commands.put (agent run_if_editable (agent set_selection_case (False)), "set_to_uppercase")
			customizable_commands.put (agent run_if_editable (agent set_selection_case (True)), "set_to_lowercase")
		end

feature -- Access

	top_widget: EV_HORIZONTAL_BOX
	bottom_widget: EV_HORIZONTAL_BOX
	left_widget: EV_HORIZONTAL_BOX
	right_widget: EV_HORIZONTAL_BOX
			-- Widgets surrounding

	search_bar: QUICK_SEARCH_BAR

	search_tool: ES_MULTI_SEARCH_TOOL_PANEL is
			-- Current search tool.
		do
			if dev_window /= Void and then not dev_window.shell_tools.is_recycled then
				Result ?= dev_window.shell_tools.tool ({ES_SEARCH_TOOL}).panel
			end
		end

feature {NONE} -- Access

	token_handler: ?ES_EDITOR_TOKEN_HANDLER
			-- Access to a token handler, for processing actions on tokens
		do
			Result := internal_token_handler
			if Result = Void then
				Result := create_token_handler
				internal_token_handler := Result
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_consistent: Result = token_handler
		end

	mouse_move_idle_timer: EV_TIMEOUT
			-- Timer used to process mouse idle actions.

feature -- Quick search bar basic operation

	quick_search is
			-- Prepare and show quick search bar, switch to quick search mode.
		local
			l_string : STRING_32
		do
			if search_tool /= Void then
				if search_tool.is_visible then
					search_tool.close
				end
				show_search_bar
				if has_selection then
					l_string := wide_string_selection
					search_bar.keyword_field.change_actions.block
					search_bar.keyword_field.set_text (l_string)
					search_bar.keyword_field.change_actions.resume
					search_bar.trigger_sensibility
				end
				focusing_search_bar := true
				search_bar.keyword_field.set_focus
				focusing_search_bar := false
			end
		end

	hide_search_bar is
			-- Hide quick search bar.
		require
			search_bar_exists: search_bar /= Void
			search_bar_not_destroyed: not search_bar.is_destroyed
		do
			search_bar.hide
		end

	show_search_bar is
			-- Show quick search bar.
		require
			search_bar_exists: search_bar /= Void
			search_bar_not_destroyed: not search_bar.is_destroyed
		do
			-- Commented out to prevent QSB flickering.
			-- set_quick_search_mode (true)
			if not search_tool.is_visible then
				search_bar.show
			end
		end

	quick_find_next is
			-- Find next using default search and options on quick search bar.
		do
			search_bar.record_current_searched
			prepare_quick_search
			search_tool.go_to_next_found
			if not is_empty then
				check_cursor_position
			end
			search_tool.trigger_keyword_field_color (search_bar.keyword_field)
		end

	quick_find_previous is
			-- Find next using default search and options on quick search bar.
		do
			search_bar.record_current_searched
			prepare_quick_search
			search_tool.go_to_previous_found
			if not is_empty then
				check_cursor_position
			end
			search_tool.trigger_keyword_field_color (search_bar.keyword_field)
		end

	set_quick_search_mode (a_mode: BOOLEAN) is
			-- Set `quick_search_mode' with `a_mode'.
		do
			shared_quick_search_mode.put (a_mode)
		end

feature {NONE} -- Quick search bar.

	build_search_bar is
			-- Build quick search bar.
		require
			bottom_widget_created: bottom_widget /= Void
		do
			create search_bar.make (search_tool)

			first_result_reached_action := agent search_bar.trigger_first_reached_pixmap
			bottom_reached_action := agent search_bar.trigger_bottom_reached_pixmap

			search_tool.first_result_reached_actions.extend (first_result_reached_action)
			search_tool.bottom_reached_actions.extend (bottom_reached_action)
			bottom_widget.extend (search_bar)
			hide_search_bar
			search_bar.advanced_button.select_actions.extend (agent trigger_advanced_search)
			search_bar.close_button.select_actions.extend (agent close_quick_search_bar)
			search_bar.next_button.select_actions.extend (agent quick_find_next)
			search_bar.previous_button.select_actions.extend (agent quick_find_previous)

			search_bar.keyword_field.change_actions.extend (agent quick_incremental_search)
			search_bar.keyword_field.focus_in_actions.extend (agent search_tool.focusing_keyword_field)
			search_bar.keyword_field.focus_in_actions.extend (agent prepare_quick_search)
			search_bar.keyword_field.return_actions.extend (agent return_on_quick_search_field)

			search_bar.set_lose_focus (agent on_search_bar_lose_focus)
			search_bar.set_key_press_action (agent on_key_pressed_on_search_bar)
		end

	prepare_quick_search is
			-- Prepare search options and keyword on search panel for quick search.
		local
			l_incremental_search: BOOLEAN
			l_keyword: STRING_32
		do
			if search_bar.is_case_sensitive /= search_tool.case_sensitive_button.is_selected then
				if search_bar.is_case_sensitive then
					search_tool.case_sensitive_button.enable_select
				else
					search_tool.case_sensitive_button.disable_select
				end
			end
			if search_bar.is_regex /= search_tool.use_regular_expression_button.is_selected then
				if search_bar.is_regex then
					search_tool.use_regular_expression_button.enable_select
				else
					search_tool.use_regular_expression_button.disable_select
				end
			end
			l_keyword := search_bar.keyword_field.text
			search_tool.search_current_editor_only
			if not l_keyword.is_empty then
				search_tool.set_check_class_succeed (True)
				l_incremental_search := search_tool.is_incremental_search
				search_tool.disable_incremental_search
				if not search_tool.keyword_field.text.is_equal (l_keyword) then
					search_tool.set_current_searched (l_keyword)
				end
				if l_incremental_search then
					search_tool.enable_incremental_search
				end
			end
		end

	quick_incremental_search is
			-- Incremental search for text in search bar.
		local
			l_editor: EB_EDITOR
		do
			if not search_tool.is_recycled then
				if not is_empty and search_tool.is_incremental_search then
					if search_bar.keyword_field.text_length /= 0 then
						l_editor := search_tool.old_editor
						search_tool.set_old_editor (Current)
						search_tool.incremental_search (search_bar.keyword_field.text, search_tool.incremental_search_start_pos, False)
						if search_tool.has_result then
							search_tool.select_in_current_editor
						else
							search_tool.retrieve_cursor
						end
						search_tool.set_old_editor (l_editor)
					else
						search_tool.retrieve_cursor
					end
				end
				search_tool.trigger_keyword_field_color (search_bar.keyword_field)
			end
		end

	trigger_advanced_search is
			-- Show advanced search panel.
		do
			if not search_tool.is_visible then
				search_tool.prepare_search
			else
				search_tool.close
			end
		end

	gain_focus is
			-- Update the panel as it has just gained the focus.
			-- Show quick search bar, if is in search mode.
		do
			Precursor {EB_EDITOR}
			if quick_search_mode then
				show_search_bar
			end
		end

	lose_focus is
			-- Update the panel as it has just lost the focus.
			-- Hide quick search bar.
		do
			Precursor {EB_EDITOR}
			if search_bar /= Void and then not search_bar.is_destroyed and then search_bar.is_displayed then
				if not search_bar.has_focus_on_widgets and not focusing_search_bar then
					-- Commented out to prevent QSB flickering.
					-- hide_search_bar
					close_quick_search_bar
				else
					if not search_bar.is_displayed then
						show_search_bar
					end
				end
			end
		end

	focusing_search_bar: BOOLEAN

	on_search_bar_lose_focus is
			-- On search bar losing focus.
		do
			if is_initialized then
				if not has_focus and not search_bar.has_focus_on_widgets then
					-- Commented out to prevent QSB flickering.
					-- hide_search_bar
					close_quick_search_bar
				end
			end
		end

	on_key_pressed_on_search_bar (a_key: EV_KEY) is
			-- On key pressed on any widget of search bar.
		local
			l_shortcut_forw: SHORTCUT_PREFERENCE
			l_shortcut_backw: SHORTCUT_PREFERENCE
			l_shortcut_sel_forw: SHORTCUT_PREFERENCE
			l_shortcut_sel_backw: SHORTCUT_PREFERENCE
		do
			l_shortcut_forw := preferences.editor_data.shortcuts.item ("search_forward")
			l_shortcut_backw := preferences.editor_data.shortcuts.item ("search_backward")
			l_shortcut_sel_forw := preferences.editor_data.shortcuts.item ("search_selection_forward")
			l_shortcut_sel_backw := preferences.editor_data.shortcuts.item ("search_selection_backward")
			if a_key.code = {EV_KEY_CONSTANTS}.key_escape and not ctrled_key and not shifted_key and not alt_key then
				close_quick_search_bar
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter and not ctrled_key and not shifted_key and not alt_key then
				search_bar.record_current_searched
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter and ctrled_key and not shifted_key and not alt_key then
				search_bar.record_current_searched
				ev_application.do_once_on_idle (agent editor_drawing_area.set_focus)
			elseif l_shortcut_forw.matches (a_key, alt_key, ctrled_key, shifted_key) then
				quick_find_next
			elseif l_shortcut_backw.matches (a_key, alt_key, ctrled_key, shifted_key) then
				quick_find_previous
			elseif l_shortcut_sel_forw.matches (a_key, alt_key, ctrled_key, shifted_key) then
				find_next_selection
			elseif l_shortcut_sel_backw.matches (a_key, alt_key, ctrled_key, shifted_key) then
				find_previous_selection
			end
		end

	return_on_quick_search_field is
			-- On key pressed on keyword field of quick search bar.
		do
			if ctrled_key and not shifted_key and not alt_key then
				search_bar.record_current_searched
				ev_application.do_once_on_idle (agent editor_drawing_area.set_focus)
			elseif not ctrled_key and not shifted_key and not alt_key then
				quick_find_next
			elseif not ctrled_key and shifted_key and not alt_key then
				quick_find_previous
			end
		end

	close_quick_search_bar is
			-- When `close_button' is pressed.
		do
			set_quick_search_mode (false)
			hide_search_bar
			ev_application.do_once_on_idle (agent set_focus_to_drawing_area)
		end

	quick_search_mode : BOOLEAN is
			-- Is editor in search mode?
		do
			Result := shared_quick_search_mode.item
		end

	check_search_bar_visible is
			-- Show search bar if it has focus on one of its widget.
		do
			if search_bar.has_focus_on_widgets then
				if quick_search_mode then
					show_search_bar
				end
			end
		end

feature -- Search commands

	find_next is
			-- Find next occurrence of last searched pattern.
		do
			if search_tool /= Void then
				if search_tool.is_visible then
					search_tool.go_to_next_found
					if not text_displayed.is_empty then
						check_cursor_position
					end
					search_tool.trigger_keyword_field_color (search_bar.keyword_field)
				else
					quick_find_next
				end
			end
		end

	find_previous is
			-- Find next occurrence of last searched pattern.
		do
			if search_tool /= Void then
				if search_tool.is_visible then
					search_tool.go_to_previous_found
					if not text_displayed.is_empty then
						check_cursor_position
					end
					search_tool.trigger_keyword_field_color (search_bar.keyword_field)
				else
					quick_find_previous
				end
			end
		end

	find_next_selection is
			-- Find next occurrence of selection.
		do
			if search_tool /= Void then
				prepare_search_selection
				find_next
			end
		end

	find_previous_selection is
			--
		do
			if search_tool /= Void then
				prepare_search_selection
				find_previous
			end
		end

	search is
			-- Display search tool if necessary.
		do
			if search_tool /= Void then
				prepare_search_tool (False)
			end
		end

	replace is
			-- Display search tool (with Replace field) if necessary.
		do
			if search_tool /= Void then
				prepare_search_tool (True)
			end
		end

feature {ES_EDITOR_TOKEN_HANDLER} -- Basic operation

	reset_mouse_idle_timer
			-- Resets the mouse idle timer, if it's active. Resetting actually kills the
			-- timer and it will not resume again until the user moves the mouse. This is useful
			-- in situtation such as editing where idle actions should not be performed.
		do
			if mouse_move_idle_timer /= Void then
				mouse_move_idle_timer.destroy
				mouse_move_idle_timer := Void
			end
		ensure
			mouse_move_idle_timer_destroyed: old mouse_move_idle_timer /= Void implies (old mouse_move_idle_timer).is_destroyed
			mouse_move_idle_timer_detached: mouse_move_idle_timer = Void
		end

feature {NONE} -- Action hanlders

	on_mouse_move (a_x_pos: INTEGER; a_y_pos: INTEGER; unused1, unused2, unused3: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Process events related to mouse pointer moves over the editor widget.
		local
			l_timer: like mouse_move_idle_timer
		do
			Precursor {EB_EDITOR} (a_x_pos, a_y_pos, unused1, unused2, unused3, a_screen_x, a_screen_y)

			if text_is_fully_loaded and then not is_empty then
				l_timer := mouse_move_idle_timer
				if l_timer = Void then
					create l_timer.make_with_interval ({ES_UI_CONSTANTS}.popup_idle_interval)
					l_timer.actions.extend (agent on_mouse_idle (a_x_pos, a_y_pos, a_screen_x, a_screen_y))
					mouse_move_idle_timer := l_timer
					editor_drawing_area.pointer_leave_actions.extend_kamikaze (agent
						local
							l_handler: like token_handler
						do
							reset_mouse_idle_timer
							if {PLATFORM}.is_windows then
									-- On Windows-based systems we can exit the processing immediately. On GTK this
									-- action is fired too soon to perform the immediate exit.
								l_handler := token_handler
								if l_handler /= Void and then l_handler.can_perform_exit (True) then
									l_handler.perform_exit (True)
								end
							end
						end)
				else
					l_timer.actions.wipe_out
					l_timer.actions.extend (agent on_mouse_idle (a_x_pos, a_y_pos, a_screen_x, a_screen_y))
					l_timer.set_interval ({ES_UI_CONSTANTS}.popup_idle_interval)
				end
			end
		end

	on_mouse_idle (a_abs_x, a_abs_y: INTEGER; a_screen_x, a_screen_y: INTEGER)
			-- Called when the pointer has remained idle over the same place for a interval.
			-- The interval is dictated by `mouse_mode_idle_internal'.
		require
			is_interface_usable: is_interface_usable
			text_displayed_attached: text_displayed /= Void
			not_is_empty: not is_empty
		local
			l_handler: like token_handler
			l_cursor: EIFFEL_EDITOR_CURSOR
			l_instant: BOOLEAN
		do
			if text_is_fully_loaded then
				l_handler := token_handler
				if l_handler /= Void then
					if {l_clickable_text: !CLICKABLE_TEXT} text_displayed then
							-- Fetch token at current mouse position
						create l_cursor.make_from_character_pos (1, 1, l_clickable_text)
						position_cursor (l_cursor, a_abs_x, a_abs_y - editor_viewport.y_offset)
						if {l_token: !EDITOR_TOKEN} l_cursor.token then
								-- An instant key (CTRL) allows direct processing of the token.
							l_instant := (ev_application.ctrl_pressed and then not ev_application.alt_pressed and then not ev_application.shift_pressed)
							if l_instant or else not l_handler.is_active then
									-- Even if the handler is active, an instant key will override it.
								if l_handler.is_applicable_token (l_token) then
									l_handler.perform_on_token_with_mouse_coords (l_instant, l_token, l_cursor.line.index, a_abs_x, a_abs_y, a_screen_x, a_screen_y)
								elseif not l_instant then
										-- No reset is performed when using an instant key, because invalid tokens will not show
										-- anything so we should not hide what's already there
									l_handler.perform_reset
								end
							elseif l_handler.last_token_handled /= l_token and then l_handler.can_perform_exit (False) then
									-- Nothing to perform so ensure exit.
								l_handler.perform_exit (False)
							end
						end
					end
				end
			end
		end

	on_key_down (a_key: EV_KEY)
			-- Called when the user hits a key
		do
			if is_editable then
					-- Reset timer as edits override mouse idle events
				reset_mouse_idle_timer
			end
			Precursor (a_key)
		end

	on_mouse_button_down (a_x_pos, a_y_pos, a_button: INTEGER; unused1, unused2, unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Process single click on mouse buttons.
		do
				-- Reset idle timer because of a mouse action
			reset_mouse_idle_timer
			Precursor (a_x_pos, a_y_pos, a_button, unused1, unused2, unused3, a_screen_x, a_screen_y)
		end

feature {NONE} -- Factory

	create_token_handler: ?ES_EDITOR_TOKEN_HANDLER
			-- Create a token handler, used to perform actions or respond to mouse/keyboard events
			-- Note: Return Void to prevent any handling from takening place.
		do
			-- Does nothing by default.
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

feature {NONE} -- Implementation

	set_focus_to_drawing_area is
		do
			if editor_drawing_area.is_displayed and then
				editor_drawing_area.is_sensitive and then
				not editor_drawing_area.is_destroyed
			then
				editor_drawing_area.set_focus
			end
		end

	internal_recycle is
			-- Recycle
		do
			if mouse_move_idle_timer /= Void and then not mouse_move_idle_timer.is_destroyed then
				mouse_move_idle_timer.destroy
				mouse_move_idle_timer := Void
			end
			dev_window.window.focus_in_actions.prune_all (check_search_bar_visible_procedure)
			if search_tool /= Void then
				search_tool.first_result_reached_actions.prune_all (first_result_reached_action)
				search_tool.bottom_reached_actions.prune_all (bottom_reached_action)
			end
			search_bar.destroy
			Precursor {EB_EDITOR}
		end

	shared_quick_search_mode: CELL [BOOLEAN] is
			-- Shared quick search mode.
		once
			create Result
		end

	prepare_search_tool (a_replace: BOOLEAN) is
			-- Show and give focus to search panel.
		local
			l_replace: BOOLEAN
		do
			l_replace := a_replace and then (not text_displayed.is_empty and then not text_displayed.selection_is_empty)

			search_tool.notebook.select_item (search_tool.notebook.i_th (1))
			if l_replace then
				search_tool.show_and_set_focus_replace
			else
				search_tool.show_and_set_focus
			end

			if l_replace then
				search_tool.set_current_searched (text_displayed.selected_wide_string)
			end
			if not text_displayed.is_empty then
				check_cursor_position
			end
		end

	prepare_search_selection is
			-- Prepare search selection.
		local
			l_search_tool: ES_MULTI_SEARCH_TOOL_PANEL
			l_incremental_search: BOOLEAN
		do
			l_search_tool := search_tool
			l_search_tool.set_check_class_succeed (True)
			if not text_displayed.has_selection then
				select_current_token (True)
			end
			if text_displayed.has_selection then
				l_search_tool.force_new_search
				l_incremental_search := l_search_tool.is_incremental_search
				l_search_tool.disable_incremental_search
				l_search_tool.set_current_searched (text_displayed.selected_wide_string)
				if l_incremental_search then
					l_search_tool.enable_incremental_search
				end
				if l_search_tool.currently_searched /= Void and then not l_search_tool.currently_searched.is_equal (search_bar.keyword_field.text) then
					search_bar.keyword_field.change_actions.block
					search_bar.keyword_field.set_text (l_search_tool.currently_searched)
					search_bar.record_current_searched
					search_bar.keyword_field.change_actions.resume
					search_bar.trigger_sensibility
				end
			end
		end

	build_surrounding_widgets is
			-- Build surrounding widgets.
		local
			l_widget: like widget
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_widget

			create l_vbox
			create top_widget
			create l_hbox
			create bottom_widget

			l_widget.extend (l_vbox)

			l_vbox.extend (top_widget)
			l_vbox.extend (l_hbox)
			l_vbox.extend (bottom_widget)
			l_vbox.disable_item_expand (top_widget)
			l_vbox.disable_item_expand (bottom_widget)

			create left_widget
			create right_widget

			l_hbox.extend (left_widget)
			l_hbox.extend (widget)
			l_hbox.extend (right_widget)
			l_hbox.disable_item_expand (left_widget)
			l_hbox.disable_item_expand (right_widget)

			widget := l_widget
		end

	customizable_commands: HASH_TABLE [PROCEDURE [like Current, TUPLE], STRING]
			-- Hash of customizable commands (agent hashed by shortcut name)

	check_search_bar_visible_procedure: PROCEDURE [ANY, TUPLE];
			-- Procedure instance added into focus_in_actions of current window

	first_result_reached_action: PROCEDURE [ANY, TUPLE]
	bottom_reached_action: PROCEDURE [ANY, TUPLE];
			-- Actions to recycle

feature {NONE} -- Internal implentation cache

	internal_token_handler: like token_handler
			-- Cached version of `token_handler'
			-- Note: Do not use directly!

;indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
