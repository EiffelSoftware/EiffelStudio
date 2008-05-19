indexing
	description: "[
		A widget used to view and edit (when not the class is not read-only) contracts, given a context {ES_CONTRACT_EDITOR_CONTEXT} object.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_EDITOR_WIDGET

inherit
	ES_WINDOW_WIDGET [ES_GRID]
		redefine
			on_before_initialize
		end

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
			l_support: EB_EDITOR_TOKEN_GRID_SUPPORT
		do
			create l_support.make_with_grid (edit_contract_grid)
			l_support.synchronize_color_or_font_change_with_editor
			l_support.enable_grid_item_pnd_support
			l_support.enable_ctrl_right_click_to_open_new_window
			l_support.set_context_menu_factory_function (agent (develop_window.menus).context_menu_factory)
			auto_recycle (l_support)

			edit_contract_grid.set_column_count_to (context_column)
			edit_contract_grid.enable_auto_size_best_fit_column (contract_column)
			edit_contract_grid.enable_tree
			edit_contract_grid.enable_single_row_selection
			edit_contract_grid.set_subrow_indent (tab_indent_spacing.as_integer_32)
			edit_contract_grid.hide_tree_node_connectors
			edit_contract_grid.disable_row_height_fixed
			edit_contract_grid.enable_always_selected

				-- Colors
			edit_contract_grid.set_focused_selection_color (colors.grid_focus_selection_color)
			edit_contract_grid.set_focused_selection_text_color (colors.grid_focus_selection_text_color)
			edit_contract_grid.set_non_focused_selection_color (colors.grid_unfocus_selection_color)
			edit_contract_grid.set_non_focused_selection_text_color (colors.grid_unfocus_selection_text_color)

			register_action (edit_contract_grid.row_select_actions, agent (a_row: EV_GRID_ROW)
					-- Call the source select actions
				local
					l_source: ?ES_CONTRACT_SOURCE_I
				do
					if is_interface_usable and then is_initialized then
						l_source ?= a_row.data
						source_selection_actions.call ([l_source])
					end
				end)

				-- Columns
			l_col := edit_contract_grid.column (contract_column)
			l_col.set_title (interface_names.l_contracts)
			l_col := edit_contract_grid.column (context_column)
			l_col.set_title (interface_names.l_location)
		end

	on_before_initialize
			-- <Precursor>
		do
			create commit_edit_actions
			create source_selection_actions
			Precursor
		end

feature -- Access

	context: ?ES_CONTRACT_EDITOR_CONTEXT [CLASSI_STONE] assign set_context
			-- Contract editor context information

	context_contracts: !DS_BILINEAR [!ES_CONTRACT_LINE]
			-- Retrieves just the context's contracts.
			-- Note: Only the top contracts are returned because we only support edition of the context contracts,
			--       in the future this may change.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
		local
			l_result: DS_ARRAYED_LIST [!ES_CONTRACT_LINE]
			l_grid: !like edit_contract_grid
			l_row: EV_GRID_ROW
			l_sub_row: EV_GRID_ROW
			l_count, i: INTEGER
		do
			if internal_context_contracts = Void then
				create l_result.make_default
				l_grid := edit_contract_grid
				if l_grid.row_count > 0 then
					l_row := l_grid.row (1)
					l_count := l_row.subrow_count_recursive
					from i := 1 until i > l_count loop
						l_sub_row := l_row.subrow (i)
						if {l_line: !ES_CONTRACT_LINE} l_sub_row.data then
							l_result.force_last (l_line)
						end
						i := i + l_sub_row.subrow_count_recursive + 1
					end
				end

				Result ?= l_result
				internal_context_contracts := Result
			else
				Result ?= internal_context_contracts
			end
		ensure
			result_consistent: Result = context_contracts
		end

