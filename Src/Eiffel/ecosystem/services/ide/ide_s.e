note
	description: "[
			IDE services, mostly to handle events.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IDE_S

inherit
	SERVICE_I

feature -- Access: Connecton

	ide_connection: EVENT_CONNECTION_I [IDE_OBSERVER, IDE_S]
			-- Connection point.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

feature -- Acces

	zoom_factor: INTEGER
			-- Current zoom factor value.
		deferred
		end

	set_zoom_factor (a_zoom_factor: INTEGER)
			-- Set `zoom_factor` to `a_zoom_factor`.
		deferred
		ensure
			zoom_factor_set: a_zoom_factor = zoom_factor
		end

feature -- Events

	zoom_event: EVENT_TYPE [TUPLE [zoom_factor: INTEGER]]
			-- Events called when zoom (in|out) is triggered.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Event publishing

	on_zoom (a_zoom_factor: INTEGER)
			-- Called after code statistics are updated.
		require
			is_interface_usable: is_interface_usable
		do
			set_zoom_factor (a_zoom_factor)
			if zoom_event.is_interface_usable then
				zoom_event.publish ([a_zoom_factor])
			end
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
