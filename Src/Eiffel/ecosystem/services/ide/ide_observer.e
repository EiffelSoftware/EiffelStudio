note
	description: "Summary description for {IDE_OBSERVER}."
	date: "$Date$"
	revision: "$Revision$"

class
	IDE_OBSERVER

inherit
	EVENT_OBSERVER_I

feature -- Registration helpers

	register_as_ide_observer
		do
			if
				attached {IDE_S} (create {SERVICE_CONSUMER [IDE_S]}).service as l_ide_service
			then
				l_ide_service.ide_connection.connect_events (Current)
			end
		end

	unregister_as_ide_observer
		do
			if
				attached {IDE_S} (create {SERVICE_CONSUMER [IDE_S]}).service as l_ide_service
			then
				l_ide_service.ide_connection.disconnect_events (Current)
			end
		end

	zoom_factor: INTEGER
			-- Current zoom factor.
		do
			if
				attached {IDE_S} (create {SERVICE_CONSUMER [IDE_S]}).service as l_ide_service
			then
				Result := l_ide_service.zoom_factor
			end
		end

feature {IDE_S} -- Event handlers

	on_zoom (a_zoom_factor: INTEGER)
			-- Called when statistics is updated
			--
			-- `service': statistics service.
		require
			is_interface_usable: attached {USABLE_I} Current as u implies u.is_interface_usable
		do
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
