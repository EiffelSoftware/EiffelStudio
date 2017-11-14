note
	description: "Objects that represent the data of a objects grid row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_STACK_LINE

inherit
	ES_OBJECTS_GRID_SPECIFIC_LINE
		redefine
			compute_grid_display_for,
			text_data_for_clipboard
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_as (stack_id)
		end

feature {NONE} -- Implementation

	compute_grid_display_for (cse: like call_stack_element)
		local
			r: EV_GRID_ROW
			glab: EV_GRID_LABEL_ITEM
			es_glab: EV_GRID_LABEL_ITEM
			l_exception_class_detail: STRING
			l_exception_module_detail: STRING_32
			l_exception_meaning, l_exception_message: STRING_32
			l_exception_code: INTEGER
			appstat: APPLICATION_STATUS
			dotnet_status: APPLICATION_STATUS_DOTNET
			exc_dv: EXCEPTION_DEBUG_VALUE
		do
			appstat := debugger_manager.application_status
			if appstat.exception_occurred then
					--| Details
				glab := parent_grid.folder_label_item (Cst_exception_raised_text)
				parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.debug_exception_handling_icon)
				row.set_item (1, glab)
				create glab

				dotnet_status ?= appstat
				if dotnet_status /= Void then
					if dotnet_status.exception_handled then
						parent_grid.grid_cell_set_text (glab, Cst_exception_first_chance_text)
					else
						parent_grid.grid_cell_set_text (glab, Cst_exception_unhandled_text)
					end
				else
					parent_grid.grid_cell_set_text (glab, appstat.exception_short_description)
				end
				row.set_item (2, glab)

				exc_dv := appstat.exception
				if exc_dv /= Void then
						--| Meaning
					l_exception_meaning := exc_dv.meaning
					if l_exception_meaning /= Void then
						r := parent_grid.extended_new_subrow (row)
						glab := parent_grid.name_label_item ("Meaning")
						parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
						r.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_meaning)
						parent_grid.grid_cell_set_text (es_glab, l_exception_meaning)
						r.set_item (2, es_glab)
					end
						--| Message
					l_exception_message := exc_dv.message
					if l_exception_message /= Void then
						r := parent_grid.extended_new_subrow (row)
						glab := parent_grid.name_label_item ("Message")
						parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
						r.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_message)
						parent_grid.grid_cell_set_text (es_glab, l_exception_message)
						r.set_item (2, es_glab)
					end

						--| Code
					l_exception_code := exc_dv.code
					if l_exception_code /= 0 then
						r := parent_grid.extended_new_subrow (row)
						glab := parent_grid.name_label_item ("Code")
						parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
						r.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_code.out)
						parent_grid.grid_cell_set_text (es_glab, l_exception_code.out)
						r.set_item (2, es_glab)
					end

						--| Type
					l_exception_class_detail := exc_dv.type_name
					if l_exception_class_detail /= Void then
						r := parent_grid.extended_new_subrow (row)
						glab := parent_grid.name_label_item ("Type")
						parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
						r.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_class_detail)
						parent_grid.grid_cell_set_text (es_glab, l_exception_class_detail)
						r.set_item (2, es_glab)
					end

					if dotnet_status /= Void then
							--| IL type name
						l_exception_class_detail := dotnet_status.exception_il_type_name
						if l_exception_class_detail /= Void then
							r := parent_grid.extended_new_subrow (row)
							glab := parent_grid.name_label_item ("IL Type")
							parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
							r.set_item (1, glab)
							create es_glab
							es_glab.set_data (l_exception_class_detail)
							parent_grid.grid_cell_set_text (es_glab, l_exception_class_detail)
							r.set_item (2, es_glab)
						end
							--| Module
						l_exception_module_detail := dotnet_status.exception_module_name
						if l_exception_module_detail /= Void then
							r := parent_grid.extended_new_subrow (row)
							glab := parent_grid.name_label_item (interface_names.l_module)
							parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
							r.set_item (1, glab)
							create es_glab
							es_glab.set_data (l_exception_module_detail)
							parent_grid.grid_cell_set_text (es_glab, l_exception_module_detail)
							r.set_item (2, es_glab)
						end
					end

					r := parent_grid.extended_new_subrow (row)
					parent_grid.attach_debug_value_to_grid_row (r, exc_dv, interface_names.l_exception_object)
				end
				row.show
				row.ensure_expandable
			else
				row.hide
			end
		end

feature -- Query

	text_data_for_clipboard: detachable STRING_32
		do
			Result := Interface_names.l_stack_information
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
