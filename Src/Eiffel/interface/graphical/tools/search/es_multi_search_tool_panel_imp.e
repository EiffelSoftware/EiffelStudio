indexing
	description: "Interface of EB_MULTI_SEARCH_TOOL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_MULTI_SEARCH_TOOL_PANEL_IMP

inherit
	EB_TOOL
		export
			{NONE} show
		redefine
			mini_toolbar,
			build_mini_toolbar,
			internal_recycle,
			internal_detach_entities,
			show
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature {NONE} -- Initialize

	build_interface is
			-- Build all the tool's widgets.
		local
			vbox: EV_VERTICAL_BOX
			search_box: EV_HORIZONTAL_BOX
			replace_box: EV_HORIZONTAL_BOX
			label, label_search: EV_LABEL
			scope_tab: EV_BOX
			report_box: EV_BOX
			frame: EV_FRAME
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			option_and_replace_all_box: EV_HORIZONTAL_BOX
			option_frame: EV_FRAME
		do
					-- Search box
			create label_search.make_with_text (Interface_names.l_search_for)
			label_search.align_text_left

			create keyword_field
			keyword_field.set_minimum_width (
				Layout_constants.Dialog_unit_to_pixels (min_width_of_keyword_field))

			create search_box
			search_box.set_padding (2)
			search_box.extend (label_search)
			search_box.disable_item_expand (label_search)
			search_box.extend (keyword_field)
			create search_button.make_with_text (interface_names.b_search)
			search_button.disable_sensitive
			search_box.extend (search_button)
			search_box.disable_item_expand (search_button)

					-- Replace box
			create replace_combo_box
			replace_combo_box.set_minimum_width (
				Layout_constants.Dialog_unit_to_pixels (min_width_of_keyword_field))

			create replace_button.make_with_text (interface_names.b_replace)

			create replace_box
			replace_box.set_padding (2)
			create label.make_with_text (interface_names.l_replace_with)
			replace_box.extend (label)
			replace_box.disable_item_expand (label)
			replace_box.extend (replace_combo_box)
			replace_box.extend (replace_button)
			replace_box.disable_item_expand (replace_button)

				-- Ensures alignments of combo boxes by making sure that their preceeding
				-- labels have the same width.
			label_search.set_minimum_width (label.width.max (label_search.minimum_width))
			label.set_minimum_width (label_search.minimum_width)

					-- Options and replace all
			create option_and_replace_all_box
			create option_frame.make_with_text (interface_names.l_options)

			option_and_replace_all_box.extend (option_frame)
			create hbox
			create cell
			cell.set_minimum_width (10)
			hbox.extend (cell)
			hbox.disable_item_expand (cell)
			option_frame.extend (hbox)

				-- Option "Incremental search"
			create incremental_search_button.make_with_text ("Have not added to search panel")

				-- Option "Match case"
			create case_sensitive_button.make_with_text (Interface_names.l_match_case)

				-- Option "Whole word"
			create whole_word_button.make_with_text (Interface_names.l_whole_word)

				-- Option "Use regular expression"
			create use_regular_expression_button.make_with_text (Interface_names.l_use_regular_expression)

				-- Option "Search backward"
			create search_backward_button.make_with_text (Interface_names.l_search_backward)

			create vbox
			vbox.extend (case_sensitive_button)
			vbox.disable_item_expand (case_sensitive_button)
			vbox.extend (whole_word_button)
			vbox.disable_item_expand (whole_word_button)
			hbox.extend (vbox)

			hbox.disable_item_expand (vbox)

			create cell
			cell.set_minimum_width (10)
			hbox.extend (cell)

			create vbox
			vbox.extend (use_regular_expression_button)
			vbox.disable_item_expand (use_regular_expression_button)
			vbox.extend (search_backward_button)
			vbox.disable_item_expand (search_backward_button)
			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)

			create cell
			cell.set_minimum_width (10)
			hbox.extend (cell)

			create replace_all_click_button.make_with_text (interface_names.b_replace_all)

			create vbox
			vbox.extend (replace_all_click_button)
			vbox.disable_item_expand (replace_all_click_button)
			vbox.extend (create {EV_CELL})

			create cell
			cell.set_minimum_width (3)
			option_and_replace_all_box.extend (cell)
			option_and_replace_all_box.disable_item_expand (cell)

			option_and_replace_all_box.extend (vbox)
			option_and_replace_all_box.disable_item_expand (vbox)

			layout_constants.set_default_width_for_button (replace_button)
			layout_constants.set_default_width_for_button (replace_all_click_button)
			layout_constants.set_default_width_for_button (search_button)

			replace_button.disable_sensitive
			replace_all_click_button.disable_sensitive

			scope_tab := build_scope_box
			report_box := build_report_box

			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_border_size)
			vbox.extend (search_box)
			vbox.disable_item_expand (search_box)
			vbox.extend (replace_box)
			vbox.disable_item_expand (replace_box)
			vbox.extend (option_and_replace_all_box)
			vbox.disable_item_expand (option_and_replace_all_box)

			create notebook

			notebook.set_tab_position (notebook.tab_top)
			notebook.extend (vbox)
			notebook.extend (scope_tab)
			notebook.item_tab (vbox).set_text (interface_names.t_search_tool)
			notebook.item_tab (scope_tab).set_text (interface_names.l_scope.twin)

			create vbox
			vbox.extend (notebook)
			vbox.disable_item_expand (notebook)

			create frame
			frame.set_style ((create {EV_FRAME_CONSTANTS}).Ev_frame_raised)
			frame.extend (vbox)
			widget := frame
		end

	build_scope_box: EV_VERTICAL_BOX is
			-- Create and return a box containing scope pad.
		local
			vbox: EV_VERTICAL_BOX
			cell: EV_CELL
			hbox: EV_HORIZONTAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
		do
				-- Option "Current Editor"		
			create current_editor_button.make_with_text (Interface_names.l_current_editor)

				-- Option "Whole Project"
			create whole_project_button.make_with_text (Interface_names.l_whole_project)

				-- Option "Scope"
			create custom_button.make_with_text (Interface_names.l_custom)

				-- Option "Subcluster"
			create search_subcluster_button.make_with_text (Interface_names.l_sub_clusters)

				-- Option "Compiled class"
			create search_compiled_class_button.make_with_text (Interface_names.l_compiled_class)

				-- Option list scope
			create scope_list.default_create
			scope_list.enable_multiple_selection
			scope_list.set_pick_and_drop_mode

				-- Add button
			create add_button.make_with_text (interface_names.b_add)
			layout_constants.set_default_width_for_button (add_button)

				-- Remove button
			create remove_button.make_with_text (interface_names.b_remove)
			layout_constants.set_default_width_for_button (remove_button)

				-- Remove all button
			create remove_all_button.make_with_text (interface_names.b_remove_all)
			layout_constants.set_default_width_for_button (remove_all_button)

			create Result

			create hbox
			hbox.set_border_width (Layout_constants.Small_border_size)

			create cell
			cell.set_minimum_width (5)
			hbox.extend (cell)
			hbox.disable_item_expand (cell)

			create scope
			create vbox
			vbox.set_padding_width (layout_constants.small_border_size )
			vbox.extend (current_editor_button)
			vbox.extend (whole_project_button)
			vbox.extend (custom_button)
			vbox.extend (search_compiled_class_button)
			vbox.disable_item_expand (current_editor_button)
			vbox.disable_item_expand (whole_project_button)
			vbox.disable_item_expand (custom_button)
			vbox.disable_item_expand (search_compiled_class_button)
			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)

			create vbox
			vbox.extend (scope_list)
			scope_list.set_minimum_width (min_width_of_keyword_field)

			scope.extend (vbox)

			create cell
			cell.set_minimum_width (3)
			scope.extend (cell)
			scope.disable_item_expand (cell)

			create vbox
			vbox.set_padding_width (layout_constants.small_border_size)

			create l_hbox
			vbox.extend (l_hbox)
			vbox.disable_item_expand (l_hbox)
			l_hbox.extend (add_button)
			l_hbox.disable_item_expand (add_button)

			create l_hbox
			vbox.extend (l_hbox)
			vbox.disable_item_expand (l_hbox)
			l_hbox.extend (remove_button)
			l_hbox.disable_item_expand (remove_button)

			create l_hbox
			vbox.extend (l_hbox)
			vbox.disable_item_expand (l_hbox)
			l_hbox.extend (remove_all_button)
			l_hbox.disable_item_expand (remove_all_button)

			vbox.extend (search_subcluster_button)
			vbox.disable_item_expand (search_subcluster_button)
			scope.extend (vbox)
			scope.disable_item_expand (vbox)

			hbox.extend (scope)

			create options
			options.extend (hbox)

			Result.extend (options)
			Result.disable_item_expand (options)
			Result.set_border_width (layout_constants.small_border_size)
		end

	build_report_box: EV_VERTICAL_BOX is
			-- Build report box
		deferred
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER, ES_TOOL} -- Initialize

	build_mini_toolbar is
			-- Build mini tool bar.
		local
			l_cmd: ES_SHOW_TOOL_COMMAND
		do
			create mini_toolbar.make
			l_cmd := develop_window.commands.show_shell_tool_commands.item (develop_window.shell_tools.tool ({ES_SEARCH_REPORT_TOOL}))
				-- Pixmap should be changed.
			l_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.callstack_send_to_external_editor_icon)
			l_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.callstack_send_to_external_editor_icon_buffer)
			mini_toolbar.extend (l_cmd.new_mini_sd_toolbar_item)
			mini_toolbar.compute_minimum_size

			content.set_mini_toolbar (mini_toolbar)
		ensure then
			mini_toolbar_exists: mini_toolbar /= Void
		end

