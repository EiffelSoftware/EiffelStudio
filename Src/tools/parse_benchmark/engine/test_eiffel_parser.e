note
	description: "Wrapper for {EIFFEL_PARSER} so parsers can be indentified and may be performed easily."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EIFFEL_PARSER

create
	make

feature {NONE} -- Initialization

	make (a_id: like identity; a_factory: AST_FACTORY)
			-- Initializes a test parser with a id `a_id' and a factory `a_factory'.
			-- `a_frozen_factory' is used in conjunction with frozen parser tests.
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		do
			identity := a_id
			create eiffel_parser.make_with_factory (a_factory)
		ensure
			identity_set: identity = a_id
		end

feature -- Access

	identity: STRING
			-- Name or id that identifier parser

feature -- Parsing

	parse (a_source: STRING)
			-- Parses source `a_source'.
		require
			a_fn_attached: a_source /= Void
		local
			l_parser: like eiffel_parser
			retried: BOOLEAN
		do
			if not retried then
				l_parser := eiffel_parser
				l_parser.reset
				l_parser.parse_from_string (a_source)
				successful := l_parser.error_count = 0
			else
				successful := False
			end
		rescue
			retried := True
			retry
		end

	parse_file (a_fn: STRING)
			-- Parses file `a_fn'.
		require
			a_fn_attached: a_fn /= Void
			not_a_fn_is_empty: not a_fn.is_empty
			a_fn_exists: (create {RAW_FILE}.make (a_fn)).exists
		local
			l_buffer_if: KL_BINARY_INPUT_FILE
			l_parser: like eiffel_parser
			retried: BOOLEAN
		do
			if not retried then
				l_parser := eiffel_parser
				l_parser.reset
				create l_buffer_if.make (a_fn)
				l_parser.parse (l_buffer_if)
				successful := l_parser.error_count = 0
			else
				successful := False
			end
		rescue
			retried := True
			retry
		end

feature -- Status report

	successful: BOOLEAN
			-- Indicates if last parse was successful

feature {NONE} -- Implementation

	eiffel_parser: EIFFEL_PARSER
			-- Parser used to perform Eiffel parse

invariant
	identity_attached: identity /= Void
	not_identity_is_empty: not identity.is_empty

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

end -- class {TEST_EIFFEL_PARSER}
