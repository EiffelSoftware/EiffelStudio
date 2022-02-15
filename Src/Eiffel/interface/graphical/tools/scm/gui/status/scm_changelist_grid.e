note
	description: "Summary description for {SCM_CHANGELIST_GRID}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_CHANGELIST_GRID

inherit
	SCM_GRID
		redefine
			initialize,
			destroy
		end

	SCM_CHANGELIST_COLLECTION_OBSERVER
		undefine
			default_create,
			copy
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

	make_with_workspace (chlst: SCM_CHANGELIST_COLLECTION; a_parent_box: detachable SCM_STATUS_BOX)
		do
			changelist := chlst
			chlst.register_observer (Current)
			status_box := a_parent_box
			default_create
		end

	initialize
		do
			Precursor

			set_configurable_target_menu_mode
			set_configurable_target_menu_handler (agent context_menu_handler)
			set_item_pebble_function (agent pebble_for_item)

			set_column_count_to (3)
--			column (checkbox_column).set_title ("")
			column (status_column).set_title (scm_names.header_status)
			column (filename_column).set_title (scm_names.header_name)
			column (parent_column).set_title (scm_names.header_folder)


--			set_auto_resizing_column (checkbox_column, True)
--			column (checkbox_column).set_width (20)
			set_auto_resizing_column (status_column, True)
			set_auto_resizing_column (filename_column, True)
			set_auto_resizing_column (parent_column, True)

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

			populate
		end

feature -- Access

	changelist: SCM_CHANGELIST_COLLECTION

	status_box: detachable SCM_STATUS_BOX

feature -- Events

	on_item_removed (a_changelist: SCM_CHANGELIST; a_item: SCM_STATUS)
			-- Item `a_item` was removed from associated `a_changelist`
		do
			if attached checkable_label_for_status (a_item) as cb then
				cb.set_is_checked (False)
			end
		end

	on_item_added (a_changelist: SCM_CHANGELIST; a_item: SCM_STATUS)
			-- Item `a_item` was added to associated `a_changelist`
		do
			if attached checkable_label_for_status (a_item) as cb then
				cb.set_is_checked (True)
			elseif attached row_for_changelist (a_changelist) as l_row then
				add_status_to_changelist_row (a_item, a_changelist, l_row)
			else
				add_changelist (a_changelist)
			end
		end

	on_changelist_reset (a_changelist: SCM_CHANGELIST)
			-- Associated `a_changelist` was reset.
			-- no more item.
		do
			populate
		end

	on_row_selected (r: EV_GRID_ROW)
		do
		end

	on_row_deselected (r: EV_GRID_ROW)
		do
		end

feature -- PnD

	pebble_for_item (a_item: EV_GRID_ITEM): detachable ANY
		do
			if Result = Void then
				if attached {SCM_STATUS} a_item.data as l_status then
					create {SCM_STATUS_STONE} Result.make (l_status)
				end
			end
		end

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


feature -- Layout settings

	checkbox_column: INTEGER
		do
			Result := status_column
		end

	status_column: INTEGER = 1
	filename_column: INTEGER = 2
	parent_column: INTEGER = 3

feature -- Operations

	populate
		do
			set_row_count_to (0)
			across
				changelist as coll_ic
			loop
				add_changelist (coll_ic.item)
			end
		end

	add_changelist (a_changelist: SCM_CHANGELIST)
		local
			glab: EV_GRID_LABEL_ITEM
			r: EV_GRID_ROW
		do
			r := extended_new_row
			r.set_data (a_changelist.root)
			glab := new_label_item (a_changelist.root.nature)
			r.set_item (status_column, glab)

			add_new_span_label_item_to (a_changelist.root.location_path_name, filename_column, <<parent_column>>, r)
			set_row_style_properties (r, bold_font, stock_colors.blue, Void)
			across
				a_changelist as ic
			loop
				add_status_to_changelist_row (ic.item, a_changelist, r)
			end
		end

	add_status_to_changelist_row (a_status: SCM_STATUS; a_changelist: SCM_CHANGELIST; a_parent_row: EV_GRID_ROW)
		local
			r: EV_GRID_ROW
			glab: EV_GRID_LABEL_ITEM
			gcb: like new_checkable_label_item
		do
			r := extended_new_subrow (a_parent_row)
			r.set_data (a_status)

			gcb := new_checkable_label_item (a_status.status_as_string)
--					glab := new_label_item (l_status.status_as_string)
--					r.set_item (status_column, glab)
			r.set_item (status_column, gcb)
			gcb.set_is_checked (True)
			gcb.checked_changed_actions.extend (agent (i_root: SCM_LOCATION ; i_st: SCM_STATUS; i_cb: EV_GRID_CHECKABLE_LABEL_ITEM)
				do
					if i_cb.is_checked then
						changelist.extend_status (i_root, i_st)
					else
						changelist.remove_status (i_root, i_st)
					end

				end (a_changelist.root, a_status, ?))

			glab := new_label_item (a_status.location.entry.name)
			glab.set_data (a_status)
			r.set_item (filename_column, glab)
			if
				attached {SCM_STATUS_UNVERSIONED} a_status
				or attached {SCM_STATUS_UNKNOWN} a_status
			then
				-- Ignore
			else
				glab.set_tooltip (scm_names.double_click_show_diff_tooltip)
				glab.pointer_double_press_actions.extend (agent (a_root: SCM_LOCATION; i_status: SCM_STATUS; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
						do
							if attached status_box as l_status_box then
								if
									attached scm_s.service as scm and then
									not (ev_application.ctrl_pressed or ev_application.shift_pressed or ev_application.alt_pressed)
								then
									l_status_box.show_status_diff (a_root, i_status)
								else
									l_status_box.grid.open_file_location (i_status.location)
								end
							end
						end(a_changelist.root, a_status, ?,?,?,?,?,?,?,?)
					)
			end


			glab.set_pixmap (status_pixmap (a_status))

			glab := new_label_item (a_status.location.parent.name)
			r.set_item (parent_column, glab)

			fill_empty_grid_items (r)

			if a_parent_row.is_expandable and then not a_parent_row.is_expanded then
				a_parent_row.expand
			end
		end

feature {NONE} -- Implementation

	checkable_label_for_status (a_status: SCM_STATUS): detachable like new_checkable_label_item
		local
			r, rn: INTEGER
			c, cn: INTEGER
			l_item: EV_GRID_ITEM
		do
			from
				r := 1
				rn := row_count
			until
				r > rn or Result /= Void
			loop
				if
					attached row (r) as l_row and then
					attached {SCM_STATUS} l_row.data as l_row_status and then
					a_status.location.same_as (l_row_status.location)
				then
					from
						c := 1
						cn := l_row.count
					until
						c > cn or Result /= Void
					loop
						l_item := l_row.item (c)
						if attached {like new_checkable_label_item} l_row.item (c) as cb then
							Result := cb
						end
						c := c + 1
					end
				end
				r := r + 1
			end
		end

	row_for_changelist (a_chglist: SCM_CHANGELIST): detachable EV_GRID_ROW
		local
			r, rn: INTEGER
		do
			from
				r := 1
				rn := row_count
			until
				r > rn or Result /= Void
			loop
				if
					attached row (r) as l_row and then
					attached {SCM_LOCATION} l_row.data as l_loc and then
					l_loc.same_as (a_chglist.root)
				then
					Result := l_row
				end
				r := r + 1
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
		end

	destroy
		do
			if attached changelist as lst then
				lst.unregister_observer (Current)
			end
			Precursor
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
