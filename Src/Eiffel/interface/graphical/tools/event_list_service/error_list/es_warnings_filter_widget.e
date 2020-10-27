note
	description: "[
		A widget for the Errors and Warnings tool to filter warnings.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_WARNINGS_FILTER_WIDGET

inherit
	EV_VERTICAL_BOX

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			copy,
			default_create,
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize filter widget
		do
			default_create
			build_interface
			create filter_changed_actions
			filter_changed_actions.compare_objects
		end

	build_interface
			-- Constructs the window's interface
		local
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
			l_link: EV_LINK_LABEL
		do
			set_background_color ((create{EV_STOCK_COLORS}).black)
			set_border_width (1)

			create l_vbox
			l_vbox.set_padding (4)
			l_vbox.set_border_width (4)

			create l_label.make_with_text (interface_names.l_filter_warnings)
			l_label.align_text_left

			create l_hbox
			l_hbox.set_border_width (1)
			l_hbox.set_background_color ((create{EV_STOCK_COLORS}).black)

			create grid_warnings
			grid_warnings.hide_header
			grid_warnings.set_column_count_to (1)
			l_hbox.extend (grid_warnings)

			l_vbox.extend (l_label)
			l_vbox.disable_item_expand (l_label)
			l_vbox.extend (l_hbox)

			create l_hbox
			l_hbox.set_padding (4)
			l_hbox.extend (create {EV_CELL})
			create l_link.make_with_text (interface_names.l_select_all)
			l_link.select_actions.extend (agent on_select_all)
			l_hbox.extend (l_link)
			l_hbox.disable_item_expand (l_link)
			create l_label.make_with_text ("|")
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			create l_link.make_with_text (interface_names.l_select_none)
			l_link.select_actions.extend (agent on_select_none)
			l_hbox.extend (l_link)
			l_hbox.disable_item_expand (l_link)
			l_vbox.extend (l_hbox)

			extend (l_vbox)

			initialize_warning_items

			grid_warnings.set_minimum_size (200, 180)
			grid_warnings.enable_multiple_row_selection
			grid_warnings.enable_default_tree_navigation_behavior (True, True, True, True)
			grid_warnings.key_release_actions.extend (agent on_grid_key_release)
		end

	initialize_warning_items
			-- Initializes items for filter
		local
			l_grid: like grid_warnings
			l_types: like warning_types
			l_cursor: DS_BILINEAR_CURSOR [TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]]
			l_item: TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]
			l_internal: like internal
			l_id: INTEGER
			l_warning: ERROR
			l_name: STRING
			l_row: EV_GRID_ROW
			l_check_item: EV_GRID_CHECKABLE_LABEL_ITEM
			i: INTEGER
			l_check_assert: BOOLEAN
		do
			l_types := warning_types
			l_grid := grid_warnings
			l_grid.set_row_count_to (l_types.count)

			l_internal := internal
			l_cursor := warning_types.new_cursor
			from l_cursor.start; i := 1 until l_cursor.after loop
				l_item := l_cursor.item
				l_id := l_internal.generic_dynamic_type (l_item.type, 1)
				l_warning := Void
				if l_item.exact_only then
					l_warning ?= l_internal.new_instance_of (l_id)
				end
				if l_warning /= Void then
						-- In order to evaluate `code' we need to disable assertion monitoring.
						-- This is clearly a hack and this code should be done differently.
					l_check_assert := {ISE_RUNTIME}.check_assert (False)
					l_name := l_warning.code
					l_check_assert := {ISE_RUNTIME}.check_assert (l_check_assert)
				else
					l_name := l_internal.type_name_of_type (l_id)
				end
				create l_check_item.make_with_text (" " + l_name)
				l_check_item.set_data (l_item)
				l_check_item.set_is_checked (True)
				l_check_item.checked_changed_actions.extend (agent on_filter_changed)
				l_row := l_grid.row (i)
				l_row.set_item (1, l_check_item)

				i := i + 1
				l_cursor.forth
			end

			if l_grid.row_count > 0 then
				l_grid.select_row (1)
			end
		end

feature -- Access

	filtered: DS_BILINEAR [TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]]
			-- List of currently filtered out types.
		local
			l_grid: like grid_warnings
			l_row: EV_GRID_ROW
			l_item: EV_GRID_CHECKABLE_LABEL_ITEM
			l_data: TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]
			l_count, i: INTEGER
			l_result: DS_ARRAYED_LIST [TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]]
		do
			Result := internal_filtered
			if Result = Void then
				l_grid := grid_warnings
				create l_result.make (0)
				from l_count := l_grid.row_count; i := 1 until i > l_count loop
					l_row := l_grid.row (i)
					l_item ?= l_row.item (1)
					if l_item /= Void and not l_item.is_checked then
						l_data ?= l_item.data
						if l_data /= Void then
							l_result.force_last (l_data)
						end
					end
					i := i + 1
				end
				Result := l_result
				internal_filtered := Result
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_items_locatable_in_warning_types: Result.for_all (agent warning_types.has)
		end

feature {NONE} -- Access

	warning_types: DS_BILINEAR [TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]]
			-- List of warning applicable for filtering
			-- Note: Result.exact_only indicates if the warning types has to match excatly, otherwise
			--       filtering should be based on conformance.
		local
			l_result: DS_ARRAYED_LIST [TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]]
		once
			create l_result.make (20)
			l_result.put_last ([{CAT_CALL_WARNING}, True])
			l_result.put_last ([{OBS_CLASS_WARN}, True])
			l_result.put_last ([{OBS_FEAT_WARN}, True])
			l_result.put_last ([{SYNTAX_WARNING}, True])
			l_result.put_last ([{UNUSED_LOCAL_WARNING}, True])
			l_result.put_last ([{C_COMPILER_WARNING}, True])
			l_result.put_last ([{VTCM}, True])
			l_result.put_last ([{VD43}, True])
			l_result.put_last ([{VD80}, True])
			l_result.put_last ([{VD81}, True])
			l_result.put_last ([{VD83}, True])
			l_result.put_last ([{VD85}, True])
			l_result.put_last ([{VIAC}, True])
			l_result.put_last ([{VICF}, True])
			l_result.put_last ([{VIIK}, True])
			l_result.put_last ([{VIOP}, True])
			l_result.put_last ([{VIRC}, True])
			l_result.put_last ([{VJRV}, False])
			l_result.put_last ([{VWEQ}, True])
			l_result.put_last ([{VWAB}, True])

			Result := l_result
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	frozen internal: INTERNAL
			-- Shared access to {INTERNAL}
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen keys: EV_KEY_CONSTANTS
			-- Shared access to {EV_KEY_CONSTANTS}
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- User interface elements

	grid_warnings: ES_GRID
			-- Warnings grid

feature -- Status report

	is_unfiltered (a_warning: ERROR): BOOLEAN
			-- Determines if a warning should not be filtered.
		local
			l_cursor: DS_BILINEAR_CURSOR [TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]]
			l_item: TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]
			l_type: TYPE [ANY]
			l_internal: INTERNAL
			l_matched: BOOLEAN
		do
			l_internal := internal
			l_cursor := filtered.new_cursor
			from l_cursor.start until l_cursor.after or l_matched loop
				l_item := l_cursor.item
				l_type := l_internal.type_of (a_warning)
				if l_item.exact_only then
					l_matched := l_type ~ l_item.type
				else
					l_matched := l_type.conforms_to (l_item.type)
				end
				l_cursor.forth
			end
			l_cursor.go_after

			Result := not l_matched
		end

feature {NONE} -- Basic operations

	toggle_selected_rows
			-- Toggles all selected rows
		do
			grid_warnings.selected_items.do_all (agent (a_item: EV_GRID_ITEM)
				do
					if attached {EV_GRID_CHECKABLE_LABEL_ITEM} a_item as l_check_item then
						l_check_item.set_is_checked (not l_check_item.is_checked)
					end
				end)
		end

	check_all_rows (a_checked: BOOLEAN)
			-- Checks all rows according to `a_checked'.
			--
			-- `a_checked': True to check all items, False to uncheck.
		local
			l_grid: like grid_warnings
			l_row: EV_GRID_ROW
			l_count, i: INTEGER
		do
			l_grid := grid_warnings
			from
				i := 1
				l_count := l_grid.row_count
			until
				i > l_count
			loop
				l_row := l_grid.row (i)
				if attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_row.item (1) as l_check_item then
					if a_checked /= l_check_item.is_checked then
						l_check_item.set_is_checked (a_checked)
					end
				end
				i := i + 1
			end
		end

feature -- Actions

	filter_changed_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN; exclude: BOOLEAN]]
			-- Action called when a filter has been changed.

feature {ES_ERROR_LIST_TOOL_PANEL} -- Action handlers

	on_shown
			-- Called when widget is display
		require
			is_displayed: is_displayed
		do
			grid_warnings.set_focus
		end

feature {NONE} -- Action handlers

	on_filter_changed (a_item: EV_GRID_CHECKABLE_LABEL_ITEM)
			-- Call when a filter state has changed.
			--
			-- `a_item': Changed item.
		local
			l_data: TUPLE [type: TYPE [ANY]; exact_only: BOOLEAN]
		do
			internal_filtered := Void
			l_data ?= a_item.data
			if l_data /= Void then
				filter_changed_actions.call ([l_data.type, l_data.exact_only, not a_item.is_checked])
			end
		end

	on_grid_key_release (a_key: EV_KEY)
			-- Called after a key has been released
			--
			-- `a_key': Key that was released
		do
			if a_key /= Void then
				if a_key.code = keys.key_escape then
					parent.hide
				elseif a_key.code = keys.key_space or a_key.code = keys.key_enter then
					toggle_selected_rows
				end
			end
		end

	on_select_all
			-- Called when user selects all filters
		do
			check_all_rows (True)
		end

	on_select_none
			-- Called when user selects no filters
		do
			check_all_rows (False)
		end

feature {NONE} -- Internal implementation cache

	internal_filtered: like filtered
			-- Cached version of `filtered'
			-- Note: Do not use directly!

invariant
	grid_warnings_attached: grid_warnings /= Void
	filter_changed_actions_attached: filter_changed_actions /= Void

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
