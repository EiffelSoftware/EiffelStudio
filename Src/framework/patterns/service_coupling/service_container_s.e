indexing
	description: "[
		The service interface for retrieving the global service container.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

frozen class
	SERVICE_CONTAINER_S

inherit
	SERVICE_I

	SERVICE_CONTAINER_I

create
	make

feature {NONE} -- Initialization

	make (a_container: !like container)
			-- Initializes the service container service with an actual container.
			--
			-- `a_container': The actual service container use to delegate calls to.			
		do
			container := a_container
		ensure
			container_set: container = a_container
		end

feature {NONE} -- Access

	container: !SERVICE_CONTAINER_I
			-- Actual service container to perform operations on.

feature -- Extension

	register (a_type: !TYPE [SERVICE_I]; a_service: !SERVICE_I; a_promote: BOOLEAN)
			-- <Precursor>
		do
			container.register (a_type, a_service, a_promote)
		end

	register_with_activator (a_type: !TYPE [SERVICE_I]; a_activator: !FUNCTION [ANY, TUPLE, ?SERVICE_I] a_promote: BOOLEAN)
			-- <Precursor>
		do
			container.register_with_activator (a_type, a_activator, a_promote)
		end

feature -- Removal

	revoke (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN)
			-- <Precursor>
		do
			container.revoke (a_type, a_promote)
		end

feature -- Query

	is_service_proffered (a_type: !TYPE [SERVICE_I]; a_promote: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			Result := container.is_service_proffered (a_type, a_promote)
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

end

