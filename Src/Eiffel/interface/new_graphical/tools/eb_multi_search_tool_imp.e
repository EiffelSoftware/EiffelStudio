indexing
	description: "Interface of EB_MULTI_SEARCH_TOOL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_MULTI_SEARCH_TOOL_IMP

inherit

	EB_TOOL
		export
			{NONE} show
		redefine
			menu_name,
			pixmap
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
			search_box: EV_VERTICAL_BOX
			replace_box: EV_VERTICAL_BOX
			label, label_search: EV_LABEL
			size: INTEGER
			options_box: EV_BOX
			report_box: EV_BOX
			frame: EV_FRAME
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			option_and_replace_all_box: EV_HORIZONTAL_BOX
			option_frame: EV_FRAME
		do
					-- Search box
			create label_search.make_with_text (Interface_names.l_Search_for + " ")
			label_search.align_text_left
			size := label_search.minimum_width

			create keyword_field
			keyword_field.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (290))

			create search_box
			search_box.set_padding (1)
			create hbox
			search_box.extend (hbox)
			hbox.extend (label_search)
			hbox.disable_item_expand (label_search)

			hbox.extend (keyword_field)
			hbox.disable_item_expand (keyword_field)
			create cell
			cell.set_minimum_width (3)
			hbox.extend (cell)
			hbox.disable_item_expand (cell)
			create search_button.make_with_text (interface_names.b_search)
			search_button.disable_sensitive
			hbox.extend (search_button)
			hbox.disable_item_expand (search_button)

					-- Replace box
			create replace_combo_box
			replace_combo_box.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (290))

			create replace_check_button.make_with_text (Interface_names.l_Replace_with)

			create replace_button.make_with_text (interface_names.b_replace)

			create replace_box
			create hbox
			replace_box.extend (hbox)
			replace_box.disable_item_expand (hbox)
			create label.make_with_text (interface_names.l_replace_with + " ")

			hbox.extend (label)
			hbox.disable_item_expand (label)
			label_search.set_minimum_width (label.width)

			hbox.extend (replace_check_button)
			replace_check_button.hide
			hbox.disable_item_expand (replace_check_button)
			hbox.extend (replace_combo_box)
			hbox.disable_item_expand (replace_combo_box)
			size := label.width.max (size) + replace_combo_box.width

			create cell
			cell.set_minimum_width (3)
			hbox.extend (cell)
			hbox.disable_item_expand (cell)

			hbox.extend (replace_button)
			hbox.disable_item_expand (replace_button)

					-- Options and replace all
			create option_and_replace_all_box
			create option_frame.make_with_text (interface_names.l_Options)
			option_frame.set_minimum_width (size)
			option_and_replace_all_box.extend (option_frame)
			option_and_replace_all_box.disable_item_expand (option_frame)
			create hbox
			create cell
			cell.set_minimum_width (10)
			hbox.extend (cell)
			hbox.disable_item_expand (cell)
			option_frame.extend (hbox)
				-- Option "Match case"
			create case_sensitive_button.make_with_text (Interface_names.l_Match_case)

				-- Option "Whole word"
			create whole_word_button.make_with_text (Interface_names.l_Whole_word)

				-- Option "Use regular expression"
			create use_regular_expression_button.make_with_text (Interface_names.l_Use_regular_expression)

				-- Option "Search backward"
			create search_backward_button.make_with_text (Interface_names.l_Search_backward)

			create vbox
			vbox.extend (case_sensitive_button)
			vbox.disable_item_expand (case_sensitive_button)
			vbox.extend (whole_word_button)
			vbox.disable_item_expand (whole_word_button)
			hbox.extend (vbox)

			hbox.disable_item_expand (vbox)

			create cell
			cell.set_minimum_width (80)
			hbox.extend (cell)
			hbox.disable_item_expand (cell)

			create vbox
			vbox.extend (use_regular_expression_button)
			vbox.disable_item_expand (use_regular_expression_button)
			vbox.extend (search_backward_button)
			vbox.disable_item_expand (search_backward_button)
			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)

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

			replace_button.set_minimum_width (layout_constants.default_button_width)
			replace_all_click_button.set_minimum_width (layout_constants.default_button_width)
			search_button.set_minimum_width (layout_constants.default_button_width)

			replace_button.disable_sensitive
			replace_all_click_button.disable_sensitive

			options_box := build_scope_box
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
			notebook.extend (options_box)
			notebook.item_tab (vbox).set_text (interface_names.t_search_tool)
			notebook.item_tab (options_box).set_text (interface_names.l_scope)

			create vbox
			vbox.extend (notebook)
			vbox.disable_item_expand (notebook)

			vbox.extend (report_box)
			create frame
			frame.set_style ((create {EV_FRAME_CONSTANTS}).Ev_frame_raised)
			frame.extend (vbox)
			widget := frame
		end

	build_scope_box: EV_VERTICAL_BOX is
			-- Create and return a box containing the search options
		local
			vbox: EV_VERTICAL_BOX
			cell: EV_CELL
			hbox: EV_HORIZONTAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
		do
				-- Option "Incremental search"
			create incremental_search_button.make_with_text ("Have not added to search panel")

				-- Option "Current Editor"		
			create current_editor_button.make_with_text (Interface_names.l_Current_editor)

				-- Option "Whole Project"
			create whole_project_button.make_with_text (Interface_names.l_Whole_project)

				-- Option "Scope"
			create custom_button.make_with_text (Interface_names.l_Custom)

				-- Option "Subcluster"
			create search_subcluster_button.make_with_text (Interface_names.l_Sub_clusters)

				-- Option "Compiled class"
			create search_compiled_class_button.make_with_text (Interface_names.l_Compiled_class)

				-- Option list scope
			create scope_list.default_create
			scope_list.enable_multiple_selection
			scope_list.set_pick_and_drop_mode

				-- Add button
			create add_button.make_with_text (interface_names.b_Add)
			add_button.set_minimum_width (layout_constants.default_button_width)

				-- Remove button
			create remove_button.make_with_text (interface_names.b_Remove)
			remove_button.set_minimum_width (layout_constants.default_button_width)

				-- Remove all button
			create remove_all_button.make_with_text (interface_names.b_Remove_all)
			remove_all_button.set_minimum_width (layout_constants.default_button_width)

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
			scope_list.set_minimum_width (142 + layout_constants.default_button_width)

			scope.extend (vbox)
			scope.disable_item_expand (vbox)

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
		ensure
			report_tool_not_void: report_tool /= Void
		end

