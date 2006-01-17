indexing
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
	make (t: like type; c: like call; l_as, r_as: like lbang_symbol)is
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

	lbang_symbol, rbang_symbol: SYMBOL_AS
			-- Symbol "!" associated with this structure

	set_lbang_symbol (a_symbol: SYMBOL_AS) is
			--- Set `lbang_symbol' with `a_symbol'.
		do
			lbang_symbol := a_symbol
		ensure
			lbang_symbol_set: lbang_symbol = a_symbol
		end

	set_rbang_symbol (a_symbol: SYMBOL_AS) is
			--- Set `rbang_symbol' with `a_symbol'.
		do
			rbang_symbol := a_symbol
		ensure
			rbang_symbol_set: rbang_symbol = a_symbol
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bang_creation_expr_as (Current)
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := type.complete_start_location (a_list)
			else
				Result := lbang_symbol.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if call /= Void then
				Result := call.complete_end_location (a_list)
			else
				if a_list = Void then
					Result := type.complete_end_location (a_list)
				else
					Result := rbang_symbol.complete_end_location (a_list)
				end

			end
		end

indexing
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

end
