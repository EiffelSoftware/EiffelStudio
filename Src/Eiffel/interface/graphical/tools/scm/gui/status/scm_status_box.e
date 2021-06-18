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

	EB_SHARED_PIXMAPS
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

	make (a_service: SOURCE_CONTROL_MANAGEMENT_S; win: EB_DEVELOPMENT_WINDOW)
		do
			scm_service := a_service
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
			l_combo: EV_COMBO_BOX
			pix: EV_PIXMAP
			pix_cell: EV_CELL
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

			create but.make_with_text (scm_names.button_check_all)
			check_all_repo_button := but
			but.select_actions.extend (agent
					do
						update_statuses (Void)
					end
				)
			bar.extend (but); bar.disable_item_expand (but)

			bar.extend (create {EV_CELL})
			
			create but.make_with_text (scm_names.button_save_changelist)
			but.set_tooltip (scm_names.button_save_changelist_tooltip)
			save_all_repo_button := but
			but.disable_sensitive
			but.select_actions.extend (agent on_save)
			bar.extend (but); bar.disable_item_expand (but)


			create l_combo
			l_combo.return_actions.extend (agent on_changelist_combo_changed)
			changelist_combo := l_combo
			update_changelist_combo (l_combo)
			bar.extend (l_combo)

			create pix_cell
			pix := icon_pixmaps.general_remove_icon
			pix_cell.extend (pix)
			pix_cell.set_minimum_size (pix.width, pix.height)
			pix.set_tooltip (scm_names.button_clear_changelist_tooltip)
			pix.pointer_button_release_actions.extend (agent (ix,iy,ibut: INTEGER; r1,r2,r3: REAL_64; i7,i8: INTEGER)
					do
						if ibut = {EV_POINTER_CONSTANTS}.left then
							on_clear_active_changelist
						end
					end)
			bar.extend (pix_cell)
			bar.disable_item_expand (pix_cell)

			create grid_cell
			b.extend (grid_cell)
		end

feature -- Access

	scm_service: SOURCE_CONTROL_MANAGEMENT_S

	development_window: EB_DEVELOPMENT_WINDOW

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
			g.drop_actions.extend (agent stone_dropped_on_grid)
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

	stone_dropped_on_grid (a_pebble: STONE)
		local
			p: PATH
		do
			if attached active_changelist as ch then
				if attached {FILED_STONE} a_pebble as l_filed_stone then
					create p.make_from_string (l_filed_stone.file_name)
					if attached scm_service.scm_root_location (p) as l_root then
						ch.extend_path (l_root, p)
						scm_service.on_changelist_updated (ch)
					end
				end
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

	open_save_dialog (a_commit: SCM_COMMIT_SET)
		local
			l_save_dialog: SCM_SAVE_DIALOG
		do
			create l_save_dialog.make (scm_service, a_commit)
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
		local
			l_commit: SCM_COMMIT_SET
		do
			if attached active_changelist as lst then
				if lst.changelist_count = 1 and then attached lst.first_changelist as l_changelist then
					create {SCM_SINGLE_COMMIT_SET} l_commit.make_with_changelist (Void, l_changelist)
					open_save_dialog (l_commit)
				else
					create {SCM_MULTI_COMMIT_SET} l_commit.make_with_changelists (Void, lst)
					open_save_dialog (l_commit)
				end
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
			create d.make (scm_service, a_diff)
			d.set_is_modal (False)
			if attached development_window as devwin then
				d.set_size (devwin.dpi_scaler.scaled_size (700).min (devwin.window.width), devwin.dpi_scaler.scaled_size (500).min (devwin.window.height))
			end
			d.show_on_active_window
		end

	show_command_execution (a_op: READABLE_STRING_GENERAL; a_output: READABLE_STRING_GENERAL)
		local
			d: SCM_COMMAND_EXECUTION_DIALOG
		do
			create d.make (scm_service, a_op, a_output)
			d.set_is_modal (False)
			if attached development_window as devwin then
				d.set_size (devwin.dpi_scaler.scaled_size (700).min (devwin.window.width), devwin.dpi_scaler.scaled_size (500).min (devwin.window.height))
			end
			d.show_on_active_window
		end

feature -- Access

	workspace: detachable SCM_WORKSPACE

	grid_cell: EV_CELL

	grid: detachable SCM_STATUS_GRID

feature -- Changelist

	changelists: STRING_TABLE [SCM_CHANGELIST_COLLECTION]
		do
			Result := scm_service.changelists
		end

	changelist_combo: detachable EV_COMBO_BOX

	active_changelist_name: detachable IMMUTABLE_STRING_32

	on_clear_active_changelist
		local
			lst: like active_changelist
		do
			lst := active_changelist
			if lst /= Void then
				lst.wipe_out
				if changelists.count > 1 then
					changelists.remove (lst.name)
				end
				active_changelist_name := Void
				lst := active_changelist
				if lst /= Void then
					on_changelist_selected (lst)
				end
			end
		end

	active_changelist: detachable SCM_CHANGELIST_COLLECTION
		do
			if attached active_changelist_name as n then
				Result := changelists [n]
			elseif
				attached changelist_combo as l_combo and then
				attached l_combo.text as l_name
			then
				Result := changelists [l_name]
			elseif not changelists.is_empty then
				changelists.start
				Result := changelists.item_for_iteration
			end
		end

	on_changelist_combo_changed
		local
			l_new: SCM_CHANGELIST_COLLECTION
			l_name: READABLE_STRING_GENERAL
		do
			if attached changelist_combo as l_combo then
				l_name := l_combo.text
				if not changelists.has (l_name) then
					create l_new.make (l_name, 10)
					changelists [l_new.name] := l_new
				end
				if attached changelists [l_name] as sel then
					on_changelist_selected (sel)
				end

				update_changelist_combo (l_combo)
			end
		end

	on_changelist_selected (a_collection: SCM_CHANGELIST_COLLECTION)
			-- Update grid with changelist from `a_collection`
			-- update the grid even if `a_collection` was already the active one.
		do
			active_changelist_name := a_collection.name
			if attached grid as g then
				g.apply_changelist_collection (a_collection)
			end
		end

	update_changelist_combo (a_combo: EV_COMBO_BOX)
		local
			li: EV_LIST_ITEM
		do
			a_combo.return_actions.block
			a_combo.wipe_out
			across
				changelists as ic
			loop
				create li.make_with_text (ic.item.name)
				a_combo.extend (li)
				if attached active_changelist_name as sel then
					if sel.same_string (ic.item.name) then
						li.enable_select
					end
				elseif a_combo.count = 1 then
					li.enable_select
				end
				li.select_actions.extend (agent on_changelist_selected (ic.item))
				li.set_tooltip (ic.item.count.out + " item(s)")
			end
			a_combo.return_actions.resume
		end

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
