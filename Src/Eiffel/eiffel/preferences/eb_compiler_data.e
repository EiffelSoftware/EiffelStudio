indexing
	description: "All shared preferences for the compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPILER_DATA

create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			initialize_preferences (a_preferences)
		end

feature -- Value

	maximum_processor_usage: INTEGER is
			-- Maximum number of processors to utilize for compilation
		do
			Result := maximum_processor_usage_preference.value
		end

feature {NONE} -- Preference

	maximum_processor_usage_preference: INTEGER_PREFERENCE

	maximum_processor_usage_string: STRING is "compiler.maximum_processors_usage"

feature {NONE} -- Implementation

	initialize_preferences (a_preferences: PREFERENCES) is
			-- Initialize preference values.
		require
			a_preferences_not_void: a_preferences /= Void
		local
			l_manager: PREFERENCE_MANAGER
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			l_manager := a_preferences.new_manager ("compiler")

			maximum_processor_usage_preference := l_factory.new_integer_preference_value (l_manager, maximum_processor_usage_string, 0)
		end

invariant
	maximum_processor_usage_preference_attached: maximum_processor_usage_preference /= Void

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
