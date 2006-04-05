indexing
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Specific_statement -> specific_control_type id "," x "," y "," width "," height "," Optional_styles_list

class S_SPECIFIC_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "SPECIFIC_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			control_type: SPECIFIC_CONTROL_STATEMENT
			id: IDENTIFIER
			x: IDENTIFIER
			y: IDENTIFIER
			width: IDENTIFIER
			height: IDENTIFIER
			optional_styles: OPTIONAL_STYLES_LIST
		once
			!! Result.make
			Result.forth

			!! control_type.make
			put (control_type)

			!! id.make
			put (id)

			keyword (",")

			!! x.make
			put (x)

			keyword (",")

			!! y.make
			put (y)

			keyword (",")

			!! width.make
			put (width)

			keyword (",")

			!! height.make
			put (height)

			!! optional_styles.make
			put (optional_styles)
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
end -- class S_SPECIFIC_STATEMENT

