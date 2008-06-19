indexing
	description: "[
		Base implementation for all root or localized service containers.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SERVICE_PROVIDER_CONTAINER

inherit
	SERVICE_CONTAINER_I

	SERVICE_PROVIDER_I

feature {NONE} -- Initialization

	make
			-- Initialize the service container.
		do
			create services.make (13)
		end

feature {NONE} -- Access

	services: !HASH_TABLE [!SERVICE_CONCEALER_I, !HASHABLE]
			-- Local registered services indexed by a service type hash code
			--
			-- Key: Computed type hash using `type_hash'
			-- Value: Service object

feature -- Status report

	is_service_proffered (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN): BOOLEAN
			-- <Precursor>.
		do
			Result := services.has (type_hash (a_type))
		end

feature -- Query

	frozen service (a_type: !TYPE [SERVICE_I]): ?SERVICE_I
			-- <Precursor>
		local
			l_obj: ANY
		do
			l_obj := internal_service (a_type)
			if l_obj /= Void then
				Result := reveal (l_obj)
			end

			if Result /= Void and then {l_provider: !SERVICE_PROVIDER_I} Current and then Result.site /= l_provider then
				Result.site := l_provider
			end
		end

feature {NONE} -- Query

	frozen type_hash (a_type: !TYPE [SERVICE_I]): !HASHABLE
			-- Retrieves a hashable object given a type.
			-- Note: This is added for compatiblity, given that {TYPE} is not yet {HASHABLE}. When this is
			--       changed this feature is to be removed and the type used directly.
			--
			-- `a_type': The service type to retrieve a hashable object for.
			-- `Result': A hashable object to use with `services'.
		do
			if {l_hashable: HASHABLE} a_type then
				Result := l_hashable
			else
				Result ?= a_type.generating_type
			end
		end

	internal_service (a_type: !TYPE [SERVICE_I]): ?ANY
			-- Attempts to retrieve a service or a service concealer ({SERVICE_CONCEALER_I}).
			--
			-- `a_type': The service type to query the `services' table with.
			-- `Result': A service object or a service concealer object.
		do
			if is_service_proffered (a_type, True) then
				Result := services [type_hash (a_type)]
			end
		end

feature -- Extension

	register (a_type: !TYPE [SERVICE_I]; a_service: !SERVICE_I; a_promote: BOOLEAN)
			-- <Precursor>
		do
			services.put (create {SERVICE_STATIC_CONCEALER}.make (a_service), type_hash (a_type))
		end

	register_with_activator (a_type: !TYPE [SERVICE_I]; a_activator: !FUNCTION [ANY, TUPLE, ?SERVICE_I] a_promote: BOOLEAN)
			-- <Precursor>
		do
			services.put (create {SERVICE_DELAYED_CONCEALER}.make (a_activator), type_hash (a_type))
		end

feature -- Removal

	revoke (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN)
			-- <Precursor>
		do
			if is_service_proffered (a_type, False) then
				services.remove (type_hash (a_type))
			end
		end

feature {NONE} -- Basic operations

	reveal (a_obj: !ANY): ?SERVICE_I
			-- Extracts `a_service' from a possible concealed service.s
			--
			-- `a_service': The service to reveal.
			-- `Result': A revealed service or Void is no service could be revealed.
		do
			if {l_concealer: SERVICE_CONCEALER_I} a_obj then
				Result := l_concealer.service
			else
				Result ?= a_obj
			end
		end

;indexing
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

end -- class {SERVICE_PROVIDER_CONTAINER}
