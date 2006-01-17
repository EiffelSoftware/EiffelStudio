indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred
class ES_OBJECTS_GRID_MANAGER

inherit
	REFACTORING_HELPER

	EV_SHARED_APPLICATION

	EV_GRID_HELPER


feature -- cmd specific

	hex_format_cmd: EB_HEX_FORMAT_CMD

	pretty_print_cmd: EB_PRETTY_PRINT_CMD
			-- Command that is used to display extended information concerning objects.

	slices_cmd: ES_OBJECTS_GRID_SLICES_CMD

feature {ES_OBJECTS_GRID_MANAGER, ES_OBJECTS_GRID_LINE, ES_OBJECTS_GRID_SLICES_CMD} -- EiffelStudio specific

	objects_grid_item (add: STRING): ES_OBJECTS_GRID_LINE is
		require
			valid_address: add /= Void
		deferred
		ensure
			valid_result: Result /= Void implies (
					Result.object_address /= Void
					and then add.is_equal (Result.object_address)
				)
		end

feature -- ES grid specific

	expand_selected_rows (a_grid: EV_GRID) is
		require
			a_grid /= Void
		local
			rows: ARRAYED_LIST [EV_GRID_ROW]
			row: EV_GRID_ROW
		do
			rows := a_grid.selected_rows
			from
				rows.start
			until
				rows.after
			loop
				row := rows.item
				if not row.is_expanded and then row.is_expandable then
					row.expand
				end
				rows.forth
			end
		end

	collapse_selected_rows (a_grid: EV_GRID) is
		require
			a_grid /= Void
		local
			rows: ARRAYED_LIST [EV_GRID_ROW]
			row: EV_GRID_ROW
		do
			rows := a_grid.selected_rows
			from
				rows.start
			until
				rows.after
			loop
				row := rows.item
				if row.is_expanded then
					row.collapse
				end
				rows.forth
			end
		end

	grid_data_from_widget (a_item: EV_ANY): ANY is
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_item /= Void then
				ctler ?= a_item.data
				if ctler /= Void then
					Result := ctler.data
				else
					Result ?= a_item.data
				end
			end
		end

feature -- Clipboard related

	update_clipboard_string_with_selection (grid: ES_OBJECTS_GRID) is
		local
			dv: ABSTRACT_DEBUG_VALUE
			text_data: STRING
			lrow: EV_GRID_ROW
			gline: ES_OBJECTS_GRID_LINE
		do
			lrow := grid.selected_rows.first
			if lrow /= Void then
				gline ?= lrow.data
				if gline /= Void then
					text_data := gline.text_data_for_clipboard
				else
					dv ?= grid_data_from_widget (lrow)
					if dv /= Void then
						text_data := dv.dump_value.full_output
					else
						text_data ?= lrow.data
					end
				end
			end
			if text_data /= Void then
				ev_application.clipboard.set_text (text_data)
			else
				ev_application.clipboard.remove_text
			end
		end

	set_expression_from_clipboard (grid: ES_OBJECTS_GRID) is
			-- Sets an expression from text held in clipboard
		local
			text_data: STRING
			row: EV_GRID_ROW
			rows: ARRAYED_LIST [EV_GRID_ROW]
			empty_expression_cell: ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL
		do
			text_data := ev_application.clipboard.text
			if text_data /= Void and then not text_data.is_empty then
				rows := grid_selected_top_rows (grid)
				if not rows.is_empty then
					row := rows.first
					if
						grid.col_name_index <= row.count
					then
						empty_expression_cell ?= row.item (grid.col_name_index)
						if empty_expression_cell /= Void then
							empty_expression_cell.activate_with_string (text_data)
						end
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
