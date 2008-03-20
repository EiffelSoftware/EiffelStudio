indexing
	description: "[
		Base implementation for all root or localized service containers.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SERVICE_CONTAINER_IMPL

inherit
	SERVICE_CONTAINER

	SERVICE_PROVIDER

feature {NONE} -- Initialization

	make is
			-- Initialize a local service container
		do
			create services.make (3)
		end

feature -- Extension

	add_service (a_type: TYPE [ANY]; a_service: SERVICE_I; a_promote: BOOLEAN) is
			-- Add a service `a_service' with a linked association with type `a_type'.
			-- If service is being promoted it will be registered with a parent service provider.
		do
			services.put (create {SERVICE_STATIC_CONCEALER}.make (a_service), type_hash_code (a_type))
		end

	add_service_with_activator (a_type: TYPE [ANY]; a_activator: FUNCTION [ANY, TUPLE, SERVICE_I] a_promote: BOOLEAN) is
			-- Adds a delayed activated service for type `a_type', which uses function `a_activator' to instaiates
			-- an instance of service when requested.
			-- If service is being promoted it will be registered with a parent service provider.
		do
			services.put (create {SERVICE_DELAYED_CONCEALER}.make (a_activator), type_hash_code (a_type))
		end

feature -- Removal

	revoke_service (a_type: TYPE [ANY]; a_promote: BOOLEAN) is
			-- Removes service associated with type `a_type'.
			-- If a client promote the removal services in a parent container will also be removed.
		do
			if proffers_service (a_type, False) then
				services.remove (type_hash_code (a_type))
			end
		end

feature -- Query

	proffers_service (a_type: TYPE [ANY]; a_promote: BOOLEAN): BOOLEAN is
			-- Determines if service associate with type `a_type' is being proffered.
			-- If a client prompts query then parent containers will be checked if service
			-- is not offerred locally.
		do
			Result := services.has (type_hash_code (a_type))
		end

feature -- Query

	frozen query_service (a_type: TYPE [ANY]): SERVICE_I
			-- Queries for service `a_type' and returns result if service was found on Current
		local
			l_obj: ANY
		do
			l_obj := internal_query_service (a_type)
			if l_obj /= Void then
				Result := reveal_service (l_obj)
			end

			if Result /= Void and then {l_provider: !SERVICE_PROVIDER} Current and then Result.site /= l_provider then
				Result.site := l_provider
			end
		ensure then
				-- If this contract is violated when you need to reveal the service. See `reveal_service'
			not_result_is_concealer: Result /= Void implies (({SERVICE_CONCEALER}) #? Result) = Void
		end

feature {NONE} -- Query

	internal_query_service (a_type: TYPE [ANY]): ANY
			-- Queries for service `a_type' and returns result if service was found on Current.
			--
			-- Note: Typically will retrieve a concealed service as the result, which must be
			--       revealed using `reveal_service'
		require
			a_type_attached: a_type /= Void
		do
			if proffers_service (a_type, True) then
				Result := services [type_hash_code (a_type)]
			end
		end

feature {NONE} -- Basic operations

	reveal_service (a_service: ANY): SERVICE_I
			-- Extracts `a_service' from a possible concealed service.s
			--
			-- `a_service': The service to reveal.
			-- `Result': A revealed service or Void is no service could be revealed.
		require
			a_service_attached: a_service /= Void
		local
			l_concealer: SERVICE_CONCEALER
		do
			l_concealer ?= a_service
			if l_concealer = Void then
				Result ?= a_service
			else
					-- Reveal service
				Result := l_concealer.service
			end
		end

feature {NONE} -- Implementation

	services: HASH_TABLE [SERVICE_CONCEALER, STRING_8]
			-- Local registered services indexed by a service type hash code
			-- Key: Computed type hash code using `type_hash_code'
			-- Value: Service object

invariant
	services_attached: services /= Void

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

end -- class {SERVICE_CONTAINER_IMPL}
