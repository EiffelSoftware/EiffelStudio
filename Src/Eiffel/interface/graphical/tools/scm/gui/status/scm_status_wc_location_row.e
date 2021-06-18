note
	description: "Summary description for {SCM_STATUS_WC_LOCATION_ROW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_STATUS_WC_LOCATION_ROW

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

create
	make,
	make_checked

convert
	row: {EV_GRID_ROW}

feature {NONE} -- Initialization

	make (a_parent_grid: like parent_grid; a_parent_row: like parent_row; a_row: EV_GRID_ROW; a_location: PATH)
		require
			a_parent_grid /= Void
			a_parent_row /= Void
			a_row /= Void
			a_location /= Void
		do
			parent_grid := a_parent_grid
			parent_row := a_parent_row
			row := a_row
			location := a_location
			a_row.set_data (Current)

			build_row
		end

	make_checked (a_parent_grid: like parent_grid; a_parent_row: like parent_row; a_row: EV_GRID_ROW; a_location: PATH)
		do
			is_checked := True
			make (a_parent_grid, a_parent_row, a_row, a_location)
		end

feature -- Access

	location: PATH

	parent_grid: SCM_STATUS_GRID

	parent_row: SCM_STATUS_WC_ROW

	row: EV_GRID_ROW

	is_checked: BOOLEAN

	associated_group: detachable SCM_GROUP
		do
			if attached parent_row.groups as l_groups then
				if l_groups.count = 1 then
					across
						l_groups as ic
					loop
						Result := ic.item
					end
				else
					Result := l_groups.item (location.name)
				end
			end
		end

feature -- Statistics

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

