indexing
	description: "[
		Data used in conjuntion with an Eiffel AST-augmented code class text modifier {ES_CLASS_TEXT_AST_MODIFIER}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CLASS_TEXT_AST_MODIFIER_DATA

inherit
	ES_CLASS_TEXT_MODIFIER_DATA
		redefine
			reset,
			prepare
		end

create
	make

feature -- Access

	ast: ?CLASS_AS
			-- Root AST node of prepared class.

	ast_match_list: ?LEAF_AS_LIST
			-- Match list produced by the last parse.

feature {NONE} -- Access

	parser: !EIFFEL_PARSER
			-- Eiffel code parser used to prepare the data of Current.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_COMPILER_FACTORY})
		end

feature -- Status report

	is_ast_available: BOOLEAN
			-- Indicates if the AST information is available.
		require
			is_prepared: is_prepared
		do
			Result := ast /= Void and then ast_match_list /= Void
		ensure
			ast_attached: Result implies ast /= Void
			ast_match_list_attached: Result implies ast_match_list /= Void
		end

feature -- Basic operations

	prepare
			-- <Precursor>
		local
			l_parser: !like parser
			l_class: !like associated_class
			l_current_class: ?CLASS_C
			l_current_group: ?CONF_GROUP
			l_options: CONF_OPTION
			l_errors: LINKED_LIST [ERROR]
			l_error_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				l_class := associated_class
				if l_class.is_compiled then
					l_current_class := system.current_class
					system.set_current_class (l_class.compiled_class)
				end
				l_current_group := inst_context.group
				inst_context.set_group (l_class.group)

					-- Log last error index
				l_errors := error_handler.error_list
				if l_errors /= Void then
					l_error_index := l_errors.count
				end

					-- Perform parse
				l_parser := parser
				l_options := l_class.config_class.options
				l_parser.set_is_indexing_keyword (l_options.syntax_level.item /= {CONF_OPTION}.syntax_level_standard)
				l_parser.set_is_note_keyword (l_options.syntax_level.item /= {CONF_OPTION}.syntax_level_obsolete)
				l_parser.parse_from_string (text)
				if l_parser.root_node /= Void and then l_parser.match_list /= Void then
					ast := l_parser.root_node
					ast_match_list := l_parser.match_list
				end

				inst_context.set_group (l_current_group)
				if l_current_class /= Void then
					system.set_current_class (l_current_class)
				end
			end

			if l_error_index > 0 then
					-- Remove additional errors errors
				l_errors.go_i_th (l_error_index)
				from until l_errors.count = l_error_index loop
					l_errors.remove_right
				end
			else
				l_errors.wipe_out
			end

			if retried then
				reset
			end

			is_prepared := True
		rescue
			retried := True
			retry
		end

feature {ES_CLASS_TEXT_MODIFIER} -- Basic operations

	reset
			-- <Precursor>
		do
			Precursor {ES_CLASS_TEXT_MODIFIER_DATA}
			ast := Void
			ast_match_list := Void
		ensure then
			ast_detached: ast = Void
			ast_match_list_detached: ast_match_list = Void
		end

invariant
	ast_attached: is_ast_available implies ast /= Void
	ast_match_list_attached: is_ast_available implies ast_match_list /= Void

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
