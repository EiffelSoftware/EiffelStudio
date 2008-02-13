indexing
	description: "[
		An ESF interface for implementing "dirty" state preservation on objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_MODIFIABLE_I

inherit
	USABLE_I

feature -- Status report

	is_dirty: BOOLEAN
			-- Indicates if Current contains uncommited modifications.

feature {NONE} -- Status setting

	set_is_dirty (a_dirty: like is_dirty)
			-- Sets Current's dirty state.
			--
			-- `a_dirty': True to change Current to be dirty, False to indicate its clean.
		require
			is_interface_usable: is_interface_usable
		local
			l_old_is_dirty: like is_dirty
		do
			l_old_is_dirty := is_dirty
			if l_old_is_dirty /= a_dirty then
				is_dirty := a_dirty
				dirty_actions.call ([a_dirty])
			end
		ensure
			is_dirty_set: is_dirty = a_dirty
		end

feature -- Events

	dirty_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE [is_dirty: BOOLEAN]]
			-- Actions called when the dirty state changes.
		require
			is_interface_usable: is_interface_usable
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
