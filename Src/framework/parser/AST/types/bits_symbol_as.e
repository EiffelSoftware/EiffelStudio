indexing
	description: "AST representation of bit symbols."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BITS_SYMBOL_AS

inherit
	TYPE_AS
		redefine
			first_token, last_token
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (s: like bits_symbol; b_as: KEYWORD_AS) is
			-- Create a new BITS_SYMBOL AST node.
		require
			s_not_void: s /= Void
		do
			bits_symbol := s
			if b_as /= Void then
				bit_keyword_index := b_as.index
			end
		ensure
			bits_symbol_set: bits_symbol = s
			bit_keyword_set: b_as /= Void implies bit_keyword_index = b_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bits_symbol_as (Current)
		end

feature -- Roundtrip

	bit_keyword_index: INTEGER
		-- Integer of keyword "bit" associated with this structure		

	bit_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
		-- Keyword "bit" associated with this structure		
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := bit_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Attributes

	bits_symbol: ID_AS
			-- Bits value

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				if a_list /= Void and bit_keyword_index /= 0 then
					Result := bit_keyword (a_list)
				else
					Result := bits_symbol
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := bits_symbol
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (bits_symbol, other.bits_symbol)
		end

feature -- Output

	dump: STRING is
			-- Debug purpose
		do
			create Result.make (5 + bits_symbol.name.count)
			Result.append ("BIT ")
			Result.append (bits_symbol.name)
   		end

invariant
	bits_symbol_not_void: bits_symbol /= Void

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

end -- class BITS_SYMBOL_AS
