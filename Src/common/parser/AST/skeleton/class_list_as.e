indexing
	description: "Object that represents a list of class name as clients"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_LIST_AS

inherit
	EIFFEL_LIST [ID_AS]
		redefine
			process, first_token, last_token
		end

create
	make,
	make_filled

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_class_list_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				check
					lcurly_symbol /= Void
				end
				Result := lcurly_symbol.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				check
					rcurly_symbol /= Void
				end
				Result := rcurly_symbol.last_token (a_list)
			end
		end

feature -- Roundtrip

	lcurly_symbol, rcurly_symbol: SYMBOL_AS
			-- Symbol "{" and "}" associated with current AST node

	set_lcurly_symbol (a_symbol: SYMBOL_AS) is
			-- Set `lcurly_symbol' with `a_symbol'.
		do
			lcurly_symbol := a_symbol
		ensure
			lcurly_symbol_set: lcurly_symbol = a_symbol
		end

	set_rcurly_symbol (a_symbol: SYMBOL_AS) is
			-- Set `rcurly_symbol' with `a_symbol'.
		do
			rcurly_symbol := a_symbol
		ensure
			rcurly_symbol_set: rcurly_symbol = a_symbol
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
end
