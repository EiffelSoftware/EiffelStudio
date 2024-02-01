note
	description: "Summary description for {ES_CLOUD_LICENSE_SELECTION_BOX}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_LICENSE_SELECTION_BOX

inherit
	EV_VERTICAL_BOX
		redefine
			initialize
		end

	SHARED_ES_CLOUD_NAMES
		undefine
			default_create, copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_service: ES_CLOUD_S; acc: ES_ACCOUNT; inst: ES_ACCOUNT_INSTALLATION; a_callback: like callback)
		do
			service := a_service
			account := acc
			callback := a_callback
			default_create
			set_installation (inst)
		end

	initialize
		local
			l_scaler: EVS_DPI_SCALER
			lab: EV_LABEL
			g: ES_GRID
			cl: EV_CELL
		do
			Precursor
			create l_scaler.make
			set_padding_width (l_scaler.scaled_size (5))
			set_border_width (l_scaler.scaled_size (3))

			create lab
			extend (lab)
			disable_item_expand (lab)
			lab.hide
			title_label := lab

			create g
			inner_grid := g
			extend (g)
			create cl
			extend (cl)
			disable_item_expand (cl)
			cl.hide
			error_cell := cl
		end

feature -- Element change

	set_title (m: detachable READABLE_STRING_GENERAL)
		do
			if m = Void then
				title_label.remove_text
				title_label.hide
			else
				title_label.set_text (m)
				title_label.show
			end
		end

	set_installation (inst: ES_ACCOUNT_INSTALLATION)
		local
			lab: EV_LABEL
			glab: EV_GRID_LABEL_ITEM
			g: ES_GRID
			r: INTEGER
		do
			installation := inst
			g := inner_grid
			g.wipe_out
			if attached inst.adapted_licenses as lics and then not lics.is_empty then
				g.set_row_count_to (lics.count + 1)
				g.set_column_count_to (3)
				g.column (1).set_title (cloud_names.label_license)
				g.column (2).set_title (cloud_names.label_plan)
				g.column (3).set_title (cloud_names.label_info)
				g.hide_header
				g.disable_border
--				g.disable_column_separators
--				g.disable_row_separators
				g.enable_row_separators
				g.enable_single_row_selection
				g.row_select_actions.extend (agent on_row_selected)
				g.row_deselect_actions.extend (agent on_row_deselected)

				r := 0
				across
					lics as ic
				loop
					if attached {ES_ACCOUNT_LICENSE} ic.item as lic then
						r := r + 1
						if attached g.row (r) as l_row then
							create glab.make_with_text (lic.key)
							l_row.set_data (lic)
							l_row.set_item (1, glab)
							glab.pointer_double_press_actions.extend (agent (i_lic: ES_ACCOUNT_LICENSE; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
									do
										if i_button = {EV_POINTER_CONSTANTS}.left then
											select_license (i_lic)
										end
									end(lic, ?,?,?,?,?,?,?,?)
								)
							l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (lic.plan_name))
							if lic.is_fallback then
								l_row.set_item (3, create {EV_GRID_LABEL_ITEM}.make_with_text (cloud_names.label_fallback_in_parentheses))
							else
								l_row.set_item (3, create {EV_GRID_ITEM})
							end
							l_row.select_actions.extend (agent on_license_selected (lic))
							l_row.deselect_actions.extend (agent on_license_deselected (lic))
						end
					end
				end
				g.set_minimum_height (g.row_height * 2)
--				g.enable_auto_size_best_fit_column (1)
--				g.enable_auto_size_best_fit_column (2)
--				g.enable_auto_size_best_fit_column (3)
				g.resize_column_to_content (g.column (1), False, False)
				g.resize_column_to_content (g.column (2), False, False)
				g.enable_last_column_use_all_width
				g.resize_column_to_content (g.column (3), False, False)

			else
				create lab.make_with_text (cloud_names.label_no_license_for_installation)
				error_cell.put (lab)
				error_cell.show
			end
		end

feature -- Access: widgets

	inner_grid: ES_GRID

	title_label: EV_LABEL

	error_cell: EV_CELL

feature -- Access

	service: ES_CLOUD_S

	account: ES_ACCOUNT

	installation: ES_ACCOUNT_INSTALLATION

	callback: PROCEDURE [TUPLE [lic: detachable ES_ACCOUNT_LICENSE; is_choosen: BOOLEAN]]

feature -- Access

	selected_license: detachable ES_ACCOUNT_LICENSE

feature -- Callbacks

	on_row_selected (r: EV_GRID_ROW)
		do
			if
				r /= Void and then not r.is_destroyed and then
				attached {ES_ACCOUNT_LICENSE} r.data as lic
			then
				on_license_selected (lic)
			else
				on_license_deselected (Void)
			end
		end

	on_row_deselected (r: EV_GRID_ROW)
		do
			on_license_deselected (Void)
		end

	on_license_selected (lic: ES_ACCOUNT_LICENSE)
		do
			selected_license := lic
			callback (lic, False)
		end

	on_license_deselected (lic: detachable ES_ACCOUNT_LICENSE)
		do
			selected_license := Void
			callback (Void, False)
		end

	select_license (lic: ES_ACCOUNT_LICENSE)
		do
			selected_license := lic
			callback (lic, True)
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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

