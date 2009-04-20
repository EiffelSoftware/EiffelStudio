note
	description: "[
		The default implementation of {REGISTRAR_I} for supporting other iterfaces with
		registration/unregisteration of modular/extension objects.
		
		Objects registered are automatically adopted by the registrar and will be disposed
		of when removed. If this is not the desired functionality then seek the functions
		of {ACTIVE_DICTIONARY_I}/{ACTIVE_DICTIONARY}.
		
		Objects registered will be automatically sited with the registrar object, if the
		object implemented {SITE}[{REGISTRAR_I}[G, K]], when registration takes place or
		a registered activator actives an object.
		
		All clean up is performed automously starting with the object being disposed if
		implementing {DISPOSABLE_I} and then unsite if implementing a conforming site
		specification.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REGISTRAR [G, K -> HASHABLE]

inherit
	REGISTRAR_I [G, K]

	DISPOSABLE_SAFE

--create
--	make

feature {NONE} -- Initialization

	make
			-- Initialize a new registrar.
		do
			create table.make_default
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		local
			l_keys: DS_LINEAR [K]
			l_item: detachable CONCEALER_I [G]
			l_key: detachable K
			l_automation: like automation
			l_action: PROCEDURE [ANY, TUPLE]
		do
			if a_explicit then
				l_keys := table.keys
				if not l_keys.is_empty then
					l_automation := automation
					from until l_keys.is_empty loop
						l_keys.start
						l_key := l_keys.item_for_iteration
						check
							l_key_attached: l_key /= Void
						end
						unregister (l_key)
					end
				end
			end
		ensure then
			table_is_empty: a_explicit implies table.is_empty
		end

feature -- Access

	active_registrations: DS_LINEAR [G]
			-- <Precursor>
		local
			l_list: DS_ARRAYED_LIST [G]
			l_cursor: DS_LINEAR_CURSOR [CONCEALER_I [G]]
			l_concealer: detachable CONCEALER_I [G]
			l_object: detachable G
		do
			if attached internal_active_registrations as l_result then
				Result := l_result
			else
				create l_list.make_default
				l_cursor := registrations.new_cursor
				from l_cursor.start until l_cursor.after loop
					l_concealer := l_cursor.item
					check l_concealer_attached: l_concealer /= Void end
					if l_concealer.is_revealed then
						l_object := l_concealer.object
						if l_object /= Void then
							if (not attached {USABLE_I} l_object as l_usable) or else l_usable.is_interface_usable then
								l_list.force_last (l_object)
							end
						end
					end
					l_cursor.forth
				end
				Result := l_list
				internal_active_registrations := Result
			end
		end

	registrations: DS_LINEAR [CONCEALER_I [G]]
			-- <Precursor>
		do
			Result := table.as_attached
		end

feature {NONE} -- Access

	table: DS_HASH_TABLE [CONCEALER_I [G], K]
			-- Actual table used to store active dictionary items.

feature -- Status report

	is_valid_registration_key (a_key: K): BOOLEAN
			-- <Precursor>
		do
			Result := attached {USABLE_I} a_key as l_usable implies l_usable.is_interface_usable
		end

	is_valid_registration (a_item: G): BOOLEAN
			-- <Precursor>
		do
			Result := attached {USABLE_I} a_item as l_usable implies l_usable.is_interface_usable
		end

	is_registered (a_key: K): BOOLEAN
			-- <Precursor>
		do
			Result := table.has (a_key)
		ensure then
			table_has_a_key: Result implies table.has (a_key)
		end

feature -- Query

	registration alias "[]" (a_key: K): G
			-- <Precursor>
		local
			l_item: CONCEALER_I [G]
			l_result: detachable G
		do
			l_item := table.item (a_key)
			check l_item_attached: l_item /= Void end
			l_result := l_item.object
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

