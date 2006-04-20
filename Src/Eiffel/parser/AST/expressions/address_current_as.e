indexing
	description: "AST representation of an Eiffel function pointer for Current."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ADDRESS_CURRENT_AS

inherit
	EXPR_AS

	LOCATION_AS

create
	initialize

feature{NONE} -- Initialization

	initialize (c_as: like current_keyword; a_as: like address_symbol) is
			-- Create new ADDRESS_CURRENT AST node.
		require
			c_as_not_void: c_as /= Void
		do
			current_keyword := c_as
			address_symbol := a_as
			make_from_other (current_keyword)
		ensure
			current_keyword_set: current_keyword = c_as
			address_symbol_set: address_symbol = a_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_address_current_as (Current)
		end

feature -- Roundtrip

	address_symbol: SYMBOL_AS
			-- Symbol "$" associated with this structure

	current_keyword: KEYWORD_AS
			-- Keyword "current" associated with this structure

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := current_keyword.first_token (a_list)
			else
				Result := address_symbol.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := current_keyword.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
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

end -- class ADDRESS_CURRENT_AS
