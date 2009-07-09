indexing
	description: "[
		Abstract inferface for tools/UI where stones can set and synchronized.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	HISTORY_MANAGER_S

inherit
	SERVICE_I

feature -- Query

	history_manager (a_kind: attached UUID): attached HISTORY_CONTAINER_I
			-- Retrieve a shared history manager.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

feature --

	new_isolated_history_container: attached HISTORY_CONTAINER_I
			-- Creates a new isolate history container for tools and services that utilize a single
			-- history container.
			-- For tools and services that need
		deferred
		end

	new_history_container: attached HISTORY_CONTAINER_I
		deferred
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
