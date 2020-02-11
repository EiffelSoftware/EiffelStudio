note
	description: "Abstract description of a multi_branch construct."

deferred class INSPECT_ABSTRACTION_AS [C -> CASE_ABSTRACTION_AS [P], P -> detachable AST_EIFFEL]

inherit
	AST_EIFFEL

feature {NONE} -- Creation

	make (s: like switch; c: like case_list; e: like else_part; k: like end_keyword; i, o: detachable KEYWORD_AS)
			-- Create a new INSPECT AST node with inspect expression `s`,
			-- list of cases `c`, optional else part `e`, "end" keyword `k`,
			-- optional keywords "inspect" `i` and "else" `o` respectively.
		require
			s_not_void: s /= Void
			k_not_void: k /= Void
		do
			switch := s
			case_list := c
			else_part := e
			end_keyword := k
			if attached i then
				inspect_keyword_index := i.index
			end
			if attached o then
				else_keyword_index := o.index
			end
		ensure
			switch_set: switch = s
			case_list_set: case_list = c
			else_part_set: else_part = e
			end_keyword_set: end_keyword = k
			inspect_keyword_set: attached i implies inspect_keyword_index = i.index
			else_keyword_set: attached o implies else_keyword_index = o.index
		end

feature -- Roundtrip

	inspect_keyword_index, else_keyword_index: INTEGER
			-- Index of keyword "inspect" and "else" associated with this structure.

	inspect_keyword (l: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "inspect" associated with this structure.
		require
			l_attached: attached l
		do
			Result := keyword_from_index (l, inspect_keyword_index)
		end

	else_keyword (l: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "else" associated with this structure.
		require
			l_attached: attached l
		do
			Result := keyword_from_index (l, else_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := inspect_keyword_index
		end

feature -- Access

	switch: EXPR_AS
			-- Expression to inspect.

	case_list: detachable EIFFEL_LIST [C]
			-- Alternatives.

	else_part: detachable P
			-- Else part expression (if any).

	end_keyword: KEYWORD_AS
			-- Line number where `end` keyword is located.

feature -- Roundtrip/Token

	first_token (l: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			if attached l and inspect_keyword_index /= 0 then
				Result := inspect_keyword (l)
			else
				Result := switch.first_token (l)
			end
		end

	last_token (l: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			Result := end_keyword.last_token (l)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result :=
				equivalent (case_list, other.case_list) and then
				equivalent (else_part, other.else_part) and then
				equivalent (switch, other.switch)
		end

invariant
	switch_attached: attached switch
	end_keyword_attached: attached end_keyword

note
	ca_ignore: "CA011", "CA011: too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
