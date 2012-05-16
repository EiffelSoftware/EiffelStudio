note
	description: "Objects that assembles copyright information to an EIFFEL class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COPYRIGHT_ASSEMBLER

inherit
	CONSTANTS

	INTERNAL_COMPILER_STRING_EXPORTER

	SHARED_ERROR_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_file: STRING; a_copyright: STRING)
			-- Init.
		require
			a_file_attached: a_file /= Void
			a_copyright_attached: a_copyright /= Void
		do
			copyright := a_copyright
			file_path := a_file
			create file.make (a_file)
			create file_assembled_actions

		ensure
			file_assembled_actions_not_void: file_assembled_actions /= Void
			copyright_not_void: copyright = a_copyright
			a_file_not_void: file /= Void
			file_path_not_void: file_path /= Void
		end

feature -- Access

	copyright: STRING

	file: RAW_FILE

	file_path: STRING
			-- Path and name of the file

	text: STRING
			-- Text after processing.

feature -- Status report

	end_class_comments_removed: BOOLEAN

	bottom_index_replaced: BOOLEAN

	bottom_index_inserted: BOOLEAN

	top_index_modified: BOOLEAN

	top_index_inserted: BOOLEAN

	init_error: BOOLEAN
			-- The file is not a eiffel class or has syntax error.

	parse_failed: BOOLEAN
			-- After assembling, check if the class is parsable.

	text_mode: BOOLEAN
			-- Has "%R"?
			-- Gives correct answer after `assemble'.

feature -- Call back

	file_assembled_actions: EV_NOTIFY_ACTION_SEQUENCE

feature -- Basic operations

	assemble
			-- Do assembling.
		local
			file_string: STRING
			ast_visitor: COPYRIGHT_AST_VISITOR
		do
			if check_file then
				file.open_read
				file.read_stream (file.count)
				file_string := file.last_string
				file.close
				text_mode := file_string.has ('%R')
				eiffel_parser.reset
				parse_eiffel_class (eiffel_parser, file_string)
				if eiffel_parser.error_count > 0 then
					init_error := True
				else
					create ast_visitor.make (top_index_insert_strings, copyright)
					ast_visitor.set_parsed_class (eiffel_parser.root_node)
					ast_visitor.set_match_list (eiffel_parser.match_list)
					ast_visitor.process_class_as (eiffel_parser.root_node)

					top_index_inserted := ast_visitor.top_index_inserted
					top_index_modified := ast_visitor.top_index_modified
					bottom_index_inserted := ast_visitor.bottom_index_inserted
					bottom_index_replaced := ast_visitor.bottom_index_replaced
					end_class_comments_removed := ast_visitor.end_class_comments_removed
					text := eiffel_parser.root_node.text (ast_visitor.match_list)
					text.prune_all ('%R')
					if text_mode then
						text.replace_substring_all ("%N", "%R%N")
					end
					eiffel_parser.reset
					parse_eiffel_class (eiffel_parser, text)
					if eiffel_parser.error_count > 0 then
						parse_failed := True
					end
				end
			file_assembled_actions.call ([Void])
			end
		end

feature {NONE} -- Implementation

	parse_eiffel_class (a_parser: EIFFEL_PARSER; a_buffer: STRING)
			-- Using a parser, parse our code using different parser mode, to ensure that we can
			-- indeed convert any kind of Eiffel classes.
		require
			a_parser_not_void: a_parser /= Void
			a_buffer_not_void: a_buffer /= Void
		do
			error_handler.wipe_out
			a_parser.set_syntax_version ({EIFFEL_PARSER}.Provisional_syntax)
			a_parser.parse_class_from_string (a_buffer, Void, Void)
			if error_handler.has_error then
				error_handler.wipe_out
					-- There was an error, let's try to see if the code is using a different syntax.
				a_parser.set_syntax_version ({EIFFEL_PARSER}.obsolete_syntax)
				a_parser.parse_class_from_string (a_buffer, Void, Void)
				if error_handler.has_error then
					error_handler.wipe_out
						-- There was an error, let's try to see if the code is using a different syntax.
					a_parser.set_syntax_version ({EIFFEL_PARSER}.Transitional_syntax)
					a_parser.parse_class_from_string (a_buffer, Void, Void)
					if error_handler.has_error then
						error_handler.wipe_out
						-- There was an error, let's try to see if the code is using a different syntax.
						a_parser.set_syntax_version ({EIFFEL_PARSER}.Ecma_syntax)
						a_parser.parse_class_from_string (a_buffer, Void, Void)
					end
				end
			end
		end

	check_file: BOOLEAN
			-- Check if the file is valid.
		local
			l_str: STRING
		do
			l_str := file.name.twin
			l_str.keep_tail (2)
			l_str.to_lower
			if l_str.is_equal (".e") and then file.exists then
				Result := True
			end
		end

	eiffel_parser: EIFFEL_PARSER
			--
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
			Result.set_il_parser
		end

invariant
		copyright_not_void: copyright /= Void
		a_file_not_void: file /= Void
note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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

