note
	description: "COM interface for metadata consumer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {CLASS_INTERFACE_ATTRIBUTE}.make ({CLASS_INTERFACE_TYPE}.none) end,
		create {GUID_ATTRIBUTE}.make ("64E0AD08-417E-4243-B533-561A05F4B5E6") end

frozen class
	COM_CACHE_MANAGER

inherit
	SYSTEM_OBJECT

	I_COM_CACHE_MANAGER

	ISPONSOR

create {COM_CACHE_MANAGER}
	default_create

feature -- Access

	is_successful: BOOLEAN
			-- Was the consuming successful?

	is_initialized: BOOLEAN
			-- has COM object been initialized?

	last_error_message: detachable SYSTEM_STRING
			-- Last error message

feature -- Basic Exportations

	initialize
			-- initialize the object using default path to EAC
		local
			l_sub: AR_RESOLVE_SUBSCRIBER
			l_resolver: AR_RESOLVER
			l_current_domain: APP_DOMAIN
		do
			create l_sub.make
			create l_resolver.make_with_name ({STRING_32} "Initializing Resolver")
			l_current_domain := {APP_DOMAIN}.current_domain
			if attached l_current_domain then
				l_sub.subscribe (l_current_domain, l_resolver)
			else
				check
					current_domain_attached: False
				end
			end

				-- Turn of all security to prevent any security exceptions
			{SECURITY_MANAGER}.set_security_enabled (False)

			is_initialized := True

			if attached l_current_domain then
				l_current_domain.add_domain_unload (create {EVENT_HANDLER}.make (Current, $on_unload_top_level_domain))
			end
		end

	initialize_with_path (a_path: SYSTEM_STRING)
			-- initialize object with path to specific EAC and initializes it if not already done.
		local
			cr: CACHE_READER
		do
			eac_path := a_path
			create cr
			cr.set_internal_eiffel_cache_path (create {PATH}.make_from_string (create {STRING_32}.make_from_cil (a_path)))

			initialize
			if not cr.is_initialized then
				{EIFFEL_SERIALIZATION}.serialize (
					cr.new_cache_info (cr.absolute_info_path),
					cr.absolute_info_path.name, False)
			end
			is_initialized := True
		end

	unload
			-- unloads initialized app domain and cache releated objects to preserve resources
		do
			if internal_marshalled_cache_manager /= Void then
				if attached new_marshalled_cache_manager as l_impl then
					l_impl.prepare_for_unload
				end
				if attached app_domain as l_domain then
					internal_marshalled_cache_manager := Void
					if not l_domain.is_finalizing_for_unload then
						{APP_DOMAIN}.unload (l_domain)
					end
					app_domain := Void
				end
			end
		end

	consume_assembly (a_name: SYSTEM_STRING; a_version, a_culture, a_key: detachable SYSTEM_STRING; a_info_only: BOOLEAN)
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		do
			if attached new_marshalled_cache_manager as l_impl then
				l_impl.consume_assembly (a_name, a_version, a_culture, a_key, a_info_only)
				update_current (l_impl)
			end
		end

	consume_assembly_from_path (a_path: SYSTEM_STRING; a_info_only: BOOLEAN; a_references: detachable SYSTEM_STRING)
			-- Consume assembly located `a_path'
		do
			if attached new_marshalled_cache_manager as l_impl then
				l_impl.consume_assembly_from_path (a_path, a_info_only, a_references)
				update_current (l_impl)
			end
		end

feature {NONE} -- Event Handlers

	on_unload_top_level_domain (a_sender: detachable SYSTEM_OBJECT; a_args: detachable EVENT_ARGS)
			-- Called when top level domain is unloaded.
		do
				-- Exits notifier
			{WINFORMS_APPLICATION}.exit
		end

feature {NONE} -- Lifetime Service Sponsorship

	renewal (lease: detachable ILEASE): TIME_SPAN
			-- Renews lease.
		do
			Result := {TIME_SPAN}.from_days (1)
		ensure then
			result_not_zero: Result /= {TIME_SPAN}.zero
		end

feature {NONE} -- Implementation

	update_current (a_impl: MARSHAL_CACHE_MANAGER)
			-- Update Current with `a_impl'.
		note
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		require
			a_impl_not_void: a_impl /= Void
		do
			is_successful := a_impl.is_successful
			last_error_message := a_impl.last_error_message
		end

	new_marshalled_cache_manager: detachable MARSHAL_CACHE_MANAGER
			-- New instance of {MARSHAL_CACHE_MANAGER} created in `a_app_domain'.
		local
			retried_count: INTEGER
		do
			if retried_count = 0 then
				Result := {MARSHAL_CACHE_MANAGER} / new_marshalled_cache_manager_object.unwrap
			else
					-- Resets cached internal manager
				internal_marshalled_cache_manager := Void
				Result := {MARSHAL_CACHE_MANAGER} /new_marshalled_cache_manager_object.unwrap
			end
		rescue
			retried_count := retried_count + 1
			if retried_count < 2 then
				retry
			end
		end

	new_marshalled_cache_manager_object: OBJECT_HANDLE
			-- New instance of {MARSHAL_CACHE_MANAGER} created in `a_app_domain'.
		note
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		local
			l_location: SYSTEM_STRING
			l_full_name: SYSTEM_STRING
			l_subscription: AR_RESOLVE_SUBSCRIBER
			l_resolver: AR_RESOLVER
			l_type: SYSTEM_TYPE
			l_current_domain: APP_DOMAIN
		do
			Result := internal_marshalled_cache_manager
			if not attached Result then
				check
					app_domain_not_exists: app_domain = Void
				end
				if attached {APP_DOMAIN}.create_domain ("EiffelSoftware.MetadataConsumer" + create {STRING_8}.make_from_cil ({GUID}.new_guid.to_string), Void, Void) as l_app_domain then
					app_domain := l_app_domain

						-- ensure that no decendant is mistaken by creating an instance of `COM_CACHE_MANAGER'.
					l_type := {COM_CACHE_MANAGER}
					if attached l_type.assembly as l_assembly then
						l_location := l_assembly.location
					else
						check
							from_documentation_assembly_attached: False
						then
						end
					end
						-- Watch out here, we create a .NET type of an Eiffel type, usually it is the interface type
						-- that we get, but in this case, MARSHAL_CACHE_MANAGER inheriting from a .NET type, interface
						-- and implementation are actually the same type.
					l_type := {MARSHAL_CACHE_MANAGER}
					l_full_name := l_type.full_name
					if
						attached l_app_domain.create_instance_from (l_location, l_full_name) as l_inst_obj_handle and then
						attached {ILEASE} l_inst_obj_handle.get_lifetime_service as l_lifetime_lease
					then
							-- Add a lifetime lease sponsor for {OBJECT_HANDLER}.
						l_lifetime_lease.register (Current)
							-- Note: When trying to unwrap a dynamically created object using
							-- APP_DOMAIN.create_instance_from, OBJECT_HANDLE.unwrap will try
							-- to relocate the assembly (using a display name instead of the path
							-- used to create the instance?!? Using COM interop it will look
							-- in the application base. For EiffelStudio this works fine because
							-- it resides in the application base. However with Eiffel ENViSioN!
							-- devenv location is the application base, which is not where the
							-- consumer is installed to.
						create l_subscription.make
						create l_resolver.make
						l_current_domain := {APP_DOMAIN}.current_domain
						if attached l_current_domain then
							l_subscription.subscribe (l_current_domain, l_resolver)
						else
							check
								current_domain_attached: False
							then
							end
						end

						Result := l_inst_obj_handle
						if attached {MARSHAL_CACHE_MANAGER} Result.unwrap as l_marshal then
								-- clean up resolver because it's no longer needed
							l_subscription.unsubscribe (l_current_domain, l_resolver)
							if attached eac_path as l_path then
								l_marshal.initialize_with_path (l_path)
							else
								l_marshal.initialize
							end
							if l_marshal.is_initialized then
								internal_marshalled_cache_manager := Result
							end
						else
								-- clean up resolver because it's no longer needed
							l_subscription.unsubscribe (l_current_domain, l_resolver)
							check
								marshal_cache_manager_attached: False
							end
						end
					else
						check
							instance_handle_attached: False
						then
						end
					end
				else
					check
						create_domain_attached: False
					then
					end
				end
			end
		ensure
			new_cache_manager_not_void: Result /= Void
		end

	eac_path: detachable SYSTEM_STRING
			-- Location of EAC `Eiffel Assembly Cache'
		note
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		attribute
		end

	internal_marshalled_cache_manager: detachable OBJECT_HANDLE
			-- internal marshalled cache manager
		note
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		attribute
		end

	app_domain: detachable APP_DOMAIN
			-- app domain consumption is run in
		note
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		attribute
		end

	e_fail_code: INTEGER
			--
		external
			"C [ macro %"winerror.h%"] : HRESULT"
		alias
			"E_FAIL"
		end;

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
