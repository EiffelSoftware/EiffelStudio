indexing
	description: "COM interface for metadata consumer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {CLASS_INTERFACE_ATTRIBUTE}.make ({CLASS_INTERFACE_TYPE}.none) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE1AC-C5BD-492B-924A-8DBC9D2112F5") end

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

	last_error_message: SYSTEM_STRING
			-- Last error message

feature -- Basic Exportations

	initialize is
			-- initialize the object using default path to EAC
		local
			l_sub: AR_RESOLVE_SUBSCRIBER
			l_resolver: AR_RESOLVER
		do
			create l_sub.make
			create l_resolver.make_with_name ("Initializing Resolver")
			l_sub.subscribe ({APP_DOMAIN}.current_domain, l_resolver)

				-- Turn of all security to prevent any security exceptions
			{SECURITY_MANAGER}.set_security_enabled (False)

			is_initialized := True

			{APP_DOMAIN}.current_domain.add_domain_unload (create {EVENT_HANDLER}.make (Current, $on_unload_top_level_domain))
		end

	initialize_with_path (a_path: SYSTEM_STRING) is
			-- initialize object with path to specific EAC and initializes it if not already done.
		local
			cr: CACHE_READER
		do
			eac_path := a_path
			create cr
			cr.set_internal_eiffel_cache_path (eac_path)

			initialize
			if not cr.is_initialized then
				(create {EIFFEL_SERIALIZER}).serialize (
					cr.new_cache_info (cr.absolute_info_path),
					cr.absolute_info_path, False)
			end
			is_initialized := True
		end

	unload is
			-- unloads initialized app domain and cache releated objects to preserve resources
		local
			l_impl: MARSHAL_CACHE_MANAGER
		do
			if internal_marshalled_cache_manager /= Void then
				l_impl := new_marshalled_cache_manager
				l_impl.prepare_for_unload
				if app_domain /= Void then
					internal_marshalled_cache_manager := Void
					if not app_domain.is_finalizing_for_unload then
						{APP_DOMAIN}.unload (app_domain)
					end
					app_domain := Void
				end
			end
		end

	consume_assembly (a_name, a_version, a_culture, a_key: SYSTEM_STRING; a_info_only: BOOLEAN) is
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		local
			l_impl: MARSHAL_CACHE_MANAGER
		do
			l_impl := new_marshalled_cache_manager
			l_impl.consume_assembly (a_name, a_version, a_culture, a_key, a_info_only)
			update_current (l_impl)
		end

	consume_assembly_from_path (a_path: SYSTEM_STRING; a_info_only: BOOLEAN; a_references: SYSTEM_STRING) is
			-- Consume assembly located `a_path'
		local
			l_impl: MARSHAL_CACHE_MANAGER
		do
			l_impl := new_marshalled_cache_manager
			l_impl.consume_assembly_from_path (a_path, a_info_only, a_references)
			update_current (l_impl)
		end

feature {NONE} -- Event Handlers

	on_unload_top_level_domain (a_sender: SYSTEM_OBJECT; a_args: EVENT_ARGS) is
			-- Called when top level domain is unloaded.
		do
				-- Exits notifier
			{WINFORMS_APPLICATION}.exit
		end

feature {NONE} -- Lifetime Service Sponsorship

	renewal (lease: ILEASE): TIME_SPAN is
			-- Renews lease.
		do
			Result := {TIME_SPAN}.from_days (1)
		ensure then
			result_not_zero: Result /= {TIME_SPAN}.zero
		end

feature {NONE} -- Implementation

	update_current (a_impl: MARSHAL_CACHE_MANAGER) is
			-- Update Current with `a_impl'.
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		require
			a_impl_not_void: a_impl /= Void
		do
			is_successful := a_impl.is_successful
			last_error_message := a_impl.last_error_message
		end

	new_marshalled_cache_manager: MARSHAL_CACHE_MANAGER is
			-- New instance of {MARSHAL_CACHE_MANAGER} created in `a_app_domain'.
		local
			retried_count: INTEGER
		do
			if retried_count = 0 then
				Result ?= new_marshalled_cache_manager_object.unwrap
			else
					-- Resets cached internal manager
				internal_marshalled_cache_manager := Void
				Result ?= new_marshalled_cache_manager_object.unwrap
			end
		rescue
			retried_count := retried_count + 1
			if retried_count < 2 then
				retry
			end
		end

	new_marshalled_cache_manager_object: OBJECT_HANDLE is
			-- New instance of {MARSHAL_CACHE_MANAGER} created in `a_app_domain'.
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		local
			l_inst_obj_handle: OBJECT_HANDLE
			l_lifetime_lease: ILEASE
			l_time_span: TIME_SPAN
			l_marshal: MARSHAL_CACHE_MANAGER
			l_location: SYSTEM_STRING
			l_full_name: SYSTEM_STRING
			l_subscription: AR_RESOLVE_SUBSCRIBER
			l_resolver: AR_RESOLVER
			l_type: SYSTEM_TYPE
		do
			if internal_marshalled_cache_manager = Void then
				check
					app_domain_not_exists: app_domain = Void
				end
				app_domain := {APP_DOMAIN}.create_domain ("EiffelSoftware.MetadataConsumer" + {GUID}.new_guid.to_string, Void, Void)

					-- ensure that no decendant is mistaken by creating an instance of `COM_CACHE_MANAGER'.
				l_type := {COM_CACHE_MANAGER}
				l_location := l_type.assembly.location
					-- Watch out here, we create a .NET type of an Eiffel type, usually it is the interface type
					-- that we get, but in this case, MARSHAL_CACHE_MANAGER inheriting from a .NET type, interface
					-- and implementation are actually the same type.
				l_type := {MARSHAL_CACHE_MANAGER}
				l_full_name := l_type.full_name
				l_inst_obj_handle ?= app_domain.create_instance_from (l_location, l_full_name)

					-- Add a lifetime lease sponsor for {OBJECT_HANDLER}.
				check l_inst_obj_handle_attached: l_inst_obj_handle /= Void end
				l_lifetime_lease ?= l_inst_obj_handle.get_lifetime_service
				check l_lifetime_lease_attached: l_lifetime_lease /= Void end
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
				l_subscription.subscribe ({APP_DOMAIN}.current_domain, l_resolver)

				Result := l_inst_obj_handle
				l_marshal ?= Result.unwrap
				check
					unwrapped: l_marshal /= Void
				end

					-- clean up resolver because it's no longer needed
				l_subscription.unsubscribe ({APP_DOMAIN}.current_domain, l_resolver)

				if eac_path = Void then
					l_marshal.initialize
				else
					l_marshal.initialize_with_path (eac_path)
				end
				if l_marshal.is_initialized then
					internal_marshalled_cache_manager := Result
				end
			else
				Result := internal_marshalled_cache_manager
			end
		ensure
			new_cache_manager_not_void: Result /= Void
		end

	eac_path: SYSTEM_STRING
			-- Location of EAC `Eiffel Assembly Cache'
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		end

	internal_marshalled_cache_manager: OBJECT_HANDLE
			-- internal marshalled cache manager
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		end

	app_domain: APP_DOMAIN
			-- app domain consumption is run in
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		end

	e_fail_code: INTEGER is
			--
		external
			"C [ macro %"winerror.h%"] : HRESULT"
		alias
			"E_FAIL"
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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


end -- class COM_CACHE_MANAGER
