indexing
	description: "Metric criterion definition grid"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CRITERION_GRID

inherit
	ES_EDITOR_TOKEN_GRID
		redefine
			on_key_pressed
		end

	QL_SHARED_NAMES
		undefine
			is_equal,
			default_create,
			copy
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE}all
		undefine
			is_equal,
			default_create,
			copy
		end

	EB_CONSTANTS
		export
			{NONE}all
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			is_equal,
			default_create,
			copy
		end

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize `scope' with `a_scope'
		local
			l_grid_supprot: like new_grid_support
		do
			create change_actions
			default_create
			enable_tree
			enable_row_separators
			enable_column_separators

			set_column_count_to (2)
			column (2).set_width (100)
			enable_single_item_selection
			column (1).set_title (metric_names.t_criterion)
			column (2).set_title (metric_names.t_properties)
			set_item_pebble_function (agent criterion_pebble)
			set_item_veto_pebble_function (agent veto_pebble_function)
			item_drop_actions.extend (agent on_item_drop)
			set_selected_rows_function (agent selected_rows_internal)
			enable_default_tree_navigation_behavior (True, True, True, True)
			key_press_string_actions.extend (agent on_key_string_pressed)
			enable_selection_on_single_button_click
			l_grid_supprot := new_grid_support (Current)
			l_grid_supprot.enable_grid_item_pnd_support
		ensure then
			tree_enabled: is_tree_enabled
		end

