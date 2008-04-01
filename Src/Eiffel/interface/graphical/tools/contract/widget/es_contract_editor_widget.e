indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_EDITOR_WIDGET

inherit
	ES_WIDGET [ES_GRID]
		redefine
			on_before_initialize
		end

inherit {NONE}
	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	build_widget_interface (a_widget: !ES_GRID)
			-- <Precursor>
		local
			l_col: EV_GRID_COLUMN
		do
			edit_contract_grid.set_column_count_to (context_column)
			edit_contract_grid.enable_auto_size_best_fit_column (contract_column)
			edit_contract_grid.enable_tree
			edit_contract_grid.enable_single_row_selection
			edit_contract_grid.set_subrow_indent (tab_indent_spacing.as_integer_32)

				-- Colors
			edit_contract_grid.set_focused_selection_color (colors.grid_focus_selection_color)
			edit_contract_grid.set_focused_selection_text_color (colors.grid_focus_selection_text_color)
			edit_contract_grid.set_non_focused_selection_color (colors.grid_unfocus_selection_color)
			edit_contract_grid.set_non_focused_selection_text_color (colors.grid_unfocus_selection_text_color)

				-- Columns
			l_col := edit_contract_grid.column (contract_column)
			l_col.set_title ("Contracts")
			l_col := edit_contract_grid.column (context_column)
			l_col.set_title ("Context")
		end

	on_before_initialize
			-- <Precursor>
		do
			create commit_edit_actions
			Precursor {ES_WIDGET}
		end

feature -- Access

	context: ?ES_CONTRACT_EDITOR_CONTEXT [CLASSC_STONE] assign set_context
			-- Contract editor context information

feature {NONE} -- Access

	tab_indent_spacing: NATURAL_32
			-- Number of pixels to indent rendered text, representing a tab character.
		local
			l_font: EV_FONT
		do
			l_font := preferences.editor_data.fonts.item (preferences.editor_data.editor_font_id).twin
			Result := l_font.string_width (once "%T").as_natural_32.max (10)
		ensure
			result_positive: Result > 0
		end

