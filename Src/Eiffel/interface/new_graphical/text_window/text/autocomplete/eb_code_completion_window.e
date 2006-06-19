indexing
	description: "Window that displays a text area and a list of possible features for automatic completion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CODE_COMPLETION_WINDOW

inherit

	CODE_COMPLETION_WINDOW
		rename
			complete as complete_feature
		redefine
			make,
			close_and_complete,
			rebuild_list_during_matching,
			automatically_complete_words,
			save_window_position,
			complete_feature,
			scrolling_common_line_count,
			mouse_wheel_scroll_full_page,
			mouse_wheel_scroll_size,
			on_char,
			code_completable,
			sorted_names,
			name_type,
			build_option_bar,
			choice_list,
			on_key_down,
			on_key_released,
			set_expanded_row_icon
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create, copy
		end

	EB_RECYCLABLE
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create
		do
			Precursor {CODE_COMPLETION_WINDOW}
			choice_list.enable_tree
			set_title (Interface_names.t_Autocomplete_window)
			setup_option_buttons
		end

	build_option_bar: EV_VERTICAL_BOX is
			-- Build option bar
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_sep: EV_HORIZONTAL_SEPARATOR
			l_label: EV_LABEL
			l_tooltip: STRING
		do
			create Result

				-- Separator
			create l_sep
			l_sep.set_minimum_height (2)
			Result.extend (l_sep)

			create l_hbox
			l_hbox.set_padding_width (layout_constants.small_padding_size)
			l_hbox.set_border_width (1)
			Result.extend (l_hbox)
			Result.disable_item_expand (l_hbox)

				-- "Options" label
			create l_label.make_with_text (interface_names.l_options)
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)

			create option_bar
			l_hbox.extend (option_bar)
			l_hbox.disable_item_expand (option_bar)

				-- Option buttons
			create filter_button
			filter_button.set_pixmap (pixmaps.mini_pixmaps.completion_filter_icon)
			l_tooltip := preferences.editor_data.filter_completion_list_preference.description
			if l_tooltip /= Void then
			 	filter_button.set_tooltip (l_tooltip)
			end
			option_bar.extend (filter_button)

			create show_return_type_button
			show_return_type_button.set_pixmap (pixmaps.mini_pixmaps.completion_show_return_type_icon)
			l_tooltip := preferences.editor_data.show_completion_type_preference.description
			if l_tooltip /= Void then
				show_return_type_button.set_tooltip (l_tooltip)
			end
			option_bar.extend (show_return_type_button)

			create show_signature_button
			show_signature_button.set_pixmap (pixmaps.mini_pixmaps.completion_show_signature_icon)
			l_tooltip := preferences.editor_data.show_completion_signature_preference.description
			if l_tooltip /= Void then
				show_signature_button.set_tooltip (l_tooltip)
			end
			option_bar.extend (show_signature_button)

			create show_disambiguated_name_button
			show_disambiguated_name_button.set_pixmap (pixmaps.mini_pixmaps.completion_show_disambiguants_icon)
			l_tooltip := preferences.editor_data.show_completion_disambiguated_name_preference.description
			if l_tooltip /= Void then
				show_disambiguated_name_button.set_tooltip (l_tooltip)
			end
			option_bar.extend (show_disambiguated_name_button)

			create remember_size_button
			remember_size_button.set_pixmap (pixmaps.mini_pixmaps.completion_remember_size_icon)
			remember_size_button.set_tooltip (preferences.development_window_data.remember_completion_list_size_preference.description)
			option_bar.extend (remember_size_button)
		end

	setup_option_buttons is
			-- Setup option buttons according to preference.
			-- Setup callbacks on option buttons.
		do
				-- Preference setup
			if filter_completion_list then
				filter_button.enable_select
			else
				filter_button.disable_select
			end
			if show_completion_type then
				show_return_type_button.enable_select
			else
				show_return_type_button.disable_select
			end
			if show_completion_signature then
				show_signature_button.enable_select
			else
				show_signature_button.disable_select
			end
			if show_completion_disambiguated_name then
				show_disambiguated_name_button.enable_select
			else
				show_disambiguated_name_button.disable_select
			end
			if remember_window_size then
				remember_size_button.enable_select
			else
				remember_size_button.disable_select
			end

				-- Callbacks
			filter_button.select_actions.extend (agent on_option_button_selected (filter_button))
			show_return_type_button.select_actions.extend (agent on_option_button_selected (show_return_type_button))
			show_signature_button.select_actions.extend (agent on_option_button_selected (show_signature_button))
			show_disambiguated_name_button.select_actions.extend (agent on_option_button_selected (show_disambiguated_name_button))
			remember_size_button.select_actions.extend (agent on_option_button_selected (remember_size_button))

				-- Preference change
			filter_completion_list_agent := agent on_option_changed (filter_button)
			show_return_type_agent := agent on_option_changed (show_return_type_button)
			show_completion_signature_agent := agent on_option_changed (show_signature_button)
			show_completion_disambiguated_name_agent := agent on_option_changed (show_disambiguated_name_button)
			remember_window_size_agent := agent on_option_changed (remember_size_button)

			preferences.editor_data.filter_completion_list_preference.change_actions.extend (filter_completion_list_agent)
			preferences.editor_data.show_completion_type_preference.change_actions.extend (show_return_type_agent)
			preferences.editor_data.show_completion_signature_preference.change_actions.extend (show_completion_signature_agent)
			preferences.editor_data.show_completion_disambiguated_name_preference.change_actions.extend (show_completion_disambiguated_name_agent)
			preferences.development_window_data.remember_completion_list_size_preference.change_actions.extend (remember_window_size_agent)
		end