feature -- Basic operation

	resize_column (a_index: INTEGER; a_width: INTEGER) is
			-- Resize `a_index'-th column to `a_width' in pixels.
			-- If `a_width' is 0, resize specified column to its content.
		require
			a_index_valid: a_index > 0 and then a_index <= column_count
		local
			l_width: INTEGER
		do
			if row_count > 0 then
				if a_width = 0 then
					l_width := column (a_index).required_width_of_item_span (1, row_count)
					if l_width + 5 > column (a_index).width then
						column (a_index).set_width (l_width + 5)
					end
				else
					column (a_index).set_width (a_width)
				end
			end
		end

	load_criterion (a_criterion: like criterion; a_scope: like scope; a_read_only: BOOLEAN) is
			-- Load `a_criterion' in Current.
			-- `a_read_only' indicates if `a_criterion' loaded in Current is in read-only mode.				
		require
			a_scope_attached: a_scope /= Void
			criterion_matches_scope: a_criterion /= Void implies a_criterion.scope = a_scope
		local
			l_row: EB_METRIC_CRITERION_ROW
		do
			scope := a_scope
			is_criterion_loaded := True
			is_read_only := a_read_only

			insert_new_row (1)
			change_actions.block
			create l_row.make (a_criterion, row (1), Current, is_read_only, scope)
			change_actions.resume

			resize_column (1, 0)
			resize_column (2, 0)
		ensure
			criterion_loaded: is_criterion_loaded
			scope_set: scope = a_scope
			is_read_only_set: is_read_only = a_read_only
		end

	load_undefinable_criteria is
			-- Load undefinable criteria such as compliation basic metric.
		do
			is_criterion_loaded := True
		end

	clear_criterion is
			-- Clear criterion loaded in Current
		do
			change_actions.block
			if row_count > 0 then
				remove_rows (1, row_count)
			end
			is_criterion_loaded := False
			is_read_only := False
			scope := Void
			change_actions.resume
		ensure
			no_criterion_loaded: not is_criterion_loaded
			scope_not_attached: scope = Void
			is_read_only_set: not is_read_only
		end

	add_criterion_row (a_criterion: like criterion; a_row: EV_GRID_ROW; a_before: BOOLEAN; a_selected: BOOLEAN) is
			-- Add a new row containing `a_criterion' before `a_row' if `a_before' is Ture, otherwise,
			-- after `a_row'. If `a_selected' is True, select newly added row.
		require
			criterion_loaded: is_criterion_loaded
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent = Current
		local
			l_data: EB_METRIC_CRITERION_ROW
			l_new: EB_METRIC_CRITERION_ROW
			l_new_row: EV_GRID_ROW
			l_parent: EB_METRIC_CRITERION_ROW
			l_subrow_index: INTEGER
		do
			l_data ?= a_row.data
			check l_data /= Void end
			if a_row.parent_row /= Void then
					-- `a_row' is a sub-row.
				l_subrow_index := subrow_index (a_row.parent_row, a_row)
				if not a_before then
					l_subrow_index := l_subrow_index + 1
				end
				a_row.parent_row.insert_subrow (l_subrow_index)
				l_new_row := a_row.parent_row.subrow (l_subrow_index)
				create l_new.make (a_criterion, l_new_row, Current, is_read_only, scope)
				l_parent ?= a_row.parent_row.data
				check l_parent /= Void end
				l_parent.register_subrow (l_new)
				if a_selected then
					remove_selection
					l_new_row.enable_select
				end
				change_actions.call (Void)
			end
		end

	remove_criterion_row (a_row: EV_GRID_ROW; a_empty_row_removable: BOOLEAN; a_select_row: BOOLEAN) is
			-- Remove `a_row' from Current.
			-- If `a_empty_row_removable' is True, remove `a_row' even if it's an empty row.
			-- If `a_select_row' is True, try to selected the nearest row related to `a_row'
		require
			criterion_loaded: is_criterion_loaded
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent = Current
		local
			l_data: EB_METRIC_CRITERION_ROW
			l_parent: EB_METRIC_CRITERION_ROW
			l_should_remove: BOOLEAN
			l_old_row_index: INTEGER
		do
			l_data ?= a_row.data
			check l_data /= Void end
			if a_row.index = 1 then
				l_should_remove := True
			else
				if a_row.parent_row /= Void then
						-- `a_row' is a sub-row.
					if a_empty_row_removable or else not l_data.is_empty_row then
						l_parent ?= a_row.parent_row.data
						check l_parent /= Void end
						l_parent.remove_subrow (l_data)
						l_should_remove := True
					end
				end
			end
			if l_should_remove then
				l_old_row_index := a_row.index
				if a_row.subrow_count_recursive > 0 then
					remove_rows (a_row.index + 1, a_row.index + a_row.subrow_count_recursive)
				end
				remove_row (a_row.index)
				if row_count = 0 then
					load_criterion (Void, scope, is_read_only)
				end
				if a_select_row then
					if row_count > 0 then
						if l_old_row_index <= row_count then
							select_row (l_old_row_index)
						else
							select_row (row_count)
						end
					end
				end
				change_actions.call (Void)
			end
		end

	move_criterion_row (a_row: EV_GRID_ROW; a_up: BOOLEAN) is
			-- Move `a_row' up if `a_up' is True, otherwise move `a_row' down.
		require
			criterion_loaded: is_criterion_loaded
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent = Current
		local
			l_data: EB_METRIC_CRITERION_ROW
			l_parent_row: EB_METRIC_CRITERION_ROW
			l_move_available: BOOLEAN
			l_new_subrow_index: INTEGER
			l_old_subrow_index: INTEGER
		do
			l_data ?= a_row.data
			if l_data /= Void and then l_data.parent /= Void then
				l_parent_row := l_data.parent
				check l_parent_row.grid_row.subrow_count > 0 end
				l_old_subrow_index := subrow_index (l_parent_row.grid_row, l_data.grid_row)
				if a_up then
					l_move_available := l_old_subrow_index > 1
					l_new_subrow_index := l_old_subrow_index - 1
				else
					l_move_available := l_old_subrow_index < l_parent_row.grid_row.subrow_count
					l_new_subrow_index := l_old_subrow_index + 1
				end
				if l_move_available then
					change_actions.block
					add_criterion_row (l_data.criterion, l_parent_row.grid_row.subrow (l_new_subrow_index), a_up, True)
					remove_criterion_row (a_row, True, False)
					change_actions.resume
					change_actions.call (Void)
				end
			end
		end

	indent_criterion_row (a_row: EV_GRID_ROW; a_and: BOOLEAN) is
			-- Indent `a_row' using "AND" operator if `a_and' is True, otherwise using "OR" operator.
		require
			criterion_loaded: is_criterion_loaded
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent = Current
		local
			l_data: EB_METRIC_CRITERION_ROW
			l_parent_row: EB_METRIC_CRITERION_ROW
			l_nary_cri: EB_METRIC_NARY_CRITERION
			l_criterion: EB_METRIC_CRITERION
			l_new_row: EB_METRIC_CRITERION_ROW
			l_item: EV_GRID_ITEM
		do
			change_actions.block
			l_data ?= a_row.data
			if not l_data.is_empty_row then
					-- We only indent non-empty row.
				l_criterion := l_data.criterion
				check l_criterion /= Void end
				l_parent_row := l_data.parent
				if l_parent_row /= Void then
					l_parent_row.remove_subrow (l_data)
				end
				if a_and then
					create {EB_METRIC_AND_CRITERION} l_nary_cri.make (scope, query_language_names.ql_cri_and)
				else
					create {EB_METRIC_OR_CRITERION} l_nary_cri.make (scope, query_language_names.ql_cri_or)
				end
				l_nary_cri.operands.extend (l_criterion)
				create l_new_row.make (l_nary_cri, l_data.grid_row, Current, is_read_only, scope)
				if l_parent_row /= Void then
					l_parent_row.register_subrow (l_new_row)
				end
				remove_selection
				l_item := l_new_row.grid_row.subrow (l_new_row.grid_row.subrow_count).item (1)
				if l_item /= Void then
					l_item.enable_select
				end
			end
			change_actions.resume
			change_actions.call (Void)
		end

