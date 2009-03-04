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

--inherit {NONE}
	EVENT_CONNECTION_POINT_I [REGISTRAR_OBSERVER [G, K], REGISTRAR_I [G, K]]
		rename
			connection as registrar_connection
		end

feature -- Access

	active_registrations: attached DS_LINEAR [G]
			-- Current registration object that can be used.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = active_registrations
--			result_contains_attached_items: not Result.has (Void)
			result_contains_usable_items: Result.for_all (agent (ia_item: G): BOOLEAN
				do
					Result := attached {USABLE_I} ia_item as l_usable implies l_usable.is_interface_usable
				end)
		end

	registrations: attached DS_LINEAR [CONCEALER_I [G]]
			-- Current registrations.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = registrations
--			result_contains_attached_items: not Result.has (Void)
			result_contains_usable_items: Result.for_all (agent (ia_item: CONCEALER_I [G]): BOOLEAN
				do
					Result := attached {USABLE_I} ia_item as l_usable implies l_usable.is_interface_usable
				end)
		end

feature -- Status report

	is_valid_registration_key (a_key: attached K): BOOLEAN
			-- Determines if a registeration key is valid for the registrar.
			--
			-- `a_key': The registeration key to determine validity for.
			-- `Result': True if the key is valid; False otherwise.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			a_key_is_interface_usable: attached {USABLE_I} a_key as l_usable implies l_usable.is_interface_usable
		end

	is_valid_registration (a_item: attached G): BOOLEAN
			-- Determines if a registeration object is valid for the registrar.
			--
			-- `a_item': The registeration object to determine validity for.
			-- `Result': True if the object is valid; False otherwise.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			a_item_is_interface_usable: attached {USABLE_I} a_item as l_usable implies l_usable.is_interface_usable
		end

	is_registered (a_key: attached K): BOOLEAN
			-- Determins if a object has been registered already.
			--
			-- `a_key': A registeration key.
			-- `Result': True if there is a registeration pertaining to the supplied key; False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
		deferred
		end

feature -- Query

	registration alias "[]" (a_key: attached K): attached G assign register
			-- Retrieves an object registered with the supplied registration key.
			--
			-- `a_key': The registeration key to retrieve an registration object for.
			-- `Result': The registeration object, associated with the supplied registration key.
		require
			is_interface_usable: is_interface_usable
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
			a_key_is_registered: is_registered (a_key)
		deferred
		end

feature -- Basic operations

	register (a_item: attached G; a_key: attached K)
			-- Registers an object with the registrar.
			--
			-- `a_item': The object to register.
			-- `a_key': A unique registeration key to associate with the registration object.
		require
			is_interface_usable: is_interface_usable
			a_item_is_valid_registration_key: is_valid_registration_key (a_key)
			is_valid_registration_item: is_valid_registration (a_item)
			not_a_key_is_registered: not is_registered (a_key)
		deferred
		ensure
			is_registered_a_key: is_registered (a_key)
			a_item_sited: attached {SITE [REGISTRAR_I [G, K]]} a_item as l_site implies (l_site.is_sited and then l_site.site = Current)
		end

	register_with_activator (a_activator: attached FUNCTION [ANY, TUPLE, attached G]; a_key: attached K)
			-- Registers an activator function, used to retrieve a registration object upon request.
			--
			-- `a_item': The object to register.
			-- `a_key': A unique registeration key to associate with the registration object.
		require
			is_interface_usable: is_interface_usable
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
			not_a_key_is_registered: not is_registered (a_key)
		deferred
		ensure
			a_key_is_registered: is_registered (a_key)
		end

	register_with_type_activator (a_type: attached TYPE [G]; a_key: attached K)
			-- Registers an activator with the registrar, which will be used to instantiate the registration
			-- object when the first request is made.
			--
			-- Note: The registration object should not have a creation routine because the regisration object
			--       will be dynamically instatiated. For initialization properties use classes implementing
			--       {SITE [REGISTRAR_I [..., ...]]}.
			--
			-- `a_type': The object type to register.
			-- `a_key': A unique registeration key to associate with the registration object.
		require
			is_interface_usable: is_interface_usable
			a_item_is_valid_registration_key: is_valid_registration_key (a_key)
			not_a_key_is_registered: not is_registered (a_key)
		deferred
		ensure
			is_registered_a_key: is_registered (a_key)
		end

	unregister (a_key: attached K)
			-- Unregisters a previous registered object or activator.
			--
			-- `a_key': The key originally used to register an object or activator.
		require
			is_interface_usable: is_interface_usable
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
			a_key_is_registered_a_key: is_registered (a_key)
		deferred
		ensure
			not_is_registered_a_key: not is_registered (a_key)
			a_item_unsited: attached {SITE [REGISTRAR_I [G, K]]} old registration (a_key) as l_site implies not l_site.is_sited
		end

feature -- Events

	registered_event: attached EVENT_TYPE [TUPLE [registrar: REGISTRAR_I [G, K]; registration: attached CONCEALER_I [G]; key: attached K]]
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

	unregistered_event: attached EVENT_TYPE [TUPLE [registrar: REGISTRAR_I [G, K]; registration: attached CONCEALER_I [G]; key: attached K]]
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

	registration_activated_event: attached EVENT_TYPE [TUPLE [registrar: REGISTRAR_I [G, K]; registration: attached G; key: attached K]]
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
