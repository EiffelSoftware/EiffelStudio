indexing
	description: "[
		A custom widget for viewing the contract and comments of a particular feature.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_VIEWER_WIDGET

inherit
	ES_WIDGET [EV_VERTICAL_BOX]

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	build_widget_interface (a_widget: !EV_VERTICAL_BOX) is
			-- Builds widget's interface.
			-- `a_widget': The widget to initialize of build upon.
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_grid_support: EB_EDITOR_TOKEN_GRID_SUPPORT
		do
			a_widget.set_border_width (2)

			create contract_grid
			contract_grid.hide_header
			contract_grid.set_column_count_to (1)
			contract_grid.enable_auto_size_best_fit_column (1)
			contract_grid.disable_row_height_fixed
			contract_grid.disable_selection_on_click

			create l_grid_support.make_with_grid (contract_grid)
			l_grid_support.enable_ctrl_right_click_to_open_new_window
			l_grid_support.enable_grid_item_pnd_support
			auto_recycle (l_grid_support)

			a_widget.extend (contract_grid)

			create l_hbox
			l_hbox.extend (create {EV_CELL})

			create edit_contract_label.make_with_text ("Edit Contracts...")
			edit_contract_label.align_text_right
			register_action (edit_contract_label.select_actions, agent on_edit_contracts)
			l_hbox.extend (edit_contract_label)

				-- Edit contracts button
			create edit_contracts_button.make_with_text ("Edit Contracts...")
			edit_contracts_button.set_tooltip ("Edit the contracts for this feature.")
			register_action (edit_contracts_button.select_actions, agent on_edit_contracts)
--			l_hbox.extend (edit_contracts_button)
--			l_hbox.disable_item_expand (edit_contracts_button)

			edit_contracts_button.hide

			a_widget.extend (l_hbox)
			a_widget.disable_item_expand (l_hbox)
		end

feature {NONE} -- Access

	context_feature: E_FEATURE
			-- Last viewed feature

	context_class: CLASS_C
			-- Last viewed class

feature -- Element change

	set_context (a_class: !like context_class; a_feature: !like context_feature)
			-- Set's the contract widget's view context
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			now_is_shown: not is_shown
		do
			context_class := a_class
			context_feature := a_feature
			update_context
		ensure
			context_class_set: context_class = a_class
			context_feature_set: context_feature = a_feature
		end

feature -- Status report

	is_showing_full_contracts: BOOLEAN assign set_is_showing_full_contracts
			-- Indicates if the full contracts should be shown

	is_showing_comments: BOOLEAN
			-- Indicates if comments should be shown
		require
			is_interface_usable: is_interface_usable
		do
			Result := True
		end

feature {NONE} -- Status report

	has_context: BOOLEAN
			-- Determines if the widget has enough context to display the contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			Result := context_class /= Void and then context_feature /= Void
		ensure
			context_class_attached: Result implies context_class /= Void
			context_feature_attached: Result implies context_feature /= Void
		end

feature -- Status setting

	set_is_showing_full_contracts (a_show: like is_showing_full_contracts)
			-- Sets state to indicate if the full contracts should be shown.
			--
			-- `a_show': True to ensure all contracts are shown; False to show only preconditions.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_is_showing: like is_showing_full_contracts
		do
			l_is_showing := is_showing_full_contracts
			if l_is_showing /= a_show then
				is_showing_full_contracts := a_show
				if is_shown and then has_context then
					update_context
				end
			end
		ensure
			is_showing_full_contracts_set: is_showing_full_contracts = a_show
		end

