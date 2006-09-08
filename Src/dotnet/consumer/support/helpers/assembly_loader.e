indexing
	description: "A utility class for loading assemblies"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_LOADER

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			initialize_lifetime_service
		end

	ASSEMBLY_LOADER_IMPL
		export
			{NONE} all
		end

	ISPONSOR
		export
			{NONE} all
		end

feature -- Cleanup

	release_cached_data is
			-- Releases all cached data
		local
			l_dom: APP_DOMAIN
			retried: BOOLEAN
		do
			if not retried then
				if internal_loaded_assemblies /= Void then
					internal_loaded_assemblies.clear
					internal_loaded_assemblies := Void
				end
				if internal_gac_loader /= Void then
					l_dom := internal_gac_loader.my_domain
					if not my_domain.equals (l_dom) and then not l_dom.is_finalizing_for_unload then
							-- Only unload app domain if called from another.
						{APP_DOMAIN}.unload (l_dom)
					end
				end
			end
			internal_gac_loader := Void
		ensure
			internal_gac_loader_unattached: internal_gac_loader = Void
			internal_loaded_assemblies_unattached: internal_loaded_assemblies = Void
		rescue
			retried := True
			retry
		end

feature {ASSEMBLY_LOADER} -- Access

	my_domain: APP_DOMAIN is
			-- Retrieves domain in which loader is running in
		do
			Result := {APP_DOMAIN}.current_domain
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	resolver: CONSUMER_AGUMENTED_RESOLVER
			-- Resolver used for load resolution

feature -- Element change

	set_resolver (a_resolver: like resolver) is
			-- Sets `resolver' with `a_resolver'
		do
			resolver := a_resolver
		ensure
			resolver_set: resolver = a_resolver
		end

feature -- Basic operations

	load_from (a_path: SYSTEM_STRING): ASSEMBLY is
			-- Attempts to load an assembly from `a_path'
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: a_path.length > 0
			a_path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			l_path: SYSTEM_STRING
			l_asms: like loaded_assemblies
			retried: BOOLEAN
		do
			if not retried then
				l_path := a_path.to_lower
				l_asms := loaded_assemblies
				if not l_asms.contains (l_path) then
						-- Loads assembly in reflection only mode.
					Result := dotnet_load_from (l_path)
					l_asms.add (l_path, Result)
				else
					Result ?= l_asms.item (l_path)
				end
			end
		rescue
			retried := True
			retry
		end

	load_from_full_name (a_name: SYSTEM_STRING): ASSEMBLY is
			-- Attempts to load an assembly from  a full name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: a_name.length > 0
		local
			l_name: ASSEMBLY_NAME
			retried: BOOLEAN
		do
			if not retried then
					-- Loads assembly in reflection only mode.
				create l_name.make
				l_name.set_name (a_name)
				Result := load (l_name)
			end
		rescue
			retried := True
			retry
		end

	load (a_name: ASSEMBLY_NAME): ASSEMBLY is
			-- Attempts to load assembly `a_name' and returns the result. If no assembly could be found then
			-- Void will be returned
		require
			a_name_attached: a_name /= Void
		local
			l_asms: like loaded_assemblies
			l_resolver: like resolver
			l_fn: STRING
			retried: BOOLEAN
			retried_again: BOOLEAN
		do
			if not retried_again then
				l_asms := loaded_assemblies
				if l_asms.contains (a_name) then
					Result ?= l_asms.item (a_name)
				else
					l_resolver := resolver
					if not retried and l_resolver /= Void then
							-- Use resolver to find best path possible	
						l_fn := resolver.resolve_by_assembly_name ({APP_DOMAIN}.current_domain, a_name)
						if l_fn /= Void then
							Result := load_from (l_fn)
						end
					end
					if Result = Void and (retried or l_fn = Void) then
							-- Fail safe.
						Result := dotnet_load (a_name.to_string)
					end
					l_asms.add (a_name, Result)
				end
			end
		rescue
			retried_again := retried
			retried := True
			retry
		end

	load_from_gac_or_path (a_path: SYSTEM_STRING): ASSEMBLY is
			-- Attempts to load an assembly `a_path' from the GAC. Failure to find an assembly in the GAC will
			-- load the assembly from the specified path.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: a_path.length > 0
			a_path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			l_result: ASSEMBLY
		do
			Result := load_from (a_path)
			if Result /= Void then
					-- Attempt to locate in GAC (without a resolver! - do not set active resolver because
					-- the CLR should only resolve in GAC)
				l_result := gac_loader.load (Result.get_name)
				if l_result /= Void and then l_result.global_assembly_cache then
					Result := l_result
				end
				check result_attached: Result /= Void end
			end
		end

feature -- Domain

	gac_loader: ASSEMBLY_LOADER is
			-- Loader used to load GAC only assemblies
		local
			l_type: SYSTEM_TYPE
			l_new_dom: APP_DOMAIN
			l_hnd: OBJECT_HANDLE
			l_lease: ILEASE
			l_setup: APP_DOMAIN_SETUP
		do
			Result := internal_gac_loader
			if Result = Void then
				l_type := (({SYSTEM_OBJECT})[Current]).get_type
				l_new_dom := {APP_DOMAIN}.create_domain (gac_domain_name)
				l_hnd := l_new_dom.create_instance_from (l_type.assembly.location, l_type.full_name)

					-- Extend life time of created object
				l_lease ?= l_hnd.get_lifetime_service
				check l_lease_attached: l_lease /= Void end
				l_lease.register (Current)

					-- Unwrap
				Result ?= l_hnd.unwrap
				internal_gac_loader := Result

					-- Add event handler for parent domain unloads
				l_new_dom.add_domain_unload (Result.new_gac_domain_unload_delelgate)
			end
		ensure
			result_attached: Result /= Void
			internal_gac_loader_set: internal_gac_loader = Result
		end

	on_gac_domain_unloaded (a_sender: SYSTEM_OBJECT; a_args: EVENT_ARGS) is
			-- Called when GAC specific domain is being unloaded
		do
			release_cached_data
		end

	internal_gac_loader: like gac_loader
			-- Cached version of `gac_loader'
			-- Note: do not use directly

