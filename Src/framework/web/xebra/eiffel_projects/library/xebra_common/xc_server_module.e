note
	description: "[
		Interface for server modules.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_SERVER_MODULE

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Initializes current
		require
			a_name_attached: a_name /= Void
		do
			is_launched := False
			is_running := False
			name := a_name
		ensure
			name_set: equal(name, a_name)
		end

feature  -- Access

	name: STRING

feature -- Status report

	is_launched: BOOLEAN
		-- Checks if a module has been launched

	is_running: BOOLEAN
		-- Checks if a module is currently running	

feature -- Status setting

	shutdown
			-- Shutds down the module.
		deferred
		end

	launch
			-- Launches the module.	
		deferred
		end

	join
			-- Joins the thread.	
		deferred
		end

invariant
	name_attached: name /= Void
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

