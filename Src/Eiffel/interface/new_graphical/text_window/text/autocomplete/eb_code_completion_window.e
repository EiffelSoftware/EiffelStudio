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
			build_displayed_list,
			name_type
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

create
	make

feature {NONE} -- Initialization

	make is
			-- Create
		do
			Precursor {CODE_COMPLETION_WINDOW}
			set_title (Interface_names.t_Autocomplete_window)
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

	code_completable: EB_TAB_CODE_COMPLETABLE
			-- associated window

	sorted_names: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- list of possible feature names sorted alphabetically

	name_type: EB_NAME_FOR_COMPLETION

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

feature {NONE} -- Implementation

	on_char (character_string: STRING_32) is
   			-- Process displayable character key press event.
   		local
   			c: CHARACTER
			c_name: like name_type
   		do
			if character_string.count = 1 then
				c := character_string.item (1).to_character_8
				if c.is_alpha or c.is_digit or c = '_' then
					buffered_input.append_character (c)
					code_completable.handle_character (c)
					create c_name.make (buffered_input)
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

	complete_feature is
			-- Complete feature name
		local
			ix: INTEGER
			l_feature: EB_FEATURE_FOR_COMPLETION
		do
			if not choice_list.selected_rows.is_empty then
				if character_to_append = '(' then
					character_to_append := '%U'
				end
				ix := index_to_complete
				if sorted_names.item (ix).has_dot then
					code_completable.complete_feature_from_window (sorted_names.item (ix).full_insert_name, True, character_to_append, remainder)
				else
					code_completable.complete_feature_from_window (" " + sorted_names.item (ix).full_insert_name, True, character_to_append, remainder)
				end
				l_feature ?= sorted_names.item (ix)
				if l_feature /= Void then
					last_completed_feature_had_arguments := l_feature.has_arguments
				else
					last_completed_feature_had_arguments := False
				end
			end
		end

	save_window_position is
			-- Save current window position
		do
			if preferences.development_window_data.remember_completion_list_size and then is_displayed then
				preferences.development_window_data.save_completion_list_size (width, height)
			end
		end

	build_displayed_list (name: STRING) is
			-- Build the list based on matches with `name'
		local
			l_count: INTEGER
			matches: ARRAY [like name_type]
			list_row: EV_GRID_LABEL_ITEM
			match_item: like name_type
			row_index: INTEGER
			l_upper: INTEGER
		do
			choice_list.wipe_out

			if rebuild_list_during_matching then
				matches := matches_based_on_name (name)
			else
				matches := sorted_names.subarray (1, sorted_names.count)
			end


			if matches.is_empty then
				current_index := 0
			else
				current_index := 1
			end
			from
				l_count := matches.lower
				l_upper := matches.upper
				row_index := 1
			until
				l_count > l_upper
			loop
				match_item := matches.item (l_count)
				if match_item /= Void then
					create list_row.make_with_text (match_item.out)
					list_row.set_pixmap (match_item.icon)
					if not match_item.show_signature or not match_item.show_type then
						list_row.set_tooltip (match_item.tooltip_text)
								-- TODO: neilc.  auto activating the tooltip works but only based on mouse x/y,
								-- whereas we need selected_item x/y.
							--list_row.select_actions.extend (agent activate_tooltip)								
					end
					choice_list.set_item (1, row_index, list_row)
				end
				l_count := l_count + 1
				row_index := row_index + 1
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
