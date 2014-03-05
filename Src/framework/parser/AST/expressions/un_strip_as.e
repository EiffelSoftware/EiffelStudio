note
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

	initialize (i: like id_list; o: like strip_keyword; lp_as, rp_as: like lparan_symbol)
			-- Create a new UN_STRIP AST node.
		require
			i_not_void: i /= Void
		do
			id_list := i
			if o /= Void then
				strip_keyword_index := o.index
			end
			if lp_as /= Void then
				lparan_symbol_index := lp_as.index
			end
			if rp_as /= Void then
				rparan_symbol_index := rp_as.index
			end
		ensure
			id_list_set: id_list = i
			strip_keyword_set: o /= Void implies strip_keyword_index = o.index
			lparan_symbol_set: lp_as /= Void implies lparan_symbol_index = lp_as.index
			rparan_symbol_set: rp_as /= Void implies rparan_symbol_index = rp_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_un_strip_as (Current)
		end

feature -- Attributes

	id_list: IDENTIFIER_LIST
			-- Attribute list

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and strip_keyword_index /= 0 then
				Result := strip_keyword (a_list)
			elseif a_list /= Void and lparan_symbol_index /= 0 then
				Result := lparan_symbol (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and rparan_symbol_index /= 0 then
				Result := rparan_symbol (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equal (id_list, other.id_list)
		end

feature -- Roundtrip

	strip_keyword_index: INTEGER
			-- Index of keyword "strip"

	lparan_symbol_index, rparan_symbol_index: INTEGER
			-- Index of symbol "(" and ")" associated with this structure

	strip_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "strip"
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, strip_keyword_index)
		end

	lparan_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "(" associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, lparan_symbol_index)
		end

	rparan_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol ")" associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, rparan_symbol_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := strip_keyword_index
		end

invariant
	id_list_not_void: id_list /= Void

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

end -- class UN_STRIP_AS
