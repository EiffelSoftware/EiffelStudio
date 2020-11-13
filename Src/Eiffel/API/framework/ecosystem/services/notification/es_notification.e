note
	description: "Summary description for {ES_NOTIFICATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NOTIFICATION

inherit
	NOTIFICATION_S

	DISPOSABLE_SAFE

create
	make

feature {NONE} -- Creation

	make
		do
		end

feature -- Status report

	is_available: BOOLEAN = True
			-- Is account service available?

feature -- Execution

	notify (m: NOTIFICATION_MESSAGE)
		local
			evt: like notification_event
		do
			if is_interface_usable then
				evt := notification_event
				if evt.is_interface_usable then
					evt.publish ([m])
				end
			end
		end

feature -- Events

	notification_event: EVENT_TYPE [TUPLE [NOTIFICATION_MESSAGE]]
			-- <Precursor>
		do
			Result := internal_notification_event
			if Result = Void then
				create Result
				internal_notification_event := Result
				auto_dispose (Result)
			end
		end

feature -- Events: Connection point

	notification_connection: EVENT_CONNECTION_I [NOTIFICATION_OBSERVER, NOTIFICATION_S]
			-- <Precursor>
		do
			if attached internal_notification_connection as l_result then
				Result := l_result
			else
				create {EVENT_CONNECTION [NOTIFICATION_OBSERVER, NOTIFICATION_S]} Result.make (
					agent (ia_observer: NOTIFICATION_OBSERVER): ARRAY [TUPLE [event: like notification_event; action: PROCEDURE [NOTIFICATION_MESSAGE]]]
						do
							Result := << [notification_event, agent ia_observer.on_notification] >>
						end)
				auto_dispose (Result)
				internal_notification_connection := Result
			end
		end

feature {NONE} -- Implementation: Internal cached

	internal_notification_event: detachable like notification_event
			-- Cached version of `notification_event'.
			-- Note: Do not use directly!

	internal_notification_connection: detachable like notification_connection
			-- Cached version of `es_notification_connection'.
			-- Note: Do not use directly!		


feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
