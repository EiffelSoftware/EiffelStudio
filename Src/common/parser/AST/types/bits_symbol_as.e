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
			bit_keyword := b_as
		ensure
			bits_symbol_set: bits_symbol = s
			bit_keyword_set: bit_keyword = b_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bits_symbol_as (Current)
		end

feature -- Roundtrip

	bit_keyword: KEYWORD_AS
		-- Keyword "bit" associated with this structure


feature -- Attributes

	bits_symbol: ID_AS
			-- Bits value

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				if a_list = Void then
					Result := bits_symbol.first_token (a_list)
				else
					Result := bit_keyword.first_token (a_list)
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := bits_symbol.last_token (a_list)
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
			create Result.make (5 + bits_symbol.count)
			Result.append ("BIT ")
			Result.append (bits_symbol)
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
