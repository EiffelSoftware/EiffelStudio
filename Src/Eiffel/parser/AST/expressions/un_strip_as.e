indexing
	description: "AST represenation of a unary `strip' operation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UN_STRIP_AS

inherit
	EXPR_AS

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (i: like id_list; o: KEYWORD_AS; lp_as, rp_as: SYMBOL_AS) is
			-- Create a new UN_STRIP AST node.
		require
			i_not_void: i /= Void
		do
			id_list := i
			strip_keyword := o
			set_paran_symbols (lp_as, rp_as)
		ensure
			id_list_set: id_list = i
			strip_keyword_set: strip_keyword = o
		end

feature -- Roundtrip

	strip_keyword: AST_EIFFEL
			-- Keyword "strip"

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_strip_as (Current)
		end

feature -- Attributes

	id_list: CONSTRUCT_LIST [INTEGER]
			-- Attribute list

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Void
			else
				Result := strip_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Void
			else
				Result := rparan_symbol.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (id_list, other.id_list)
		end

feature -- Roundtrip

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Symbol "(" and ")" associated with current AST node

	set_rparan_symbol (a_symbol: SYMBOL_AS) is
			-- Set `rparan_symbol' with `a_symbol'.
		do
			rparan_symbol := a_symbol
		ensure
			rparan_symbol_set: rparan_symbol = a_symbol
		end

	set_lparan_symbol (a_symbol: SYMBOL_AS) is
			-- Set `lparan_symbol' with `a_symbol'.
		do
			lparan_symbol := a_symbol
		ensure
			lparan_symbol_set: lparan_symbol = a_symbol
		end

	set_paran_symbols (l, r: SYMBOL_AS) is
			-- Set `lparan_symbol' with `l' and `rparan_symbol' with 'r'.
		do
			set_lparan_symbol (l)
			set_rparan_symbol (r)
		end

invariant
	id_list_not_void: id_list /= Void

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

end -- class UN_STRIP_AS