feature -- Lifetime services

	initialize_lifetime_service: SYSTEM_OBJECT is
			-- Obtains a lifetime service object to control the lifetime policy for this instance
		local
			l_lease: ILEASE
		do
			l_lease ?= Precursor {MARSHAL_BY_REF_OBJECT}
			check l_lease_attached: l_lease /= Void end

			l_lease.initial_lease_time := {TIME_SPAN}.zero
			Result := l_lease
		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Lifetime service sponsorship

	renewal (a_lease: ILEASE): TIME_SPAN is
			-- Renews lease.
		do
			Result := {TIME_SPAN}.from_days (1)
		ensure then
			result_not_zero: Result /= {TIME_SPAN}.zero
		end

feature {NONE} -- Implementation

	loaded_assemblies: HASHTABLE is
			-- Table of loaded assemblies
		do
			Result := internal_loaded_assemblies
			if Result = Void then
				create Result.make (30)
				internal_loaded_assemblies := Result
			end
		ensure
			result_attached: Result /= Void
			internal_loaded_assemblies_set: internal_loaded_assemblies = Result
		end

	internal_loaded_assemblies: like loaded_assemblies;
			-- Cached version of `loaded_assemblies'
			-- Note: Do not use directly!

feature {ASSEMBLY_LOADER} -- Implementation

	gac_domain_name: SYSTEM_STRING = "ASSEMBLY_LOADER (GAC)"
			-- Friendly name given to GAC domain.

	new_gac_domain_unload_delelgate: EVENT_HANDLER is
			-- Creates a new event handler to ensure generated code is verifiable.
		require
			requested_in_gac_domain: {APP_DOMAIN}.current_domain.friendly_name.equals (gac_domain_name)
		do
			create Result.make (Current, $on_gac_domain_unloaded)
		ensure
			result_attached: Result /= Void
		end

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

end -- class {ASSEMBLY_LOADER}