feature -- Basic operations

	register (a_item: G a_key: K)
			-- <Precursor>
		local
			l_concealer: CONCEALER_STATIC [G]
		do
			create l_concealer.make (a_item)
			internal_register (l_concealer, a_key)
		end

	register_with_activator (a_activator: FUNCTION [ANY, TUPLE, attached G]; a_key: K)
			-- <Precursor>
		local
			l_concealer: CONCEALER_WITH_ACTIVATOR [G]
		do
			create l_concealer.make (a_activator)
			internal_register (l_concealer, a_key)
		end

	register_with_type_activator (a_type: TYPE [G]; a_key: K)
			-- <Precursor>
		local
			l_concealer: CONCEALER_WITH_ACTIVATOR [G]
		do
			register_with_activator (agent (ia_type: TYPE [G]): attached G
					-- Activator function to dynamically instantiate type.
				local
					l_internal: INTERNAL
					l_type_id: INTEGER
					l_result: detachable G
				do
					create l_internal
					l_type_id := l_internal.generic_dynamic_type (ia_type, 1)
					if attached {G} l_internal.new_instance_of (l_type_id) as l_object then
						l_result := l_object
					end
					check attached l_result end
					Result := l_result
				end (a_type), a_key)
		end

	unregister (a_key: K)
			-- <Precursor>
		local
			l_table: like table
			l_registration: detachable CONCEALER_I [G]
			l_action: PROCEDURE [ANY, TUPLE]
			l_adopted: BOOLEAN
		do
			l_table := table
			if l_table.has (a_key) then
				l_registration := l_table.item (a_key)
				check l_registration_attached: l_registration /= Void end
				l_table.remove (a_key)

				if attached internal_unregistered_event as l_event then
					l_event.publish ([Current, l_registration, a_key])
				end

				deactivate_registration (l_registration, a_key)
			end
		end

feature {NONE} -- Basic operations

	internal_register (a_item: CONCEALER_I [G]; a_key: K)
			-- <Precursor>
		require
			a_item_attached: a_item /= Void
			a_item_is_valid_registration_item:
				(attached {G} a_item as l_item implies is_valid_registration (l_item)) or else
				(attached {CONCEALER_I [G]} a_item)
			a_key_attached: a_key /= Void
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
		local
			l_registration: detachable ANY
		do
				-- Add the item to the table.
			table.force (a_item, a_key)

				-- Fetch the actual item
			if a_item.is_revealed then
					-- The object has already been revealed, so use it.
				l_registration := a_item.object
				check l_registration_attached: l_registration /= Void end
			else
				l_registration := a_item
			end

				-- Publish registration event
			if attached internal_registered_event as l_event then
				l_event.publish ([Current, a_item, a_key])
			end

				-- Perform activation setup and notification
			activate_registration (l_registration, a_key)
		ensure
			a_key_is_registered: is_registered (a_key)
		end

