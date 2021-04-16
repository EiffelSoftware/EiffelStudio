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

			lab.pointer_double_press_actions.extend (agent (i_loc: PATH; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
					do
						if attached parent_grid as pg then
							pg.open_file_location (i_loc)
						end
					end(st.location, ?,?,?,?,?,?,?,?)
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
				sr.set_item (parent_grid.scm_column, wc_row.new_label_item (st.status_as_string))
--				cb_lab.set_is_checked (True)
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
