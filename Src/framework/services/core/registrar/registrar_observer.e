note
	description: "[
		An observer for events implemented on a {REGISTRAR_I} interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REGISTRAR_OBSERVER [G -> ANY, K -> HASHABLE]

inherit
	EVENT_OBSERVER_I

feature {REGISTRAR_I} -- Event handlers

	on_registered (a_registrar: REGISTRAR_I [G, K]; a_registration: CONCEALER_I [G]; a_key: K)
			-- Called when a registrar has been extended with a new registration object.
			--
			-- Note: Be sure to check {CONCEALER_I}.is_revealed before calling {CONCEALER_I}.object to
			--       prevent unncessary initialization. Alternatively, use `on_registration_activated'.
			--
			-- `a_registrar': The registrar the registration object was registered on.
			-- `a_registration': A concealed registration object, just registered with a registrar
			-- `a_key': A registrar key, used to register the newly registered object.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_registrar_attached: a_registrar /= Void
			a_registration_attached: a_registration /= Void
			is_interface_usable: attached {USABLE_I} a_registration as l_usable_item implies l_usable_item.is_interface_usable
			a_key_attached: a_key /= Void
		do
		end

	on_unregistered (a_registrar: REGISTRAR_I [G, K]; a_registration: CONCEALER_I [G]; a_key: K)
			-- Called when a registrar has been pruned with because a registration object has been
			-- unregistered.
			--
			-- Note: Be sure to check {CONCEALER_I}.is_revealed before calling {CONCEALER_I}.object to
			--       prevent unncessary initialization.
			--
			-- `a_registrar': The registrar the registration object was unregistered on.
			-- `a_registration': A concealed registration object, just unregistered with a registrar
			-- `a_key': A registrar key, used to unregister the registered object.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_registrar_attached: a_registrar /= Void
			a_registration_attached: a_registration /= Void
			a_key_attached: a_key /= Void
		do
		ensure
			is_revealed_unchanged: a_registration.is_revealed = old a_registration.is_revealed
		end

	on_registeration_activated (a_registrar: REGISTRAR_I [G, K]; a_registration: G; a_key: K)
			-- Called when a registration object has been revealed and is read for use.
			--
			-- Note: Typically, this will be called directly after `on_registered'. However, when
			--       registering using an activator instead of an object, with the registrar, this
			--       will only be called when that activator instantiates the registration object.
			--
			-- `a_registrar': The registrar the registration object was registered by.
			-- `a_registration': A activated registration object.
			-- `a_key': A registrar key, used when the registration object was registered.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_registrar_attached: a_registrar /= Void
			a_registration_attached: a_registration /= Void
			is_interface_usable: attached {USABLE_I} a_registration as l_usable_item implies l_usable_item.is_interface_usable
			a_key_attached: a_key /= Void
		do
		end

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
