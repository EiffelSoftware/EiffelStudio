note
	description: "Summary description for {SCM_STATUS_GRID}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_STATUS_GRID

inherit
	SCM_GRID
		redefine
			initialize
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create,
			copy
		end

	SHARED_WORKBENCH
		undefine
			default_create,
			copy
		end

create
	make_with_workspace

feature {NONE} -- Initialization

	make_with_workspace (box: SCM_STATUS_BOX; ws: SCM_WORKSPACE)
		do
			status_box := box
			default_create
			unversioned_files_included := box.unversioned_files_included
			location_with_no_change_hidden := box.location_with_no_change_hidden
			set_workspace (ws)
		end

	initialize
		do
			Precursor

			set_configurable_target_menu_mode
			set_configurable_target_menu_handler (agent context_menu_handler)
			set_item_pebble_function (agent pebble_for_item)

			set_column_count_to (5)
			column (checkbox_column).set_title ("")
			column (filename_column).set_title (scm_names.header_name)
			column (parent_column).set_title (scm_names.header_folder)
			column (scm_column).set_title (scm_names.header_repository)
			column (info_column).set_title ("...")

			enable_resize_column (filename_column)
			enable_resize_column (parent_column)

			set_auto_resizing_column (checkbox_column, True)
--			column (checkbox_column).set_width (20)
			set_auto_resizing_column (filename_column, True)
			set_auto_resizing_column (parent_column, True)
			set_auto_resizing_column (scm_column, True)
			enable_column_separators

			enable_last_column_use_all_width

			enable_multiple_row_selection

			row_select_actions.extend (agent on_row_selected)
			row_deselect_actions.extend (agent on_row_deselected)

			enable_default_tree_navigation_behavior (True, True, True, True)
			key_press_actions.extend (agent  (k: EV_KEY)
				local
					l_checked: BOOLEAN
				do
					if k.code = {EV_KEY_CONSTANTS}.key_space then
						if attached selected_rows_in_grid as lst then
							l_checked := True
							across
								lst as ic
							until
								not l_checked
							loop
								if attached {EV_GRID_CHECKABLE_LABEL_ITEM} ic.item.item (checkbox_column) as cb then
									l_checked := l_checked and cb.is_checked
								end
							end
							across
								lst as ic
							loop
								if attached {EV_GRID_CHECKABLE_LABEL_ITEM} ic.item.item (checkbox_column) as cb then
--									cb.toggle_is_checked
									cb.set_is_checked (not l_checked)
								end
							end
						end
					end
				end
			)
		end

