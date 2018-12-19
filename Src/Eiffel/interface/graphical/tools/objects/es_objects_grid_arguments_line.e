note
	description: "Objects that represent the data of a objects grid row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_ARGUMENTS_LINE

inherit
	ES_OBJECTS_GRID_SPECIFIC_LINE

create
	make

feature {NONE} -- Initialization

	make
		do
			make_as (arguments_id)
		end

feature {NONE} -- Implementation

	compute_grid_display_for (cse: like call_stack_element)
		local
			glab: EV_GRID_LABEL_ITEM
			list: LIST [ABSTRACT_DEBUG_VALUE]
			r: INTEGER
		do
			if cse /= Void then
				list := cse.arguments
			end
			if list /= Void and then not list.is_empty then
				glab := parent_grid.folder_label_item (Interface_names.l_Arguments)
				parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.folder_features_all_icon)
				row.set_item (1, glab)
				from
					row.insert_subrows (list.count, 1)
					r := row.index + 1
					list.start
				until
					list.after
				loop
					parent_grid.attach_debug_value_to_grid_row (parent_grid.row (r), list.item, Void)
					r := r + 1
					list.forth
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
			Result := Interface_names.l_arguments
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
