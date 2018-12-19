note
	description	: "AST representation of a require statement."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REQUIRE_AS

inherit
	ASSERT_LIST_AS

create
	make

feature -- Initialization

	make (a: like assertions; k_as: like require_keyword)
			-- Create new REQUIRE AST node.
		do
			initialize (a)
			if k_as /= Void then
				require_keyword_index := k_as.index
			end
		ensure
			require_keyword_set: k_as /= Void implies require_keyword_index = k_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_require_as (Current)
		end

feature -- Roundtrip

	require_keyword_index: INTEGER
			-- Index of keyword "require" associated with this structure.

	require_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "require" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, require_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := require_keyword_index
		end

feature -- Properties

	is_else: BOOLEAN
			-- Is the assertion list a require else?
		do
			-- Do nothing
		end

feature -- Roundtrip/Location

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				if attached assertions as l_assertions then
					Result := l_assertions.first_token (a_list)
				else
					Result := Void
				end
			elseif require_keyword_index /= 0 then
				Result := require_keyword (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				if attached assertions as l_assertions then
					Result := l_assertions.last_token (a_list)
				else
					Result := Void
				end
			else
				if attached full_assertion_list as l_full_assertion_list then
					Result := l_full_assertion_list.last_token (a_list)
				elseif require_keyword_index /= 0 then
					Result := require_keyword (a_list)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
