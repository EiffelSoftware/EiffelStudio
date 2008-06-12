indexing
	description: "Preferences for compiler components of the Eiffel Compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Initialize preference data
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			create compiler_data.make (a_preferences)
		end

feature -- Access

	maximum_processor_usage: INTEGER is
			-- Maximum number of processors to utilitize in C/C++ compilation
		do
			Result := compiler_data.maximum_processor_usage
		ensure
			non_negative_result: Result >= 0
		end

feature -- Access

	preferences: PREFERENCES
			-- Actual preferences.  Use only to get a preference which you do not know the type
			-- of at runtime through `get_resource'.

feature {NONE} -- Implementation

	compiler_data: EB_COMPILER_DATA
			-- Preference data for compiler.		

invariant
	compiler_data_attached: compiler_data /= Void
	preferences_attached: preferences /= Void

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
