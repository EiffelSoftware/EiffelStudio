note
	description: "Objects that contains an debugging execution parameters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_EXECUTION_PARAMETERS

obsolete "[2009-09-14] Please use DEBUGGER_EXECUTION_PROFILE"

create
	make,
	make_from_profile

--convert
--	make_from_profile ({DEBUGGER_EXECUTION_PROFILE, attached DEBUGGER_EXECUTION_PROFILE, detachable DEBUGGER_EXECUTION_PROFILE}) --,
--	to_profile: {DEBUGGER_EXECUTION_PROFILE, detachable DEBUGGER_EXECUTION_PROFILE}

feature {NONE} -- Initialization

	make
			-- Create Current parameters
		do
		end

feature -- Conversion

	make_from_profile (a_prof: detachable DEBUGGER_EXECUTION_PROFILE)
		do
			if a_prof /= Void then
				arguments := a_prof.arguments
				working_directory := a_prof.working_directory
				environment_variables := a_prof.environment_variables
			end
		end

	to_profile: DEBUGGER_EXECUTION_PROFILE
		do
			create Result.make
			Result.set_arguments (arguments)
			Result.set_working_directory (working_directory)
			Result.set_environment_variables (environment_variables)
		end

feature -- Properties

	arguments: STRING
			-- Command line arguments

	working_directory: STRING
			-- Working directory for execution

	environment_variables: HASH_TABLE [STRING_32, STRING_32]
			-- Modified environment variables

feature -- Change

	set_arguments (v: like arguments)
			-- Set `arguments'
		do
			arguments := v
		end

	set_working_directory (v: like working_directory)
			-- Set `working_directory'
		do
			working_directory := v
		end

	set_environment_variables (v: like environment_variables)
			-- Set `environment_variables'
		do
			environment_variables := v
		end

note
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