feature {NONE} -- Access

	tab_indent_spacing: INTEGER
			-- Number of pixels to indent rendered text, representing a tab character.
		do
			Result := (create {EDITOR_TOKEN_TABULATION}.make (1)).width
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
					refresh
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

	is_showing_all_rows: BOOLEAN assign set_is_showing_all_rows
			-- Indicates if all contract rows should be shown.
			-- Note: By default only those entities with contracts are shown.

feature -- Status setting

	set_is_showing_all_rows (a_show: like is_showing_all_rows)
			-- Set status to show/hide rows without contracts.
			--
			-- `a_show': True to show all rows; False to show only rows with contracts
		require
			is_interface_usable: is_interface_usable
		local
			l_grid: like edit_contract_grid
			l_row: EV_GRID_ROW
			i, l_count: INTEGER
		do
			if is_showing_all_rows /= a_show then
				if is_initialized and has_context then
					l_grid := edit_contract_grid
					l_count := l_grid.row_count
					from i := 1 until i > l_count loop
						l_row := l_grid.row (i)
						if l_row.subrow_count = 0 then
							if a_show then
								l_row.show
							else
								check not_first_row: l_row.index > 1 end
								l_row.hide
							end
						end
						i := i + 1 + l_row.subrow_count_recursive
					end
				end

				is_showing_all_rows := a_show
			end
		ensure
			is_showing_all_rows_set: is_showing_all_rows = a_show
		end

feature -- Query

	selected_source: ?ES_CONTRACT_SOURCE_I
			-- The currently active contract source.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			l_rows := edit_contract_grid.selected_rows
			if not l_rows.is_empty then
				Result ?= l_rows.last.data
			end
		end

	selected_line: ?ES_CONTRACT_LINE
			-- The currently active selected contract line.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			Result ?= selected_source
		end

feature -- Basic operations

	refresh
			-- Updates the context information and refreshes the contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
		local
			l_grid: !like edit_contract_grid
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_selected_index: INTEGER
			l_visible_index: INTEGER
			l_parents: !DS_LIST [CLASS_C]
			l_parent: !CLASS_I
			l_row: !EV_GRID_ROW
			l_col: EV_GRID_COLUMN
			i: INTEGER
		do
				-- Remove cached data
			internal_context_contracts := Void

			l_grid := edit_contract_grid

			if l_grid.row_count > 0 then
					-- Retireve selected index
				l_selected_rows := l_grid.selected_rows
				if l_selected_rows.is_empty then
					l_selected_index := 1
				else
					l_selected_index := l_selected_rows.first.index
				end

					-- Retireve first visible index
				if l_grid.is_displayed then
					l_visible_index := l_grid.first_visible_row.index
				end
			end

				-- Remove existing items
			l_grid.lock_update
			l_grid.set_row_count_to (0)

				-- Set the column size.
			l_grid.column (context_column).set_width (16)

			if {l_context: !like context} context then
					-- Extract contracts for current class
				l_grid.set_row_count_to (l_grid.row_count + 1)
				l_row ?= l_grid.row (1)
				populate_contracts_row (l_context.context_class, l_row, l_context)

					-- Traverse through parents
				l_parents := l_context.context_parents
				if not l_parents.is_empty then
					from l_parents.start until l_parents.after loop
						l_parent ?= l_parents.item_for_iteration.lace_class
						i := l_grid.row_count + 1
						l_grid.set_row_count_to (i)
						l_row ?= l_grid.row (i)
						populate_contracts_row (l_parent, l_row, l_context)
						l_parents.forth
					end
				end

					-- Set context column width
				l_col := l_grid.column (context_column)
				l_col.set_width (l_col.width + 4)
			end

			if l_grid.row_count > 0 then
					-- Reduce preservation indexes
				if l_grid.row_count < l_selected_index then
					l_selected_index := l_grid.row_count
				end
				if l_grid.row_count < l_visible_index then
					l_visible_index := l_grid.row_count
				end

					-- Enable initial selection
				l_grid.row (l_selected_index.max (1)).enable_select
				l_grid.set_first_visible_row (l_visible_index.max (1))
			else
					-- Call the deselect actions, to notify clients that there is no valid selection.
				source_selection_actions.call ([Void])
			end

			l_grid.unlock_update
		rescue
			l_grid.unlock_update
		end

feature {NONE} -- Basic operations

	find_row (a_source: !ES_CONTRACT_SOURCE_I): ?EV_GRID_ROW
			-- Attempt to locate a grid row for a given source
			--
			-- `a_source': The contract source to locate a row for.
			-- `Result': A located grid row of Void if none was found.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
		local
			l_source: !ES_CONTRACT_SOURCE_I
			l_grid: !like edit_contract_grid
			l_row: EV_GRID_ROW
			l_sub_row: EV_GRID_ROW
			l_count, i: INTEGER
			l_sub_count, j: INTEGER
		do
				-- Retrieve real source because the source could be a line.
			l_source := a_source.source

			l_grid := edit_contract_grid
			l_count := l_grid.row_count
			from i := 1 until i > l_count or Result /= Void loop
				l_row := l_grid.row (i)
				if l_row.data = a_source then
					Result := l_row
				elseif l_row.data = l_source then
						-- Matching source, head into subrows
					l_sub_count := l_row.subrow_count_recursive
					from j := 1 until j > l_sub_count or Result /= Void loop
						l_sub_row := l_row.subrow (j)
						if l_sub_row.data = a_source then
								-- Located source subrown
							Result := l_sub_row
						else
							j := j + l_sub_row.subrow_count_recursive + 1
						end
					end
				else
					i := i + l_row.subrow_count_recursive + 1
				end
			end
		ensure
			not_result_is_destroyed: Result /= Void implies not Result.is_destroyed
			result_has_valid_parent: Result /= Void implies Result.parent = edit_contract_grid
		end

feature -- Modification

	add_contract (a_tag: !STRING_32; a_contract: !STRING_32; a_source: !ES_CONTRACT_SOURCE_I)
			-- Adds a contract using a seperate tag name and contract.
			--
			-- `a_tag': The contract tag name.
			-- `a_contract': The actual contract code.
			-- `a_source': The editable source to add the contract after
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
			not_a_contract_is_empty: not a_contract.is_empty
			a_source_is_editable: a_source.source.is_editable
		local
			l_line: ES_CONTRACT_LINE
		do
			if a_tag.is_empty then
				create l_line.make_without_tag (a_contract, a_source)
			else
				create l_line.make (a_tag, a_contract, a_source)
			end
			add_contract_string (l_line.string, a_source)
		end

	add_contract_string (a_contract: !STRING_32; a_source: !ES_CONTRACT_SOURCE_I)
			-- Adds a contract using a contract string, containing both a tag name and contract as if it was extracted directly
			-- from the editor.
			--
			-- `a_tag': The contract tag name.
			-- `a_contract': The actual contract code.
			-- `a_source': The editable source to add the contract after
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
			not_a_contract_is_empty: not a_contract.is_empty
			a_source_is_editable: a_source.source.is_editable
		local
			l_new_row: !EV_GRID_ROW
			l_selected: BOOLEAN
			i: INTEGER
		do
			if {l_row: EV_GRID_ROW} find_row (a_source) then
				l_selected := l_row.is_selected
				if l_selected then
					l_row.disable_select
				end
				if l_row.parent_row = Void then
					if l_row.subrow_count = 0 or else not context_contracts.is_empty then
						l_row.insert_subrow (1)
						l_new_row ?= l_row.subrow (1)
					else
							-- There is a place holder, just reuse it.
						l_new_row ?= l_row.subrow (1)
						if not l_selected then
							l_selected := l_new_row.is_selected
						end
					end
				else
					i := l_row.index - l_row.parent_row.index + 1
					l_row.parent_row.insert_subrow (i)
					l_new_row ?= l_row.parent_row.subrow (i)
				end
				edit_contract_grid.row_select_actions.block
				populate_editable_contract_row (a_contract, a_source.source, l_new_row)
				edit_contract_grid.row_select_actions.resume

				internal_context_contracts := Void
				if l_selected then
					l_new_row.enable_select
				end
			end
		end

	remove_contract (a_line: !ES_CONTRACT_LINE)
			-- Removes a contract.
			--
			-- `a_line': A contract line to remove from the editor.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
			a_line_source_is_editable: a_line.source.is_editable
			a_line_is_editable: a_line.is_editable
			context_contracts_has_a_line: context_contracts.has (a_line)
		local
			l_grid: !like edit_contract_grid
			l_row: !EV_GRID_ROW
			l_sub_row: !EV_GRID_ROW
			l_source: !ES_CONTRACT_SOURCE_I
			l_count, i: INTEGER
			l_sub_count, j: INTEGER
			l_removed: BOOLEAN
			l_selected: BOOLEAN
		do
			l_source := a_line.source
			l_grid := edit_contract_grid
			l_count := l_grid.row_count
			from i := 1 until i > l_count or l_removed loop
				l_row ?= l_grid.row (i)
				if l_row.data = l_source then
						-- Matching source
					l_sub_count := l_row.subrow_count_recursive
					from j := 1 until j > l_sub_count or l_removed loop
						l_sub_row ?= l_row.subrow (j)
						if l_sub_row.data = a_line then
							l_selected := l_sub_row.is_selected
							if l_selected then
								l_sub_row.disable_select
							end
							if l_selected then
									-- Disable selection, because a row could be resused so the select actions will
									-- not be called.
								l_sub_row.disable_select
							end
							if l_sub_count = 1 then
									-- Only one item left so replace with the no contract message
								populate_no_contract_row (l_sub_row)
							else
									-- Remove extra row
								l_grid.remove_row (l_sub_row.index)
							end
							internal_context_contracts := Void
							l_removed := True
							if l_selected then
									-- Perform re-selection
								if j < l_sub_count then
										-- Select next
									l_row.subrow (j).enable_select
								elseif j > 1 then
										-- Select previous
									l_row.subrow (j - 1).enable_select
								else
										-- No sub items, select parent
									l_row.enable_select
								end
							end
						else
							j := j + l_sub_row.subrow_count_recursive + 1
						end
					end

					check removed: l_removed end
				else
					i := i + l_row.subrow_count_recursive + 1
				end
			end

			check removed: l_removed end
		end

	replace_contract (a_tag: !STRING_32; a_contract: !STRING_32; a_line: !ES_CONTRACT_LINE)
			-- Replaces an existing contract.
			-- Note: `a_line' will probably be invalid after replacing the contract. There is no guarentee of it remaining the same.
			--
			-- `a_tag': A new contract tag.
			-- `a_contract': The new contracts.
			-- `a_line': The original contract lines to replace.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
			not_a_contract_is_empty: not a_contract.is_empty
			a_line_source_is_editable: a_line.source.is_editable
			a_line_is_editable: a_line.is_editable
			context_contracts_has_a_line: context_contracts.has (a_line)
		local
			l_row: like find_row
			l_line: like a_line
		do
			l_row := find_row (a_line)
			check l_row_attached: l_row /= Void end
			if l_row /= Void then
				l_line := a_line.twin
				l_line.tag := a_tag
				l_line.contract := a_contract
				internal_context_contracts := Void
				populate_editable_contract_row (l_line.string, l_line.source, l_row)
			end
		end

	swap_contracts (a_line: !ES_CONTRACT_LINE; a_other_line: !ES_CONTRACT_LINE)
			-- Swaps two contracts.
			--
			-- `a_line': Orginal contracts line.
			-- `a_other_line': Other contract line to swap with the original.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
			a_line_source_is_editable: a_line.source.is_editable
			a_line_is_editable: a_line.is_editable
			context_contracts_has_a_source: context_contracts.has (a_line)
			a_other_line_source_is_editable: a_other_line.source.is_editable
			a_other_line_is_editable: a_other_line.is_editable
			context_contracts_has_a_other_line: context_contracts.has (a_other_line)
		local
			l_row: ?like find_row
			l_other_row: ?like find_row
			l_selected: BOOLEAN
			l_other_selected: BOOLEAN
		do
			l_row := find_row (a_line)
			l_other_row := find_row (a_other_line)

			if l_row /= Void and then l_other_row /= Void then
				edit_contract_grid.row_select_actions.block
				l_selected := l_row.is_selected
				l_other_selected := l_other_row.is_selected

					-- Populate row and re-set data
				populate_editable_contract_row (a_other_line.string, a_other_line.source, l_row)
				l_row.set_data (a_other_line)

					-- Populate row and re-set data
				populate_editable_contract_row (a_line.string, a_line.source, l_other_row)
				l_other_row.set_data (a_line)

				internal_context_contracts := Void
				edit_contract_grid.row_select_actions.resume
				if l_selected then
					l_other_row.enable_select
				end
				if l_other_selected then
					l_row.enable_select
				end
			else
					-- Something's not right, this should never happen!
				check False end
			end
		ensure
			internal_context_contracts_detached: edit_contract_grid.selected_rows.is_empty implies internal_context_contracts = Void
		end

