note
	description: "Summary description for {SCM_STATUS_BOX}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_STATUS_BOX

inherit
	EV_VERTICAL_BOX
		redefine
			initialize
		end

	SHARED_SOURCE_CONTROL_MANAGEMENT_SERVICE
		undefine
			default_create,
			is_equal,
			copy
		end

	SHARED_SCM_NAMES
		undefine
			default_create,
			is_equal,
			copy
		end

	EB_SHARED_WINDOW_MANAGER
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (win: EB_DEVELOPMENT_WINDOW)
		do
			development_window := win
			default_create
		end

	initialize
		do
			Precursor
			build_interface (Current)
		end

	build_interface (b: EV_VERTICAL_BOX)
		local
			bar: EV_HORIZONTAL_BOX
			but: EV_BUTTON
			unver_cb: EV_CHECK_BUTTON
		do
			create bar
			bar.set_padding_width (5)
			bar.set_border_width (10)
			b.extend (bar)
			b.disable_item_expand (bar)

			create unver_cb.make_with_text (scm_names.question_show_unversioned_files)
			bar.extend (unver_cb); bar.disable_item_expand (unver_cb)
			unver_cb.select_actions.extend (agent (a_cb: EV_CHECK_BUTTON)
					do
						include_unversioned_files (a_cb.is_selected)
					end(unver_cb))

			bar.extend (create {EV_CELL})

			create but.make_with_text (scm_names.button_check)
			check_selected_repo_button := but
			but.disable_sensitive
			but.select_actions.extend (agent
					do
						update_statuses (selected_repository)
					end
				)
			bar.extend (but); bar.disable_item_expand (but)

			create but.make_with_text (scm_names.button_save)
			save_selected_repo_button := but
			but.disable_sensitive
			but.select_actions.extend (agent
					do
						on_save
					end
				)
			bar.extend (but); bar.disable_item_expand (but)

			create but.make_with_text (scm_names.button_check_all)
			check_all_repo_button := but
			but.select_actions.extend (agent
					do
						update_statuses (Void)
					end
				)
			bar.extend (but); bar.disable_item_expand (but)

			create but.make_with_text (scm_names.button_save_all)
			save_all_repo_button := but
			but.disable_sensitive
			but.select_actions.extend (agent
					do
						on_global_save
					end
				)
			bar.extend (but); bar.disable_item_expand (but)

			create grid_cell
			b.extend (grid_cell)
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW

	check_selected_repo_button,
	save_selected_repo_button: EV_BUTTON

	check_all_repo_button,
	save_all_repo_button: EV_BUTTON

feature -- Basic operation

	set_workspace (ws: SCM_WORKSPACE)
		local
			g: like grid
		do
			workspace := ws
			g := grid
			if g /= Void and then attached g.parent as p then
				p.prune_all (g)
			end
			create g.make_with_workspace (Current, ws)
			grid_cell.replace (g)
			grid := g

--			g.set_workspace (ws)
		end

	include_unversioned_files (b: BOOLEAN)
		do
			if attached grid as g then
				g.include_unversioned_files (b)
			end
		end

	update_statuses (loc: detachable SCM_LOCATION)
		do
			if attached grid as g then
				g.update_statuses (loc)
			end
		end

	reset
		do
			if attached grid as g then
				g.reset
			end
		end

	set_selected_repository (loc: detachable SCM_LOCATION)
		do
			selected_repository := loc
			if loc = Void then
				save_selected_repo_button.disable_sensitive
				check_selected_repo_button.disable_sensitive
			else
				save_selected_repo_button.enable_sensitive
				check_selected_repo_button.enable_sensitive
			end
		end

	open_save_dialog (a_commit: SCM_COMMIT_SET)
		local
			l_save_dialog: SCM_SAVE_DIALOG
		do
			if attached scm_s.service as scm then
				create l_save_dialog.make (scm, a_commit)
				l_save_dialog.set_size (800, 600)
				l_save_dialog.show_on_active_window
				if a_commit.is_processed then
					if attached {SCM_SINGLE_COMMIT_SET} a_commit as l_single then
						update_statuses (l_single.changelist.root)
					elseif attached {SCM_MULTI_COMMIT_SET} a_commit as l_multi then
						across
							l_multi.changelists as ic
						loop
							update_statuses (ic.item.root)
						end
					end
				end
			else
				check service_available: False end
			end
		end

	save_location (loc: SCM_LOCATION)
		local
			l_commit: SCM_SINGLE_COMMIT_SET
		do
			if attached grid.changes_for (loc) as l_changelist then
				create l_commit.make_with_changelist (Void, l_changelist)
				open_save_dialog (l_commit)
				if l_commit.is_processed then
					update_statuses (loc)
				end
			end
		end

	on_save
		do
			if attached selected_repository as loc then
				save_location (loc)
			end
		end

	on_global_save
		local
			lst: ARRAYED_LIST [SCM_CHANGELIST]
			l_commit: SCM_COMMIT_SET
		do
			create lst.make (1)
			across
				grid.scm_rows as r_ic
			loop
				if attached grid.changes_for (r_ic.item.root_location) as l_changelist and then l_changelist.count > 0 then
					lst.force (l_changelist)
				end
			end
			if attached scm_s.service as scm then
				if lst.count = 1 and then attached lst.first as l_changelist then
					create {SCM_SINGLE_COMMIT_SET} l_commit.make_with_changelist (Void, l_changelist)
					open_save_dialog (l_commit)
				else
					create {SCM_MULTI_COMMIT_SET} l_commit.make_with_changelists (Void, lst)
					open_save_dialog (l_commit)
				end
			else
				check service_available: False end
			end
		end

	on_configuration_updated
		do
			across
				grid.scm_rows as ic
			loop
				ic.item.update
			end
		end

	on_statuses_updated (a_root: SCM_LOCATION; a_location: PATH; a_statuses: detachable SCM_STATUS_LIST)
		do
			if attached grid as g then
				g.on_statuses_updated (a_root, a_location, a_statuses)
			end
		end

	show_diff (a_diff: SCM_DIFF)
		local
			d: SCM_DIFF_DIALOG
		do
			if attached scm_s.service as scm then
				create d.make (scm, a_diff)
				d.set_is_modal (False)
				if attached development_window as devwin then
					d.set_size (devwin.dpi_scaler.scaled_size (700).min (devwin.window.width), devwin.dpi_scaler.scaled_size (500).min (devwin.window.height))
				end
				d.show_on_active_window
			end
		end

	show_command_execution (a_op: READABLE_STRING_GENERAL; a_output: READABLE_STRING_GENERAL)
		local
			d: SCM_COMMAND_EXECUTION_DIALOG
		do
			if attached scm_s.service as scm then
				create d.make (scm, a_op, a_output)
				d.set_is_modal (False)
				if attached development_window as devwin then
					d.set_size (devwin.dpi_scaler.scaled_size (700).min (devwin.window.width), devwin.dpi_scaler.scaled_size (500).min (devwin.window.height))
				end
				d.show_on_active_window
			end
		end

feature -- Access

	workspace: detachable SCM_WORKSPACE

	selected_repository: detachable SCM_LOCATION

	grid_cell: EV_CELL

	grid: detachable SCM_STATUS_GRID

invariant
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
