indexing
	description: "[
		Base prompts for requesting user to confirm/cancel saving of modified entities.
	]"
	legal: "See notice at end of feature."
	status: "See notice at end of feature.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_SAVE_ENTITY_PROMPT [G -> ANY]

inherit
	ES_QUESTION_PROMPT
		redefine
			build_prompt_interface
		end

feature {NONE} -- User interface initialization

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			-- Note: Redefine to add widgets before the discardable check.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		do
			Precursor {ES_QUESTION_PROMPT} (a_container)

			set_sub_title (interface_names.st_unsaved_changed)

			create entities_list
			entities_list.disable_border
			entities_list.hide_header

				-- Current hack because EV_GRID does not implement EV_TAB_CONTROLABLE				
			if {l_tabbable: EV_TAB_CONTROLABLE} entities_list then
				l_tabbable.disable_tabable_to
			end

				-- Prevent selection
			entities_list.disable_selection_on_click
			entities_list.disable_always_selected

				-- Size size info				
			entities_list.set_minimum_width (300)
			entities_list.set_column_count_to (1)
			entities_list.column (1).set_width (300)
			entities_list.set_row_height (18)

			if entities /= Void and then not entities.is_empty then
				update_list
			end

			a_container.extend (entities_list)
		end

feature {NONE} -- User interface elements

	entities_list: !ES_GRID
			-- List used to display modified entities.

feature -- Access

	entities: ?DS_BILINEAR [G] assign set_entities
			-- Actual list of modified entity.

feature {NONE} -- Access

	token_generator: !EB_EDITOR_TOKEN_GENERATOR
			-- Formatter used to generate token lists.
		once
			create Result.make
		end

	context_printer: !ERROR_CONTEXT_PRINTER
			-- Printer used to generate a context token list.
		once
			create Result
		end

	shared_writer: !EB_SHARED_WRITER
			-- Access to shared writer used to retrieve editor label font settings
		once
			create Result
		end

feature -- Element change

	set_entities (a_entities: like entities)
			-- Sets the entities list for the save files prompt
		require
			is_interface_usable: is_interface_usable
			a_entities_attached: a_entities /= Void
			not_a_entities_is_empty: not a_entities.is_empty
			a_entities_contains_attached_items: not a_entities.has (Void)
			not_is_shown: not is_shown
		do
			entities := a_entities.twin
			if is_initialized then
				update_list
			end
		end

feature {NONE} -- Basic operations

	update_list
			-- Updates the entity list with the current list of features
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_shown: not is_shown
		local
			l_list: like entities_list
			l_entities: like entities
			l_cursor: DS_BILINEAR_CURSOR [G]
			l_row: EV_GRID_ROW
			i: INTEGER
		do
			l_entities := entities
			l_list := entities_list
			if l_entities = Void then
				l_list.set_row_count_to (0)
			else
				l_cursor := l_entities.new_cursor

				l_list.set_row_count_to (l_entities.count)
				from
					i := 1
					l_cursor.start
				until
					l_cursor.after
				loop
					l_row := l_list.row (i)
					populate_row (l_cursor.item, l_row)
					l_list.grid_row_fill_empty_cells (l_row)
					l_cursor.forth
				end

					-- Ensure the list is small enough
				l_list.set_minimum_height (l_list.row_count.min (14) * 18)
			end

		end

feature {NONE} -- Population

	populate_row (a_entity: G; a_row: EV_GRID_ROW)
			-- Populates a row with the information from a given entity.
			--
			-- `a_entity': Entity interface used to populate the grid row.
			-- `a_row': A grid row to populate.
		require
			a_entity_attached: a_entity /= Void
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_parented: a_row.parent = entities_list
		deferred
		end

invariant
	not_entities_is_empty: entities /= Void implies not entities.is_empty
	entities_contains_attached_items: entities /= Void implies not entities.has (Void)

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This feature is part of Eiffel Software's Eiffel Development Environment.
			
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
