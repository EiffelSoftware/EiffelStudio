note
	description: "[
		{XT_XEBRA_PARSER}.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_XEBRA_PARSER

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

	PEG_FACTORY

create
	make

feature -- Initialization

	make
			-- Initialize parsers
		do
				-- A common identifier. Will put the identifier {STRING} on the stack
			identifier_prefix := (lower_case | upper_case | hyphen | underscore)
			identifier_prefix.fixate
			identifier := identifier_prefix + (-(lower_case | upper_case | hyphen | underscore | digit))
			identifier := identifier.consumer
			identifier.fixate
			identifier.set_name ("identifier")

				-- XML comments
			comment := rstringp ("<!--") + (-(stringp("-->").negate + rany)) + rstringp ("-->")
			comment.set_behaviour (agent concatenate_results)
			comment.set_name ("comment")

			open := char ('<')
			close := char ('>')

			source_path := "No source path specified"
		end

feature {XT_XEBRA_PARSER} -- Access

	source_path: STRING
			-- The path to the original file

feature -- Access

	set_source_path (a_source_path: like source_path)
			-- Sets the source path.
		require
			a_source_path_attached: attached a_source_path
		do
			source_path := a_source_path
		ensure
			source_path_set: source_path = a_source_path
		end

feature {NONE} -- Convenience

	add_parse_error (a_message: STRING)
			-- Adds a parse error to the error maanager
		do
			error_manager.add_error (create {XERROR_PARSE}.make
				([a_message]), False)
		end

feature {XT_XEBRA_PARSER}

	identifier, comment, open, close, identifier_prefix: PEG_ABSTRACT_PEG
			-- A xml identifier

feature {XT_XEBRA_PARSER} -- Behaviours

	concatenate_results (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Concatenates all result's 'out'-output to a single {String}
		require
			a_result_attached: attached a_result
		local
			l_product: STRING
			l_internal_result: LIST [ANY]
			l_cursor: INTEGER
		do
			l_product := ""
			l_internal_result := a_result.parse_result
			from
				l_cursor := l_internal_result.index
				l_internal_result.start
			until
				l_internal_result.after
			loop
				l_product := l_product + l_internal_result.item.out
				l_internal_result.forth
			end
			l_internal_result.go_i_th (l_cursor)
			Result := a_result
			Result.parse_result.wipe_out
			Result.append_result (l_product)
		ensure
			Result_attached: attached Result
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
