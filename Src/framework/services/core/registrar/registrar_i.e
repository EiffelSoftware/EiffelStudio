note
	description: "[
		An interface for supporting other iterfaces with registration/unregisteration of
		modular/extension objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REGISTRAR_I [G, K -> HASHABLE]

inherit
	USABLE_I

	DISPOSABLE_I

inherit {NONE}
	EVENT_CONNECTION_POINT_I [REGISTRAR_OBSERVER [G, K], REGISTRAR_I [G, K]]
		rename
			connection as registrar_connection
		end

feature -- Access

	active_registrations: !DS_LINEAR [G]
			-- Current registration object that can be used.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = active_registrations
--			result_contains_attached_items: not Result.has (Void)
			result_contains_usable_items: Result.for_all (agent (ia_item: G): BOOLEAN
				do
					Result := {l_usable: USABLE_I} ia_item implies l_usable.is_interface_usable
				end)
		end

	registrations: !DS_LINEAR [CONCEALER_I [G]]
			-- Current registrations.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = registrations
--			result_contains_attached_items: not Result.has (Void)
			result_contains_usable_items: Result.for_all (agent (ia_item: CONCEALER_I [G]): BOOLEAN
				do
					Result := {l_usable: USABLE_I} ia_item implies l_usable.is_interface_usable
				end)
		end

feature -- Status report

	is_valid_registration_key (a_key: !K): BOOLEAN
			--
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			a_key_is_interface_usable: {l_usable: USABLE_I} a_key implies l_usable.is_interface_usable
		end

	is_valid_registration (a_item: !G): BOOLEAN
			--
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			a_item_is_interface_usable: {l_usable: USABLE_I} a_item implies l_usable.is_interface_usable
		end

	is_registered (a_key: !K): BOOLEAN
			--
		require
			is_interface_usable: is_interface_usable
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
		deferred
		end

feature -- Query

	registration alias "[]" (a_key: !K): !G
			--
		require
			is_interface_usable: is_interface_usable
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
			a_key_is_registered: is_registered (a_key)
		deferred
		end

feature -- Basic operations

	register (a_item: !G; a_key: !K)
			--
		require
			is_interface_usable: is_interface_usable
			a_item_is_valid_registration_key: is_valid_registration_key (a_key)
			is_valid_registration_item: is_valid_registration (a_item)
			not_a_key_is_registered: not is_registered (a_key)
		deferred
		ensure
			is_registered_a_key: is_registered (a_key)
			a_item_sited: {l_site: SITE [REGISTRAR_I [G, K]]} a_item implies (l_site.is_sited and then l_site.site = Current)
		end

	register_with_activator (a_activator: !FUNCTION [ANY, TUPLE, !G]; a_key: !K)
			--
		require
			is_interface_usable: is_interface_usable
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
			not_a_key_is_registered: not is_registered (a_key)
		deferred
		ensure
			a_key_is_registered: is_registered (a_key)
		end

	unregister (a_key: !K)
			--
		require
			is_interface_usable: is_interface_usable
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
			a_key_is_registered_a_key: is_registered (a_key)
		deferred
		ensure
			not_is_registered_a_key: not is_registered (a_key)
			a_item_unsited: {l_site: SITE [REGISTRAR_I [G, K]]} old registration (a_key) implies not l_site.is_sited
		end

feature -- Events

	registered_event: !EVENT_TYPE [TUPLE [registrar: REGISTRAR_I [G, K]; registration: !CONCEALER_I [G]; key: !K]]
			-- Events called after an item was added to the dictionary.
			--
			-- new_item: The context item added to the dictionary.
			-- key: Item's dictionary indexing key.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = registered_event
			result_is_interface_usable: Result.is_interface_usable
		end

	unregistered_event: !EVENT_TYPE [TUPLE [registrar: REGISTRAR_I [G, K]; registration: !CONCEALER_I [G]; key: !K]]
			-- Events called after an item was removed to the dictionary.
			--
			-- old_item: The context item removed from the dictionary.
			-- key: Item's dictionary indexing key.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = unregistered_event
			result_is_interface_usable: Result.is_interface_usable
		end

	registration_activated_event: !EVENT_TYPE [TUPLE [registrar: REGISTRAR_I [G, K]; registration: !G; key: !K]]
			-- Events called after an item was removed to the dictionary.
			--
			-- new_item: The context item changed to in the dictionary.
			-- old_item: The context item changed from in the dictionary.
			-- key: Item's dictionary indexing key.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = registration_activated_event
			result_is_interface_usable: Result.is_interface_usable
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
