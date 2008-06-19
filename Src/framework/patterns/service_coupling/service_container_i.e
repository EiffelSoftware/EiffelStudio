indexing
	description: "[
		Base implementation for all global and local service containers.
		
		Note: Containers must obey some rules.
		
		* When promoting services must be registed with the global service provider ({SERVICE_HEAP}).
		  Promoting is the act of promoting a service to the highest level possible. This attribute
		  only needs to be respected when using chained containers {SERVICE_CHAINED_CONTAINER}.
		  The global service container may be retrieved using the {SERVICE_CONTAINER_S} service from
		  any service provider {SERVICE_PROVIDER_I}.
		  
		* Services that are not promoted may have a localized versions of the service, if not already
		  proffered. When querying for a service a local service is given priority. Clients are free
		  to query for the global service provider {SERVICE_PROVIDER} or {SERVICE_CONTAINER_I}.
		
		Local service providers should guarenteed querying for {SERVICE_PROVIDER_S} or {SERVICE_CONTAINER_S}
		always will return the global versions of those services!
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SERVICE_CONTAINER_I

feature -- Status report

	is_service_proffered (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN): BOOLEAN
			-- Determines if a service has been registered and is offered for use. I.E. calling `service'
			-- *should* (not guarenteed because of delayed-initialized services) yield a service object.
			--
			-- `a_type': The service type that the service object is associated with.
			-- `a_promote': True to use the global service container; False to use the Current provider
			--              only.
		deferred
		end

feature -- Extension

	register (a_type: !TYPE [SERVICE_I]; a_service: !SERVICE_I; a_promote: BOOLEAN)
			-- Registers a service object using a identifying service type object.
			--
			-- `a_type': The service type that the service object conforms to.
			-- `a_service': The actual service object to register.
			-- `a_promote': True to use the global service container; False to use the Current provider
			--              only. registeration to the global service container to ensure the service
			--              can be queried from all service providers.
		require
			not_proffers_service: not is_service_proffered (a_type, a_promote)
			a_service_conforms_to_a_type: (a_type #? a_service) /= Void
			not_a_type_is_container: is_service_proffered ({SERVICE_CONTAINER_S}, True) implies not a_type.is_equal ({SERVICE_CONTAINER_S})
			not_a_type_is_provider: is_service_proffered ({SERVICE_PROVIDER_S}, True) implies not a_type.is_equal ({SERVICE_PROVIDER_S})
		deferred
		ensure
			is_service_proffered: is_service_proffered (a_type, a_promote)
		end

	register_with_activator (a_type: !TYPE [SERVICE_I]; a_activator: !FUNCTION [ANY, TUPLE, ?SERVICE_I] a_promote: BOOLEAN)
			-- Registers a service activator function, used to create a service on demand, using a
			-- identifying service type object.
			--
			-- `a_type': The service type that the service object conforms to.
			-- `a_activator': The function used to attempt to retrieve a service object.
			-- `a_promote': True to use the global service container; False to use the Current provider
			--              only. registeration to the global service container to ensure the service
			--              can be queried from all service providers.
		require
			not_is_service_proffered: not is_service_proffered (a_type, a_promote)
			not_a_type_is_container: is_service_proffered ({SERVICE_CONTAINER_S}, True) implies not a_type.is_equal ({SERVICE_CONTAINER_S})
			not_a_type_is_provider: is_service_proffered ({SERVICE_PROVIDER_S}, True) implies not a_type.is_equal ({SERVICE_PROVIDER_S})
		deferred
		ensure
			is_service_proffered: is_service_proffered (a_type, a_promote)
		end

feature -- Removal

	revoke (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN)
			-- Revokes a registered service, using the service type object used when registering the service.
			-- Note: This may not actually remove the service object because the service object may have
			--       been registered using mulitple service type objects.
			--
			-- `a_type': The service type that the service object is associated with.
			-- `a_promote': True to use the global service container when removing; False to use the Current
			--              provider only.
		require
			is_service_proffered: is_service_proffered (a_type, a_promote)
			not_a_type_is_container: not a_type.is_equal ({SERVICE_CONTAINER_S})
			not_a_type_is_provider: not a_type.is_equal ({SERVICE_PROVIDER_S})
		deferred
		ensure
			not_is_service_proffered: not is_service_proffered (a_type, a_promote)
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

end -- class {SERVICE_CONTAINER_I}
