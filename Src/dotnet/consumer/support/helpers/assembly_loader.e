note
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

	release_cached_data
			-- Releases all cached data
		local
			l_dom: detachable APP_DOMAIN
			retried: BOOLEAN
		do
			if not retried then
				if attached internal_loaded_assemblies as l_assemblies then
					l_assemblies.clear
				end
				if attached internal_gac_loader as l_gac_loader then
					l_dom := l_gac_loader.my_domain
					if not my_domain.equals (l_dom) and then not l_dom.is_finalizing_for_unload then
							-- Only unload app domain if called from another.
						{APP_DOMAIN}.unload (l_dom)
					end
				end
			end
			internal_loaded_assemblies := Void
			internal_gac_loader := Void
		ensure
			internal_gac_loader_unattached: internal_gac_loader = Void
			internal_loaded_assemblies_unattached: internal_loaded_assemblies = Void
		rescue
			retried := True
			retry
		end

feature {ASSEMBLY_LOADER} -- Access

	my_domain: APP_DOMAIN
			-- Retrieves domain in which loader is running in
		local
			l_result: detachable APP_DOMAIN
		do
			l_result := {APP_DOMAIN}.current_domain
			check l_result_attached: l_result /= Void end
			Result := l_result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	resolver: detachable CONSUMER_AGUMENTED_RESOLVER
			-- Resolver used for load resolution

feature -- Element change

	set_resolver (a_resolver: like resolver)
			-- Sets `resolver' with `a_resolver'
		do
			resolver := a_resolver
		ensure
			resolver_set: resolver = a_resolver
		end

feature -- Basic operations

	load_from (a_path: SYSTEM_STRING): detachable ASSEMBLY
			-- Attempts to load an assembly from `a_path'
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: a_path.length > 0
			a_path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			l_path: detachable SYSTEM_STRING
			l_asms: like loaded_assemblies
			retried: BOOLEAN
		do
			if not retried then
				l_path := a_path.to_lower
				check l_path_attached: l_path /= Void end
				l_asms := loaded_assemblies
				if not l_asms.contains (l_path) then
						-- Loads assembly in reflection only mode.
					l_asms.set_item (l_path, Result)
					Result := dotnet_load_from (l_path)
					l_asms.set_item (l_path, Result)
				else
					Result ?= l_asms.item (l_path)
				end
			end
		rescue
			retried := True
			retry
		end

	load_from_full_name (a_name: SYSTEM_STRING): detachable ASSEMBLY
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

	load (a_name: ASSEMBLY_NAME): detachable ASSEMBLY
			-- Attempts to load assembly `a_name' and returns the result. If no assembly could be found then
			-- Void will be returned
		require
			a_name_attached: a_name /= Void
		local
			l_name: detachable SYSTEM_STRING
			l_asms: like loaded_assemblies
			l_domain: detachable APP_DOMAIN
			l_resolver: like resolver
			l_fn: detachable STRING
			retried: BOOLEAN
			retried_again: BOOLEAN
		do
			if not retried_again then
				l_asms := loaded_assemblies
				l_name := a_name.full_name
				check l_name_attached: l_name /= Void end
				if l_asms.contains (l_name) then
					Result ?= l_asms.item (l_name)
				else
					l_resolver := resolver
					retried := l_resolver = Void
					if l_resolver /= Void then
							-- Use resolver to find best path possible	
						l_domain := {APP_DOMAIN}.current_domain
						check l_domain_attached: l_domain /= Void end
						l_fn := l_resolver.resolve_by_assembly_name (l_domain, a_name)
						if l_fn /= Void then
							l_asms.set_item (l_fn, Result)
							Result := load_from (l_fn)
							l_asms.set_item (l_fn, Result)
						end
						retried := True
					end
					if Result = Void and retried then
							-- Fail safe.
						l_asms.set_item (l_name, Result)
						Result := dotnet_load (l_name)
						l_asms.set_item (l_name, Result)
					end
				end
			end
		rescue
			retried_again := retried
			retried := True
			retry
		end

	load_from_gac_or_path (a_path: SYSTEM_STRING): detachable ASSEMBLY
			-- Attempts to load an assembly `a_path' from the GAC. Failure to find an assembly in the GAC will
			-- load the assembly from the specified path.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: a_path.length > 0
			a_path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			l_result: detachable ASSEMBLY
			l_name: detachable ASSEMBLY_NAME
		do
			Result := load_from (a_path)
			if Result /= Void then
					-- Attempt to locate in GAC (without a resolver! - do not set active resolver because
					-- the CLR should only resolve in GAC)
				l_name := Result.get_name
				check l_name_attached: l_name /= Void end
				l_result := gac_loader.load (l_name)
				if l_result /= Void and then l_result.global_assembly_cache then
					Result := l_result
				end
			end
		end

feature -- Domain

	gac_loader: ASSEMBLY_LOADER
			-- Loader used to load GAC only assemblies
		local
			l_type: detachable SYSTEM_TYPE
			l_new_dom: detachable APP_DOMAIN
			l_hnd: detachable OBJECT_HANDLE
			l_lease: detachable ILEASE
			l_obj: SYSTEM_OBJECT
			l_loader: detachable ASSEMBLY_LOADER
			l_ass: detachable ASSEMBLY
		do
			if attached internal_gac_loader as l_gac_loader then
				Result := l_gac_loader
			else
				l_obj := Current
				l_type := l_obj.get_type
				l_new_dom := {APP_DOMAIN}.create_domain (gac_domain_name)
				check
					l_type_attached: l_type /= Void
					l_new_dom_attached: l_new_dom /= Void
				end
				l_ass := l_type.assembly
				check l_ass_attached: l_ass /= Void end
				l_hnd := l_new_dom.create_instance_from (l_ass.location, l_type.full_name)
				check l_hnd_attached: l_hnd /= Void end

					-- Extend life time of created object
				l_lease ?= l_hnd.get_lifetime_service
				check l_lease_attached: l_lease /= Void end
				l_lease.register (Current)

					-- Unwrap
				l_loader ?= l_hnd.unwrap
				check l_loader_attached: l_loader /= Void end
				internal_gac_loader := l_loader
				Result := l_loader

					-- Add event handler for parent domain unloads
				l_new_dom.add_domain_unload (Result.new_gac_domain_unload_delelgate)
			end
		ensure
			result_attached: Result /= Void
			internal_gac_loader_set: internal_gac_loader = Result
		end

	on_gac_domain_unloaded (a_sender: detachable SYSTEM_OBJECT; a_args: detachable EVENT_ARGS)
			-- Called when GAC specific domain is being unloaded
		do
			release_cached_data
		end

	internal_gac_loader: detachable like gac_loader
			-- Cached version of `gac_loader'
			-- Note: do not use directly