feature {NONE} -- Helpers

	frozen context_printer: !ERROR_CONTEXT_PRINTER
			-- Printer used to print context information
		once
			create Result
		end

	frozen pixmap_factory: !EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
			-- Pixmap factory
		once
			create Result
		end

	frozen token_scanner: !EDITOR_EIFFEL_SCANNER
			-- Scanner used to tokenize Eiffel code
		once
			create Result.make
		end

	frozen string_formatter: !STRING_FORMATTER
			-- Formatter used to format strings
		once
			create Result
		end

feature {NONE} -- User interface elements

	edit_contract_grid: !ES_GRID
			-- The grid used to display and edit the contracts for the current context
		do
			Result ?= widget
		end

feature -- Actions

	commit_edit_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE [code: !STRING_32; old_code: STRING_32]]
			-- Actions called to inform subscribers of the commit actions just taken place.
			--
			-- `' DO NOT USE

	source_selection_actions: !EV_LITE_ACTION_SEQUENCE [!TUPLE [source: ?ES_CONTRACT_SOURCE_I]]
			-- Actions called when a contract source is selected/deselected
			--
			-- `source': The selected source or Void if not source was selected

feature {NONE} -- Population

	populate_contracts_row (a_class: !CLASS_I; a_row: !EV_GRID_ROW; a_context: !like context) is
			-- Populates a inherited read-only grid row for a given class.
			--
			-- `a_class': Current class where the context feature resides.
			-- `a_row': The grid row to populate with the current contract information.
			-- `a_context': The editor context used to populate the contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_parented: a_row.parent = edit_contract_grid
			a_context_has_stone: a_context.has_stone
		local
			l_grid: like edit_contract_grid
			l_editable: BOOLEAN
			l_mod_contract: TUPLE [contracts: !DS_LIST [TAGGED_AS]; modifier: !ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]]
			l_contracts: !DS_LIST [TAGGED_AS]
			l_tagged: TAGGED_AS
			l_decorator: TEXT_FORMATTER_DECORATOR
			l_feat_decorator: FEAT_TEXT_FORMATTER_DECORATOR
			l_token_generator: EB_EDITOR_TOKEN_GENERATOR
			l_feature_i: FEATURE_I
			l_row: !EV_GRID_ROW
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_scanner: ?like token_scanner
			l_tagged_text: STRING
			l_left_border: INTEGER
			l_class_c: CLASS_C
			l_contract_source: !ES_CONTRACT_SOURCE
			l_contract_line: !ES_CONTRACT_LINE
			i: INTEGER
		do
			l_grid := edit_contract_grid

				-- Retrieve context information
			l_editable := a_context.context_class = a_class and not a_class.is_read_only
			l_mod_contract := a_context.contracts_for_class (a_class, l_editable)

			populate_contract_header_row (a_class, a_row, a_context, l_editable)

			create l_contract_source.make (a_context, l_editable)
			a_row.set_data (l_contract_source)

				-- Retrieve width of left indent for items
			l_left_border := tab_indent_spacing

				-- Set row's data to include the class text modifier
			if l_editable then
					-- For now we only allow edits on the context class/feature.
				l_scanner := token_scanner
				l_scanner.reset
				l_scanner.set_current_class (a_class.config_class)
			end

				-- Populate contracts, if any
			l_contracts := l_mod_contract.contracts
			if not l_contracts.is_empty and then (not l_editable or else l_mod_contract.modifier.is_ast_available) then
				a_row.insert_subrows (l_contracts.count, 1)
				if not l_editable then
						-- Create token generator for use later.
					create l_token_generator.make
				end

				from
					i := 1
					l_contracts.start
				until
					l_contracts.after
				loop
					l_tagged := l_contracts.item_for_iteration
					check l_tagged_attached: l_tagged /= Void end
					if l_tagged /= Void then
						l_row ?= a_row.subrow (i)

						if l_editable then
							check
								l_scanner_attached: l_scanner /= Void
								ast_match_list_attached: l_mod_contract.modifier.ast_match_list /= Void
							end

							l_tagged_text := l_tagged.text (l_mod_contract.modifier.ast_match_list)
								-- Because the tagged text is coming from an AST node the initial tabbing is missing.
							if {l_inv: ES_INVARIANT_CONTRACT_EDITOR_CONTEXT} context then
								l_tagged_text.prepend ("%T")
							else
								l_tagged_text.prepend ("%T%T%T")
							end
								-- Call will set row data!
							populate_editable_contract_row (({!STRING_32}) #? l_tagged_text.as_string_32, l_contract_source, l_row)
						else
								-- Perform formatting with decorator, enabling clickable text.
							l_class_c := l_mod_contract.modifier.context_class.compiled_class
							if {l_fmodifier: !ES_FEATURE_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]} l_mod_contract.modifier then
								l_feature_i := l_class_c.feature_of_feature_id (l_fmodifier.context_feature.feature_id)
								create l_feat_decorator.make (l_class_c, l_token_generator)
								l_feat_decorator.init_feature_context (l_feature_i, l_feature_i, l_fmodifier.context_feature.ast)
								l_decorator := l_feat_decorator
							else
								create l_decorator.make (l_class_c, l_token_generator)
							end

							check l_decorator_attached: l_decorator /= Void end
							l_decorator.format_ast (l_tagged)
							l_tagged_text := l_tagged.text (l_class_c.match_list_server.item (l_class_c.class_id))

								-- Add contract item
							create l_editor_item
							l_editor_item.set_text_with_tokens (l_token_generator.tokens (0))
							l_editor_item.set_left_border (l_left_border)
							l_row.set_item (contract_column, l_editor_item)

							l_row.set_height (l_row.height.max (l_editor_item.required_height_for_text_and_component))

								-- Clear formatter
							l_token_generator.wipe_out_lines

								-- Set contract line data
							create l_contract_line.make_from_string (({!STRING_32}) #? l_tagged_text.as_string_32, l_contract_source)
							l_row.set_data (l_contract_line)
						end

						if not l_editable then
							l_row.disable_select
							a_row.disable_select
						end
						l_grid.grid_row_fill_empty_cells (l_row)

							-- Ensure item is expandable
						a_row.ensure_expandable
						if not a_row.is_expanded then
								-- Expand now to stop refresh flashing.
							a_row.expand
						end
						i := i + 1
					end
					l_contracts.forth
				end
			elseif l_editable or else a_row.index = 1 then
					-- Add "No contracts found" sub row for first item, as first items represent the context
					-- class and should always be seen.
				a_row.insert_subrows (1, 1)
				l_row ?= a_row.subrow (a_row.subrow_count)

				if not l_editable or else a_context.text_modifier.is_ast_available then
					populate_no_contract_row (l_row)
				else
						-- If not ast is available then there was a syntax error
					populate_syntax_error_row (a_class, l_row)
				end

					-- Expand row
				a_row.expand

				if not l_editable then
						-- Disable selection of non-editable rows
					l_row.disable_select
					a_row.disable_select
				end
			elseif not is_showing_all_rows then
					-- Hide the row because there are no contracts
				a_row.hide
			end
		ensure
			a_row_data_set: a_context.text_modifier.is_ast_available implies (({ES_CONTRACT_SOURCE_I}) #? a_row.data) /= Void
		end

	populate_contract_header_row (a_class: !CLASS_I; a_row: !EV_GRID_ROW; a_context: !like context; a_editable: BOOLEAN)
			-- Populates a contract header row.
			--
			-- `a_class': Current class where the context feature resides.
			-- `a_row': The grid row to populate with the current contract information.
			-- `a_context': The editor context used to populate the contracts.
			-- `a_editable': True to indicate the header row is editable; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
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
			l_pixmap: EV_PIXEL_BUFFER
			l_selected: BOOLEAN
		do
			l_selected := a_row.is_selected
			a_row.clear

				-- Context class
			create l_generator.make
			l_generator.disable_multiline

			if {l_context: !ES_FEATURE_CONTRACT_EDITOR_CONTEXT} a_context then
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
					l_pixmap := pixmap_factory.pixmap_from_e_feature (l_e_feature)
				else
					l_pixmap := stock_pixmaps.feature_routine_icon_buffer
				end
				if not a_editable then
					l_pixmap := (create {EB_SHARED_PIXMAPS}).icon_buffer_with_overlay (l_pixmap, stock_pixmaps.overlay_locked_icon_buffer, 0, 0)
				end
				l_item.set_pixmap (l_pixmap)

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
				l_pixmap := pixmap_factory.pixmap_from_class_i (a_class)
				if not a_editable then
					l_pixmap := (create {EB_SHARED_PIXMAPS}).icon_buffer_with_overlay (l_pixmap, stock_pixmaps.overlay_locked_icon_buffer, 0, 0)
				end
				l_item.set_pixmap (l_pixmap)
				l_item.set_text_with_tokens (a_context.contract_keywords (True))

				a_row.set_item (contract_column, l_item)

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

			if l_selected then
				a_row.disable_select
				a_row.enable_select
			end
		end

	populate_editable_contract_row (a_contract: !STRING_32; a_source: !ES_CONTRACT_SOURCE_I; a_row: !EV_GRID_ROW)
			-- Populates a inherited read-only grid row for a given class.
			--
			-- `a_class': Current class where the context feature resides.
			-- `a_row': The grid row to populate with the current contract information.
			-- `a_context': The editor context used to populate the contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
			token_scanner_has_current_class: token_scanner.current_class /= Void
			not_a_contract_is_empty: not a_contract.is_empty
			a_source_is_editable: a_source.is_editable
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_parented: a_row.parent = edit_contract_grid
		local
			l_selected: BOOLEAN
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_scanner: !like token_scanner
			l_editable_lines: LIST [STRING_32]
			l_editor_tokens: LINKED_LIST [EDITOR_TOKEN]
			l_line: EIFFEL_EDITOR_LINE
			l_contract_line: !ES_CONTRACT_LINE
		do
			l_selected := a_row.is_selected

			a_row.clear

			l_scanner := token_scanner

			create l_contract_line.make_from_string (a_contract, a_source)
			l_editable_lines := l_contract_line.string.split ('%N')

				-- Editable items are not clickable. This is because the AST data is live, and un-annotated.
				-- However, we'll do our best to make them a pretty as possible.
				-- FIXME: Implement clickable behavior like the editor.
			create l_editor_tokens.make

				-- Iterate through the lines to build a token list
			from l_editable_lines.start until l_editable_lines.after loop
				if l_editable_lines.islast then
					l_scanner.execute (l_editable_lines.item)
				else
					l_scanner.execute (l_editable_lines.item + "%N")
				end
				create l_line.make_from_lexer (l_scanner)
				l_editor_tokens.append (l_line.content)
				l_editable_lines.forth
			end
			l_scanner.reset

			if l_editor_tokens.is_empty then
				check False end
					-- Create the text item (fail safe)
				l_editor_tokens.extend (create {EDITOR_TOKEN_TEXT}.make (a_contract))
			end

				-- Create the editor item
			create l_editor_item
			l_editor_item.set_text_with_tokens (l_editor_tokens)

			a_row.set_height (l_editor_item.required_height_for_text_and_component)

			l_editor_item.set_left_border (tab_indent_spacing)
			a_row.set_item (contract_column, l_editor_item)

				-- Set contract line data
			a_row.set_data (l_contract_line)

			edit_contract_grid.grid_row_fill_empty_cells (a_row)

			if l_selected then
				a_row.disable_select
				a_row.enable_select
			end
		ensure
			a_row_selected: old a_row.is_selected implies a_row.is_selected
		end

	populate_no_contract_row (a_row: !EV_GRID_ROW)
			-- Populates a row to indicate that no contracts exist.
			--
			-- `a_row': The grid row to populate with the message.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_parented: a_row.parent = edit_contract_grid
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_selected: BOOLEAN
		do
			l_selected := a_row.is_selected
			a_row.clear

				-- Use an editor grid item to replicate the style
			if {l_pre: ES_PRECONDITION_CONTRACT_EDITOR_CONTEXT} context then
				create l_editor_item.make_with_text (interface_names.t_contract_no_preconditions.as_string_8)
			elseif {l_post: ES_POSTCONDITION_CONTRACT_EDITOR_CONTEXT} context then
				create l_editor_item.make_with_text (interface_names.t_contract_no_postcondtions.as_string_8)
			else
				create l_editor_item.make_with_text (interface_names.t_contract_no_invariants.as_string_8)
			end
			l_editor_item.set_pixmap (stock_pixmaps.general_warning_icon)
			l_editor_item.set_left_border (tab_indent_spacing)
			a_row.set_item (contract_column, l_editor_item)
			edit_contract_grid.grid_row_fill_empty_cells (a_row)

			a_row.set_data (a_row.parent_row.data)

			if l_selected then
				a_row.disable_select
				a_row.enable_select
			end
		ensure
			a_row_data_set: a_row.data = a_row.parent_row.data
		end

	populate_syntax_error_row (a_class: !CLASS_I; a_row: !EV_GRID_ROW)
			-- Populates a row to indicate the supplied class has a syntax error.
			--
			-- `a_class': Current class where the syntax error occurred.
			-- `a_row': The grid row to populate with the message.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_parented: a_row.parent = edit_contract_grid
		local
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_token_generator: EB_EDITOR_TOKEN_GENERATOR
			l_selected: BOOLEAN
		do
			l_selected := a_row.is_selected
			a_row.clear

			create l_token_generator.make
			l_token_generator.add (interface_names.t_contract_syntax_error_1)
			l_token_generator.add_class (a_class)
			l_token_generator.add (interface_names.t_contract_syntax_error_2)

			create l_editor_item
			l_editor_item.set_pixmap (stock_pixmaps.general_error_icon)
			l_editor_item.set_left_border (tab_indent_spacing)
			l_editor_item.set_text_with_tokens (l_token_generator.tokens (0))
			a_row.set_item (contract_column, l_editor_item)
			edit_contract_grid.grid_row_fill_empty_cells (a_row)

			a_row.set_data (Void)
			a_row.parent_row.set_data (Void)

			if l_selected then
				a_row.disable_select
				a_row.enable_select
			end
		ensure
			a_row_data_unset: a_row.data = Void
			a_row_parent_data_unset: a_row.parent_row.data = Void
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

feature {NONE} -- Internal implementation cache

	internal_context_contracts: ?like context_contracts
			-- Cached version of `context_contracts'
			-- Note: Do not use directly!

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
