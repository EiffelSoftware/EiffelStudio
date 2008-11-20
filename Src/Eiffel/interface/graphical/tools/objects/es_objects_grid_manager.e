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

	object_viewer_cmd: EB_OBJECT_VIEWER_COMMAND is
			-- Command that is used to display extended information concerning objects.
		deferred
		end

	slices_cmd: ES_OBJECTS_GRID_SLICES_CMD

feature -- Access

	widget: EV_WIDGET is
			-- Widget representing Current object.
		deferred
		end

	parent_window: EV_WINDOW is
			-- Parent EV_WINDOW if any.
		local
			w: EV_WIDGET
		do
			w := widget
			if w /= Void then
				Result := impl_parent_window (w)
			end
		end

feature -- Refresh

	refresh is
			-- Refresh related grid
		deferred
		end

feature {ES_OBJECTS_GRID_MANAGER, ES_OBJECTS_GRID_LINE, ES_OBJECTS_GRID_SLICES_CMD} -- EiffelStudio specific

	objects_grid_object_line (add: DBG_ADDRESS): ES_OBJECTS_GRID_OBJECT_LINE is
		require
			valid_address: add /= Void
		deferred
		ensure
			valid_result: Result /= Void implies (
					Result.object_address /= Void
					and then add.is_equal (Result.object_address)
				)
		end

	pre_activate_cell (ei: EV_GRID_ITEM) is
			-- Process special operation before cell `ei' get activated
		local
			evi: ES_OBJECTS_GRID_VALUE_CELL
			ost: OBJECT_STONE
			p: ES_OBJECTS_GRID
		do
			if object_viewer_cmd /= Void then
				evi ?= ei
				if evi /= Void and then evi.is_parented and then evi.row /= Void then
					p ?= ei.parent
					if p /= Void then
						ost ?= p.grid_pebble_from_cell (evi)
						if ost /= Void and then object_viewer_cmd.accepts_stone (ost) then
							evi.set_button_action (agent object_viewer_cmd.set_stone (ost))
						end
					end
				end
			end
		end

feature -- ES grid specific

	toggle_expanded_state_of_selected_rows (a_grid: EV_GRID) is
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
				if row.is_expandable then
					if not row.is_expanded then
						row.expand
					else
						row.collapse
					end
				end
				rows.forth
			end
		end

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
			s, text_data: STRING_32
			lrows: LIST [EV_GRID_ROW]
			lrows_index: SORTED_TWO_WAY_LIST [INTEGER]
			lrow: EV_GRID_ROW
			gline: ES_OBJECTS_GRID_LINE
			c: INTEGER
			gi: EV_GRID_LABEL_ITEM
		do
			lrows := grid.selected_rows
			if lrows.count > 0 then
				from
					create lrows_index.make
					lrows.start
				until
					lrows.after
				loop
					lrow := lrows.item
					if lrow /= Void and then lrow.is_show_requested then
						lrows_index.extend (lrow.index)
					end
					lrows.forth
				end
				from
					create text_data.make_empty
					lrows_index.start
				until
					lrows_index.after
				loop
					lrow := grid.row (lrows_index.item)
					if lrow /= Void then
						gline ?= lrow.data
						if gline /= Void then
							s := gline.text_data_for_clipboard
						else
							dv ?= grid_data_from_widget (lrow)
							if dv /= Void then
								s := dv.dump_value.full_output
							else
								s ?= lrow.data
							end
						end
						if s = Void then
							from
								create s.make_empty
								c := 1
							until
								c > lrow.count
							loop
								gi ?= lrow.item (c)
								if gi /= Void then
									s.append (gi.text)
								end
								s.append_character ('%T')
								c := c + 1
							end
						end
						if s /= Void then
							text_data.append_string (s)
							text_data.append_string ("%N")
						end
					end
					lrows_index.forth
				end
			end
			if text_data /= Void and then not text_data.is_empty then
				ev_application.clipboard.set_text (text_data)
			else
				ev_application.clipboard.remove_text
			end
		end

feature {NONE} -- Implementation

	impl_parent_window (w: EV_WIDGET): EV_WINDOW is
		local
			p: EV_WIDGET
		do
			p := w.parent
			if p /= Void then
				Result ?= p
				if Result = Void then
					Result := impl_parent_window (p)
				end
			end
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
