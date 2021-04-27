note
	description: "Summary description for {SCM_STATUS_CHANGE_ROW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_STATUS_CHANGE_ROW

inherit
	ANY

	SCM_SHARED_RESOURCES
		undefine
			default_create, copy
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create, copy
		end

	SHARED_SOURCE_CONTROL_MANAGEMENT_SERVICE
		undefine
			default_create, copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

	ES_SHARED_FONTS_AND_COLORS
		undefine
			default_create, copy
		end

create
	make

convert
	row: {EV_GRID_ROW}

feature {NONE} -- Initialization

	make (a_wc_location_row: SCM_STATUS_WC_LOCATION_ROW; a_root: like root_location; a_status: SCM_STATUS)
		do
			wc_location_row := a_wc_location_row
			wc_row := a_wc_location_row.parent_row
			parent_grid := a_wc_location_row.parent_grid
			root_location := a_root
			status := a_status
		end

feature -- Access

	parent_grid: SCM_STATUS_GRID

	wc_location_row: SCM_STATUS_WC_LOCATION_ROW

	wc_row: SCM_STATUS_WC_ROW

	row: EV_GRID_ROW

	root_location: SCM_LOCATION

	change_location: PATH
		do
			Result := status.location
		end

	status: SCM_STATUS

	is_selected: BOOLEAN

feature -- Element change

	set_selected (b: BOOLEAN)
		do
			is_selected := b
			if attached {EV_GRID_CHECKABLE_LABEL_ITEM} row.item (parent_grid.checkbox_column) as cb then
				cb.set_is_checked (b)
			end
		end

feature -- Execution

	attach_to_grid_row (a_grid: SCM_STATUS_GRID; a_row: EV_GRID_ROW)
		do
			parent_grid := a_grid
			row := a_row
			a_row.set_data (Current)
			a_row.set_data (status)
			if a_row.parent = parent_grid then
				a_row.clear
			end
			update_row (a_grid, a_row)
		end

	update_row (a_grid: SCM_STATUS_GRID; a_row: EV_GRID_ROW)
		local
			l_scm_root: SCM_LOCATION
			sr: EV_GRID_ROW
			st: SCM_STATUS
			rel_loc: READABLE_STRING_32
			lab, l_parent_lab: EV_GRID_LABEL_ITEM
			l_scm_lab: EV_GRID_LABEL_ELLIPSIS_ITEM
			cb_lab: EV_GRID_CHECKABLE_LABEL_ITEM
		do
			l_scm_root := root_location
			st := status
			sr := row

			cb_lab := wc_row.new_checkable_label_item (Void)
			row.set_item (parent_grid.checkbox_column, cb_lab)

			if attached st.location.entry as e then
				rel_loc := e.name
			else
				rel_loc := l_scm_root.relative_location (st.location)
			end
			lab := wc_row.new_label_item (rel_loc)
			lab.set_data (st)
			if attached status_pixmap (st) as pix then
				lab.set_pixmap (pix)
			end

			lab.pointer_double_press_actions.extend (agent (a_root: SCM_LOCATION; i_loc: PATH; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
					local
						ch_list: SCM_CHANGELIST
						l_ext_cmd: READABLE_STRING_GENERAL
					do
						if attached parent_grid as pg then
							if
								attached scm_s.service as scm and then
								ev_application.ctrl_pressed
							then
								if
									attached {SCM_GIT_LOCATION} a_root and then
									scm.config.use_external_git_diff_command
								then
									l_ext_cmd := scm.config.external_git_diff_command (i_loc)
								elseif
									attached {SCM_SVN_LOCATION} a_root and then
									scm.config.use_external_svn_diff_command
								then
									l_ext_cmd := scm.config.external_svn_diff_command (i_loc)
								else
									l_ext_cmd := Void
								end
								if l_ext_cmd /= Void then
									execution_environment.launch (l_ext_cmd)
								else
									create ch_list.make_with_location (wc_row.root_location)
									ch_list.extend_path (i_loc)
									if attached scm.diff (ch_list) as diff then
										parent_grid.status_box.show_diff (diff)
									end
								end
							else
								pg.open_file_location (i_loc)
							end
						end
					end(root_location, st.location, ?,?,?,?,?,?,?,?)
				)
			sr.set_item (parent_grid.filename_column, lab)

			l_parent_lab := wc_row.new_label_item (l_scm_root.relative_location (st.location.parent))
			l_parent_lab.pointer_double_press_actions.extend (agent (i_loc: PATH; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
					do
						if attached parent_grid as pg then
							pg.open_directory_location (i_loc)
						end
					end(st.location.parent, ?,?,?,?,?,?,?,?)
				)
			sr.set_item (parent_grid.parent_column, l_parent_lab)

			if attached {SCM_STATUS_UNVERSIONED} st then
				lab.set_foreground_color (colors.disabled_foreground_color)
				l_parent_lab.set_foreground_color (colors.disabled_foreground_color)
			else
				l_scm_lab := wc_row.new_label_ellipsis_item (st.status_as_string)
				sr.set_item (parent_grid.scm_column, l_scm_lab)
				l_scm_lab.ellipsis_actions.extend (agent on_options (l_scm_lab))
				l_scm_lab.pointer_button_press_actions.extend (agent (i_item: EV_GRID_ITEM; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
							do
								if i_button = {EV_POINTER_CONSTANTS}.right then
									on_options (i_item)
								end
							end (l_scm_lab, ?,?,?,?,?,?,?,?)
						)
				wc_row.increment_changes_count
			end

			cb_lab.set_data (st)
			cb_lab.checked_changed_actions.extend (agent wc_row.on_checkbox_change_checked (Current, ?))
		end

	status_pixmap (a_status: SCM_STATUS): detachable EV_PIXMAP
		do
			if attached {SCM_STATUS_MODIFIED} a_status then
				Result := icon_pixmaps.source_modified_icon
			elseif attached {SCM_STATUS_ADDED} a_status then
				Result := icon_pixmaps.source_added_icon
			elseif attached {SCM_STATUS_DELETED} a_status then
				Result := icon_pixmaps.source_deleted_icon
			elseif attached {SCM_STATUS_CONFLICTED} a_status then
				Result := icon_pixmaps.source_conflicted_icon
			elseif attached {SCM_STATUS_UNVERSIONED} a_status then
				Result := icon_pixmaps.source_unversioned_icon
			else
			end
		end

	show_diff
		local
			ch_list: SCM_CHANGELIST
		do
			if attached scm_s.service as scm then
				create ch_list.make_with_location (root_location)
				ch_list.extend_path (status.location)
				if attached scm.diff (ch_list) as l_diff then
					parent_grid.status_box.show_diff (l_diff)
				end
			end
		end

	on_options (a_item: EV_GRID_ITEM)
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
		do
			create m
			create mi.make_with_text_and_action (scm_names.menu_diff, agent show_diff)
			m.extend (mi)
			m.show
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