feature -- EB_TOOL

	widget: EV_WIDGET
			-- Widget representing Current

	show_and_set_focus is
			-- Show the search tool and set focus to the search text field
		require
			not_void: content /= Void
		do
			show
			if currently_searched /= Void and then currently_searched.is_empty then
				if not keyword_field.is_destroyed and currently_searched /= Void and not currently_searched.has_code (('%R').natural_32_code) and keyword_field.is_editable then
					keyword_field.set_text (currently_searched)
				end
			end
			if currently_replacing /= Void and then not currently_replacing.is_empty then
				if not replace_combo_box.is_destroyed and currently_replacing /= Void and not currently_replacing.has_code (('%R').natural_32_code) then
					replace_combo_box.set_text (currently_replacing)
				end
			end
			set_focus_if_possible (keyword_field)
		end

	show is
			-- Show tool.
		do
			Precursor {EB_TOOL}
			set_focus_if_possible (keyword_field)
		end

feature -- Access

	report_tool: ES_SEARCH_REPORT_TOOL_PANEL
			-- Report tool.
		do
			Result ?= develop_window.shell_tools.tool ({ES_SEARCH_REPORT_TOOL}).panel
		ensure
			result_attached: Result /= Void
		end

	show_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when the item becomes visible.

feature -- Widgets

	scope : EV_HORIZONTAL_BOX
			-- Scope widget container.

	choose_dialog: EB_CHOOSE_MULTI_CLUSTER_N_CLASS_DIALOG
			-- Dialog used to add classes or clusters to scope

	keyword_field: EV_COMBO_BOX
			-- Text field where the user type in the word he's looking for.

	case_sensitive_button: EV_CHECK_BUTTON
			-- button to choose case sensitivity or not

	replace_all_click_button: EV_BUTTON
			-- Replace all button

	add_button: EV_BUTTON
			-- Add button

	remove_button: EV_BUTTON
			-- Remove button

	remove_all_button: EV_BUTTON
			-- Remove all button

	use_regular_expression_button: EV_CHECK_BUTTON
			-- Button to tell if pattern contains regular expression

	current_editor_button: EV_RADIO_BUTTON
			-- Button to search in editor

	whole_project_button: EV_RADIO_BUTTON
			-- Button to search in whole project

	custom_button: EV_RADIO_BUTTON
			-- Button to search in a specific scope

	search_subcluster_button: EV_CHECK_BUTTON
			-- Button to indicate if subcluster of the specific scope will be searched.

	search_compiled_class_button: EV_CHECK_BUTTON
			-- Button to indicate if compiled classes will be searched.

	incremental_search_button: EV_CHECK_BUTTON
			-- Button to control incremental search.

	scope_list: EV_LIST
			-- List of the specific scope

	search_report_grid: EB_SEARCH_REPORT_GRID
			-- Grid to contain search report
		do
			Result := report_tool.search_report_grid
		end

	replace_combo_box: EV_COMBO_BOX
			-- Replacment combo box

	notebook: EV_NOTEBOOK
			-- Notebook, one tab for basic search, one for scopes.

	whole_word_button: EV_CHECK_BUTTON
			-- button to look for isolated words

	search_button: EV_BUTTON
			-- Search button

	replace_button: EV_BUTTON
			-- Replace button

	search_backward_button: EV_CHECK_BUTTON
			-- button to search backward

	options: EV_FRAME
			-- Options widget

	mini_toolbar: SD_TOOL_BAR
			-- Mini tool bar.