feature {NONE} -- Actions handlers

	activate_registration (a_registration: ANY; a_key: K)
			-- Activates a registration object, and in the case of a concealed object, setup for delayed
			-- activation.
			--
			-- `a_registration': A registration object {G} or a concealed registration object {CONCEALER_I}[G].
			-- `a_key': The key used to register the registration object.
		require
			is_interface_usable: is_interface_usable
			a_registration_attached: a_registration /= Void
			a_registration_is_valid_registration_item:
				(attached {G} a_registration as l_item implies is_valid_registration (l_item)) or else
				(attached {CONCEALER_I [G]} a_registration)
			a_key_attached: a_key /= Void
			a_key_is_valid_registration_key: is_valid_registration_key (a_key)
			a_key_is_registered: is_registered (a_key)
		do
			if attached {G} a_registration as l_registration then
					-- Actual item is available.

					-- Set disposable actions to automatically remove the item.
				if attached {DISPOSABLE_I} l_registration as l_disposable then
						-- Add subscription to dispose notification so the item can be removed automatically
						-- from the list
					l_disposable.automation.notify_on_disposed (agent unregister (a_key))
				end

					-- Site the active item.
				if attached {SITE [REGISTRAR_I [G, K]]} l_registration as l_site then
					check not_sited: not l_site.is_sited end
					if l_site.is_valid_site (Current) then
						l_site.site := Current
					end
				end

					-- Publish activation event.
				if attached internal_registration_activated_event as l_event then
					l_event.publish ([Current, l_registration, a_key])
				end

					-- Detach the cache active registrations so it's recached.
				internal_active_registrations := Void
			elseif attached {CONCEALER_I [G]} a_registration as l_concealer then
					-- The registration is wrapped in a concealer.

				if not l_concealer.is_revealed and then attached {CONCEALER_WITH_ACTIVATOR [G]} a_registration as l_activator then
						-- The object is concealed, so delay other functionality.
					l_activator.activated_event.subscribe_for_single_notification (agent (ia_object: detachable G; ia_key: K)
						require
							is_interface_usable: is_interface_usable
						do
							if ia_object /= Void then
									-- Activate the registration object now.
								activate_registration (ia_object, ia_key)
							else
								unregister (ia_key)
							end
						end (?, a_key))
				else
					check is_revealed: l_concealer.is_revealed end

						-- The object is available, so use it.
					if attached {G} l_concealer.object as l_object then
						activate_registration (l_object, a_key)
					else
						check False end
					end
				end
			end
		end

	deactivate_registration (a_registration: ANY; a_key: K)
			-- Deactivates a registration object, one that was activated using `activate_registration'.
			--
			-- `a_registration': A registration object {G} or a concealed registration object {CONCEALER_I}[G].
			-- `a_key': The key used to register the registration object.
		require
			is_interface_usable: is_interface_usable
			a_registration_attached: a_registration /= Void
			a_registration_is_valid_registration_item: (attached {G} a_registration) or (attached {CONCEALER_I [G]} a_registration)
		local
			l_action: PROCEDURE [ANY, TUPLE]
		do
			if attached {G} a_registration as l_item then
					-- Actual item is available.

					-- Clean up
				if attached {DISPOSABLE_I} l_item as l_disposable then
						-- Clean up item
					if l_disposable.is_interface_usable then
							-- Remove subscription to dispose because the item is being cleaned up now.
						l_action := agent unregister (a_key)
						if l_disposable.automation.is_notified_on_disposed (l_action) then
							l_disposable.automation.ignore_on_disposed (l_action)
						end
						l_disposable.dispose
					end
				end

					-- Remove any site object
				if attached {SITE [REGISTRAR_I [G, K]]} l_item as l_old_site then
					if l_old_site.is_sited then
						check sited_to_current: l_old_site.site = Current end
						l_old_site.site := Void
					end
				end

					-- Detach the cache active registrations so it's recached.
				internal_active_registrations := Void
			elseif attached {CONCEALER_I [G]} a_registration as l_concealer then
					-- The item is wrapped in a concealer.
				if not attached {USABLE_I} l_concealer as l_usable or else l_usable.is_interface_usable then
					if l_concealer.is_revealed then
							-- The object is available, so use it.
						if attached {G} l_concealer.object as l_object then
							deactivate_registration (l_object, a_key)
						else
							check False end
						end
					end
					if attached {DISPOSABLE_I} l_concealer as l_concealed_disposable then
							-- Clean up concealer
						l_concealed_disposable.dispose
					end
				end
			end
		end

feature -- Events: Connection point

	frozen registrar_connection: EVENT_CONNECTION_I [REGISTRAR_OBSERVER [G, K], REGISTRAR_I [G, K]]
			-- <Precursor>
		do
			if attached internal_registrar_connection as l_result then
				Result := l_result
			else
				create {EVENT_CONNECTION [REGISTRAR_OBSERVER [G, K], REGISTRAR_I [G, K]]} Result.make (
					agent (ia_observer: REGISTRAR_OBSERVER [G, K]): ARRAY [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
								[registered_event, agent ia_observer.on_registered],
								[unregistered_event, agent ia_observer.on_unregistered],
								[registration_activated_event, agent ia_observer.on_registeration_activated] >>
						end)
				automation.auto_dispose (Result)
				internal_registrar_connection := Result
			end
		end

feature -- Events

	registered_event: EVENT_TYPE [TUPLE [registrar: REGISTRAR_I [G, K]; registration: CONCEALER_I [G]; key: K]]
			-- <Precursor>
		do
			if attached internal_registered_event as l_result then
				Result := l_result
			else
				create Result
				internal_registered_event := Result
				automation.auto_dispose (Result)
			end
		end

	unregistered_event: EVENT_TYPE [TUPLE [registrar: REGISTRAR_I [G, K]; registration: CONCEALER_I [G]; key: K]]
			-- <Precursor>
		do
			if attached internal_unregistered_event as l_result then
				Result := l_result
			else
				create Result
				internal_unregistered_event := Result
				automation.auto_dispose (Result)
			end
		end

	registration_activated_event: EVENT_TYPE [TUPLE [registrar: REGISTRAR_I [G, K]; registration: G; key: K]]
			-- <Precursor>
		do
			if attached internal_registration_activated_event as l_result then
				Result := l_result
			else
				create Result
				internal_registration_activated_event := Result
				automation.auto_dispose (Result)
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_active_registrations: detachable like active_registrations
			-- Cached version of `active_registrations'
			-- Note: Do not use directly!

	internal_registered_event: detachable like registered_event
			-- Cached version of `registered_event'.
			-- Note: Do not use directly!

	internal_unregistered_event: detachable like unregistered_event
			-- Cached version of `unregistered_event'.
			-- Note: Do not use directly!

	internal_registration_activated_event: detachable like registration_activated_event
			-- Cached version of `registration_activated_event'.
			-- Note: Do not use directly!

	internal_registrar_connection: detachable like registrar_connection
			-- Cached version of `registrar_connection'.
			-- Note: Do not use directly!

invariant
	table_attached: table /= Void

;note
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
