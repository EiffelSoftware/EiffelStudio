note
	description: "Abstract description of an Eiffel creation expression call (using bang form) "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BANG_CREATION_EXPR_AS

inherit
	CREATION_EXPR_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization
	make (t: like type; c: like call; l_as, r_as: like lbang_symbol)
			-- new CREATE_CREATION_EXPR AST node.
		do
			initialize (t, c)
			lbang_symbol := l_as
			rbang_symbol := r_as
		ensure
			lbang_symbol_set: lbang_symbol = l_as
			rbang_symbol_set: rbang_symbol = r_as
		end

feature -- Roundtrip

	lbang_symbol, rbang_symbol: detachable SYMBOL_AS
			-- Symbol "!" associated with this structure

	index: INTEGER
			-- <Precursor>
		do
			if attached lbang_symbol as s then
				Result := s.index
			elseif attached call as c then
				Result := c.index
			else
				Result := type.index
			end
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_bang_creation_expr_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				Result := type.first_token (a_list)
			elseif attached lbang_symbol as l_symbol then
				Result := l_symbol
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if call /= Void then
				Result := call.last_token (a_list)
			else
				if a_list = Void then
					Result := type.last_token (a_list)
				elseif attached rbang_symbol as l_symbol then
					Result := l_symbol
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
