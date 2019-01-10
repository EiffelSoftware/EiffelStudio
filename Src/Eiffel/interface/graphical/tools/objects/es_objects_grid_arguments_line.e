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

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make
		do
			make_as (arguments_id)
		end

feature -- Access

	argument_ast_stone (a_name: READABLE_STRING_GENERAL): detachable ACCESS_ID_FEATURE_STONE
			-- AST Stone for argument named `a_name`, if any.
		local
			l_list_dec_as: EIFFEL_LIST [TYPE_DEC_AS]
			l_type_dec: TYPE_DEC_AS
			i, nb: INTEGER
			l_leaf_as: LEAF_AS
		do
			if
				attached call_stack_element as cse and then
				attached cse.routine as l_routine and then
				attached cse.routine_i as l_routine_i and then
				attached l_routine_i.match_list_server.item (l_routine_i.written_in) as l_match_list and then
				attached l_routine_i.real_body as l_body_ast
			then
				l_list_dec_as := l_body_ast.arguments
				across
					l_list_dec_as as ic
				until
					Result /= Void
				loop
					l_type_dec := ic.item
					across
						l_type_dec.id_list as id_ic
					until
						Result /= Void
					loop
						if
							attached l_type_dec.item_name_32 (id_ic.target_index) as l_name and then
							a_name.is_case_insensitive_equal (l_name)
						then
							create Result.make_with_feature (l_routine, l_type_dec)
							Result.set_associated_text (l_name)
						end
					end
				end
			end
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
					parent_grid.attach_debug_value_from_line_to_grid_row (parent_grid.row (r), list.item, Current ,Void)
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
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
