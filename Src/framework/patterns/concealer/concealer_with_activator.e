note
	description: "[
		An implementation of the {CONCEALER_I} pattern interface to provided access to a concealed
		object using an activator function to retrieve the object.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	CONCEALER_WITH_ACTIVATOR [G -> ANY]

inherit
	USABLE_I

	DISPOSABLE_I

	CONCEALER_I [G]

	DISPOSABLE_SAFE

create
	make

feature {NONE} -- Initialization

	make (a_activator: like activator)
			-- Initialize concealer with activator function, use to retrieve a concealed object.
			--
			-- `a_activator': A function used to retrieve a concealed object on first use.
		require
			a_activator_attached: a_activator /= Void
		do
			activator := a_activator
		ensure
			activator_set: activator = a_activator
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			activator := Void
			internal_object := default_object
			is_revealed := False
		ensure then
			activator_detached: activator = Void
			internal_object_is_default: internal_object = default_object
		end

feature -- Access

	object: detachable G
			-- <Precursor>
		local
			l_activator: like activator
			l_events: like internal_activated_event
		do
			if is_revealed then
				Result := internal_object
			else
				l_activator := activator
				check l_activator_attached: attached l_activator end
				Result := activator.item (Void)
					-- Detach activator as it is no longer required
				activator := Void
				internal_object := Result
				is_revealed := True

				l_events := internal_activated_event
				if attached l_events then
					l_events.publish ([Result])
					l_events.dispose
				end
			end
		ensure then
			internal_activated_event_disposed:
				attached internal_activated_event as el_events implies not el_events.is_interface_usable
		end

feature {NONE} -- Access

	activator: detachable FUNCTION [ANY, TUPLE, detachable G]
			-- The function use to active an object for the first time
			-- Note: Once the object has been activated the function will not long be available.

	default_object: G
			-- Default generic object.

feature -- Status report

	is_revealed: BOOLEAN
			-- <Precursor>

feature -- Event

	activated_event: EVENT_TYPE [TUPLE [object: detachable G]]
			-- Events called when the object is activated.
		require
			is_interface_usable: is_interface_usable
			not_is_revealed: not is_revealed
		local
			l_result: detachable EVENT_TYPE [TUPLE [detachable G]]
		do
			l_result := internal_activated_event
			if attached l_result then
				Result := l_result
			else
				create Result
				internal_activated_event := Result
				automation.auto_dispose (Result)
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = activated_event
		end

feature {NONE} -- Implementation: Internal cache

	internal_object: detachable like object
			-- Cached version of `object'.
			-- Note: Do not use directly!

	internal_activated_event: detachable like activated_event
			-- Cached version of `activated_event'.
			-- Note: Do not use directly!

invariant
	activator_attached: is_interface_usable implies (is_revealed implies attached activator)
	activator_detached: is_interface_usable implies (is_revealed implies not attached activator)
	is_revealed: is_interface_usable implies (internal_object /= Void implies is_revealed)

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
