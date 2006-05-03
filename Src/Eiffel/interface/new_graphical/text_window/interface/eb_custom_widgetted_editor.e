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
			recycle
		end

create
	make

feature {NONE} -- Initialization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialization
		require
			a_dev_window_attached: a_dev_window /= Void
		do
			dev_window := a_dev_window
			make_editor
			initialize_customizable_commands
			search_tool.show_actions.extend (agent hide_search_bar)
		end

	user_initialization is
			-- Initialization
		do
			Precursor {EB_EDITOR}
			build_surrounding_widgets
			build_search_bar
		end

	initialize_customizable_commands is
			-- Create array of customizable commands.
		do
			create customizable_commands.make (6)
			customizable_commands.put (agent search, "show_search_panel")
			customizable_commands.put (agent quick_search, "show_quick_search_bar")
			customizable_commands.put (agent replace, "show_search_and_replace_panel")
			customizable_commands.put (agent find_selection, "search_selection")
			customizable_commands.put (agent find_last, "search_last")
			customizable_commands.put (agent find_previous, "search_backward")
		end

feature -- Access

	top_widget: EV_HORIZONTAL_BOX
	bottom_widget: EV_HORIZONTAL_BOX
	left_widget: EV_HORIZONTAL_BOX
	right_widget: EV_HORIZONTAL_BOX
			-- Widgets surrounding

	search_bar: QUICK_SEARCH_BAR

	search_tool: EB_MULTI_SEARCH_TOOL is
			-- Current search tool.
		do
			Result := dev_window.search_tool
		end

feature -- Quick search bar basic operation

	quick_search is
			-- Prepare and show quick search bar, switch to quick search mode.
		local
			l_string : STRING
		do
			if search_tool.is_visible then
				search_tool.close
			end
			show_search_bar
			if has_selection then
				l_string := string_selection
				search_bar.keyword_field.change_actions.block
				search_bar.keyword_field.set_text (l_string)
				search_bar.keyword_field.change_actions.resume
				search_bar.trigger_sensibility
			end
			focusing_search_bar := true
			search_bar.keyword_field.set_focus
			focusing_search_bar := false
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
			set_quick_search_mode (true)
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
			check_cursor_position
			search_tool.trigger_keyword_field_color (search_bar.keyword_field)
		end

	quick_find_previous is
			-- Find next using default search and options on quick search bar.
		do
			search_bar.record_current_searched
			prepare_quick_search
			search_tool.go_to_previous_found
			check_cursor_position
			search_tool.trigger_keyword_field_color (search_bar.keyword_field)
		end

	quick_find_last is
			-- Find last using default search and options on quick search bar.
		do
			prepare_search_last
			search_bar.record_current_searched
			prepare_quick_search
			search_tool.go_to_next_found
			check_cursor_position
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
			search_tool.first_result_reached_actions.extend (agent search_bar.trigger_first_reached_pixmap)
			search_tool.bottom_reached_actions.extend (agent search_bar.trigger_bottom_reached_pixmap)
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
			l_keyword: STRING
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
			if search_bar.is_displayed then
				if not search_bar.has_focus_on_widgets and not focusing_search_bar then
					hide_search_bar
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
			if not has_focus and not search_bar.has_focus_on_widgets then
				hide_search_bar
			end
		end

	on_key_pressed_on_search_bar (a_key: EV_KEY) is
			-- On key pressed on any widget of search bar.
		local
			l_shortcut_sel: SHORTCUT_PREFERENCE
			l_shortcut_pre: SHORTCUT_PREFERENCE
			l_shortcut_last: SHORTCUT_PREFERENCE
		do
			l_shortcut_sel := preferences.editor_data.shortcuts.item ("search_selection")
			l_shortcut_pre := preferences.editor_data.shortcuts.item ("search_backward")
			l_shortcut_last := preferences.editor_data.shortcuts.item ("search_last")
			if a_key.code = {EV_KEY_CONSTANTS}.key_escape and not ctrled_key and not shifted_key and not alt_key then
				close_quick_search_bar
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter and not ctrled_key and not shifted_key and not alt_key then
				search_bar.record_current_searched
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter and ctrled_key and not shifted_key and not alt_key then
				search_bar.record_current_searched
				ev_application.idle_actions.extend_kamikaze (agent editor_drawing_area.set_focus)
			elseif l_shortcut_sel.matches (a_key, alt_key, ctrled_key, shifted_key) then
				quick_find_next
			elseif l_shortcut_pre.matches (a_key, alt_key, ctrled_key, shifted_key) then
				quick_find_previous
			elseif l_shortcut_last.matches (a_key, alt_key, ctrled_key, shifted_key) then
				quick_find_last
			end
		end

	return_on_quick_search_field is
			-- On key pressed on keyword field of quick search bar.
		do
			if ctrled_key and not shifted_key and not alt_key then
				search_bar.record_current_searched
				ev_application.idle_actions.extend_kamikaze (agent editor_drawing_area.set_focus)
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
			ev_application.idle_actions.extend_kamikaze (agent editor_drawing_area.set_focus)
		end

	quick_search_mode : BOOLEAN is
			-- Is editor in search mode?
		do
			Result := shared_quick_search_mode.item
		end

