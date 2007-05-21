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
	SERVICE_CONTAINER

	SERVICE_CONTAINER_IMPL
		redefine
			add_service,
			add_service_with_activator,
			revoke_service,
			proffers_service
		end

	SITE [SERVICE_CONTAINER]
		export
			{SERVICE_CONTAINER} all
		end

create
	make

feature -- Extension

	add_service (a_type: TYPE [ANY]; a_service: ANY; a_promote: BOOLEAN) is
			-- Add a service `a_service' with a linked association with type `a_type'.
			-- If service is being promoted it will be registered with a parent service provider.
		local
			l_parent: SERVICE_CONTAINER
		do
			l_parent := site
			if a_promote and then l_parent /= Void then
				l_parent.add_service (a_type, a_service, True)
			else
				Precursor {SERVICE_CONTAINER_IMPL} (a_type, a_service, a_promote)
			end
		end

	add_service_with_activator (a_type: TYPE [ANY]; a_activator: FUNCTION [ANY, TUPLE, ANY] a_promote: BOOLEAN) is
			-- Adds a delayed activated service for type `a_type', which uses function `a_activator' to instaiates
			-- an instance of service when requested.
			-- If service is being promoted it will be registered with a parent service provider.
		local
			l_parent: SERVICE_CONTAINER
		do
			l_parent := site
			if a_promote and then l_parent /= Void then
				l_parent.add_service_with_creator (a_type, a_activator, True)
			else
				Precursor {SERVICE_CONTAINER_IMPL} (a_type, a_activator, a_promote)
			end
		end

feature -- Removal

	revoke_service (a_type: TYPE [ANY]; a_promote: BOOLEAN) is
			-- Removes service associated with type `a_type'.
			-- If a client promote the removal services in a parent container will also be removed.
		local
			l_parent: SERVICE_CONTAINER
		do
			if proffers_service (a_type, False) then
				Precursor {SERVICE_CONTAINER_IMPL} (a_type, a_promote)
			elseif a_promote then
				l_parent := site
				if l_parent /= Void then
					l_parent.remove_service (a_type, True)
				end
			end
		end

feature -- Query

	proffers_service (a_type: TYPE [ANY]; a_promote: BOOLEAN): BOOLEAN is
			-- Determines if service associate with type `a_type' is being proffered.
			-- If a client prompts query then parent containers will be checked if service
			-- is not offerred locally.
		local
			l_parent: SERVICE_CONTAINER
		do
			Result := Precursor {SERVICE_CONTAINER_IMPL} (a_type, a_promote)
			if not Result and then a_promote then
				l_parent := site
				if l_parent /= Void then
					Result := l_parent.proffers_service (a_type, True)
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
