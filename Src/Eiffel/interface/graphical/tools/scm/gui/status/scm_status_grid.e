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

			set_auto_resizing_column (checkbox_column, True)
--			column (checkbox_column).set_width (20)
			set_auto_resizing_column (filename_column, True)
			set_auto_resizing_column (parent_column, True)
			set_auto_resizing_column (scm_column, True)

			row_select_actions.extend (agent on_row_selected)
			row_deselect_actions.extend (agent on_row_deselected)

			enable_default_tree_navigation_behavior (True, True, True, True)
			key_press_actions.extend (agent  (k: EV_KEY)
				do
					if k.code = {EV_KEY_CONSTANTS}.key_space then
						if attached selected_rows_in_grid as lst then
							across
								lst as ic
							loop
								if attached {EV_GRID_CHECKABLE_LABEL_ITEM} ic.item.item (checkbox_column) as cb then
									cb.toggle_is_checked
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
		do
			create mi.make_with_text ("...")
			a_menu.extend (mi)
		end

	pebble_for_item (a_item: EV_GRID_ITEM): detachable ANY
		local
			st: FILE_LOCATION_STONE
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
					create st.make_with_path (g.location)
					Result := st
				elseif attached {SCM_STATUS} a_item.data as l_status then
					create st.make_with_path (l_status.location)
					Result := st
				elseif attached {PATH} a_item.data as l_path then
					create st.make_with_path (l_path)
					Result := st
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