feature {NONE} -- Basic operation

	update_context
			-- Updates the contract view based on a previously set context.
			-- Note: Context can be set using `set_context'
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_context: has_context
		local
			l_server: ASSERTION_SERVER
			l_assertions: CHAINED_ASSERTIONS
			l_decorator: FEAT_TEXT_FORMATTER_DECORATOR
			l_generator: !EB_EDITOR_TOKEN_GENERATOR
			l_feature_i: FEATURE_I
			l_feature_as: FEATURE_AS
			l_editor_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_grid: like contract_grid
			l_height: INTEGER
			l_token_text: EB_EDITOR_TOKEN_TEXT
			l_row: EV_GRID_ROW
			l_tokens: LIST [EDITOR_TOKEN]
			l_width: INTEGER
		do
				-- Clear the contract grid
			l_grid := contract_grid
			l_grid.lock_update
			l_grid.clear

			if {l_feature: !like context_feature} context_feature and {l_class: !like context_class} context_class then
--				contract_grid.set_row_count_to (1)

				create l_token_text

--					-- Create editor signature
				create l_generator.make
				l_generator.enable_multiline
--				l_feature.append_signature (l_generator)
--				l_tokens := l_generator.tokens (0)

--				l_row := contract_grid.row (1)
--				create l_editor_item
--				l_editor_item.enable_component_pebble
--				l_editor_item.set_text_with_tokens (l_tokens)
--					-- Evaluate height
--				l_token_text.set_tokens (l_tokens)
--				l_row.set_height (l_token_text.required_height)
--					-- Set item
--				l_row.set_item (1, l_editor_item)
--					-- Clean up
--				l_generator.wipe_out_lines

--					-- Grid dimension adjustments
--				l_height := l_height + l_row.height
--				l_width := l_width.max (l_token_text.required_width)

					-- Comments
				create l_editor_item
				l_grid.set_row_count_to (l_grid.row_count + 1)
				l_row := l_grid.row (l_grid.row_count)
				l_row.set_item (1, l_editor_item)
				l_row.hide

				if is_showing_comments then
					l_tokens := feature_comment_tokens (l_feature, l_generator)
					if l_tokens = Void or else l_tokens.is_empty then
							-- Create empty comments
						create {ARRAYED_LIST [EDITOR_TOKEN]} l_tokens.make (2)
						l_tokens.extend (create {EDITOR_TOKEN_TABULATION}.make (2))
						l_tokens.extend (create {EDITOR_TOKEN_COMMENT}.make ("-- " + interface_names.h_no_comments_for_feature))
					end
					if l_tokens /= Void then
						l_editor_item.set_text_with_tokens (l_tokens)
						l_generator.wipe_out_lines

						l_token_text.set_tokens (l_tokens)
						l_row.set_height (l_token_text.required_height)
						l_row.show

							-- Grid dimension adjustments
						l_height := l_height + l_row.height
						l_width := l_width.max (l_token_text.required_width)
					end
				end

				l_generator.wipe_out_lines

				l_feature_i := l_feature.associated_feature_i
				l_feature_as := l_feature.ast
				create l_server.make_for_feature (l_feature_i, l_feature_as)
				l_assertions := l_server.current_assertion
				l_assertions.set_is_without_breakable
				l_assertions.set_in_bench_mode
				if l_assertions /= Void then
						-- Preconditions
					create l_decorator.make (l_class, l_generator)
					l_decorator.init_feature_context (l_feature_i, l_feature_i, l_feature_as)
					l_assertions.format_precondition (l_decorator)

					l_tokens := l_generator.tokens (1)
					if not l_tokens.is_empty then
							-- Format preconditions
						create l_editor_item
						l_editor_item.set_text_with_tokens (l_tokens)
						l_generator.wipe_out_lines

							-- Set row
						l_grid.set_row_count_to (l_grid.row_count + 1)

						l_row := l_grid.row (l_grid.row_count)
						l_row.set_item (1, l_editor_item)
						l_token_text.set_tokens (l_tokens)
						l_row.set_height (l_token_text.required_height)

							-- Grid dimension adjustments
						l_height := l_height + l_row.height
						l_width := l_width.max (l_token_text.required_width)
					end

					if is_showing_full_contracts then
							-- Postconditions
						create l_decorator.make (l_class, l_generator)
						l_decorator.init_feature_context (l_feature_i, l_feature_i, l_feature_as)
						l_assertions.format_postcondition (l_decorator)

						l_tokens := l_generator.tokens (1)
						if not l_tokens.is_empty then
								-- Format postconditions
							create l_editor_item
							l_editor_item.set_text_with_tokens (l_tokens)
							l_generator.wipe_out_lines

								-- Set row
							l_grid.set_row_count_to (l_grid.row_count + 1)

							l_row := l_grid.row (l_grid.row_count)
							l_row.set_item (1, l_editor_item)
							l_token_text.set_tokens (l_tokens)
							l_row.set_height (l_token_text.required_height)

								-- Grid dimension adjustments
							l_height := l_height + l_row.height
							l_width := l_width.max (l_token_text.required_width)
						end
					end
				end

				l_grid.set_minimum_size (l_width + 20, l_height + 6)
				l_grid.column (1).set_width (l_width + 2)
			end

			l_grid.unlock_update

				-- Set contract button's edit state.
			if context_class.group.is_readonly then
				edit_contract_label.set_text ("View Contracts...")
			else
				edit_contract_label.set_text ("Edit Contracts...")
			end
		end

feature {NONE} -- Comment extraction

	feature_comment_tokens (a_feature: !E_FEATURE; a_token_writer: !EB_EDITOR_TOKEN_GENERATOR): ARRAYED_LIST [EDITOR_TOKEN] is
			-- Editor token representation of comment of `a_feature'.
			--
			-- `a_feature': The feature to show comments for.
			-- `a_token_writer': The token generator used to extract tokens from the feature comments.
			-- `Result': A list of tokens or Void if no comments were found.
		local
			l_comments: EIFFEL_COMMENTS
			l_comment: STRING_8
		do
			l_comments := (create {COMMENT_EXTRACTOR}).feature_comments_ex (a_feature, True)
			if l_comments /= Void and then not l_comments.is_empty then
				create Result.make (128)

				a_token_writer.set_comment_context_class (a_feature.associated_class)
				from
					l_comments.start
				until
					l_comments.after
				loop
					a_token_writer.new_line
					a_token_writer.add_indent
					a_token_writer.add_indent

					l_comment := l_comments.item.content
					a_token_writer.add_comment_text ("--")
					a_token_writer.add_comment_text (l_comment)

					Result.append (a_token_writer.last_line.content)
					if not l_comments.islast then
						Result.extend (create {EDITOR_TOKEN_EOL}.make)
					end
					l_comments.forth
				end

					-- Update the comment token widths
				Result.do_all (agent {EDITOR_TOKEN}.update_width)
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

feature {NONE} -- User interface elements

	contract_grid: !ES_GRID
			-- The grid used to show the contracts

	edit_contracts_button: !EV_BUTTON
			-- Button used to edit the contracts

	edit_contract_label: !EVS_LINK_LABEL
			-- Label used to edit contracts

feature {NONE} -- Action handlers

	on_edit_contracts
			-- Called when the user selects to edit the contracts of the Current feature
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			context_feature_attached: context_feature /= Void
			context_class_attached: context_class /= Void
		local
			l_manager: EB_WINDOW_MANAGER
			l_window: EB_DEVELOPMENT_WINDOW
			l_feature_stone: FEATURE_STONE
		do
			l_manager := (create {EB_SHARED_WINDOW_MANAGER}).window_manager
			l_window := l_manager.last_focused_development_window
			if l_window /= Void and l_window.is_interface_usable then
				if {l_tool: !ES_CONTRACT_TOOL} l_window.shell_tools.tool ({ES_CONTRACT_TOOL}) and then l_tool.is_interface_usable then
						-- Show and activate focus on the tool.
					create l_feature_stone.make (context_feature)
					check l_feature_stone_is_stone_usable: l_tool.is_stone_usable (l_feature_stone) end
					if l_tool.query_set_stone (l_feature_stone) then
						l_tool.set_stone (l_feature_stone)
						l_tool.show (True)
					end
				end
			end
		end

feature {NONE} -- Factory

	create_widget: !EV_VERTICAL_BOX
			-- Creates a new widget, which will be initialized when `build_interface' is called.
		do
			create Result
		end

feature {NONE} -- Regular expressions

	original_comment_reg_ex: RX_PCRE_MATCHER
			-- Pattern to match a original comment specification with an optional precursor class name
		once
			create Result.make
			Result.compile ("[\ \t]*<[\ \t]*[Oo][Rr][Ii][Gg][Ii][Nn][Aa][Ll][\ \t]*({([A-Z][A-Z_0-9]*)\}[\ \t]*>|>)")
		ensure
			result_is_compiled: Result.is_compiled
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