feature -- Status report

	is_criterion_loaded: BOOLEAN
			-- Has any criterion been loaded in Current?

	is_read_only: BOOLEAN
			-- Is criterion in current read only?

feature -- Access

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when any kind of change occurs in current

	scope: QL_SCOPE
			-- Scope in Current

	criterion: EB_METRIC_CRITERION is
			-- Criterion defined in Current
		require
			criterion_loaded: is_criterion_loaded
		local
			l_row: EB_METRIC_CRITERION_ROW
		do
			if row_count > 0 then
				l_row ?= row (1).data
				if l_row /= Void then
					Result := l_row.criterion
				end
			end
		end

feature -- Actions

	on_item_drop (a_item: EV_GRID_ITEM; a_pebble: ANY) is
			-- Action to be performed when `a_pebble' is dropped on `a_item'
		local
			l_source_row: EV_GRID_ROW
			l_source_data: EB_METRIC_CRITERION_ROW
			l_dest_row: EV_GRID_ROW
			l_dest_data: EB_METRIC_CRITERION_ROW
			l_criterion: EB_METRIC_CRITERION
			l_source_parent: EB_METRIC_CRITERION_ROW
			l_dest_parent: EB_METRIC_CRITERION_ROW
			l_new_row: EV_GRID_ROW
			l_old_index: INTEGER
			l_new_data: EB_METRIC_CRITERION_ROW
			l_agent: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, EV_GRID_ITEM]]
			l_last_row: EB_METRIC_CRITERION_ROW
			l_insert_index: INTEGER
			l_stone: STONE
			l_domain_grid_item: EB_METRIC_GRID_DOMAIN_ITEM [ANY]
			l_value_criterion_item: EB_METRIC_VALUE_CRITERION_GRID_ITEM
			l_metric: EB_METRIC
		do
			if a_item /= Void then
				change_actions.block
				l_stone ?= a_pebble
				l_metric ?= a_pebble
				if l_stone /= Void then
						-- Pebble is a stone.
					l_domain_grid_item ?= a_item
					if l_domain_grid_item /= Void then
						l_domain_grid_item.drop_pebble (l_stone)
						resize_column (2, 0)
					end
				elseif l_metric /= Void then
					l_value_criterion_item ?= a_item
					if l_value_criterion_item /= Void then
						l_value_criterion_item.drop_pebble (l_metric)
						resize_column (2, 0)
					end
				else
					l_dest_row := a_item.row
					l_dest_data ?= l_dest_row.data
					l_source_row ?= a_pebble
					if l_source_row /= Void then
						l_source_data ?= l_source_row.data
					end
					if l_source_data /= Void and then l_dest_data /= Void and then l_source_row.index /= l_dest_row.index then
						if l_dest_data.is_empty_row then
								-- Item is dropped on an empty row, it will replace the empty row.
							l_criterion := l_source_data.criterion
							check l_criterion /= Void end
							remove_criterion_row (l_source_data.grid_row, True, False)
							l_dest_parent := l_dest_data.parent
							check l_dest_parent /= Void end
							l_insert_index := subrow_index (l_dest_parent.grid_row, l_dest_data.grid_row)
							l_dest_parent.grid_row.insert_subrow (l_insert_index)
							l_new_row := l_dest_parent.grid_row.subrow (l_insert_index)
							create l_new_data.make (l_criterion, l_new_row, Current, is_read_only, scope)
							l_dest_data.register_subrow (l_new_data)
						elseif l_dest_data.is_valid_nary_row then
								-- Item is dropped on an "AND" or "OR" row, it will become a row of the "AND" or "OR" row.
							l_criterion := l_source_data.criterion
							check l_criterion /= Void end
							l_source_parent := l_source_data.parent
							remove_criterion_row (l_source_data.grid_row, True, False)
							l_insert_index := l_dest_data.grid_row.subrow_count
							if l_insert_index = 0 then
								l_insert_index := 1
							else
								l_last_row ?= l_dest_data.grid_row.subrow (l_insert_index).data
								check l_last_row /= Void end
								if not l_last_row.is_empty_row then
									l_insert_index := l_insert_index + 1
								end
							end
							l_dest_data.grid_row.insert_subrow (l_insert_index)
							l_new_row := l_dest_data.grid_row.subrow (l_insert_index)

							create l_new_data.make (l_criterion, l_new_row, Current, is_read_only, scope)
							l_dest_data.register_subrow (l_new_data)

							if l_dest_data.grid_row.is_expandable and then not l_dest_data.grid_row.is_expanded then
								l_dest_data.grid_row.expand
							end
						else
								-- Item is dropped on a criterion row, it will be inserted into current position.
							l_criterion := l_source_data.criterion
							check l_criterion /= Void end
							l_source_parent := l_source_data.parent
							remove_criterion_row (l_source_data.grid_row, True, False)
							check l_dest_data.parent /= Void end
							l_dest_parent := l_dest_data.parent
							l_old_index := subrow_index (l_dest_data.parent.grid_row, l_dest_data.grid_row)
							l_dest_parent.grid_row.insert_subrow (l_old_index + 1)
							l_new_row := l_dest_parent.grid_row.subrow (l_old_index + 1)
							create l_new_data.make (l_criterion, l_new_row, Current, is_read_only, scope)
							l_dest_parent.register_subrow (l_new_data)
						end
						row_to_be_selected := l_new_row
						l_agent := agent on_pointer_button_release
						pointer_button_release_item_actions.extend (l_agent)
						pointer_button_release_item_actions.prune_when_called (l_agent)
					end
				end
				change_actions.resume
				change_actions.call (Void)
			end
		end