feature -- Status report

	is_visible: BOOLEAN is
			-- Can `Current' be seen on screen?
		do
			Result := widget.is_displayed
		end

	reverse : BOOLEAN is
			-- Search upwards?
		do
			Result := search_backward_button.is_selected
		end

	is_whole_project_searched : BOOLEAN is
			-- Is the whole project searched?
		do
			Result := whole_project_button.is_selected
		end

	is_customized : BOOLEAN is
			-- Is search scoped?
		do
			Result := custom_button.is_selected
		end

	is_case_sensitive: BOOLEAN is
			-- Is search case sensitive?
		do
			Result := case_sensitive_button.is_selected
		end

	is_whole_word_matched: BOOLEAN is
			-- Is search whole word matched?
		do
			Result := whole_word_button.is_selected
		end

	is_regular_expression_used: BOOLEAN is
			-- Is regular expression used in search?
		do
			Result := use_regular_expression_button.is_selected
		end

	is_incremental_search: BOOLEAN is
			-- Is incremental search enabled?
		do
			Result := incremental_search_button.is_selected
		end

	is_sub_cluster_searched: BOOLEAN is
			-- Are subclusters searched?
		do
			Result := search_subcluster_button.is_selected
		end

	is_current_editor_searched: BOOLEAN is
			-- Is current editor searched?
		do
			Result := current_editor_button.is_selected
		end

	only_compiled_class_searched: BOOLEAN is
			-- Only compiled classes are searched?
		do
			Result := search_compiled_class_button.is_selected
		end

feature {NONE} -- Destroy behavior.

	save_preferences is
			-- Save preferences. All options' status.
		local
			l_pre : EB_SEARCH_TOOL_DATA
		do
			l_pre := preferences.search_tool_data
			l_pre.init_incremental_preference.set_value (is_incremental_search)
			preferences.preferences.save_preference (l_pre.init_incremental_preference)

			l_pre.init_match_case_preference.set_value (is_case_sensitive)
			preferences.preferences.save_preference (l_pre.init_match_case_preference)

			l_pre.init_only_compiled_classes_preference.set_value (only_compiled_class_searched)
			preferences.preferences.save_preference (l_pre.init_only_compiled_classes_preference)

			l_pre.init_search_backwards_preference.set_value (search_backward_button.is_selected)
			preferences.preferences.save_preference (l_pre.init_search_backwards_preference)

			l_pre.init_subclusters_preference.set_value (is_sub_cluster_searched)
			preferences.preferences.save_preference (l_pre.init_subclusters_preference)

			l_pre.init_use_regular_expression_preference.set_value (is_regular_expression_used)
			preferences.preferences.save_preference (l_pre.init_use_regular_expression_preference)

			l_pre.init_whole_word_preference.set_value (is_whole_word_matched)
			preferences.preferences.save_preference (l_pre.init_whole_word_preference)

			if is_current_editor_searched then
				l_pre.init_scope_preference.set_selected_index (1)
			elseif is_whole_project_searched then
				l_pre.init_scope_preference.set_selected_index (2)
			elseif is_customized then
				l_pre.init_scope_preference.set_selected_index (3)
			end
			preferences.preferences.save_preference (l_pre.init_scope_preference)
		end

	internal_recycle is
			-- Recycle
		do
			save_preferences
			show_actions.wipe_out
			widget.destroy
			Precursor {EB_TOOL}
		end

	internal_detach_entities is
			-- Recycle all widgets so that we can better detect memory leaks.
		do
			scope := Void
			choose_dialog := Void
			keyword_field := Void
			case_sensitive_button := Void
			replace_all_click_button := Void
			add_button := Void
			remove_button := Void
			remove_all_button := Void
			use_regular_expression_button := Void
			current_editor_button := Void
			whole_project_button := Void
			custom_button := Void
			search_subcluster_button := Void
			search_compiled_class_button := Void
			incremental_search_button := Void
			scope_list := Void
			replace_combo_box := Void
			notebook := Void
			whole_word_button := Void
			search_button := Void
			replace_button := Void
			search_backward_button := Void
			options := Void
			Precursor
		end

feature {NONE} -- Implementation

	min_width_of_keyword_field: INTEGER is 100

	currently_searched: STRING_32 is
		deferred
		end

	currently_replacing: STRING_32 is
		deferred
		end

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
