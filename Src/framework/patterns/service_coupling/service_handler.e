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

	make (a_container: like container)
			-- Initialize service handler using an existing service container.
			--
			-- `a_container': The service container to use as the implementation container for Current.
		do
			create handled_services.make (1)
			handled_services.compare_objects
			container := a_container
		ensure
			container_set: container = a_container
		end

feature {NONE} -- Access

	container: !SERVICE_CONTAINER_I
			-- Source container to add and remove services on.

	handled_services: !ARRAYED_LIST [!TUPLE [service: !TYPE [SERVICE_I]; promote: BOOLEAN]]
			-- List of services handled by `Current'

feature -- Status report

	is_service_proffered (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			Result := container.is_service_proffered (a_type, a_promote)
		ensure then
			handled_services_has_service: Result implies handled_services.has ([a_type, a_promote])
		end

feature -- Extension

	register (a_type: !TYPE [SERVICE_I]; a_service: !SERVICE_I; a_promote: BOOLEAN)
			-- <Precursor>
		do
			container.register (a_type, a_service, a_promote)
			handled_services.extend ([a_type, a_promote])
		ensure then
			handled_services_has_a_type: handled_services.has ([a_type, a_promote])
		end

	register_with_activator (a_type: !TYPE [SERVICE_I]; a_activator: !FUNCTION [ANY, TUPLE, ?SERVICE_I] a_promote: BOOLEAN)
			-- <Precursor>
		do
			container.register_with_activator (a_type, a_activator, a_promote)
			handled_services.extend ([a_type, a_promote])
		ensure then
			handled_services_has_a_type: handled_services.has ([a_type, a_promote])
		end

feature -- Removal

	revoke (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN)
			-- <Precursor>
		local
			l_services: like handled_services
		do
			container.revoke (a_type, a_promote)
			l_services := handled_services
			l_services.search ([a_type, a_promote])
			if not l_services.exhausted then
				l_services.remove
			end
		ensure then
			not_handled_services_has_a_type: not handled_services.has ([a_type, a_promote])
		end

	revoke_all
			-- Removes all services that were added using an instance of this handler.
		local
			l_services: like handled_services
			l_service: !TUPLE [service: !TYPE [SERVICE_I]; promote: BOOLEAN]
		do
			l_services := handled_services
			from l_services.start until l_services.after loop
				l_service := l_services.item_for_iteration
				revoke (l_service.service, l_service.promote)
			end
			l_services.wipe_out
		ensure then
			handled_services_is_empty: handled_services.is_empty
		end

invariant
	handled_services_compares_objects: handled_services.object_comparison

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
