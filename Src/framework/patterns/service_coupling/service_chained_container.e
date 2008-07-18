indexing
	description: "[
		A service container that can be sited with a parent container to promote services to higher container.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SERVICE_CHAINED_CONTAINER

inherit
	SITE [SERVICE_CONTAINER_I]
		export
			{SERVICE_CONTAINER_I} all
		end

	SERVICE_PROVIDER_CONTAINER
		redefine
			register,
			register_with_activator,
			revoke,
			is_service_proffered
		end

create
	make

feature -- Extension

	register (a_type: !TYPE [SERVICE_I]; a_service: !SERVICE_I; a_promote: BOOLEAN)
			-- <Precursor>
		do
			if a_promote and then {l_container: SERVICE_CONTAINER_I} site then
				l_container.add_service (a_type, a_service, True)
			else
				Precursor {SERVICE_PROVIDER_CONTAINER} (a_type, a_service, False)
			end
		end

	register_with_activator (a_type: !TYPE [SERVICE_I]; a_activator: !FUNCTION [ANY, TUPLE, ?SERVICE_I] a_promote: BOOLEAN)
			-- <Precursor>
		do
			if a_promote and then {l_container: SERVICE_CONTAINER_I} site then
				l_container.add_service_with_creator (a_type, a_activator, True)
			else
				Precursor {SERVICE_PROVIDER_CONTAINER} (a_type, a_activator, False)
			end
		end

feature -- Removal

	revoke (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN)
			-- <Precursor>
		do
			if proffers_service (a_type, False) then
				Precursor {SERVICE_PROVIDER_CONTAINER} (a_type, a_promote)
			elseif a_promote and then {l_container: SERVICE_CONTAINER_I} site then
				l_container.revoke (a_type, True)
			end
		end

feature -- Query

	is_service_proffered (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {SERVICE_PROVIDER_CONTAINER} (a_type, a_promote)
			if not Result and then a_promote then
				if {l_container: SERVICE_CONTAINER_I} site then
					Result := l_container.is_service_proffered (a_type, True)
				end
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

end -- class {SERVICE_CHAINED_CONTAINER}
