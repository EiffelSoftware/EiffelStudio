indexing
	description: "Types shared by all debug values"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE_TYPES

feature -- Shared constants

	Immediate_value: INTEGER is 1
	Void_value: INTEGER is 2
	Reference_value: INTEGER is 3
	Expanded_value: INTEGER is 4
	Special_value: INTEGER is 5
	External_reference_value: INTEGER is 6 -- used for dotnet
	Static_external_reference_value: INTEGER is 7 -- Used for static external reference value
	Static_reference_value: INTEGER is 8 -- Used for static external reference value (known in ec)
	Exception_message_value: INTEGER is 9 -- used to display exception on value retrieving
	Procedure_return_message_value: INTEGER is 10; -- used to display error on value retrieving
	Error_message_value: INTEGER is 11; -- used to display error on value retrieving

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

end -- class VALUE_TYPES
