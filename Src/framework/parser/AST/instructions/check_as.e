note

	description: "Abstract description of a check clause. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CHECK_AS

inherit
	INSTRUCTION_AS

	ASSERTION_FILTER

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like check_list; c_as: detachable like check_keyword; e: like end_keyword)
			-- Create a new CHECK AST node.
		require
			e_not_void: e /= Void
		do
			full_assertion_list := c
			check_list := filter_tagged_list (full_assertion_list)
			end_keyword := e
			if c_as /= Void then
				check_keyword_index := c_as.index
			end
		ensure
			full_assertion_list_set: full_assertion_list = c
			end_keyword_set: end_keyword = e
			check_keyword_set: c_as /= Void implies check_keyword_index = c_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_check_as (Current)
		end

feature -- Roundtrip

	check_keyword_index: INTEGER
			-- Index of keyword "check" associated with this structure

	check_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "check" associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, check_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := check_keyword_index
		end

feature -- Attributes

	check_list: detachable EIFFEL_LIST [TAGGED_AS]
			-- List of tagged boolean expression
			-- (only complete assertions are included)
			-- e.g. "tag:expr", "expr"

	end_keyword: KEYWORD_AS
			-- Line number where `end' keyword is located

feature -- Roundtrip

	full_assertion_list: like check_list
			-- Assertion list that contains both complete and incomplete assertions.
			-- e.g. "tag:expr", "tag:", "expr"

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				if attached check_list as l_check_list then
					Result := l_check_list.first_token (a_list)
				else
					Result := end_keyword.first_token (a_list)
				end
			elseif check_keyword_index /= 0 then
				Result := check_keyword (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := end_keyword.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (check_list, other.check_list)
		end

invariant
	end_keyword_not_void: end_keyword /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

end -- class CHECK_AS
