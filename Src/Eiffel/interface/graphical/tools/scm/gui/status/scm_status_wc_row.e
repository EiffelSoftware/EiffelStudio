note
	description: "Summary description for {SCM_STATUS_WC_ROW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCM_STATUS_WC_ROW

inherit
	ANY

	SCM_SHARED_RESOURCES
		undefine
			default_create, copy
		end

	ES_SHARED_FONTS_AND_COLORS
		undefine
			default_create, copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

	SHARED_SOURCE_CONTROL_MANAGEMENT_SERVICE
		undefine
			default_create, copy
		end

convert
	row: {EV_GRID_ROW}

feature {NONE} -- Initialization

	make (a_parent_grid: like parent_grid; a_root: like root_location; a_groups: STRING_TABLE [SCM_GROUP])
		do
			root_location := a_root
			groups := a_groups
		end

feature -- Access

	root_location: SCM_LOCATION

	groups: STRING_TABLE [SCM_GROUP]

	sorted_group_locations: detachable ARRAYED_LIST [PATH]
		local
			p: PATH
			l_sorter: QUICK_SORTER [PATH]
		do
			if attached groups as l_groups and then not l_groups.is_empty then
				create Result.make (l_groups.count)
				across
					l_groups as ic
				loop
					if ic.item.is_included then
						p := ic.item.location
						if across Result as ric some p.same_as (ric.item) end then
								-- Already in the list
						else
							Result.force (p)
						end
					end
				end
				if Result.is_empty then
					Result := Void
				elseif Result.count > 1 then
					create l_sorter.make (create {COMPARABLE_COMPARATOR [PATH]})
					l_sorter.sort (Result)
				end
			end
		end

	unversioned_files_included (a_grid: SCM_STATUS_GRID; a_location: PATH): BOOLEAN
		local
			g: SCM_GROUP
		do
			if a_grid.unversioned_files_included or repo_unversioned_files_included then
				Result := True
			elseif attached groups as l_groups and then not l_groups.is_empty then
				across
					l_groups as ic
				until
					Result
				loop
					g := ic.item
					if g.location.same_as (a_location) then
						Result := g.unversioned_files_included
					end
				end
			end
		end

	all_content_included: BOOLEAN

	repo_unversioned_files_included: BOOLEAN

feature -- Status report

	is_supported: BOOLEAN
		deferred
		end

feature {SCM_STATUS_CHANGE_ROW, SCM_STATUS_WC_LOCATION_ROW} -- Internal

	parent_grid: SCM_STATUS_GRID

	row: detachable EV_GRID_ROW

	recorded_changes: like changes
		do
			if attached parent_grid.status_box.active_changelist as coll then
				Result := coll.changelist (root_location)
			end
		end

	add_change_to_active_changelist (a_status: SCM_STATUS)
		local
			lst: SCM_CHANGELIST
		do
			if attached parent_grid.status_box.active_changelist as coll then
				lst := coll.changelist (root_location)
				if lst = Void then
					create lst.make_with_location (root_location)
					coll.put_changelist (lst)
				end
				if not lst.has_status (a_status) then
					lst.extend_status (a_status)
					parent_grid.status_box.on_changelist_combo_changed
				end
			end
		end

	remove_change_from_active_changelist (a_status: SCM_STATUS)
		do
			if
				attached parent_grid.status_box.active_changelist as coll and then
				attached coll.changelist (root_location) as lst
			then
				lst.remove_path (a_status.location)
				parent_grid.status_box.on_changelist_combo_changed
			end
		end

	set_recorded_changes (a_changes: like changes)
		local
			lst: SCM_CHANGELIST
		do
			if attached parent_grid.status_box.active_changelist as coll then
				lst := coll.changelist (root_location)
				if lst = Void then
					coll.put_changelist (a_changes)
				else
					across
						a_changes as ic
					loop
						if not lst.has_status (ic.item) then
							lst.extend_status (ic.item)
						end
					end
				end
			end
		end

	scm_rows: detachable ARRAYED_LIST [SCM_STATUS_WC_LOCATION_ROW]