feature -- Initialization

	initialize_for_features (an_editor: like code_completable;
							feature_name: STRING;
							a_remainder: INTEGER;
							completion_possibilities: like sorted_names;
							a_complete_word: BOOLEAN) is
			-- Initialize to to complete for `feature_name' in `an_editor'.
		local
			l_string: STRING
		do
			feature_mode := True
			l_string := feature_name
			l_string.prune_all_leading (' ')
			l_string.prune_all_leading ('	')
			common_initialization (an_editor, l_string, a_remainder, completion_possibilities, a_complete_word)
		end

	initialize_for_classes (an_editor: like code_completable;
							class_name: STRING;
							a_remainder: INTEGER;
							completion_possibilities: like sorted_names) is
			-- Initialize to to complete for `class_name' in `an_editor'.
		do
			feature_mode := False
			common_initialization (an_editor, class_name, a_remainder, completion_possibilities, True)
		end

feature -- Access

	choice_list: EB_COMPLETION_LIST_GRID
			-- Choice list

	code_completable: EB_TAB_CODE_COMPLETABLE
			-- associated window

	sorted_names: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- list of possible feature names sorted alphabetically

	name_type: EB_NAME_FOR_COMPLETION

feature -- Widget

	show_return_type_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show return type

	show_signature_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show signature

	show_disambiguated_name_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show disambiguated name

	remember_size_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Button to remember window size

