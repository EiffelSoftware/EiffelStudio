note
	description: "[
		Contains settings that are read from execution arguments.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_ARG_CONFIG

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			create debug_level.make_empty
			create config_filename.make_empty
			create unmanaged.make_empty
		ensure
			debug_level_attached: debug_level /= Void
			config_filename_attached: config_filename /= Void
			unmanaged_attached: unmanaged /= Void
		end

feature -- Access

	debug_level: SETTABLE_INTEGER

	config_filename: SETTABLE_STRING assign set_config_filename

	unmanaged:  SETTABLE_BOOLEAN assign set_unmanaged
			-- Specifies

feature -- Status report

	print_configuration: STRING
			-- Renders the configuration to a string
		do
			Result := "%N---------------- Server Arguments ----------------"
			Result.append ( "%N-Debug Level '" + debug_level.out + "'" +
					  "%N-Unmanaged  '" + unmanaged.out + "'")
			Result.append ("%N--------------------------------------------------")
		ensure
			Result_attached: Result /= Void
		end

feature  -- Status setting

	set_debug_level  (a_debug_level: like debug_level)
			-- Sets debug_level.
		require
			a_debug_level_attached: a_debug_level /= Void
		do
			debug_level  := a_debug_level
		ensure
			debug_level_set: debug_level  = a_debug_level
		end

	set_config_filename (a_config_filename: like config_filename)
			-- Sets config_filename.
		require
			a_config_filename_attached: a_config_filename /= Void
		do
			config_filename  := a_config_filename
		ensure
			config_filename_set: config_filename  = a_config_filename
		end

	set_unmanaged (a_unmanaged: like unmanaged)
			-- Sets unmanaged.
		require
			a_unmanaged_attached: a_unmanaged /= Void
		do
			unmanaged := a_unmanaged
		ensure
			unmanaged_set: unmanaged = a_unmanaged
		end

invariant
	debug_level_attached: debug_level /= Void
	config_filename_attached: config_filename /= Void
	unmanaged_attached: unmanaged /= Void
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