feature -- Factory

	new_label_item (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			Result := parent_grid.new_label_item (a_text)
		end

	add_new_span_label_item_to (a_text: detachable READABLE_STRING_GENERAL; a_master_column: INTEGER; a_span_columns: ITERABLE [INTEGER]; a_row: EV_GRID_ROW)
		require
			a_row /= Void and then not a_row.is_destroyed
		do
			parent_grid.add_new_span_label_item_to (a_text, a_master_column, a_span_columns, a_row)
		end

	new_label_ellipsis_item (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_LABEL_ELLIPSIS_ITEM
		do
			if a_text /= Void then
				create Result.make_with_text (a_text)
			else
				create Result
			end
			parent_grid.set_label_item (Result)
		end

	new_checkable_label_item (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_CHECKABLE_LABEL_ITEM
		do
			Result := parent_grid.new_checkable_label_item (a_text)
		end

feature -- Execution

	attach_to_grid_row (a_grid: SCM_STATUS_GRID; a_row: EV_GRID_ROW)
		do
			parent_grid := a_grid
			row := a_row
			a_row.set_data (Current)
			if a_row.parent /= Void then
				a_row.clear
--				a_row.set_background_color (Void)
			end
			populate_row (a_grid, a_row)
		end

	update
		do
			if attached parent_grid as g and attached row as r then
				if r.parent = g then
					g.remove_and_clear_subrows_from (r)
				end
				scm_rows := Void
				populate_row (g, r)
			end
		end

	populate_row (a_grid: SCM_STATUS_GRID; a_row: EV_GRID_ROW)
		deferred
		end

	reset
		do
			if attached row as r and attached parent_grid as l_grid then
				r.set_item (l_grid.info_column, new_label_item (scm_names.label_resetting))
				l_grid.grid_remove_and_clear_subrows_from (r)
			end
		end

	update_statuses
		local
			r: SCM_STATUS_WC_LOCATION_ROW
		do
			if is_supported then
				set_recorded_changes (changes)
				if attached row as l_row and attached parent_grid as l_grid then
					reset_changes_count
					if attached scm_rows as l_scm_rows then
						across
							l_scm_rows as ic
						loop
							ic.item.set_is_checking
							l_grid.refresh_now
						end

						across
							l_scm_rows as ic
						loop
							r := ic.item
							ev_application.add_idle_action_kamikaze (agent r.update_statuses)
						end
					end
				end
			end
		end

	apply_changelist (a_changes: detachable SCM_CHANGELIST)
		do
			if attached scm_rows as lst then
				across
					lst as ic
				loop
					ic.item.apply_changelist (a_changes)
				end
			end
		end

	on_statuses_updated (a_location: PATH; a_statuses: detachable SCM_STATUS_LIST)
		local
			r: SCM_STATUS_WC_LOCATION_ROW
		do
			if is_supported then
				set_recorded_changes (changes)
				if attached row as l_row and attached parent_grid as l_grid then
					reset_changes_count
					if attached scm_rows as l_scm_rows then
						across
							l_scm_rows as ic
						loop
							r := ic.item
							if a_location.same_as (r.location) then
								r.on_statuses_updated (a_statuses)
							end
						end
					end
				end
			end
		end

	on_checkbox_change_checked (a_change_row: SCM_STATUS_CHANGE_ROW; a_cb: EV_GRID_CHECKABLE_LABEL_ITEM)
		local
			g: like parent_grid
		do
			g := a_change_row.parent_grid
			if a_cb.is_checked then
				increment_changes_count
			else
				decrement_changes_count
			end

			if
				attached a_cb.row as r and then
				attached {SCM_STATUS_CHANGE_ROW} r.data as l_ch_row and then
				attached l_ch_row.status as st
			then
				if a_cb.is_checked then
					add_change_to_active_changelist (st)
				else
					remove_change_from_active_changelist (st)
				end
				if attached {EV_GRID_LABEL_ITEM} r.item (g.filename_column) as glab then
					if a_cb.is_checked then
						if attached {SCM_STATUS_UNVERSIONED} st then
							glab.set_foreground_color (g.stock_colors.dark_red)
						else
							glab.set_foreground_color (g.foreground_color)
						end
						glab.set_font (g.bold_font)
					else
						if attached {SCM_STATUS_UNVERSIONED} st then
							glab.set_foreground_color (colors.disabled_foreground_color)
						end
						glab.set_font (g.grid_font)
					end
				end
			end

			a_change_row.wc_location_row.update_check_status_for_row
			g.on_changes_updated (Current)
		end

	changes_count: INTEGER

	reset_changes_count
		do
			changes_count := 0
		end

	increment_changes_count
		do
			changes_count := changes_count + 1
		end

	decrement_changes_count
		do
			changes_count := changes_count - 1
		end

	changes: detachable SCM_CHANGELIST
			-- Last change list
		local
			i,n: INTEGER
			l_row: EV_GRID_ROW
		do
			if attached parent_grid as l_grid then
				create Result.make_with_location (root_location)
				if attached scm_rows as l_scm_rows then
					across
						l_scm_rows as ic
					loop
						l_row := ic.item
						from
							i := 1
							n := l_row.subrow_count
						until
							i > n
						loop
							if
								attached l_row.subrow (i) as l_subrow and then
								attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_subrow.item (l_grid.checkbox_column) as cb and then
								cb.is_checked and then
								attached {SCM_STATUS_CHANGE_ROW} l_subrow.data as l_ch_row
							then
								if not Result.has_status (l_ch_row.status) then
									Result.extend_status (l_ch_row.status)
								end
							end
							i := i + 1
						end
					end
				end
			end
		end

feature {SCM_STATUS_WC_LOCATION_ROW} -- Implementation

	propagate_checkbox_state_to_subrows (cb: EV_GRID_CHECKABLE_LABEL_ITEM; a_opt_col: INTEGER)
		do
			if attached parent_grid as g then
				g.propagate_checkbox_state_to_subrows (cb, a_opt_col)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