feature{NONE} -- Implementation/Actions

	on_pointer_button_release (x, y, button: INTEGER; a_item: EV_GRID_ITEM) is
			-- Action to be performed when pointer released
		do
			if button = 3 and then row_to_be_selected /= Void and then row_to_be_selected.parent = Current then
				remove_selection
				row_to_be_selected.enable_select
				row_to_be_selected := Void
			end
		end

	on_key_pressed (a_key: EV_KEY) is
			-- Action to be performed when `a_key' is pressed on Current
		local
			l_selected_items: LIST [EV_GRID_ITEM]
			l_domain_criterion_item: EB_METRIC_GRID_DOMAIN_ITEM [ANY]
			l_grid_item: EV_GRID_ITEM
			l_key_code: INTEGER
		do
			Precursor (a_key)
			l_key_code := a_key.code
			if l_key_code /= {EV_KEY_CONSTANTS}.key_tab then
				if l_key_code = {EV_KEY_CONSTANTS}.key_f2 or l_key_code = {EV_KEY_CONSTANTS}.key_enter then
					l_selected_items := selected_items
					if not l_selected_items.is_empty then
						l_grid_item := l_selected_items.first
						l_grid_item.activate
						l_domain_criterion_item ?= l_grid_item
						if l_domain_criterion_item /= Void then
							l_domain_criterion_item.show_dialog
						end
					end
				end
			end
		end

	on_key_string_pressed (a_string: STRING_32) is
			-- Action to be performed when `a_string' is pressed on Current
		require
			a_string_attached: a_string /= Void
		local
			l_selected_items: LIST [EV_GRID_ITEM]
			l_grid_editable_item: EV_GRID_EDITABLE_ITEM
		do
			if not (a_string.is_equal (once "%N") or a_string.is_equal (once "%T")) then
				l_selected_items := selected_items
				if not l_selected_items.is_empty then
					l_selected_items.first.activate
					l_grid_editable_item ?= l_selected_items.first
					if l_grid_editable_item /= Void then
						l_grid_editable_item.text_field.set_text (a_string)
						if not a_string.is_empty then
							l_grid_editable_item.text_field.set_caret_position (a_string.count + 1)
						end
					end
				end
			end
		end