feature -- Actions

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: detachable ANY)
		local
			mi: EV_MENU_ITEM
			mm: EV_MENU
			l_shift_pressed: BOOLEAN
			l_show_menu: BOOLEAN
		do
			l_shift_pressed := ev_application.shift_pressed
			if preferences.misc_data.is_pnd_mode then
				l_show_menu := l_shift_pressed
			else
				l_show_menu := not l_shift_pressed
			end
			if l_show_menu then
					-- See  `pebble_for_item`
				if attached {FILED_STONE} a_pebble as l_file_location_stone then
					if
						attached status_box as l_status_box and then
						attached l_status_box.scm_service as scm and then
						attached {SCM_STATUS_STONE} l_file_location_stone as l_status_stone
					then
						if attached l_status_stone.status as l_status then
							create mi
							mi.set_data (l_status)
							mi.set_pixmap (status_pixmap (l_status))
							mi.set_text (scm_names.menu_item_status (l_status_stone.stone_name, l_status.status_as_string))
							a_menu.extend (mi)
							mi.disable_sensitive
							a_menu.extend (create {EV_MENU_SEPARATOR})
							if attached {SCM_STATUS_UNVERSIONED} l_status then
								create mi
								mi.set_text (scm_names.menu_add)
								mi.select_actions.extend (agent l_status_box.show_add_operation (Void, l_status))
								a_menu.extend (mi)
							else
								if
									attached {SCM_STATUS_MODIFIED} l_status
									or attached {SCM_STATUS_ADDED} l_status
									or attached {SCM_STATUS_DELETED} l_status
									or attached {SCM_STATUS_CONFLICTED} l_status
								then
									create mi
									mi.set_text (scm_names.menu_diff)
									mi.select_actions.extend (agent l_status_box.show_status_diff (Void, l_status))
									a_menu.extend (mi)
								end

								create mi
								mi.set_text (scm_names.menu_revert)
								mi.select_actions.extend (agent l_status_box.show_revert_operation (Void, l_status))
								a_menu.extend (mi)

								create mi
								mi.set_text (scm_names.menu_delete)
								mi.select_actions.extend (agent l_status_box.show_delete_operation (Void, l_status))
								a_menu.extend (mi)

								create mi
								mi.set_text (scm_names.menu_update)
								mi.select_actions.extend (agent l_status_box.show_update_operation (Void, l_status))
								a_menu.extend (mi)
							end

							create mm.make_with_text (scm_names.menu_add_to_changelist (Void, 0))
							across
								scm.changelists as ic
							loop
								create mi.make_with_text (scm_names.menu_add_to_changelist (ic.key, ic.item.count))
								mi.select_actions.extend (agent (i_scm: SOURCE_CONTROL_MANAGEMENT_S; i_chglist_name: READABLE_STRING_GENERAL; i_status: SCM_STATUS)
										do
											if attached i_scm.changelists [i_chglist_name] as ch then
												ch.extend_status (i_scm.scm_root_location (i_status.location), i_status)
												i_scm.on_changelist_updated (ch)
											end
										end(scm, ic.key, l_status)
									)
								mm.extend (mi)
							end
							if mm.count > 0 then
								a_menu.extend (mm)
							end
						end
					end

					a_menu.extend (create {EV_MENU_SEPARATOR})
					create mi.make_with_text (scm_names.open_location)
					mi.select_actions.extend (agent open_file_location (create {PATH}.make_from_string (l_file_location_stone.file_name)))
					a_menu.extend (mi)
				elseif attached {PATH} a_pebble as l_path then
						-- Should not occur anymore
					create mi.make_with_text (scm_names.open_parent_location)
					mi.select_actions.extend (agent open_directory_location (l_path))
					a_menu.extend (mi)
				end
			end
		end

	pebble_for_item (a_item: EV_GRID_ITEM): detachable ANY
		local
			grp: SCM_GROUP
		do
			if attached a_item.row as l_row then
				if attached {SCM_STATUS_WC_LOCATION_ROW} l_row.data as l_loc_row then
					grp := l_loc_row.associated_group
				elseif
					attached l_row.parent_row as l_parent_row and then
					attached {SCM_STATUS_WC_LOCATION_ROW} l_parent_row.data as l_loc_row
				then
					grp := l_loc_row.associated_group
				end
			end
			if Result = Void then
				if attached {SCM_GROUP} a_item.data as g then
					create {FILE_LOCATION_STONE} Result.make_with_path (g.location)
				elseif attached {SCM_STATUS} a_item.data as l_status then
					create {SCM_STATUS_STONE} Result.make (l_status)
				elseif attached {PATH} a_item.data as l_path then

				else
				end
			end
		end

	propagate_checkbox_state_to_subrows (cb: EV_GRID_CHECKABLE_LABEL_ITEM; a_opt_col: INTEGER)
		local
			i, n, j, k: INTEGER
			b: BOOLEAN
		do
			if attached cb.row as r then
				n := r.subrow_count
				if n > 0 then
					b := cb.is_checked
					from
						i := 1
					until
						i > n
					loop
						if attached r.subrow (i) as sr then
							if
								a_opt_col > 0 and then
								attached {EV_GRID_CHECKABLE_LABEL_ITEM} sr.item (a_opt_col) as sub_cb
							then
								sub_cb.set_is_checked (b)
							else
								from
									j := 1
									k := sr.count
								until
									j > k
								loop
									if attached {EV_GRID_CHECKABLE_LABEL_ITEM} sr.item (j) as sub_cb then
										sub_cb.set_is_checked (b)
									end
								end
								j := j + 1
							end
						end
						i := i + 1
					end
				end
			end
		end

feature -- Events

	on_row_selected (r: EV_GRID_ROW)
		do
			if attached {SCM_STATUS_WC_ROW} r.data as l_wc_row then
				on_wc_selected (l_wc_row)
			elseif attached {SCM_STATUS_WC_LOCATION_ROW} r.data as l_wc_loc_row then
				on_wc_selected (l_wc_loc_row.parent_row)
			elseif attached {SCM_STATUS} r.data as st then
			end
		end

	on_row_deselected (r: EV_GRID_ROW)
		do
			if attached {SCM_STATUS_WC_ROW} r.data as l_wc_row then
				on_wc_deselected (l_wc_row)
			elseif attached {SCM_STATUS_WC_LOCATION_ROW} r.data as l_wc_loc_row then
				on_wc_deselected (l_wc_loc_row.parent_row)
			else
				on_wc_deselected (Void)
			end
		end

	on_wc_selected (a_repo: SCM_STATUS_WC_ROW)
		do
		end

	on_wc_deselected (a_repo: detachable SCM_STATUS_WC_ROW)
		do
		end

	on_changes_updated (a_repo: SCM_STATUS_WC_ROW)
		local
			nb: INTEGER
		do
			across
				scm_rows as ic
			loop
				nb := nb + ic.item.changes_count
			end
			if nb = 0 then
				if attached status_box.active_changelist as lst then
					nb := lst.count
				end
			end
			if nb > 0 then
				status_box.save_all_repo_button.enable_sensitive
			else
				status_box.save_all_repo_button.disable_sensitive
			end
		end

