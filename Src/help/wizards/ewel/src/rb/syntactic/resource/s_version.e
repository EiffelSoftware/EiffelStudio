note
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Version -> identifier, identifier, identifier, identifier

class S_VERSION

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING
		once
			Result := "VERSION"
		end

	production: LINKED_LIST [CONSTRUCT]
		local
			hi_dw1: IDENTIFIER
			lo_dw1: IDENTIFIER
			hi_dw2: IDENTIFIER
			lo_dw2: IDENTIFIER
		once
			create Result.make
			Result.forth

			create hi_dw1.make
			put (hi_dw1)

			keyword (",")

			create lo_dw1.make
			put (lo_dw1)

			keyword (",")

			create hi_dw2.make
			put (hi_dw2)

			keyword (",")

			create lo_dw2.make
			put (lo_dw2)
		end

note
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
end -- class S_VERSION

