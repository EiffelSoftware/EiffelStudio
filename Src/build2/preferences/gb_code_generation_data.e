indexing
	description: "Preferences for code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CODE_GENERATION_DATA
	
create
	make

feature {GB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end		

feature {GB_SHARED_PREFERENCES} -- Value

	generate_empty_directories: BOOLEAN is
			-- 
		do
			Result := generate_empty_directories_preference.value
		end		

feature -- Preference

	generate_empty_directories_preference: BOOLEAN_PREFERENCE

feature -- Preference Strings

	generate_empty_directories_string: STRING is "code_generation.generate_empty_directories"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: GB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "dialogs")			
							
			generate_empty_directories_preference := l_manager.new_boolean_resource_value (l_manager, generate_empty_directories_string, True)		
		end
	
	preferences: PREFERENCES
			-- Preferences
	
invariant
	preferences_not_void: preferences /= Void
	generate_empty_directories_preference_not_void: generate_empty_directories_preference /= Void

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
