note
	description: "[
		The built-in Eiffel output manager kind types. To be usew with the output manager service
		({OUTPUT_MANAGER_S}) to query for an output pane.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_MANAGER_KINDS

feature -- Access

	general: attached UUID
			-- General purpose output.
		once
			create Result.make_from_string (general_string)
		end

	eiffel_compiler: attached UUID
			-- Eiffel compiler output.
		once
			create Result.make_from_string (eiffel_compiler_string)
		end

	c_compiler: attached UUID
			-- C compiler output.
		once
			create Result.make_from_string (c_compiler_string)
		end

	testing: attached UUID
			-- Testing tools output.
		once
			create Result.make_from_string (testing_string)
		end

feature -- Constants

	general_string: STRING				= "2431F588-3EE1-4455-AF18-8733D1A787D5"
	eiffel_compiler_string: STRING 		= "714EF9B7-4AC6-418B-BEDC-009876372CB0"
	c_compiler_string: STRING 			= "4ADC046F-70F6-4364-9E33-8805C8F5D242"
	testing_string: STRING 				= "D6CF2232-99CB-47AE-B99B-6B1350728231"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