feature -- EB_TOOL

	widget: EV_WIDGET
			-- Widget representing Current

	title: STRING is
			-- Title of the tool
		do
			Result := Interface_names.t_Search_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Search_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap as it may appear in toolbars and menus.
		do
			Result := Pixmaps.Icon_search
		end

	show_and_set_focus is
			-- show the search tool and set focus to the search text field
		require
			explorer_bar_item_not_void: explorer_bar_item /= Void
		do
			fixme ("it can occurs the explorer_bar_item is bad (void or maybe destroyed ..")
			explorer_bar_item.show
			if explorer_bar_item.is_minimized then
				explorer_bar_item.restore
			end
			if currently_searched /= Void and then currently_searched.is_empty then
				keyword_field.set_text (currently_searched)
			end
			if currently_replacing /= Void and then currently_replacing.is_empty then
				replace_field.set_text (currently_replacing)
			end
			keyword_field.set_focus
		end

	mode_is_search: BOOLEAN is
			-- are replace fields/buttons inactive ?
		do
			Result := not replace_check_button.is_selected
		end

	set_mode_is_search (value: BOOLEAN) is
			-- show/hide replace field according to `value'
		do
			if value then
				if replace_check_button.is_selected then
					replace_check_button.disable_select
					--switch_mode
				end
			elseif not replace_check_button.is_selected then
				replace_check_button.enable_select
			end
		end

feature -- Access

	report_tool: EB_SEARCH_REPORT_TOOL

	show_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when the item becomes visible.

feature -- Widgets

	scope : EV_HORIZONTAL_BOX
			-- Scope widget container.

	choose_dialog: EB_CHOOSE_MULTI_CLUSTER_N_CLASS_DIALOG
			-- Dialog used to add classes or clusters to scope

	keyword_field: EV_COMBO_BOX
			-- Text field where the user type in the word he's looking for.

	replace_field: EV_TEXT_FIELD
			-- Text field where the user type in the replacement word.

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

	replace_combo_box: EV_COMBO_BOX
			-- Replacment combo box

	notebook: EV_NOTEBOOK
			-- Notebook, one tab for basic search, one for scopes.

	whole_word_button: EV_CHECK_BUTTON
			-- button to look for isolated words

	search_button: EV_BUTTON
			-- Search button

	replace_check_button : EV_CHECK_BUTTON
			-- Replace check button

	replace_button: EV_BUTTON
			-- Replace button

	search_backward_button: EV_CHECK_BUTTON
			-- button to search backward

	options: EV_FRAME

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

	recycle is
			-- Recycle
		do
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			widget := Void
			manager := Void
			save_preferences
		end

feature {NONE} -- Implementation

	currently_searched: STRING is
		deferred
		end

	currently_replacing: STRING is
		deferred
		end

	create_report_grid is
			-- Create report grid
		deferred
		ensure
			search_report_grid_not_void: search_report_grid /= Void
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build explorer bar item
		do
			create explorer_bar_item.make (explorer_bar, widget, title, True)
			explorer_bar_item.set_menu_name (menu_name)
			explorer_bar_item.set_pixmap (pixmap)
			explorer_bar.add (explorer_bar_item)
			explorer_bar_item.show_actions.extend (agent show_actions.call ([Void]))
		end

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
