indexing
	description: "Object that represents a list which is surrounded by some kind of brackets (e.g. '(' and ')')."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PARAN_LIST_AS [G -> EIFFEL_LIST [AST_EIFFEL]]

inherit
	AST_EIFFEL

	EIFFEL_LIST_WRAPPER_AS [G]

feature{NONE} -- Implementation

	make (s_as: G; lp_as, rp_as: like lparan_symbol) is
			-- Initialize Current with `G' and its brackets.
		do
			content := s_as
			lparan_symbol := lp_as
			rparan_symbol := rp_as
		ensure
			content_set: content = s_as
			lparan_symbol_set: lparan_symbol = lp_as
			rparan_symbol_set: rparan_symbol = rp_as
		end

feature -- Access: roundtrip

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Left and right brackets associated with `content' AST node

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			if content = Void then
				Result := other.content = Void
			else
				Result := other.content /= Void and then content.is_equivalent (other.content)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if a_list = Void then
				if content /= Void then
					Result := content.first_token (a_list)
				end
			else
				if lparan_symbol /= Void then
					Result := lparan_symbol.first_token (a_list)
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if a_list = Void then
				if content /= Void then
					Result := content.last_token (a_list)
				end
			else
				if rparan_symbol /= Void then
					Result := rparan_symbol.last_token (a_list)
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
end