feature -- Element change

	set_context (a_context: like context)
			-- Set contract editor context.
			--
			-- `a_context': A contract editor context to set.
		require
			is_interface_usable: is_interface_usable
			a_context_is_interface_usable: a_context.is_interface_usable
		do
			if context /= a_context then
				context := a_context
				if is_initialized then
					update
				end
			end
		ensure
			context_set: context = a_context
		end

feature -- Status report

	has_context: BOOLEAN
			-- Does Current have set context information
		do
			Result := context /= Void
		ensure
			context_attached: Result implies context /= Void
		end

feature {NONE} -- Helpers

	frozen context_printer: !ERROR_CONTEXT_PRINTER
			-- Printer used to print context information
		once
			create Result
		end

	frozen pixmap_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
			-- Pixmap factory
		once
			create Result
		end

feature {NONE} -- User interface elements

	edit_contract_grid: !ES_GRID
			-- The grid used to display and edit the contracts for the current context
		do
			Result ?= widget
		end

feature -- Basic operations

	update
			-- Updates the context information and refreshes the contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
		local
			l_grid: !like edit_contract_grid
			l_parents: !DS_ARRAYED_LIST [!CLASS_C]
			l_parent: !CLASS_C
			l_row: !EV_GRID_ROW
			l_col: EV_GRID_COLUMN
			i: INTEGER
		do
			l_grid := edit_contract_grid

				-- Remove existing items
			l_grid.lock_update
			l_grid.set_row_count_to (0)

				-- Set the column size.
			l_grid.column (context_column).set_width (16)

			if {l_context: !like context} context then
					-- Add first row for edits
				l_grid.set_row_count_to (l_grid.row_count + 1)
				l_row ?= l_grid.row (1)
				populate_editable_contracts_row (l_context.context_class, l_row, l_context)

					-- Traverse through parents
				l_parents := l_context.context_parents
				if not l_parents.is_empty then
					from l_parents.start until l_parents.after loop
						l_parent := l_parents.item_for_iteration
						i := l_grid.row_count + 1
						l_grid.set_row_count_to (i)
						l_row ?= l_grid.row (i)
						populate_contracts_row (l_parent, l_row, l_context)
						l_parents.forth
					end
				end
			end

				-- Set context column width
			l_col := l_grid.column (context_column)
			l_col.set_width (l_col.width + 4)

			l_grid.unlock_update
		rescue
			l_grid.unlock_update
		end

feature -- Actions

	commit_edit_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE [code: !STRING_32; old_code: STRING_32]]
			-- Actions called to inform subscribers of the commit actions just taken place.

feature {NONE} -- Population

	populate_editable_contracts_row (a_class: !CLASS_I; a_row: !EV_GRID_ROW; a_context: !like context)
			-- Populates an editable grid row for a given class.
			--| Note: There should only be one editable row (for now), which is the top most row.
			--
			-- `a_class': Current class where the context feature resides.
			-- `a_row': The grid row to populate with the current contract information.
			-- `a_context': The editor context used to populate the editable contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_parented: a_row.parent = edit_contract_grid
			a_context_has_stone: a_context.has_stone
		do
			populate_contract_header_row (a_class, a_row, a_context)
		end

	populate_contracts_row (a_class: !CLASS_C; a_row: !EV_GRID_ROW; a_context: !like context) is
			-- Populates a inherited read-only grid row for a given class.
			--
			-- `a_class': Current class where the context feature resides.
			-- `a_row': The grid row to populate with the current contract information.
			-- `a_context': The editor context used to populate the contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_parented: a_row.parent = edit_contract_grid
			a_context_has_stone: a_context.has_stone
		local
			l_assertions: ?ASSERTION_SERVER
			l_invariants: ?INVARIANT_SERVER
			l_chain: ?CHAINED_ASSERTIONS
			l_adapter: !FEATURE_ADAPTER
			l_old_class: CLASS_C
			l_e_feature: E_FEATURE
			l_feature_i: FEATURE_I
			l_decorator: TEXT_FORMATTER_DECORATOR
			l_formatter: EB_EDITOR_TOKEN_GENERATOR
			l_invariant: INVARIANT_AS
			l_tagged_list: EIFFEL_LIST [TAGGED_AS]
			l_tagged: TAGGED_AS
			l_row: EV_GRID_ROW
			l_item: EB_GRID_EDITOR_TOKEN_ITEM

			l_invariant_modifier: ?ES_INVARIANT_CONTRACT_TEXT_MODIFIER
			l_grid: like edit_contract_grid
			l_tokens: !LINKED_LIST [EDITOR_TOKEN]
			i: INTEGER
		do
			l_grid := edit_contract_grid
			if {l_class: !CLASS_I} a_class.lace_class then
				populate_contract_header_row (l_class, a_row, a_context)
			end

			l_old_class := system.current_class
			system.set_current_class (a_class)

			if {l_context: ES_FEATURE_CONTRACT_EDITOR_CONTEXT} context then
				if a_class.has_feature_table then
						-- Attempt to locate original feature.
					l_feature_i := a_class.feature_table.feature_of_rout_id_set (l_context.context_feature.rout_id_set)
					if l_feature_i /= Void then
						l_e_feature := l_feature_i.api_feature (a_class.class_id)
						create l_assertions.make_for_feature (l_feature_i, l_feature_i.body)
						l_chain := l_assertions.current_assertion
					end
				end
			else
					-- Class invariant contracts.
				l_invariant_modifier ?= context.text_modifier
				if l_invariant_modifier /= Void then
					if not l_invariant_modifier.is_prepared then
						l_invariant_modifier.prepare
					end
					l_invariant := l_invariant_modifier.contract_ast
				end

				if l_invariant = Void then
						-- Unparsed AST, use stored AST instead
					l_invariant := a_class.invariant_ast
				end
				if l_invariant /= Void then
						-- Create formatter and decorator for tokenizing AST.
					create l_formatter.make
					l_formatter.enable_multiline
					create l_decorator.make (a_class, l_formatter)

						-- Extract invariants.
					l_tagged_list := l_invariant.assertion_list
					if l_tagged_list /= Void and then not l_tagged_list.is_empty then
						a_row.insert_subrows (l_tagged_list.count, 1)

						from i := 1 l_tagged_list.start until l_tagged_list.after loop
							l_tagged := l_tagged_list.item
							l_row := a_row.subrow (i)

								-- Perform formatting with decorator, enabling clickable text.
							l_decorator.format_ast (l_tagged)

								-- Add contract item
							create l_item
							l_item.set_text_with_tokens (l_formatter.tokens (1))
							l_row.set_item (contract_column, l_item)
							l_grid.grid_row_fill_empty_cells (l_row)

								-- Clear formatters
							l_formatter.wipe_out_lines

								-- Ensure item is expandable
							a_row.ensure_expandable

							l_tagged_list.forth
							i := i + 1
						end
					end
				end
			end

			if a_row.is_expandable then
				a_row.expand
			end

			if l_assertions /= Void then
				l_chain := l_assertions.current_assertion
			end
			system.set_current_class (l_old_class)
		end

	populate_contract_header_row (a_class: !CLASS_I; a_row: !EV_GRID_ROW; a_context: !like context) is
			-- Populates a contract header row.
			--
			-- `a_class': Current class where the context feature resides.
			-- `a_row': The grid row to populate with the current contract information.
			-- `a_context': The editor context used to populate the contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_parented: a_row.parent = edit_contract_grid
			a_context_has_stone: a_context.has_stone
		local
			l_generator: EB_EDITOR_TOKEN_GENERATOR
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_line: EIFFEL_EDITOR_LINE
			l_col: EV_GRID_COLUMN
			l_class_c: CLASS_C
			l_e_feature: E_FEATURE
			l_feature_i: FEATURE_I
			l_parents: LIST [CLASS_C]
		do
			a_row.clear
			--a_row.ensure_expandable

				-- Context class
			create l_generator.make
			l_generator.disable_multiline

			if {l_context: !ES_FEATURE_CONTRACT_EDITOR_CONTEXT} context then
					-- Keywords
				create l_item

				if a_class.is_compiled then
					l_class_c := a_class.compiled_class
					if l_class_c /= Void and then l_class_c.has_feature_table then
							-- Attempt to locate original feature
						l_feature_i := l_class_c.feature_table.feature_of_rout_id_set (l_context.context_feature.rout_id_set)
						if l_feature_i /= Void then
							l_e_feature := l_feature_i.api_feature (l_class_c.class_id)
						end
					end
				end

					-- Set icon
				if l_e_feature /= Void then
					l_item.set_pixmap (pixmap_factory.pixmap_from_e_feature (l_e_feature))
				else
					l_item.set_pixmap (stock_pixmaps.feature_routine_icon)
				end

				l_parents := l_context.context_feature.precursors
				if l_parents /= Void and then not l_parents.is_empty then
					l_item.set_text_with_tokens (a_context.contract_keywords (a_class = l_parents.last.lace_class))
				else
					l_item.set_text_with_tokens (a_context.contract_keywords (True))
				end
				a_row.set_item (contract_column, l_item)
				l_item.disable_select

					-- Print class context to generator for context column
				if l_class_c /= Void and then l_e_feature /= Void then
						-- Use compiled name information
					context_printer.print_context_feature (l_generator, l_e_feature, l_class_c)
				else
						-- Class is not compiled
					context_printer.print_context_lace_feature (l_generator, l_context.context_feature.name, a_class)
				end
			else
					-- Keywords
				create l_item
				l_item.set_pixmap (pixmap_factory.pixmap_from_class_i (a_class))
				l_item.set_text_with_tokens (a_context.contract_keywords (True))

				a_row.set_item (contract_column, l_item)
				l_item.disable_select

					-- Print class context to generator for context column
				context_printer.print_context_lace_class (l_generator, a_class)
			end

			l_line := l_generator.last_line
			if l_line /= Void then
				l_line.update_token_information

				create l_item
				l_item.set_pixmap (pixmap_factory.pixmap_from_class_i (a_class))
				l_item.enable_component_pebble
				l_item.set_text_with_tokens (l_line.content)
				a_row.set_item (context_column, l_item)
				l_item.disable_select

					-- Adjust column width.
				l_col := edit_contract_grid.column (context_column)
				l_col.set_width (l_line.width.max (l_col.width + 20 + l_item.left_border))
			end
		end

feature {NONE} -- Factory

	create_widget: !ES_GRID
			-- Creates a new widget, which will be initialized when `build_interface' is called.
		do
			create Result
		end

feature {NONE} -- Columns

	contract_column: INTEGER = 1
	context_column: INTEGER = 2

feature -- Synchronization

	synchronize
			-- Synchronizes any new data (compiled or other wise)
		do
			check False end
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
