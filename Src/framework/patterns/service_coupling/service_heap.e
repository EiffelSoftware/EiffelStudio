indexing
	description: "[
		Global service container and service provider.
		
		Note: There should only be one of these per application. Please use {SHARED_SERVICE_PROVIDER} to access the 
		global service provider. From there query for the {SERVICE_CONTAINER_I} service to add services to the heap.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SERVICE_HEAP

inherit
	SERVICE_PROVIDER_CONTAINER
		rename
			register as provider_register,
			register_with_activator as provider_register_with_activator,
			revoke as provider_revoke,
			is_service_proffered as provider_is_service_proffered
		export {NONE}
			provider_register,
			provider_register_with_activator,
			provider_revoke,
			provider_is_service_proffered
		redefine
			internal_service
		end

create {SHARED_SERVICE_PROVIDER, SERVICE_HEAP}
	make

feature -- Status report

	is_service_proffered (a_type: !TYPE [SERVICE_I]): BOOLEAN
			-- Determines if a service has been registered and is offered for use. I.E. calling `service'
			-- *should* (not guarenteed because of delayed-initialized services) yield a service object.
			--
			-- `a_type': The service type that the service object is associated with.
			-- `a_promote': True to use the global service container; False to use the Current provider
			--              only.
		do
			Result := provider_is_service_proffered (a_type, False)
		end

feature -- Extension

	register (a_type: !TYPE [SERVICE_I]; a_service: !SERVICE_I)
			-- Registers a service object using a identifying service type object.
			--
			-- `a_type': The service type that the service object conforms to.
			-- `a_service': The actual service object to register.
		require
			not_is_service_proffered: not is_service_proffered (a_type)
			a_service_conforms_to_a_type: (a_type #? a_service) /= Void
		do
			provider_register (a_type, a_service, False)
		ensure
			is_service_proffered: is_service_proffered (a_type)
		end

	register_with_activator (a_type: !TYPE [SERVICE_I]; a_activator: !FUNCTION [ANY, TUPLE, ?SERVICE_I])
			-- Registers a service activator function, used to create a service on demand, using a
			-- identifying service type object.
			--
			-- `a_type': The service type that the service object conforms to.
			-- `a_activator': The function used to attempt to retrieve a service object.
		require
			not_is_service_proffered: not is_service_proffered (a_type)
		do
			provider_register_with_activator (a_type, a_activator, False)
		ensure
			is_service_proffered: is_service_proffered (a_type)
		end

feature -- Removal

	revoke (a_type: !TYPE [SERVICE_I])
			-- Revokes a registered service, using the service type object used when registering the service.
			-- Note: This may not actually remove the service object because the service object may have
			--       been registered using mulitple service type objects.
			--
			-- `a_type': The service type that the service object is associated with.
		require
			is_service_proffered: is_service_proffered (a_type)
		do
			provider_revoke (a_type, False)
		ensure
			not_is_service_proffered: not is_service_proffered (a_type)
		end

feature -- Query

	internal_service (a_type: !TYPE [SERVICE_I]): ?ANY
			-- <Precursor>
		do
			if is_service_proffered (a_type) then
				Result := services [type_hash (a_type)]
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class {SERVICE_HEAP}
