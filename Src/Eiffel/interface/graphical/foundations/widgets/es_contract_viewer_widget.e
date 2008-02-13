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

--inherit {NONE}
--	SHARED_INST_CONTEXT
--		export
--			{NONE} all
--		end

--	SHARED_WORKBENCH
--		export
--			{NONE} all
--		end

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	build_widget_interface (a_widget: !EV_VERTICAL_BOX) is
			-- Builds widget's interface.
			-- `a_widget': The widget to initialize of build upon.
		local
			l_vbox: EV_VERTICAL_BOX
			l_hbox: EV_HORIZONTAL_BOX
		do
			a_widget.set_border_width (2)

			create contract_grid
			contract_grid.hide_header
			contract_grid.set_column_count_to (1)
			contract_grid.enable_auto_size_best_fit_column (1)
			contract_grid.disable_row_height_fixed
			contract_grid.disable_selection_on_click

			a_widget.extend (contract_grid)

			create l_hbox
			l_hbox.extend (create {EV_CELL})

				-- Edit contracts button
			create edit_contracts_button.make_with_text ("Edit Contracts...")
			edit_contracts_button.set_tooltip ("Edit the contracts for this feature.")
			register_action (edit_contracts_button.select_actions, agent on_edit_contracts)
			l_hbox.extend (edit_contracts_button)
			l_hbox.disable_item_expand (edit_contracts_button)

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
					-- Set context data
	--			l_old_class := system.current_class
	--			l_old_group := inst_context.group
	--			system.set_current_class (l_class)
	--			inst_context.set_group (l_class.group)

				contract_grid.set_row_count_to (1)

				create l_token_text

					-- Create editor signature
				create l_generator.make
				l_generator.enable_multiline
				l_feature.append_signature (l_generator)
				l_tokens := l_generator.tokens

				l_row := contract_grid.row (1)
				create l_editor_item
				l_editor_item.enable_component_pebble
				l_editor_item.set_text_with_tokens (l_tokens)
					-- Evaluate height
				l_token_text.set_tokens (l_tokens)
				l_row.set_height (l_token_text.required_height)
					-- Set item
				l_row.set_item (1, l_editor_item)
					-- Clean up
				l_generator.wipe_out_lines

					-- Grid dimension adjustments
				l_height := l_height + l_row.height
				l_width := l_width.max (l_token_text.required_width)

					-- Comments
				create l_editor_item
				l_grid.set_row_count_to (l_grid.row_count + 1)
				l_row := l_grid.row (l_grid.row_count)
				l_row.set_item (1, l_editor_item)
				l_row.hide

				if is_showing_comments then
					l_tokens := feature_comment (l_feature, l_generator)
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

					l_tokens := l_generator.tokens
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

						l_tokens := l_generator.tokens
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

	--			system.set_current_class (l_old_class)
	--			inst_context.set_group (l_old_group)

				l_grid.set_minimum_size (l_width + 5, l_height + 5)
				l_grid.column (1).set_width (l_width + 5)
			end

			l_grid.unlock_update
		end

feature {NONE} -- Comment extraction

	feature_comment (a_feature: !E_FEATURE; a_token_writer: !EB_EDITOR_TOKEN_GENERATOR): ARRAYED_LIST [EDITOR_TOKEN] is
			-- Editor token representation of comment of `a_feature'.
			--
			-- `a_feature': The feature to show comments for.
			-- `a_token_writer': The token generator used to extract tokens from the feature comments.
			-- `Result': A list of tokens or Void if no comments were found.
		local
			l_comments: EIFFEL_COMMENTS
			l_comment: STRING_8
			l_string: STRING_8
			l_leaf: LEAF_AS_LIST
			l_token: EDITOR_TOKEN
			l_stop: BOOLEAN

			l_parent_comments: like feature_inherited_comments
			l_comments_emitted: BOOLEAN
		do
			create Result.make (128)

			if {l_mls: !MATCH_LIST_SERVER} a_feature.system.match_list_server then
				l_leaf := l_mls.item (a_feature.written_class.class_id)
				if l_leaf /= Void then
					l_comments := a_feature.ast.comment (l_leaf)
					if l_comments /= Void and then l_comments.count > 0 then
						a_token_writer.set_comment_context_class (a_feature.associated_class)
						from
							l_comments.start
						until
							l_comments.after
						loop
							a_token_writer.new_line
							a_token_writer.add_indent

							l_comment := l_comments.item.content
							if l_comment.count > 1 and then l_comment.item (1).is_space then
									-- Remove first leading space
								l_comment.remove (1)
							end

								-- Retrieve comment string
							l_string := l_comment.out
							if not l_string.is_empty then

									-- Determine if inherited comments should be used
								original_comment_reg_ex.match (l_string)
								if original_comment_reg_ex.has_matched then
										-- The comment is actually a inherited comment reference
									if original_comment_reg_ex.match_count = 3 then
											-- The comment contains a inherited type specifier, take the comment from a particular type.
										l_parent_comments := feature_inherited_comments (a_feature, a_token_writer, original_comment_reg_ex.captured_substring (2))
									else
										l_parent_comments := feature_inherited_comments (a_feature, a_token_writer, Void)
									end

									if l_parent_comments /= Void and then not l_parent_comments.is_empty then
										Result.append (l_parent_comments)

											-- Adds a new line to clear the last line
										a_token_writer.add_new_line

											-- Set state to let other parts of the routine know that comments have actually been emitted.
										l_comments_emitted := True
									end
								else
										-- Add original comment
									a_token_writer.add_comment_text ("-- ")
									a_token_writer.add_comment_text (l_string)

										-- Set state to let other parts of the routine know that comments have actually been emitted.
									l_comments_emitted := True
								end
							elseif l_comments_emitted then
								a_token_writer.add_comment_text ("-- ")
							end

								-- Emit the comment line into the mutable result list
							Result.append (a_token_writer.last_line.content)
							if not l_comments.islast then
								Result.extend (create{EDITOR_TOKEN_EOL}.make)
							end
							l_comments.forth
						end

							-- Trim whitespace from the end of token list
						from
							l_stop := False
							Result.finish
						until
							Result.before or l_stop
						loop
							l_token := Result.item
							if l_token.is_blank or l_token.is_new_line or l_token.is_tabulation then
								if Result.isfirst then
									Result.remove
								else
									Result.back
									Result.remove_right
								end
							else
								l_stop := True
							end
						end

							-- Update the comment token widths
						Result.do_all (agent {EDITOR_TOKEN}.update_width)
					end

					if not l_comments_emitted then
							-- No comments were found, try using the inherited comments
						check result_is_empty: Result.is_empty end

						l_parent_comments := feature_inherited_comments (a_feature, a_token_writer, Void)
						if l_parent_comments /= Void and then not l_parent_comments.is_empty then
							Result.append (l_parent_comments)
						end
					end
				end
			end

			if Result.is_empty then
				Result := Void
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

	feature_inherited_comments (a_feature: !E_FEATURE; a_token_writer: !EB_EDITOR_TOKEN_GENERATOR; a_parent_name: ?STRING_8): ARRAYED_LIST [EDITOR_TOKEN]
			-- Attempts to extract the inherited comments from a feature
			--
			-- `a_feature': The feature to extract the comments from.
			-- `a_writer': The text formatter to use to generate editor tokens for the comments.
			-- `a_parent_name': An optional parent class name to use when extracting inherited comments.
			-- `Result': A list of tokens or Void if not comments were located.
		local
			l_parents: LIST [CLASS_C]
			l_parent_class: CLASS_C
			l_rout_id_set: ROUT_ID_SET
			l_count, i: INTEGER
			l_parent_feature: E_FEATURE
		do
			l_parents := a_feature.precursors
			if l_parents /= Void and then not l_parents.is_empty then
					-- Iterate throught parents to locate a matching routine id
				l_rout_id_set := a_feature.rout_id_set
				from
					l_parents.start
				until
					l_parents.after or
					(Result /= Void and then not Result.is_empty)
				loop
					l_parent_class := l_parents.item
					if l_parent_class /= Void then
						if (a_parent_name = Void or else l_parent_class.name_in_upper.is_equal (a_parent_name)) then
							from
								l_parent_feature := Void
								l_count := l_rout_id_set.count
								i := 1
							until
								i > l_count or l_parent_feature /= Void
							loop
									-- Attempt to locate a parent feature and extract the comments for them.
								l_parent_feature := l_parent_class.feature_with_rout_id (l_rout_id_set.item (i))
								if {l_feature: !E_FEATURE} l_parent_feature then
									Result := feature_comment (l_feature, a_token_writer)
								end
								i := i + 1
							end
						end
					end
					l_parents.forth
				end
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

feature {NONE} -- Action handlers

	on_edit_contracts
			-- Called when the user selects to edit the contracts of the Current feature
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			context_feature_attached: context_feature /= Void
			context_class_attached: context_class /= Void
		local
--			l_manager: EB_WINDOW_MANAGER
--			l_window: EB_DEVELOPMENT_WINDOW
--			l_feature_stone: FEATURE_STONE
			l_info: ES_INFORMATION_PROMPT
		do
--			l_manager := (create {EB_SHARED_WINDOW_MANAGER}).window_manager
--			l_window := l_manager.last_focused_development_window
--			if l_window /= Void and l_window.is_interface_usable then
--				if {l_tool: !ES_CONTRACT_TOOL} l_window.shell_tools.tool ({ES_CONTRACT_TOOL}) and then l_tool.is_interface_usable then
--						-- Show and activate focus on the tool.
--					create l_feature_stone.make (context_feature)
--					l_tool.set_stone (l_feature_stone)
--					l_tool.show (True)
--				end
--			end

			create l_info.make_standard ("Oh, I'd bet you'd love to do this?%N%NAll in good time. Patience is a virtue.")
			l_info.show_on_active_window
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
