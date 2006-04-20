indexing
	description:
		"Resource manager. Provide features for registering observers to resources%
		%for them to be notified when resources are changed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_OBSERVATION_MANAGER

inherit
	SHARED_RESOURCES

feature -- Access

	observer_manager: OBSERVER_MANAGEMENT is
			-- Observer manager.
		once
			create Result.make
		end

feature -- Basic operations

	add_observer (s: STRING; w: OBSERVER) is
		-- register w to the resource of name s, if any
		require
			w_exists: w /= Void
		local
			r: RESOURCE
		do
			r := resources.item (s)
			if r /= Void then
				observer_manager.add_observer (r, w)
			end
		end

	remove_observer (s: STRING; w: OBSERVER) is
		-- unregister w to the resource of name s, if any
		require
			w_exists: w /= Void
		local
			r: RESOURCE
		do
			r := resources.item (s)
			if r /= Void then
				observer_manager.remove_observer (r, w)
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

end -- class RESOURCE_OBSERVATION_MANAGER
