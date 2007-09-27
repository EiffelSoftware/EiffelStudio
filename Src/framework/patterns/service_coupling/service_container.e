indexing
	description: "[
		Base implementation for all global and local service containers.
		
		Note: Containers must obey some rules.
		
		* When prompting services must be registed with the global service provider ({SERVICE_HEAP}).
		  Promoting is the act of promoting a service to the highest level possible. This attribute
		  only needs to be respected when using chained containers {SERVICE_CHAINED_CONTAINER}.
		  The global service container may be retrieved using the {SERVICE_CONTAINER} service and then
		  global service provider using {SERVICE_PROVIDER}.
		* Services that are not promoted may have a localized versions of the service, if not already
		  proffered. When querying for a service a local service is given priority. Clients are free
		  to query for the global service provider {SERVICE_PROVIDER} or {SERVICE_CONTAINER}.
		  
		It's not guarenteed that querying for {SERVICE_PROVIDER} or {SERVICE_CONTAINER} will return
		the global versions of those services. These may also be localized services.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SERVICE_CONTAINER

feature -- Extension

	add_service (a_type: TYPE [ANY]; a_service: SERVICE_I; a_promote: BOOLEAN) is
			-- Add a service `a_service' with a linked association with type `a_type'.
			-- If service is being promoted it will be registered with a parent service provider.
		require
			a_type_attached: a_type /= Void
			a_service_attached: a_service /= Void
			not_proffers_service: not proffers_service (a_type, a_promote)
			service_conforms_to_type: service_conforms_to_type (a_type, a_service)
		deferred
		ensure
			proffers_service: proffers_service (a_type, a_promote)
		end

	add_service_with_activator (a_type: TYPE [ANY]; a_activator: FUNCTION [ANY, TUPLE, SERVICE_I] a_promote: BOOLEAN) is
			-- Adds a delayed activated service for type `a_type', which uses function `a_activator' to instaiates
			-- an instance of service when requested.
			-- If service is being promoted it will be registered with a parent service provider.

		require
			a_type_attached: a_type /= Void
			a_activator_attached: a_activator /= Void
			not_proffers_service: not proffers_service (a_type, a_promote)
		deferred
		ensure
			proffers_service: proffers_service (a_type, a_promote)
		end

feature -- Removal

	revoke_service (a_type: TYPE [ANY]; a_promote: BOOLEAN) is
			-- Removes service associated with type `a_type'.
			-- If a client promote the removal services in a parent container will also be removed.
		require
			a_type_attached: a_type /= Void
		deferred
		ensure
			not_proffers_service: not proffers_service (a_type, a_promote)
		end

feature -- Query

	proffers_service (a_type: TYPE [ANY]; a_promote: BOOLEAN): BOOLEAN is
			-- Determines if service associate with type `a_type' is being proffered.
			-- If a client prompts query then parent containers will be checked if service
			-- is not offerred locally.
		require
			a_type_attached: a_type /= Void
		deferred
		end

	service_conforms_to_type (a_type: TYPE [ANY]; a_service: SERVICE_I): BOOLEAN
			-- Determines if service `a_services' conforms to type `a_type'
			-- Note: This function is only to be used by preconditions and is not meant for client use.
		require
			a_type_attached: a_type /= Void
			a_service_attached: a_service /= Void
		local
			l_internal: INTERNAL
		do
			create l_internal
			Result := l_internal.type_conforms_to (l_internal.dynamic_type (l_internal.type_of (a_service)), l_internal.dynamic_type (a_type))
		end

	type_hash_code (a_type: TYPE [ANY]): STRING_8 is
			-- Retrieves a hash code for type `a_type'
		require
			a_type_attached: a_type /= Void
		do
			Result := a_type.generating_type
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
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

end -- class {SERVICE_CONTAINER}
