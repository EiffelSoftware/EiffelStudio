note
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

	SHARED_EIFFEL_PARSER_WRAPPER
		export
			{NONE} all
		end

create
	make

feature -- Access

	ast: detachable CLASS_AS
			-- Root AST node of prepared class.

	ast_match_list: detachable LEAF_AS_LIST
			-- Match list produced by the last parse.

feature {NONE} -- Access

	parser: EIFFEL_PARSER
			-- Eiffel code parser used to prepare the data of Current.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_COMPILER_FACTORY})
		ensure
			result_attached: attached Result
		end

feature -- Status report

	is_ast_available: BOOLEAN
			-- Indicates if the AST information is available.
		require
			is_prepared: is_prepared
		do
			Result := attached ast and then attached ast_match_list
		ensure
			ast_attached: Result implies attached ast
			ast_match_list_attached: Result implies attached ast_match_list
		end

feature -- Basic operations

	prepare
			-- <Precursor>
		local
			l_parser: like parser
			l_class: like associated_class
			l_wrapper: like eiffel_parser_wrapper
			l_current_class: detachable CLASS_C
			l_current_group: detachable CONF_GROUP
			l_options: CONF_OPTION
		do
			reset
			l_class := associated_class
			if l_class.is_compiled then
				l_current_class := system.current_class
			end
			l_current_group := inst_context.group
			inst_context.set_group (l_class.group)

				-- Perform parse
			l_parser := parser
			l_options := l_class.config_class.options
			check l_options_attached: l_options /= Void end

			l_wrapper := eiffel_parser_wrapper
			l_wrapper.parse_with_option (l_parser, text, l_options, True, l_current_class)
			if not l_wrapper.has_error then
				ast ?= l_wrapper.ast_node
				check ast_attached: ast /= Void end
				ast_match_list := l_wrapper.ast_match_list
			end

			inst_context.set_group (l_current_group)
			is_prepared := True
		end

feature {ES_CLASS_TEXT_MODIFIER} -- Basic operations

	reset
			-- <Precursor>
		do
			Precursor {ES_CLASS_TEXT_MODIFIER_DATA}
			ast := Void
			ast_match_list := Void
		ensure then
			ast_reset: not attached ast
			ast_match_list_reset: not attached ast_match_list
		end

invariant
	ast_attached: is_ast_available implies attached ast
	ast_match_list_attached: is_ast_available implies attached ast_match_list

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
