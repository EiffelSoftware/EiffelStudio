indexing
	description: "Objects that handle object id's in Build."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_ID

create
	make_with_components

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			current_id_counter := 1
		ensure
			components_set: components = a_components
		end

feature -- Status setting

	reset_id_counter is
			-- Reset `counter' to 1.
			-- This forces object ids to start
			-- at one again. Should be performed
			-- when closing an open project.
		do
			set_current_id_counter (1)
		end

feature -- Basic operations

	new_id: INTEGER is
			-- `Result' is a new id.
		do
			Result := current_id_counter
			set_current_id_counter (Result + 1)
		ensure
			result_positive: Result > 0
		end

	set_current_id_counter (value: INTEGER) is
			-- Set `value' to `internal_counter'.
		do
			current_id_counter := value
		end

	current_id_counter: INTEGER;
			-- `Result' is value of `internal_counter'.

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


end -- class GB_SHARED_ID
