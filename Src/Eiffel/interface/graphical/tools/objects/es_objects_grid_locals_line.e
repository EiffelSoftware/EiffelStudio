note
	description: "Objects that represent the data of a objects grid row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_LOCALS_LINE

inherit
	ES_OBJECTS_GRID_SPECIFIC_LINE

create
	make

feature {NONE} -- Initialization

	make
		do
			make_as (locals_id)
		end

feature -- Access

	local_ast_stone (a_name: READABLE_STRING_GENERAL): detachable ACCESS_ID_FEATURE_STONE
		local
			l_list_dec_as: LIST_DEC_AS
		do
			if
				attached call_stack_element as cse and then
				attached cse.routine as l_routine
			then
				if attached l_routine.locals as l_locals then
					across
						l_locals as ic
					until
						Result /= Void
					loop
						l_list_dec_as := ic.item
						across
							l_list_dec_as.id_list as loc_ic
						until
							Result /= Void
						loop
							if
								attached l_list_dec_as.item_name_32 (loc_ic.target_index) as l_name and then
								a_name.is_case_insensitive_equal (l_name)
							then
									-- Found local !
								create Result.make_with_feature (l_routine, l_list_dec_as)
								Result.set_associated_text (l_name)
							end
						end
					end
				end
					-- TODO: Add support for object test locals?
					-- not for now, as debugger does not support scope that permits
					-- to resolve conflict between different object test locals using the same name.
			end
		end

feature {NONE} -- Implementation

	compute_grid_display_for (cse: like call_stack_element)
		local
			glab: EV_GRID_LABEL_ITEM
			l_locals, l_ot_locals: LIST [ABSTRACT_DEBUG_VALUE]
			l_ot_row: EV_GRID_ROW
		do
			if cse /= Void then
				l_locals := cse.locals
				l_ot_locals := cse.object_test_locals
				if
					l_locals /= Void and then not l_locals.is_empty
					or l_ot_locals /= Void and then not l_ot_locals.is_empty
				then
					if l_locals = Void or else l_locals.is_empty then
						glab := parent_grid.folder_label_item (Interface_names.l_locals + " (object test)")
					else
						glab := parent_grid.folder_label_item (Interface_names.l_Locals)
					end
					parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.folder_features_all_icon)
					row.set_item (1, glab)
					if l_locals /= Void and then not l_locals.is_empty then
						append_locals_to_grid (l_locals, row)
					end
					if l_ot_locals /= Void and then not l_ot_locals.is_empty then
						row.insert_subrow (row.subrow_count + 1)
						l_ot_row := row.subrow (row.subrow_count)
						glab := parent_grid.folder_label_item ("Object test locals")
						l_ot_row.set_item (1, glab)
						parent_grid.grid_cell_set_pixmap (glab, pixmaps.mini_pixmaps.general_search_icon)
						row.show
						row.ensure_expandable
						append_locals_to_grid (l_ot_locals, l_ot_row)
						l_ot_row.expand
					end
				else
					row.hide
				end
			end
		end

	append_locals_to_grid (list: detachable LIST [ABSTRACT_DEBUG_VALUE]; a_row: EV_GRID_ROW)
		local
			i: INTEGER
			tmp: SORTABLE_ARRAY [ABSTRACT_DEBUG_VALUE]
			dbg_nb: INTEGER
			r: INTEGER
		do
			if list /= Void then
				dbg_nb := list.count
				if dbg_nb > 0 then
					from
						list.start
						create tmp.make_filled (list.first, 1, dbg_nb)
						list.forth
						i := 2
					until
						list.after
					loop
						tmp.put (list.item, i)
						i := i + 1
						list.forth
					end
					tmp.sort
					from
						r := a_row.index + a_row.subrow_count + 1
						a_row.insert_subrows (dbg_nb, a_row.subrow_count + 1)
						i := 1
					until
						i > dbg_nb
					loop
						parent_grid.attach_debug_value_from_line_to_grid_row (parent_grid.row (r), tmp [i], Current ,Void)
						r := r + 1
						i := i + 1
					end
					a_row.show
					a_row.ensure_expandable
				end
			end
		end

feature -- Query

	text_data_for_clipboard: detachable STRING_32
		do
			Result := Interface_names.l_locals
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
