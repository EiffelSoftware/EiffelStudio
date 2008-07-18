indexing
	description: "[
		Handles services by providing a facade to adding services and a single point to remove all handled services.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SERVICE_HANDLER

inherit
	SERVICE_CONTAINER_I

create
	make

feature {NONE} -- Initialization

	make (a_container: like container) is
			-- Initialize service handler using a service container `a_container'
		require
			container_attached: container /= Void
		do
			container := a_container
		ensure
			container_set: container = a_container
		end

feature -- Extension

	add_service (a_type: TYPE [ANY]; a_service: SERVICE_I; a_promote: BOOLEAN) is
			-- Add a service `a_service' with a linked association with type `a_type'.
			-- If service is being promoted it will be registered with a parent service provider.
		do
			container.add_service (a_type, a_service, a_promote)
			handled_services.extend (a_type)
		ensure then
			handled_services_has_a_type: handled_services.has (a_type)
		end

	add_service_with_activator (a_type: TYPE [ANY]; a_activator: FUNCTION [ANY, TUPLE, SERVICE_I]; a_promote: BOOLEAN) is
			-- Adds a delayed activated service for type `a_type', which uses function `a_activator' to instaiates
			-- an instance of service when requested.
			-- If service is being promoted it will be registered with a parent service provider.
		do
			container.add_service_with_activator (a_type, a_activator, a_promote)
			handled_services.extend (a_type)
		ensure then
			handled_services_has_a_type: handled_services.has (a_type)
		end

feature -- Removal

	revoke_service (a_type: TYPE [ANY]; a_promote: BOOLEAN) is
			-- Removes service associated with type `a_type'.
			-- If a client promote the removal services in a parent container will also be removed.
		local
			l_services: like handled_services
		do
			l_services := handled_services
			container.revoke_service (a_type, a_promote)
			if l_services.has (a_type) then
				l_services.search (a_type)
				if not l_services.exhausted then
					l_services.remove
				end
			end
		ensure then
			not_handled_services_has_a_type: not handled_services.has (a_type)
		end

	revoke_all is
			-- Removes all services that were added using an instance of this handler.
		do
			handled_services.do_all (agent (a_item: TYPE [ANY])
				require
					a_item_attached: a_item /= Void
				do
					revoke_service (a_item, True)
				end)
			handled_services.wipe_out
		end

feature -- Query

	proffers_service (a_type: TYPE [ANY]; a_promote: BOOLEAN): BOOLEAN is
			-- Determines if service associate with type `a_type' is being proffered.
			-- If a client prompts query then parent containers will be checked if service
			-- is not offerred locally.
		do
			Result := container.proffers_service (a_type, a_promote)
		end

feature {NONE} -- Implementation

	container: SERVICE_CONTAINER
			-- Source container to add and remove services on

	handled_services: ARRAYED_LIST [TYPE [ANY]]
			-- List of services handled by `Current'

invariant
	container_attached: container /= Void
	handled_services_attached: handled_services /= Void

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

end -- class {SERVICE_HANDLER}