feature -- Lifetime services

	initialize_lifetime_service: SYSTEM_OBJECT
			-- Obtains a lifetime service object to control the lifetime policy for this instance
		local
			l_lease: detachable ILEASE
		do
			l_lease ?= Precursor {MARSHAL_BY_REF_OBJECT}
			check l_lease_attached: l_lease /= Void end

			l_lease.initial_lease_time := {TIME_SPAN}.zero
			Result := l_lease
		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Lifetime service sponsorship

	renewal (a_lease: detachable ILEASE): TIME_SPAN
			-- Renews lease.
		do
			Result := {TIME_SPAN}.from_days (1)
		ensure then
			result_not_zero: Result /= {TIME_SPAN}.zero
		end

feature {NONE} -- Implementation

	loaded_assemblies: HASHTABLE
			-- Table of loaded assemblies
		local
			l_comparer: CONSUMER_STRING_COMPARER
		do
			if attached internal_loaded_assemblies as l_assemblies then
				Result := l_assemblies
			else
				create l_comparer.make (True)
				create Result.make (30, l_comparer, l_comparer)
				internal_loaded_assemblies := Result
			end
		ensure
			result_attached: Result /= Void
			internal_loaded_assemblies_set: internal_loaded_assemblies = Result
		end

	internal_loaded_assemblies: detachable like loaded_assemblies;
			-- Cached version of `loaded_assemblies'
			-- Note: Do not use directly!

feature {ASSEMBLY_LOADER} -- Implementation

	gac_domain_name: SYSTEM_STRING = "ASSEMBLY_LOADER (GAC)"
			-- Friendly name given to GAC domain.

	new_gac_domain_unload_delelgate: EVENT_HANDLER
			-- Creates a new event handler to ensure generated code is verifiable.
		require
			requested_in_gac_domain: attached {APP_DOMAIN}.current_domain as l_domain and then
				attached l_domain.friendly_name as l_name and then l_name.equals (gac_domain_name)
		do
			create Result.make (Current, $on_gac_domain_unloaded)
		ensure
			result_attached: Result /= Void
		end

note
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