feature{NONE} -- Implementation

	subrow_index (a_parent_row, a_subrow: EV_GRID_ROW): INTEGER is
			-- Subrow index of `a_subrow' in `a_parent_row'.
			-- Return 0 if `a_subrow' doesn't belong to `a_parent_row'.
		require
			a_parent_row_attached: a_parent_row /= Void
			a_parent_parented: a_parent_row.parent /= Void
			a_subrow_attached: a_subrow /= Void
			a_subrow_parented: a_subrow.parent /= Void
		local
			l_index: INTEGER
			l_count: INTEGER
		do
			if a_parent_row.subrow_count > 0 then
				from
					l_index := 1
					l_count := a_parent_row.subrow_count
				until
					l_index > l_count or Result > 0
				loop
					if a_parent_row.subrow (l_index) = a_subrow then
						Result := l_index
					else
						l_index := l_index + 1
					end
				end
			end
		end

	row_to_be_selected: EV_GRID_ROW
			-- Row to be selected when pointer button released

	criterion_pebble (a_item: EV_GRID_ITEM): ANY is
			-- Pebble from `a_item'.
		local
			l_data: EB_METRIC_CRITERION_ROW
		do
			if a_item /= Void and then a_item.column.index = 1 then
				l_data ?= a_item.row.data
				if l_data /= Void then
					Result := a_item.row
					set_accept_cursor (cursors.cur_criteria)
					set_deny_cursor (cursors.cur_x_criteria)
				end
			end
		end

	veto_pebble_function (a_item: EV_GRID_ITEM; a_pebble: ANY): BOOLEAN is
			-- Function to decide if `a_pebble' can be dropped on `a_item'
			-- True value means drop is allowed.
		local
			l_source_row: EV_GRID_ROW
			l_source_data: EB_METRIC_CRITERION_ROW
			l_dest_row: EV_GRID_ROW
			l_dest_data: EB_METRIC_CRITERION_ROW
			l_domain_item: EB_METRIC_GRID_DOMAIN_ITEM [ANY]
		do
			if a_item /= Void then
				if a_item.column.index = 1 then
						-- Dropped on criterion name column
					l_source_row ?= a_pebble
					l_dest_row := a_item.row
					l_dest_data ?= l_dest_row.data
					if l_source_row /= Void then
						l_source_data ?= l_source_row.data
					end
					if l_source_data /= Void and then l_dest_data /= Void and then l_source_row.index /= l_dest_row.index then
						if not l_source_data.is_empty_row then
							Result := not is_parent_row (l_dest_row, l_source_row)
						end
					end
				elseif a_item.column.index = 2 then
						-- Dropped on criterion property column
					l_domain_item ?= a_item
					Result := l_domain_item /= Void and then l_domain_item.is_pebble_droppable (a_pebble)
				end
			end
		end

	is_parent_row (a_source_row, a_dest_row: EV_GRID_ROW): BOOLEAN is
			-- Is `a_dest_row' parent row of `a_source_row'?
		require
			a_source_row_attached: a_source_row /= Void
			a_source_row_parented: a_source_row.parent /= Void
			a_dest_row_attached: a_dest_row /= Void
			a_dest_row_parented: a_dest_row.parent /= Void
		local
			l_parent_row: EV_GRID_ROW
		do
			from
				l_parent_row := a_source_row.parent_row
			until
				l_parent_row = Void or Result
			loop
				Result := l_parent_row = a_dest_row
				l_parent_row := l_parent_row.parent_row
			end
		end

	selected_rows_internal: LIST [EV_GRID_ROW] is
			-- Selected rows from `select_items'
		local
			l_items: LIST [EV_GRID_ITEM]
			l_row_table: HASH_TABLE [EV_GRID_ROW, INTEGER]
		do
			if is_single_row_selection_enabled then
				Result := selected_rows
			else
				l_items := selected_items
				create {ARRAYED_LIST [EV_GRID_ROW]}Result.make (l_items.count)
				create l_row_table.make (l_items.count)
				from
					l_items.start
				until
					l_items.after
				loop
					l_row_table.force (l_items.item.row, l_items.item.row.index)
					l_items.forth
				end
				from
					l_row_table.start
				until
					l_row_table.after
				loop
					Result.extend (l_row_table.item_for_iteration)
					l_row_table.forth
				end
			end
		ensure
			result_attached: Result /= Void
		end

invariant
	change_actions_attached: change_actions /= Void

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
