note
	description: "Main httpd iron server"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_SERVER

inherit
	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end


create
	make_and_launch

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			service_options := create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("iron.ini")
		end

feature {NONE} -- Launch operation

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: IRON_NODE_SERVER_LAUNCHER [IRON_NODE_SERVICE_EXECUTION]
		do
			create launcher
			launcher.launch (opts)
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
