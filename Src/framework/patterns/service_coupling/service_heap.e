indexing
	description: "[
		Global service container and service provider.
		
		Note: There should only be one of these per application. Please use {SHARED_SERVICE_PROVIDER} to access the 
		global service provider. From there query for the {SERVICE_CONTAINER} service to add services to the heap.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SERVICE_HEAP

inherit
	SERVICE_I

	SERVICE_CONTAINER_IMPL
		rename
			add_service as provider_add_service,
			add_service_with_activator as provider_add_service_with_activator,
			revoke_service as provider_revoke_service,
			proffers_service as provider_proffers_service
		export {NONE}
			provider_add_service,
			provider_add_service_with_activator,
			provider_revoke_service,
			provider_proffers_service
		redefine
			internal_query_service
		end

	SERVICE_PROVIDER

create {SHARED_SERVICE_PROVIDER}
	make

feature -- Extension

	add_service (a_type: TYPE [ANY]; a_service: SERVICE_I) is
			-- Add a service `a_service' with a linked association with type `a_type'.
		require
			a_type_attached: a_type /= Void
			a_service_attached: a_service /= Void
			not_proffers_service: not proffers_service (a_type)
			service_conforms_to_type: service_conforms_to_type (a_type, a_service)
		do
			provider_add_service (a_type, a_service, False)
		ensure
			proffers_service: proffers_service (a_type)
		end

	add_service_with_activator (a_type: TYPE [ANY]; a_activator: FUNCTION [ANY, TUPLE, SERVICE_I]) is
			-- Adds a delayed activated service for type `a_type', which uses function `a_activator' to instanciate
			-- an instance of service when requested.
		require
			a_type_attached: a_type /= Void
			a_activator_attached: a_activator /= Void
			not_proffers_service: not proffers_service (a_type)
		do
			provider_add_service_with_activator (a_type, a_activator, False)
		ensure
			proffers_service: proffers_service (a_type)
		end

feature -- Removal

	revoke_service (a_type: TYPE [ANY]) is
			-- Removes service associated with type `a_type'.
			-- If a client promote the removal services in a parent container will also be removed.
		require
			a_type_attached: a_type /= Void
		do
			provider_revoke_service (a_type, False)
		ensure
			not_proffers_service: not proffers_service (a_type)
		end

feature -- Query

	proffers_service (a_type: TYPE [ANY]): BOOLEAN is
			-- Determines if service associate with type `a_type' is being proffered.
		require
			a_type_attached: a_type /= Void
		do
			Result := provider_proffers_service (a_type, False)
		end

feature -- Query

	internal_query_service (a_type: TYPE [ANY]): ANY
			-- Queries for service `a_type' and returns result if service was found on Current.
			--
			-- Note: Typically will retrieve a concealed service as the result, which must be
			--       revealed using `reveal_service'
		do
			if proffers_service (a_type) then
				Result := services [type_hash_code (a_type)]
			end
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

end -- class {SERVICE_HEAP}