feature -- Status report

	feature_mode: BOOLEAN
			-- Is `Current' used to select feature names ?

	scrolling_common_line_count : INTEGER is
		do
			Result := preferences.editor_data.scrolling_common_line_count
		end

	mouse_wheel_scroll_full_page : BOOLEAN is
		do
			Result := preferences.editor_data.mouse_wheel_scroll_full_page
		end

	mouse_wheel_scroll_size: INTEGER is
		do
			Result := preferences.editor_data.mouse_wheel_scroll_size
		end

feature {NONE} -- Option Preferences

	filter_completion_list: BOOLEAN is
		do
			Result := preferences.editor_data.filter_completion_list
		end

	show_completion_type: BOOLEAN is
		do
			Result := preferences.editor_data.show_completion_type
		end

	show_completion_signature: BOOLEAN is
		do
			Result := preferences.editor_data.show_completion_signature
		end

	show_completion_disambiguated_name: BOOLEAN is
		do
			Result := preferences.editor_data.show_completion_disambiguated_name
		end

	remember_window_size: BOOLEAN is
		do
			Result := preferences.development_window_data.remember_completion_list_size
		end

feature {NONE} -- Option behaviour

	on_option_changed (a_button: EV_TOOL_BAR_TOGGLE_BUTTON) is
			-- On option changed
		require
			a_button_not_void: a_button /= Void
		do
			a_button.select_actions.block
			if a_button = filter_button then
				apply_filter_completion_list (filter_completion_list)
				if filter_completion_list then
					a_button.enable_select
				else
					a_button.disable_select
				end
			elseif a_button = show_return_type_button then
				apply_show_return_type (show_completion_type)
				if show_completion_type then
					a_button.enable_select
				else
					a_button.disable_select
				end
			elseif a_button = show_signature_button then
				apply_show_completion_signature (show_completion_signature)
				if show_completion_signature then
					a_button.enable_select
				else
					a_button.disable_select
				end
			elseif a_button = show_disambiguated_name_button then
				apply_show_completion_disambiguated_name (show_completion_disambiguated_name)
				if show_completion_disambiguated_name then
					a_button.enable_select
				else
					a_button.disable_select
				end
			elseif a_button = remember_size_button then
				apply_remember_window_size (remember_window_size)
				if remember_window_size then
					a_button.enable_select
				else
					a_button.disable_select
				end
			else
				check
					error: False
				end
			end
			a_button.select_actions.resume
		end

	on_option_button_selected (a_button: EV_TOOL_BAR_TOGGLE_BUTTON) is
			-- On option button selected
		require
			a_button_not_void: a_button /= Void
		local
			l_prefernce: BOOLEAN_PREFERENCE
		do
			if a_button = filter_button then
				if filter_completion_list /= a_button.is_selected then
					l_prefernce := preferences.editor_data.filter_completion_list_preference
					l_prefernce.change_actions.block
					l_prefernce.set_value (a_button.is_selected)
					apply_filter_completion_list (filter_completion_list)
				end
			elseif a_button = show_return_type_button then
				if show_completion_type /= a_button.is_selected then
					l_prefernce := preferences.editor_data.show_completion_type_preference
					l_prefernce.change_actions.block
					l_prefernce.set_value (a_button.is_selected)
					apply_show_return_type (show_completion_type)
				end
			elseif a_button = show_signature_button then
				if show_completion_signature /= a_button.is_selected then
					l_prefernce := preferences.editor_data.show_completion_signature_preference
					l_prefernce.change_actions.block
					l_prefernce.set_value (a_button.is_selected)
					apply_show_completion_signature (show_completion_signature)
				end
			elseif a_button = show_disambiguated_name_button then
				if show_completion_disambiguated_name /= a_button.is_selected then
					l_prefernce := preferences.editor_data.show_completion_disambiguated_name_preference
					l_prefernce.change_actions.block
					l_prefernce.set_value (a_button.is_selected)
					apply_show_completion_disambiguated_name (show_completion_disambiguated_name)
				end
			elseif a_button = remember_size_button then
				if remember_window_size /= a_button.is_selected then
					l_prefernce := preferences.development_window_data.remember_completion_list_size_preference
					l_prefernce.change_actions.block
					l_prefernce.set_value (a_button.is_selected)
					apply_remember_window_size (remember_window_size)
				end
			else
				check
					error: False
				end
			end
			l_prefernce.change_actions.resume
		end

	apply_filter_completion_list (a_b: BOOLEAN) is
			-- Apply filtering completion list.
		local
			l_name: like name_type
			l_index: INTEGER
		do
				-- Save selected item
			if not choice_list.selected_rows.is_empty then
				l_name ?= choice_list.selected_rows.first.item (1).data
				check
					l_name_not_void: l_name /= Void
				end
			end

			build_displayed_list (buffered_input)

				-- Try to selected saved item
				-- If does not exist any more, we call `ensure_item_selection'
			l_index := grid_row_by_data (l_name)
			if l_index = 0 then
				ensure_item_selection
			else
				choice_list.remove_selection
				choice_list.row (l_index).enable_select
				choice_list.row (l_index).ensure_visible
			end
			resize_column_to_window_width
		end

	apply_show_return_type (a_b: BOOLEAN) is
			-- Apply showing return type.
		local
			l_index: INTEGER
			l_row: EV_GRID_ROW
		do
			if not choice_list.selected_rows.is_empty then
				l_index := choice_list.selected_rows.first.index
			end
			build_displayed_list (buffered_input)
			if l_index > 0 and then choice_list.row_count > 0 then
				check
					l_index_valid: l_index <= choice_list.row_count
				end
				choice_list.remove_selection
				l_row := choice_list.row (l_index)
				if is_displayed then
					if l_row.parent_row /= Void and then
						l_row.parent_row.is_expandable and then
						not l_row.parent_row.is_expanded
					then
						l_row.parent_row.expand
					end
					l_row.enable_select
					l_row.ensure_visible
				end
			else
				ensure_item_selection
			end
			resize_column_to_window_width
		end

	apply_show_completion_signature (a_b: BOOLEAN) is
			-- Apply showing completion signature.
		do
			apply_show_return_type (a_b)
		end

	apply_show_completion_disambiguated_name (a_b: BOOLEAN) is
			-- Apply showing completion disambiguated name.
		do
			apply_show_return_type (a_b)
		end

	apply_remember_window_size (a_b: BOOLEAN) is
			-- Apply remembering window size.
		do
			if a_b then
				save_window_position
			else
				code_completable.position_completion_choice_window
				resize_column_to_window_width
			end
		end

	filter_completion_list_agent: PROCEDURE [ANY, TUPLE]

	show_return_type_agent:  PROCEDURE [ANY, TUPLE]

	show_completion_signature_agent: PROCEDURE [ANY, TUPLE]

	show_completion_disambiguated_name_agent: PROCEDURE [ANY, TUPLE]

	remember_window_size_agent: PROCEDURE [ANY, TUPLE]

