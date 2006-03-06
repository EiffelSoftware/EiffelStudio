indexing

	description: "Abstract class for Eiffel types. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE_AS

inherit
	AST_EIFFEL

feature -- Roundtrip

	lcurly_symbol, rcurly_symbol: SYMBOL_AS
			-- Left and/or right curly symbol(s) associated with this structure
			-- Maybe none of them, or maybe only left curly appears.

	set_lcurly_symbol (s_as: SYMBOL_AS) is
			-- Set `lcurly_symbol' with `s_as'.
		do
			lcurly_symbol := s_as
		ensure
			lcurly_symbol_set: lcurly_symbol = s_as
		end

	set_rcurly_symbol (s_as: SYMBOL_AS) is
			-- Set `rcurly_symbol' with `s_as'.
		do
			rcurly_symbol := s_as
		ensure
			rcurly_symbol_set: rcurly_symbol = s_as
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and then lcurly_symbol /= Void then
				Result := lcurly_symbol.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and then rcurly_symbol /= Void then
				Result := rcurly_symbol.last_token (a_list)
			end
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		deferred
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

end -- class TYPE_AS
