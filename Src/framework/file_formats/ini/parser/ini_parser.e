note
	description: "[
		A recoverable INI parser that creates an Abstract Syntax Tree (AST)
		reprentation of a parsed buffer.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_PARSER

create
	make,
	make_with_factory

feature {NONE} -- Initialization

	make (a_max_errors: like max_syntax_errors)
			-- Initialize a recoverable parser.
		require
			a_max_errors_positive: a_max_errors > 0
		do
			make_with_factory (a_max_errors, create {INI_DEFAULT_NODE_FACTORY})
		ensure
			max_syntax_errors_set: max_syntax_errors = a_max_errors
		end

	make_with_factory (a_max_errors: like max_syntax_errors; a_factory: like factory)
			-- Initialize a recoverable parser.
		require
			a_max_errors_positive: a_max_errors > 0
			a_factory_attached: a_factory /= Void
		do
			max_syntax_errors := a_max_errors
			factory := a_factory
			create internal_syntax_errors.make (0)
		ensure
			max_syntax_errors_set: max_syntax_errors = a_max_errors
			factory_set: factory = a_factory
		end

feature -- Access

	syntax_errors: LIST [INI_SYNTAX_ERROR]
			-- Syntax errors found in last parsed ini file
		local
			l_result: like internal_syntax_errors
		do
			Result := internal_syntax_errors
			if Result = Void then
				create l_result.make (0)
				internal_syntax_errors := l_result
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
		end

	successful: BOOLEAN
			-- Was last parse successful?
		do
			Result := syntax_errors.is_empty
		end

	max_syntax_errors: INTEGER
			-- Maximum number of recoverable syntax errors before parser
			-- gives up

	ignore_syntax_errors: BOOLEAN assign set_ignore_syntax_errors
			-- Should all syntax errors be ignored?

	parsed_root_node: INI_DOCUMENT_NODE
			-- Root INI file abstract syntax node

feature -- Basic Operations

	parse_source (a_buffer: STRING)
			-- Parses source buffer `a_buffer'.
		require
			a_buffer_attached: a_buffer /= Void
		local
			l_lines: LIST [STRING]
			l_line: STRING
			l_max_errors: like max_syntax_errors
			l_errors: like syntax_errors
			l_scanner: INI_SCANNER
			l_state: INI_SCANNER_STATE
			l_token: INI_SCANNER_TOKEN_INFO
			l_type: INI_SCANNER_TOKEN_TYPE
			l_line_tokens: ARRAYED_LIST [INI_SCANNER_TOKEN_INFO]
			l_index: INTEGER
			l_count: INTEGER
			l_stop: BOOLEAN
		do
			create parsed_root_node.make
			l_max_errors := max_syntax_errors
			l_errors := syntax_errors

			create l_scanner.make
			l_lines := a_buffer.split ('%N')
			from
				l_lines.start
			until
				l_lines.after
			loop
				l_line := l_lines.item
				l_line.prune_all_trailing ('%R')

				if not l_line.is_empty then
						-- Scan line
					create l_line_tokens.make (3)
					from
						l_count := l_line.count
						l_state := l_scanner.initial_state
						l_index := 1
					until
						l_index > l_count
					loop
						l_scanner.scan_for_next_token_info (l_line.substring (l_index, l_count), l_index, l_state)
						l_token := l_scanner.token
						l_state := l_scanner.next_state
						l_type := l_token.type
						if l_type /= {INI_SCANNER_TOKEN_TYPE}.comment and l_type /= {INI_SCANNER_TOKEN_TYPE}.whitespace then
							l_line_tokens.extend (l_token)
						end
						l_index := l_token.end_index + 1
					end
					if not l_line_tokens.is_empty then
							-- Process scanned tokens
						process_line_tokens (l_line_tokens, l_lines.index)

						-- Error handling
					l_stop := l_errors.count >= l_max_errors
					end
				end
				l_lines.forth
			end
		ensure
			parsed_root_node_attached: parsed_root_node /= Void
		end

	reset
			-- Resets parser
		local
			l_errors: like internal_syntax_errors
		do
			l_errors := internal_syntax_errors
			if l_errors /= Void then
				l_errors.wipe_out
			end
		ensure
			successful: successful
		end

feature -- Status Setting

	set_ignore_syntax_errors (a_ignore: like ignore_syntax_errors)
			-- Set `ignore_syntax_errors' to `a_ignore'.
		do
			ignore_syntax_errors := a_ignore
		ensure
			ignore_syntax_errors_set: ignore_syntax_errors = a_ignore
		end

