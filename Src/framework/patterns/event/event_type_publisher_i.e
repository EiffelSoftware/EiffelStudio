note
	description: "[
		Supports system event publication for a {EVENT_TYPE_I} implementation.
		
		The default implementation for this interface is {EVENT_TYPE}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EVENT_TYPE_PUBLISHER_I [EVENT_DATA -> TUPLE]

inherit
	USABLE_I

feature -- Status report

	is_publishing: BOOLEAN
			-- Is a publication currently being run?
		deferred
		ensure
			not_is_publishing: not is_interface_usable implies not Result
		end

feature -- Publication

	publish (a_args: detachable EVENT_DATA)
			-- Publish all not suspended actions from the subscription list.
			--
			-- `a_args': Public context arguments to forward to all subscribers.
		require
			is_interface_usable: is_interface_usable
			not_is_publishing: not is_publishing
		deferred
		ensure
			is_publishing_unchanged: is_publishing = old is_publishing
		end

	publish_if (a_args: detachable EVENT_DATA; a_predicate: PREDICATE [ANY, EVENT_DATA])
			-- Publishes the event, if the subscriptions have not been suspended.
			--
			-- `a_args': Public context arguments to forward to all subscribers.
			-- `a_predicate': The predicate to use to determine if a subscriber should recieve a published event.
		require
			is_interface_usable: is_interface_usable
			not_is_publishing: not is_publishing
			a_predicate_attached: a_predicate /= Void
			a_args_is_valid: a_predicate.valid_operands (a_args)
		deferred
		ensure
			is_publishing_unchanged: is_publishing = old is_publishing
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
