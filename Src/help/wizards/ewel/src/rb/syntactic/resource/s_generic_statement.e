note
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Generic_statement -> "CONTROL" text "," id "," class "," Styles_list "," x "," y "," width
--			"," height Optional_extended_styles_list

class S_GENERIC_STATEMENT

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING
		once
			Result := "GENERIC_STATEMENT"
		end

	production: LINKED_LIST [CONSTRUCT]
		local
			text: IDENTIFIER
			id: IDENTIFIER
			class_ident: IDENTIFIER
			Styles_list: STYLES_LIST
			x: IDENTIFIER
			y: IDENTIFIER
			width: IDENTIFIER
			height: IDENTIFIER
			optional: OPTIONAL_EXTENDED_STYLES_LIST
		once
			create Result.make
			Result.forth

			keyword ("CONTROL")
			commit

			create text.make
			put (text)

			keyword (",")

			create id.make
			put (id)

			keyword (",")

			create class_ident.make
			put (class_ident)

			keyword (",")

			create Styles_list.make
			put (Styles_list)

			keyword (",")

			create x.make
			put (x)

			keyword (",")

			create y.make
			put (y)

			keyword (",")

			create width.make
			put (width)

			keyword (",")

			create height.make
			put (height)
	
			create optional.make
			put (optional)
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
end -- class S_GENERIC_STATEMENT