feature -- Access

	status_box: SCM_STATUS_BOX

	workspace: SCM_WORKSPACE

	scm_rows: detachable ARRAYED_LIST [SCM_STATUS_WC_ROW]

	unversioned_files_included: BOOLEAN

	location_with_no_change_hidden: BOOLEAN

feature -- Query

	changes_for	(loc: SCM_LOCATION): detachable SCM_CHANGELIST
		do
			across
				scm_rows as ic
			until
				Result /= Void
			loop
				if attached ic.item as l_row and then l_row.root_location.location.same_as (loc.location) then
					Result := l_row.changes
				end
			end
		end

feature -- Layout settings

	filename_column: INTEGER = 1
	parent_column: INTEGER = 2
	checkbox_column: INTEGER = 3
	scm_column: INTEGER = 4
	info_column: INTEGER = 5

feature -- Operations

	populate
		local
			r: SCM_LOCATION
			l_row: EV_GRID_ROW
			i: INTEGER
			l_supported: BOOLEAN
			l_wc_row: SCM_STATUS_WC_ROW
		do
			set_row_count_to (0)
			create scm_rows.make (1)
			if
				attached workspace as ws and then
				attached ws.locations_by_root as locs and then
				not locs.is_empty
			then
				across
					locs as ic
				loop
					i := i + 1
					insert_new_row (row_count + 1)
					l_row := row (row_count)
					r := ic.item.root
					l_supported := True
					if attached {SCM_SVN_LOCATION} r as r_svn then
						create {SCM_SVN_ROW} l_wc_row.make (Current, r_svn, ic.item.groups)
					elseif attached {SCM_GIT_LOCATION} r as r_git then
						create {SCM_GIT_ROW} l_wc_row.make (Current, r_git, ic.item.groups)
					else
						create {SCM_UNSUPPORTED_ROW} l_wc_row.make (Current, r, ic.item.groups)
						l_supported := False
					end
					l_wc_row.attach_to_grid_row (Current, l_row)
					scm_rows.force (l_wc_row)
				end
			end
		end

	fill_empty_grid_items (r: EV_GRID_ROW)
		local
			i, n: INTEGER
		do
			from
				i := 1
				n := column_count
			until
				i > n
			loop
				if i > r.count or else r.item (i) = Void then
					r.set_item (i, create {EV_GRID_ITEM})
				end
				i := i + 1
			end
		end

	reset
		do
			if attached scm_rows as lst then
				across
					lst as ic
				loop
					ic.item.reset
				end
				refresh_now
			end
		end

	apply_changelist_collection (a_changelist_collection: SCM_CHANGELIST_COLLECTION)
		do
			if attached scm_rows as lst then
				across
					lst as ic
				loop
					ic.item.apply_changelist (a_changelist_collection.changelist (ic.item.root_location))
				end
			end
		end

	update_statuses (loc: detachable SCM_LOCATION)
		do
			status_box.scm_service.on_update_statuses_enter
			if attached scm_rows as lst then
				across
					lst as ic
				loop
					if loc = Void or else loc.same_as (ic.item.root_location) then
						ic.item.update_statuses
					end
				end
				refresh_now
			end
			status_box.scm_service.on_update_statuses_leave
		end

	update_status (a_status: SCM_STATUS)
		do
			if
				attached status_box as l_status_box and then
				attached l_status_box.scm_service as scm and then
				attached scm.scm_root_location (a_status.location) as loc
			then
				update_statuses (loc)
			end
		end

	on_statuses_updated (a_root: detachable SCM_LOCATION; a_location: PATH; a_statuses: detachable SCM_STATUS_LIST)
		do
			if attached scm_rows as lst then
				across
					lst as ic
				loop
					if a_root = Void or else a_root.same_as (ic.item.root_location) then
						ic.item.on_statuses_updated (a_location, a_statuses)
					end
				end
				refresh_now
			end
		end

feature -- Basic operation

	set_workspace (ws: SCM_WORKSPACE)
		require
			ws /= Void
		do
			workspace := ws
			populate
		end

	include_unversioned_files (b: BOOLEAN)
		do
			if unversioned_files_included /= b then
				unversioned_files_included := b
				update_statuses (Void)
			end
		end

	hide_location_with_no_change (b: BOOLEAN)
		do
			if location_with_no_change_hidden /= b then
				location_with_no_change_hidden := b
				update_statuses (Void)
			end
		end

invariant

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