feature -- Initialization

	build_row
		local
			g: like parent_grid
			glab: EV_GRID_LABEL_ITEM
			eglab: EV_GRID_LABEL_ELLIPSIS_ITEM
			gcblab: EV_GRID_CHECKABLE_LABEL_ITEM
			gloc: PATH
			grel: READABLE_STRING_32
		do
			g := parent_grid
			gloc := location
			grel := parent_row.root_location.relative_location (gloc)

			gcblab := new_checkable_label_item (Void)
			row.set_item (g.checkbox_column, gcblab)
			gcblab.set_is_checked (is_checked)
			gcblab.checked_changed_actions.extend (agent (i_cb: EV_GRID_CHECKABLE_LABEL_ITEM)
					do
						is_checked := i_cb.is_checked
					end
				)
			gcblab.checked_changed_actions.extend (agent g.propagate_checkbox_state_to_subrows (?, g.checkbox_column))

			glab := new_label_item (grel)
			glab.set_data (location)

			glab.pointer_double_press_actions.extend (agent (i_loc: PATH; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
					do
						if attached parent_grid as pg then
							pg.open_directory_location (i_loc)
						end
					end(gloc, ?,?,?,?,?,?,?,?)
				)
			row.set_item (g.filename_column, glab)
			row.set_item (g.parent_column, create {EV_GRID_ITEM})

			if parent_row.is_supported then
				eglab := new_label_ellipsis_item ("")
				eglab.ellipsis_actions.extend (agent on_options (eglab))
				eglab.pointer_button_press_actions.extend (agent (i_item: EV_GRID_ITEM; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
							do
								if i_button = {EV_POINTER_CONSTANTS}.right then
									on_options (i_item)
								end
							end (eglab, ?,?,?,?,?,?,?,?)
						)
				row.set_item (g.scm_column, eglab)
				if
					attached g.scm_s.service as scm_service and then
					attached location as l_scm_location
				then
					if attached scm_service.cached_statuses (l_scm_location) as l_statuses then
						on_statuses_updated (l_statuses)
					end
				end
			end
		end

feature -- Operations

	set_is_checking
		do
			row.set_item (parent_grid.info_column, new_label_item (scm_names.label_checking))
		end

	on_statuses_updated (a_statuses: detachable SCM_STATUS_LIST)
		local
			sr: EV_GRID_ROW
			ch_row: SCM_STATUS_CHANGE_ROW
			st: SCM_STATUS
			s: STRING_32
			nb, unb: INTEGER
			g: like parent_grid
		do
			reset_changes_count
			g := parent_grid
			if
				attached g.scm_s.service as scm_service and then
				attached location as l_scm_location and then
				attached a_statuses as l_chgs
			then
				nb := l_chgs.changes_count
				changes_count := nb
				if nb = 0 then
					row.hide
				elseif nb = 1 then
					row.show
				else
					row.show
				end
				s := scm_names.label_changes_count (nb)
				unb := l_chgs.unversioned_count
				if unb > 0 then
					s.append_string_general (" (")
					s.append_string (scm_names.label_unversioned)
					s.append_string_general (" ")
					s.append_integer (unb)
					s.append_string_general (")")
				end
				row.set_item (g.info_column, new_label_item (s))

				g.grid_remove_and_clear_subrows_from (row)
				if
					nb > 0 or (parent_row.unversioned_files_included (g, l_scm_location) and unb > 0)
				then
					across
						l_chgs as ch_ic
					loop
						st := ch_ic.item
						if
							not attached {SCM_STATUS_UNVERSIONED} st
							or parent_row.unversioned_files_included (g, l_scm_location)
						then
							row.insert_subrow (row.subrow_count + 1)
							sr := row.subrow (row.subrow_count)
							create ch_row.make (Current, parent_row.root_location, st)
							ch_row.attach_to_grid_row (g, sr)
							if
								attached parent_row.recorded_changes as l_recorded_changes and then
								l_recorded_changes.has_path (st.location)
							then
								ch_row.set_selected (True)
							end

							g.fill_empty_grid_items (sr)
						end
					end
				end
				row.expand
			else
				changes_count := 0
				row.set_item (g.info_column, new_label_item ("..."))
			end
			update_check_status_for_row
			update_changes_count
		end

	apply_changelist (a_changes: detachable SCM_CHANGELIST)
		local
			sr: EV_GRID_ROW
			i,n: INTEGER
		do
			from
				i := 1
				n := row.subrow_count
			until
				i > n
			loop
				sr := row.subrow (i)
				if attached {SCM_STATUS_CHANGE_ROW} sr.data as l_ch_row then
					if
						a_changes /= Void and then
						a_changes.has_path (l_ch_row.status.location)
					then
						l_ch_row.set_selected (True)
					else
						l_ch_row.set_selected (False)
					end
				end
				i := i + 1
			end
		end

	update_statuses
		do
			reset_changes_count
			if
				attached parent_grid.scm_s.service as scm_service and then
				attached parent_row.root_location as l_scm_root and then
				attached location as l_scm_location
			then
				on_statuses_updated (scm_service.statuses (l_scm_root, l_scm_location))
			end
			update_check_status_for_row
			update_changes_count
		end

	update_check_status_for_row
		local
			g: like parent_grid
			r: EV_GRID_ROW
			i,n: INTEGER
			l_checked_count: INTEGER
			l_unchecked_count: INTEGER
		do
			reset_changes_count
			g := parent_grid
			r := row
			if
				attached {EV_GRID_CHECKABLE_LABEL_ITEM} r.item (g.checkbox_column) as row_cb
			then
				from
					i := 1
					n := r.subrow_count
				until
					i > n
				loop
					if
						attached r.subrow (i) as sr and then
						attached {EV_GRID_CHECKABLE_LABEL_ITEM} sr.item (g.checkbox_column) as i_cb
					then
						if i_cb.is_checked then
							l_checked_count := l_checked_count + 1
						else
							l_unchecked_count := l_unchecked_count + 1
						end
					end
					i := i + 1
				end
				row_cb.checked_changed_actions.block
				if l_checked_count > 0 then
					if not row_cb.is_checked then
						row_cb.set_is_checked (True)
					end
				elseif row_cb.is_checked then
					row_cb.set_is_checked (False)
				end
				if l_checked_count > 0 and l_unchecked_count > 0 then
					row_cb.set_is_indeterminate (True)
				else
					row_cb.set_is_indeterminate (False)
				end
				row_cb.checked_changed_actions.resume
				row_cb.redraw
			end
		end

	update_changes_count
		local
			i,n: INTEGER
			g: like parent_grid
		do
			reset_changes_count
			g := parent_grid
			from
				i := 1
				n := row.subrow_count
			until
				i > n
			loop
				if
					attached row.subrow (i) as l_subrow and then
					attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_subrow.item (g.checkbox_column) as cb and then
					cb.is_checked
				then
					increment_changes_count
				end
				i := i + 1
			end
		end

	do_update
		local
			ch_list: SCM_CHANGELIST
		do
			if attached scm_s.service as scm then
				create ch_list.make_with_location (parent_row.root_location)
				ch_list.extend_path (location)
				if
					ch_list /= Void and then
					attached scm.update (ch_list) as l_update
				then
					parent_grid.status_box.show_command_execution ("Update", l_update)
				end
			end
		end


	show_diff (a_only_selected_items: BOOLEAN)
		local
			ch_list: SCM_CHANGELIST
		do
			if attached scm_s.service as scm then
				if a_only_selected_items then
					ch_list := parent_grid.changes_for (parent_row.root_location)
				else
					create ch_list.make_with_location (parent_row.root_location)
					ch_list.extend_path (location)
				end
				if
					ch_list /= Void and then
					attached scm.diff (ch_list) as l_diff
				then
					parent_grid.status_box.show_diff (l_diff)
				end
			end
		end

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

feature -- Operation

	on_options (a_item: EV_GRID_ITEM)
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			l_is_supported: BOOLEAN
		do
			l_is_supported := parent_row.is_supported
			if l_is_supported then
				update_changes_count
				create m
				create mi.make_with_text_and_action (scm_names.menu_save, agent
						do
							parent_grid.status_box.save_location (parent_row.root_location)
						end)
				m.extend (mi)
				if changes_count = 0 then
					mi.disable_sensitive
				end

				create mi.make_with_text_and_action (scm_names.menu_check, agent update_statuses)
				m.extend (mi)

				create mi.make_with_text_and_action (scm_names.menu_update, agent do_update)
				m.extend (mi)

				create mi.make_with_text_and_action (scm_names.menu_diff, agent show_diff (False))
				m.extend (mi)

				if changes_count > 0 then
					create mi.make_with_text_and_action (scm_names.menu_diff_selection, agent show_diff (True))
					m.extend (mi)
				end

				m.show
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