feature -- Search commands

	find_last is
			-- Search last searched if any.
		do
			if search_tool /= Void then
				prepare_search_last
				search_tool.go_to_next_found
				check_cursor_position
				search_tool.trigger_keyword_field_color (search_bar.keyword_field)
			end
		end

	find_next is
			-- Find next occurrence of last searched pattern.
		do
			if search_tool /= Void then
				prepare_search_selection
				search_tool.go_to_next_found
				check_cursor_position
				search_tool.trigger_keyword_field_color (search_bar.keyword_field)
			end
		end

	find_previous is
			-- Find next occurrence of last searched pattern.
		do
			if search_tool /= Void then
				prepare_search_selection
				search_tool.go_to_previous_found
				check_cursor_position
				search_tool.trigger_keyword_field_color (search_bar.keyword_field)
			end
		end

	find_selection is
			-- Find next occurrence of selection.
		do
			if search_tool /= Void then
				find_next
			end
		end

	search is
			-- Display search tool if necessary.
		do
			if search_tool /= Void then
				if not search_tool.mode_is_search then
					search_tool.set_mode_is_search (True)
				end
				prepare_search_tool (False)
			end
		end

	replace is
			-- Display search tool (with Replace field) if necessary.
		do
			if search_tool /= Void then
				if search_tool.mode_is_search then
					search_tool.set_mode_is_search (False)
				end
				prepare_search_tool (True)
			end
		end

feature {NONE} -- Implementation

	recycle is
			-- Recycle
		do
			Precursor {EB_EDITOR}
			search_bar.recycle
		end

	shared_quick_search_mode: CELL [BOOLEAN] is
			-- Shared quick search mode.
		once
			create Result
		end

	prepare_search_tool (a_replace: BOOLEAN) is
			-- Show and give focus to search panel.
		do
			if search_tool.is_visible then
				if not a_replace then
					search_tool.set_focus
				else
					search_tool.show_and_set_focus_replace
				end
			else
				if search_tool.explorer_bar_item.is_minimized then
					search_tool.explorer_bar_item.restore
				end
				search_tool.notebook.select_item (search_tool.notebook.i_th (1))
				if not a_replace then
					search_tool.show_and_set_focus
				else
					search_tool.show_and_set_focus_replace
				end
			end
			if not text_displayed.is_empty and then not text_displayed.selection_is_empty then
				search_tool.set_current_searched (text_displayed.selected_string)
			end
			if not text_displayed.is_empty then
				check_cursor_position
			end
		end

	prepare_search_last is
			-- Prepare search last.
		local
			l_incremental_search : BOOLEAN
			l_str: STRING
		do
			l_str := search_tool.last_keyword
			if l_str /= Void then
				search_tool.set_check_class_succeed (True)
				search_tool.force_new_search
				l_incremental_search := search_tool.is_incremental_search
				search_tool.disable_incremental_search
				search_tool.set_current_searched (l_str)
				if l_incremental_search then
					search_tool.enable_incremental_search
				end
				if search_tool.currently_searched /= Void and then not search_tool.currently_searched.is_equal (search_bar.keyword_field.text) then
					search_bar.keyword_field.change_actions.block
					search_bar.keyword_field.set_text (search_tool.currently_searched)
					search_bar.keyword_field.change_actions.resume
					search_bar.trigger_sensibility
				end
			end
		end

	prepare_search_selection is
			-- Prepare search selection.
		local
			l_search_tool: EB_MULTI_SEARCH_TOOL
			l_incremental_search: BOOLEAN
		do
			l_search_tool := search_tool
			l_search_tool.set_check_class_succeed (True)
			if text_displayed.has_selection then
				if l_search_tool.currently_searched = Void or else (not l_search_tool.item_selected (Current)) then
					l_search_tool.force_new_search
					l_incremental_search := l_search_tool.is_incremental_search
					l_search_tool.disable_incremental_search
					l_search_tool.set_current_searched (text_displayed.selected_string)
					if l_incremental_search then
						l_search_tool.enable_incremental_search
					end
				end
				if l_search_tool.currently_searched /= Void and then not l_search_tool.currently_searched.is_equal (search_bar.keyword_field.text) then
					search_bar.keyword_field.change_actions.block
					search_bar.keyword_field.set_text (l_search_tool.currently_searched)
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

invariant
	invariant_clause: True -- Your invariant here

indexing
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
