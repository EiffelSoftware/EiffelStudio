note
	description: "Abstract description of a check instruction with body."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class GUARD_AS

inherit
	INSTRUCTION_AS

inherit {NONE}
	ASSERTION_FILTER

create
	initialize

feature {NONE} -- Initialization

	initialize (
			c: like check_keyword;
			a: like check_list;
			t: like then_keyword;
			l: like compound;
			e: like end_keyword
		)
			-- Create a new CHECK with body AST node.
		do
			if c /= Void then
				check_keyword_index := c.index
			end
			full_assertion_list := a
			check_list := filter_tagged_list (a)
			if t /= Void then
				then_keyword_index := t.index
			end
			compound := l
			end_keyword := e
		ensure
			check_keyword_set: c /= Void implies check_keyword_index = c.index
			full_assertion_list_set: full_assertion_list = a
			then_keyword_set: t /= Void implies then_keyword_index = t.index
			compound_set: compound = l
			end_keyword_set: end_keyword = e
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_guard_as (Current)
		end

feature -- Roundtrip

	check_keyword_index, then_keyword_index: INTEGER
			-- Index of keyword "check" and "then" assoicated with this structure

	check_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "check" assoicated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := check_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	then_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "then" assoicated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := then_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Attributes

	check_list: EIFFEL_LIST [TAGGED_AS]
			-- List of tagged boolean expression
			-- (only complete assertions are included)
			-- e.g. "tag:expr", "expr"

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

	end_keyword: KEYWORD_AS
			-- Line number where `end' keyword is located

feature -- Roundtrip

	full_assertion_list: like check_list
			-- Assertion list that contains both complete and incomplete assertions.
			-- e.g. "tag:expr", "tag:", "expr"

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if a_list /= Void then
				Result := check_keyword (a_list)
			end
			if Result = Void and then attached full_assertion_list as l then
				Result := l.first_token (a_list)
			end
			if Result = Void and then a_list /= Void then
				Result := then_keyword (a_list)
			end
			if Result = Void and then attached compound as c then
				Result := c.first_token (Void)
			end
			if Result = Void and then attached end_keyword as e then
				Result := e.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if attached end_keyword as e then
				Result := e.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (check_list, other.check_list) and then
				equivalent (compound, other.compound)
		end

note
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
