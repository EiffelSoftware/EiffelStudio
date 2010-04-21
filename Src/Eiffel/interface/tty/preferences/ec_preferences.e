note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EC_PREFERENCES

inherit
	COMPILER_PREFERENCES
		rename
			make as make_compiler
		end

create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES)
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			make_compiler (a_preferences)
			create misc_data.make (a_preferences)
			create feature_tool_data.make (a_preferences)
			create flat_short_data.make (a_preferences)
			preferences := a_preferences
		end

feature -- Access

	flat_short_data: EB_FLAT_SHORT_DATA
		-- Preference data for class flat short.

	feature_tool_data: EB_FEATURE_TOOL_DATA
		-- Preference data for the feature tool.

	misc_data: EB_MISC_DATA
		-- Misc data.  This should be removed.  neilc

invariant
	feature_tool_data_not_void: feature_tool_data /= Void
	misc_data_not_void: misc_data /= Void
	flat_short_data_not_void: flat_short_data /= Void

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class EC_PREFERENCES
