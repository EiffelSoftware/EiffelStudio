note
	description: "AST node for an inline separate instruction."

class
	SEPARATE_INSTRUCTION_AS

inherit
	INSTRUCTION_AS

create
	make

feature {NONE} -- Creation

	make (s: detachable KEYWORD_AS; a: like arguments; d: detachable KEYWORD_AS; c: like compound; e: KEYWORD_AS)
			-- Initialize with "separate" keyword `s', arguments `a', "do" keyword `d', compound `c' and "end" keyword `e'.
		do
			if attached s then
				separate_keyword_index := s.index
			end
			arguments := a
			if attached d then
				do_keyword_index := d.index
			end
			compound := c
			end_keyword := e
		end

feature {AST_VISITOR} -- Visitor

	process (v: AST_VISITOR)
			-- <Precursor>
		do
			v.process_separate_instruction_as (Current)
		end

feature -- Access

	arguments: EIFFEL_LIST [NAMED_EXPRESSION_AS]
			-- Arguments.

	compound: detachable EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound.

	end_keyword: KEYWORD_AS
			-- Line number where "end" keyword is located.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result :=
				equivalent (arguments, other.arguments) and then
				equivalent (compound, other.compound)
		end

feature -- Roundtrip

	index: INTEGER
			-- <Precursor>
		do
			Result := separate_keyword_index
		end

	separate_keyword_index: INTEGER
			-- Index of keyword "separate" associated with this structure.

	separate_keyword (tokens: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "separate" associated with this structure.
		do
			Result := keyword_from_index (tokens, separate_keyword_index)
		end

	do_keyword_index: INTEGER
			-- Index of keyword "do" associated with this structure.

	do_keyword (tokens: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "do" associated with this structure.
		do
			Result := keyword_from_index (tokens, do_keyword_index)
		end

	first_token (tokens: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			if attached tokens then
				Result := separate_keyword (tokens)
			end
			if not attached Result then
				Result := arguments.first_token (tokens)
			end
			if not attached Result and then attached tokens then
				Result := do_keyword (tokens)
			end
			if not attached Result and then attached compound as c then
				Result := c.first_token (tokens)
			end
			if not attached Result then
				Result := end_keyword
			end
		end

	last_token (tokens: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			Result := end_keyword
		end

note
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
