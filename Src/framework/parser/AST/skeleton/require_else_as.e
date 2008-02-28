indexing
	description: "AST represenation of a require else construct."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REQUIRE_ELSE_AS

inherit
	REQUIRE_AS
		rename
			make as require_make
		redefine
			process,
			is_else, last_token
		end

create
	make

feature -- Initialization

	make (a: like assertions; k_as, l_as: KEYWORD_AS) is
			-- Create new REQUIRE AST node.
		do
			require_make (a, k_as)
			if l_as /= Void then
				else_keyword_index := l_as.index
			end
		ensure
			else_keyword_set: l_as /= Void implies else_keyword_index = l_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_require_else_as (Current)
		end

feature -- Roundtrip

	else_keyword_index: INTEGER
			-- Index of keyword "else" associated with this structure

	else_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "else" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := else_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Properties

	is_else: BOOLEAN is True
			-- Is the assertion list a require else?

feature -- Roundtrip/Token

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if assertions /= Void then
					Result := assertions.last_token (a_list)
				else
					Result := Void
				end
			else
				if full_assertion_list /= Void then
					Result := full_assertion_list.last_token (a_list)
				elseif else_keyword_index /= 0 then
					Result := else_keyword (a_list)
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class REQUIRE_ELSE_AS
