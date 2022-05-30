note
	description: "Grid row holding a SCM supported working copy (svn wc, or git repo)."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCM_SUPPORTED_ROW

inherit
	SCM_STATUS_WC_ROW

feature -- Access

	scm_name: STRING
		deferred
		end

feature -- Operation

	populate_row (a_grid: SCM_STATUS_GRID; a_row: EV_GRID_ROW)
		local
			glab: EV_GRID_LABEL_ITEM
			eglab: EV_GRID_LABEL_ELLIPSIS_ITEM
			cblab: EV_GRID_CHECKABLE_LABEL_ITEM
			l_groups: ARRAYED_LIST [PATH]
			l_scm_rows: like scm_rows
			l_scm_location_row: SCM_STATUS_WC_LOCATION_ROW
			l_subrow: EV_GRID_ROW
			gloc: PATH
			l_is_supported: like is_supported
		do
			l_is_supported := is_supported
			a_row.set_item (a_grid.checkbox_column, create {EV_GRID_ITEM})

			add_new_span_label_item_to (root_location.location.name, a_grid.filename_column, <<a_grid.parent_column>>, a_row)
			if attached a_row.item (a_grid.filename_column) as gi then
				gi.set_data (root_location.location)
				gi.pointer_double_press_actions.extend (agent (i_loc: PATH; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
						do
							if attached parent_grid as pg then
								pg.open_directory_location (i_loc)
							end
						end(root_location.location, ?,?,?,?,?,?,?,?)
					)
				gi.pointer_button_press_actions.extend (agent (i_item: EV_GRID_ITEM; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
						do
							if i_button = {EV_POINTER_CONSTANTS}.right then
								on_options (i_item)
							end
						end (glab, ?,?,?,?,?,?,?,?)
					)
			end
			if attached a_row.item (a_grid.parent_column) as gi then
				-- FIXME: write better code to avoid code duplication
				gi.pointer_double_press_actions.extend (agent (i_loc: PATH; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
						do
							if attached parent_grid as pg then
								pg.open_directory_location (i_loc)
							end
						end(root_location.location, ?,?,?,?,?,?,?,?)
					)
				gi.pointer_button_press_actions.extend (agent (i_item: EV_GRID_ITEM; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
						do
							if i_button = {EV_POINTER_CONSTANTS}.right then
								on_options (i_item)
							end
						end (glab, ?,?,?,?,?,?,?,?)
					)
			end

			cblab := new_checkable_label_item ("")
			a_row.set_item (a_grid.checkbox_column, cblab)
			cblab.set_is_checked (l_is_supported)
			cblab.checked_changed_actions.extend (agent propagate_checkbox_state_to_subrows (?, a_grid.checkbox_column))


			eglab := new_label_ellipsis_item (scm_name)
			eglab.ellipsis_actions.extend (agent on_options (eglab))
			glab := eglab
--			glab := new_label_item (scm_name)
			glab.pointer_button_press_actions.extend (agent (i_item: EV_GRID_ITEM; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
						do
							if i_button = {EV_POINTER_CONSTANTS}.right then
								on_options (i_item)
							end
						end (glab, ?,?,?,?,?,?,?,?)
					)
			a_row.set_item (a_grid.scm_column, glab)

			if l_is_supported then
				a_row.set_item (a_grid.info_column, Void)
			else
				glab := new_label_item (scm_names.label_not_available_check_configuration)
				glab.pointer_double_press_actions.extend (agent (i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
						local
							dlg: SCM_CONFIG_DIALOG
						do
							if attached scm_s.service as scm then
								create dlg.make (scm)
								dlg.show_on_active_window
							end
						end
					)
				a_row.set_item (a_grid.info_column, glab)
			end


--			glab.pointer_button_press_actions.extend (agent on_options)
			if l_is_supported then
				a_grid.set_row_style_properties (a_row, a_grid.bold_font, a_grid.stock_colors.blue, Void)
			else
				a_grid.set_row_style_properties (a_row, a_grid.bold_font, a_grid.stock_colors.dark_grey, Void)
			end

			a_grid.fill_empty_grid_items (a_row)
			if all_content_included then
				create l_groups.make (1)
				l_groups.extend (root_location.location)
			elseif
				attached sorted_group_locations as l_group_locations and then
				not l_group_locations.is_empty
			then
				l_groups := l_group_locations
			end

			if l_groups /= Void and then not l_groups.is_empty then
				l_scm_rows := scm_rows -- FIXME
				if l_scm_rows = Void then
					create l_scm_rows.make (l_groups.count)
					scm_rows := l_scm_rows
				end

--				l_row.insert_subrows (ic.item.groups.count, 1)

				across
					l_groups as g_ic
				loop
					gloc := g_ic.item
					a_row.insert_subrow (a_row.subrow_count + 1)
					l_subrow := a_row.subrow (a_row.subrow_count)

					if l_is_supported then
						create l_scm_location_row.make_checked (a_grid, Current, l_subrow, gloc)
					else
						create l_scm_location_row.make (a_grid, Current, l_subrow, gloc)
					end
					l_scm_rows.force (l_scm_location_row)

					a_grid.fill_empty_grid_items (l_subrow)
				end
				if a_row.subrow_count = 0 then
					a_row.collapse
				else
					a_row.expand
					a_row.show
				end
			end
		end

	show_location_update
		local
			ch_list: SCM_CHANGELIST
		do
			if attached scm_s.service as scm then
				create ch_list.make_with_location (root_location)
				ch_list.extend_path (root_location.location)
				if
					ch_list /= Void and then
					attached scm.update (ch_list) as l_update
				then
					parent_grid.status_box.show_command_execution ("update", l_update)
				end
			end
		end

	show_changes_diff
		do
			if
				attached scm_s.service as scm and then
				attached parent_grid.changes_for (root_location) as ch_list and then
				attached scm.diff (ch_list) as l_diff
			then
				parent_grid.status_box.show_diff (l_diff)
			end
		end

	show_location_diff
		do
			parent_grid.status_box.show_location_diff (root_location, root_location.location)
		end

	on_options (a_item: EV_GRID_ITEM)
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			mci: EV_CHECK_MENU_ITEM
			l_is_supported: BOOLEAN
		do
			l_is_supported := is_supported
			create m
			if not l_is_supported then
				create mi.make_with_text_and_action (scm_names.menu_configuration, agent
					local
						dlg: SCM_CONFIG_DIALOG
					do
						if attached scm_s.service as scm then
							create dlg.make (scm)
							dlg.show_on_active_window
						end
					end)
					m.extend (mi)
			end

			create mi.make_with_text_and_action (scm_names.menu_check, agent update_statuses)
			m.extend (mi)
			if not l_is_supported then
				mi.disable_sensitive
			end

			create mi.make_with_text_and_action (scm_names.menu_commit, agent
					do
						parent_grid.status_box.save_location (root_location)
					end)
			m.extend (mi)
			if changes_count = 0 then
				mi.disable_sensitive
			end
			if not l_is_supported then
				mi.disable_sensitive
			end

			if attached {SCM_GIT_LOCATION} root_location as l_git_root_location then
				create mi.make_with_text_and_action (scm_names.menu_git_push, agent (i_git_loc: SCM_GIT_LOCATION)
						do
							parent_grid.status_box.git_push_location (i_git_loc)
						end(l_git_root_location))
				m.extend (mi)
				create mi.make_with_text_and_action (scm_names.menu_git_pull, agent (i_git_loc: SCM_GIT_LOCATION)
						do
							parent_grid.status_box.git_pull_location (i_git_loc)
						end(l_git_root_location))
				m.extend (mi)
				create mi.make_with_text_and_action (scm_names.menu_git_rebase, agent (i_git_loc: SCM_GIT_LOCATION)
						do
							parent_grid.status_box.git_rebase_location (i_git_loc)
						end(l_git_root_location))
				m.extend (mi)
			else
				create mi.make_with_text_and_action (scm_names.menu_update, agent show_location_update)
				m.extend (mi)
				if not l_is_supported then
					mi.disable_sensitive
				end
			end

			create mi.make_with_text_and_action (scm_names.menu_diff, agent show_location_diff)
			m.extend (mi)
			if not l_is_supported then
				mi.disable_sensitive
			end
			create mi.make_with_text_and_action (scm_names.menu_diff_selection, agent show_changes_diff)
			m.extend (mi)
			if not l_is_supported or changes_count = 0 then
				mi.disable_sensitive
			end

			create mci.make_with_text_and_action (scm_names.question_show_unversioned_files, agent
					do
						repo_unversioned_files_included := not repo_unversioned_files_included
						if
							attached groups as l_groups and then
							not l_groups.is_empty
						then
							across
								l_groups as ic
							loop
								ic.item.include_unversioned_files (repo_unversioned_files_included)
							end
						end
						update_statuses
					end
				)
			if repo_unversioned_files_included then
				mci.enable_select
			end
			m.extend (mci)
			if not l_is_supported then
				mci.disable_sensitive
			end


			create mci.make_with_text_and_action (scm_names.question_include_all_content, agent
					do
						all_content_included := not all_content_included
						update
					end
				)
			if all_content_included then
				mci.enable_select
			end
			if not l_is_supported then
				mci.disable_sensitive
			end

			m.extend (mci)
			m.show
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
