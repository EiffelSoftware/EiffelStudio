indexing
	description: "Eiffel Assembly Cache access errors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_ERRORS

inherit
	ERROR_MANAGER

feature -- Access

	Error_category: INTEGER_8 is 0x02
	
	Assembly_not_found_error: INTEGER is 0x02000001

	Consume_error: INTEGER is 0x02000002
	
	Remove_error: INTEGER is 0x02000003
	
	Not_in_eac_error: INTEGER is 0x02000004
	
	Update_error: INTEGER is 0x02000005
	
	Assembly_dependancies_not_found_error: INTEGER is 0x02000006

feature {NONE} -- Implementation

	error_message_table: HASH_TABLE [STRING, INTEGER] is
			-- Error messages
		once
			create Result.make (2)
			Result.put ("Could not find assembly", Assembly_not_found_error)
			Result.put ("Could not fully import assembly", Consume_error)
			Result.put ("Could not remove assembly from Eiffel Assembly Cache", Remove_error)
			Result.put ("Could not find assembly in Eiffel Assembly Cache", Not_in_eac_error)
			Result.put ("Could not update assembly", Update_error)
			Result.put ("Could not load one or more of assemblies dependancies", Assembly_dependancies_not_found_error)
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


end -- class CACHE_ERRORS