feature -- Recyclable

	recycle is
			-- Recycle
		do
			preferences.editor_data.filter_completion_list_preference.change_actions.prune_all (filter_completion_list_agent)
			preferences.editor_data.show_completion_type_preference.change_actions.prune_all (show_return_type_agent)
			preferences.editor_data.show_completion_signature_preference.change_actions.prune_all (show_completion_signature_agent)
			preferences.editor_data.show_completion_disambiguated_name_preference.change_actions.prune_all (show_completion_disambiguated_name_agent)
			preferences.development_window_data.remember_completion_list_size_preference.change_actions.prune_all (remember_window_size_agent)
		end

feature {NONE} -- Implementation

	on_char (character_string: STRING_32) is
   			-- Process displayable character key press event.
   		local
   			c: CHARACTER
   		do
			if character_string.count = 1 then
				c := character_string.item (1).to_character_8
				if c.is_alpha or c.is_digit or c = '_' then
					buffered_input.append_character (c)
					code_completable.handle_character (c)
					select_closest_match
				elseif c = ' ' and ev_application.ctrl_pressed then
						-- Do nothing, we don't want to close the completion window when CTRL+SPACE is pressed
				elseif not code_completable.unwanted_characters.item (c.code) then
					close_and_complete
					if not code_completable.has_selection then
						code_completable.handle_character (c)
					end
					exit
				end
			end
		end

	on_key_down (ev_key: EV_KEY) is
			-- process user input in `choice_list'.
		do
			if ev_key /= Void then
				inspect
					ev_key.code
				when key_ctrl then
					if not show_completion_disambiguated_name then
						show_disambiguated_name_button.enable_select
						temp_switching_show_disambiguated_name := True
					end
				else
					Precursor {CODE_COMPLETION_WINDOW} (ev_key)
				end
			end
		end

	on_key_released (ev_key: EV_KEY) is
			-- process user input in `choice_list'.
		do
			if ev_key /= Void then
				inspect
					ev_key.code
				when key_ctrl then
					if temp_switching_show_disambiguated_name and then show_completion_disambiguated_name then
						show_disambiguated_name_button.disable_select
					end
					temp_switching_show_disambiguated_name := False
				else
					Precursor {CODE_COMPLETION_WINDOW} (ev_key)
				end
			end
		end

	temp_switching_show_disambiguated_name: BOOLEAN

	save_window_position is
			-- Save current window position
		do
			if preferences.development_window_data.remember_completion_list_size and then is_displayed then
				preferences.development_window_data.save_completion_list_size (width, height)
			end
		end

	rebuild_list_during_matching: BOOLEAN is
			-- Should the list be rebuilt according to current match?
		do
		    Result := preferences.editor_data.filter_completion_list
		end

	automatically_complete_words: BOOLEAN is
			-- Should completion list automatically complete words.
		do
			Result := preferences.editor_data.auto_complete_words
		end

	close_and_complete is
			-- close the window and perform completion with selected item
		do
			if not choice_list.selected_rows.is_empty then
					-- Delete current token so it is later replaced by the completion text
				if not buffered_input.is_empty then
					remove_characters_entered_since_display
				end
				if feature_mode then
					complete_feature
				else
					complete_class
				end
			end
			exit
			code_completable.block_focus_in_actions
			code_completable.set_focus
			code_completable.resume_focus_in_actions
		end

	complete_feature is
			-- Complete feature name
		local
			l_feature: EB_FEATURE_FOR_COMPLETION
			l_name_item: like name_type
			l_name: STRING
			l_row: EV_GRID_ROW
		do
			if not choice_list.selected_rows.is_empty then
				if character_to_append = '(' then
					character_to_append := '%U'
				end
				l_row := choice_list.selected_rows.first
				if ev_application.ctrl_pressed and then l_row.is_expandable and then l_row.subrow_count > 0 then
					l_row := l_row.subrow (1)
				end
				l_name_item ?= l_row.item (1).data
				check
					l_name_item_not_void: l_name_item /= Void
				end
				if ev_application.ctrl_pressed or else show_completion_disambiguated_name then
					if l_name_item.has_dot then
						l_name := l_name_item.full_insert_name
					else
						l_name := " " + l_name_item.full_insert_name
					end
				else
					if l_name_item.has_dot then
						l_name := l_name_item.insert_name
					else
						l_name := " " + l_name_item.insert_name
					end
				end
				code_completable.complete_feature_from_window (l_name, True, character_to_append, remainder)
				l_feature ?= l_name_item
				if l_feature /= Void then
					last_completed_feature_had_arguments := l_feature.has_arguments
				else
					last_completed_feature_had_arguments := False
				end
			end
		end

	complete_class is
			-- Complete class name
		local
			ix: INTEGER
		do
			if not choice_list.selected_rows.is_empty then
				if rebuild_list_during_matching then
					ix := choice_list.selected_rows.first.index + index_offset
				else
					ix := choice_list.selected_rows.first.index
				end
				code_completable.complete_class_from_window (sorted_names.item (ix), '%U', remainder)
			else
				if not buffered_input.is_empty then
					code_completable.complete_class_from_window (buffered_input, character_to_append, remainder)
				end
			end
		end

	set_expanded_row_icon (a_item: EB_GRID_COMPILER_ITEM; a_name: like name_type) is
			-- Set pixmap of `a_item'.
		do
			a_item.set_pixmap (pixmaps.icon_expandable_right_arrow_color)
		end

	last_completed_feature_had_arguments: BOOLEAN;
			-- Did the last inserted completed feature name contain arguments?

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

end -- class EB_COMPLETION_CHOICE_WINDOW
