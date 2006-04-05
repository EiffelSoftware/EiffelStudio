indexing
	description: "Access to shared constant classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONSTANTS

feature -- Access

	Application_constants: APPLICATION_CONSTANTS is
			-- Application wide constants
		once
			create Result			
		end
		
	Graphical_constants: GRAPHICAL_CONSTANTS is
			-- Graphical constants
		once
			create Result			
		end
		
	Message_constants: MESSAGE_CONSTANTS is
			-- Message string constants
		once
			create Result
		end		
		
	Help_constants: HELP_SETTING_CONSTANTS is
			-- Help wide constants
		once
			create Result			
		end
		
	Output_constants: OUTPUT_CONSTANTS is
			-- Output constants
		once
			create Result			
		end

	Transformation_constants: XSL_TRANSFORM_CONSTANTS is
			-- Transform constants
		once
			create Result	
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
end -- class SHARED_CONSTANTS