feature {NONE} -- Token Processing

	process_line_tokens (a_tokens: LIST [INI_SCANNER_TOKEN_INFO]; a_line: INTEGER)
			-- Processes list of tokens `a_token' which are on line `a_line'.
		require
			a_tokens_attached: a_tokens /= Void
			not_a_token_is_empty: not a_tokens.is_empty
			a_line_positive: a_line > 0
		local
			l_line_type: like token_line_type
		do
			l_line_type := token_line_type (a_tokens)
			inspect l_line_type.to_integer
			when {INI_PARSER_TOKEN_LINE_TYPE}.section then
				process_section_tokens (a_tokens, a_line)
			when {INI_PARSER_TOKEN_LINE_TYPE}.property then
				process_property_tokens (a_tokens, a_line)
			when {INI_PARSER_TOKEN_LINE_TYPE}.comment then
				--| Ignore comments
			when {INI_PARSER_TOKEN_LINE_TYPE}.unknown then
					--| Unexpected
				extend_syntax_error (create {INI_UNEXPECTED_SYNTAX_ERROR}.make (a_tokens.first.text, a_line, 0))
			else
				check
					False
				end
			end
		end

	process_section_tokens (a_tokens: LIST [INI_SCANNER_TOKEN_INFO]; a_line: INTEGER)
			-- Processes list of tokens `a_token' which are on line `a_line'.
		require
			a_tokens_attached: a_tokens /= Void
			not_a_tokens_is_empty: not a_tokens.is_empty
			is_section_line: token_line_type (a_tokens) = {INI_PARSER_TOKEN_LINE_TYPE}.section
			a_line_positive: a_line > 0
			parsed_root_node_attached: parsed_root_node /= Void
		local
			l_open_bracket: INI_SCANNER_TOKEN_INFO
			l_label: INI_SCANNER_TOKEN_INFO
			l_close_bracket: INI_SCANNER_TOKEN_INFO
			l_section_as: INI_SECTION_NODE
			l_factory: like factory
		do
			a_tokens.start
			l_open_bracket := a_tokens.item
			a_tokens.forth
			if not a_tokens.off then
				l_label := a_tokens.item
				if l_label.type = {INI_SCANNER_TOKEN_TYPE}.section_label then
					a_tokens.forth
					if not a_tokens.off then
						l_close_bracket := a_tokens.item
						if l_close_bracket.type = {INI_SCANNER_TOKEN_TYPE}.section_close then
							l_factory := factory
							l_section_as := l_factory.new_section_node (
								l_factory.new_symbol_node (l_open_bracket.text, create {INI_TEXT_SPAN}.make (a_line, l_open_bracket.start_index, a_line, l_open_bracket.end_index)),
								l_factory.new_id_node (l_label.text, create {INI_TEXT_SPAN}.make (a_line, l_label.start_index, a_line, l_label.end_index)),
								l_factory.new_symbol_node (l_close_bracket.text, create {INI_TEXT_SPAN}.make (a_line, l_close_bracket.start_index, a_line, l_close_bracket.end_index))
							)
							parsed_root_node.extend_section (l_section_as)
							a_tokens.forth
							if not a_tokens.off then
								--| Unexpected trailing text
								extend_syntax_error (create {INI_UNEXPECTED_SYNTAX_ERROR}.make (a_tokens.item.text, a_line, a_tokens.item.start_index))
							end
						else
								--| Expecting ']'
							extend_syntax_error (create {INI_EXPECTED_SYNTAX_ERROR}.make ({INI_SCANNER_SYMBOLS}.section_end_indicator.out, a_line, l_close_bracket.start_index))
						end
					else
						extend_syntax_error (create {INI_EXPECTED_SYNTAX_ERROR}.make ({INI_SCANNER_SYMBOLS}.section_end_indicator.out, a_line, l_label.end_index + 1))
					end
				else
						--| Expecting label error
					extend_syntax_error (create {INI_EXPECTED_SYNTAX_ERROR}.make ("label", a_line, l_label.start_index))
				end
			else
					--| Expecting label error
				extend_syntax_error (create {INI_EXPECTED_SYNTAX_ERROR}.make ("label", a_line, l_open_bracket.end_index + 1))
			end
		end

	process_property_tokens (a_tokens: LIST [INI_SCANNER_TOKEN_INFO]; a_line: INTEGER)
			-- Processes list of tokens `a_token' which are on line `a_line'.
		require
			a_tokens_attached: a_tokens /= Void
			not_a_tokens_is_empty: not a_tokens.is_empty
			is_section_line: token_line_type (a_tokens) = {INI_PARSER_TOKEN_LINE_TYPE}.property
			a_line_positive: a_line > 0
			parsed_root_node_attached: parsed_root_node /= Void
		local
			l_identifier: INI_SCANNER_TOKEN_INFO
			l_assigner: INI_SCANNER_TOKEN_INFO
			l_value: INI_SCANNER_TOKEN_INFO
			l_factory: like factory
			l_id_as: INI_ID_NODE
			l_value_as: INI_VALUE_NODE
			l_literal_as: INI_LITERAL_NODE
			l_property_as: INI_PROPERTY_NODE
		do
			a_tokens.start

				-- Check optional identifier
			l_identifier := a_tokens.item
			if l_identifier.type = {INI_SCANNER_TOKEN_TYPE}.identifier then
				a_tokens.forth
			else
				l_identifier := Void
			end

				-- Check for assigner
			if not a_tokens.off then
				l_assigner := a_tokens.item
				if l_assigner.type = {INI_SCANNER_TOKEN_TYPE}.assigner then
					a_tokens.forth

						-- Check for assigner value
					if not a_tokens.off then
						l_value := a_tokens.item
					end
					if l_identifier /= Void or l_value /= Void then
						l_factory := factory
						if l_identifier /= Void then
							l_id_as := l_factory.new_id_node (l_identifier.text, create {INI_TEXT_SPAN}.make (a_line, l_identifier.start_index, a_line, l_identifier.end_index))
						end
						if l_value /= Void then
							l_value_as := l_factory.new_value_node (l_value.text, create {INI_TEXT_SPAN}.make (a_line, l_value.start_index, a_line, l_value.end_index))
						end
						l_property_as := l_factory.new_property_node (l_id_as,
							l_factory.new_symbol_node (l_assigner.text, create {INI_TEXT_SPAN}.make (a_line, l_assigner.start_index, a_line, l_assigner.end_index)),
							l_value_as
						)
						parsed_root_node.extend_property (l_property_as)
						if not a_tokens.off then
							a_tokens.forth
							if not a_tokens.off then
									--| Unexpected tailing text
								extend_syntax_error (create {INI_UNEXPECTED_SYNTAX_ERROR}.make (a_tokens.item.text, a_line, a_tokens.item.start_index))
							end
						end
					else
							--| Expected value
						extend_syntax_error (create {INI_EXPECTED_SYNTAX_ERROR}.make ("default property value", a_line, l_assigner.end_index + 1))
					end
				elseif l_identifier /= Void then
						--| Assigner expected
					extend_syntax_error (create {INI_EXPECTED_SYNTAX_ERROR}.make ({INI_SCANNER_SYMBOLS}.assigner_indicator.out, a_line, l_assigner.start_index))
				end
			else
				if l_identifier /= Void then
					l_literal_as := factory.new_literal_node (l_identifier.text, create {INI_TEXT_SPAN}.make (a_line, l_identifier.start_index, a_line, l_identifier.end_index))
					parsed_root_node.extend_literal (l_literal_as)
				else
						--| Assigner expected
					check
						l_identifier_attached: l_identifier /= Void
					end
					extend_syntax_error (create {INI_EXPECTED_SYNTAX_ERROR}.make ({INI_SCANNER_TOKEN_TYPE}.assigner.out, a_line, l_identifier.end_index + 1))
				end
			end
		end

	token_line_type (a_tokens: LIST [INI_SCANNER_TOKEN_INFO]): INI_PARSER_TOKEN_LINE_TYPE
			-- Retrieve type of toke line for list of tokens `a_token'.
		require
			a_tokens_attached: a_tokens /= Void
			not_a_tokens_is_empty: not a_tokens.is_empty
		do
			inspect a_tokens.first.type.to_integer
			when {INI_SCANNER_TOKEN_TYPE}.section_open then
				Result := {INI_PARSER_TOKEN_LINE_TYPE}.section
			when {INI_SCANNER_TOKEN_TYPE}.comment then
				Result := {INI_PARSER_TOKEN_LINE_TYPE}.comment
			when {INI_SCANNER_TOKEN_TYPE}.identifier, {INI_SCANNER_TOKEN_TYPE}.assigner then
				Result := {INI_PARSER_TOKEN_LINE_TYPE}.property
			else
				Result := {INI_PARSER_TOKEN_LINE_TYPE}.unknown
			end
		end

feature {NONE} -- Error Handling

	extend_syntax_error (a_error: INI_SYNTAX_ERROR)
			-- Add a syntax error.
		require
			a_error_attached: a_error /= Void
			already_added: not internal_syntax_errors.has (a_error)
		local
			l_errors: like internal_syntax_errors
		do
			l_errors := internal_syntax_errors
			if l_errors.count < max_syntax_errors then
				l_errors.extend (a_error)
			end
		ensure
			error_added: old internal_syntax_errors.count < max_syntax_errors implies internal_syntax_errors.has (a_error)
		end

feature {NONE} -- Implementation

	token_span (a_token: INI_SCANNER_TOKEN_INFO; a_line: INTEGER): INI_TEXT_SPAN
			--
		require
			a_token_attached: a_token /= Void
			a_line_positive: a_line > 0
		do
			create Result.make (a_line, a_token.start_index, a_line, a_token.end_index)
		ensure
			result_attached: Result /= Void
		end

	factory: INI_NODE_FACTORY
			-- Factory used to create AS nodes

feature {NONE} -- Internal Implementation Cache

	internal_syntax_errors: ARRAYED_LIST [INI_SYNTAX_ERROR]
			-- Cached version of `syntax_errors'
			-- Note: Do not use directly!

invariant
	max_syntax_errors_positive: not ignore_syntax_errors implies max_syntax_errors > 0
	internal_syntax_errors_attached: internal_syntax_errors /= Void
	factory_attached: factory /= Void

note
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

end -- class {INI_PARSER}
