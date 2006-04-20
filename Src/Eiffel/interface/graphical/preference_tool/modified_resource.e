indexing

	description:
		"A resource that has been modified."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MODIFIED_RESOURCE

create
	make

feature {NONE} -- Initialization

	make (old_res, new_res: RESOURCE) is
			-- Initialize Current with `old_resource' as `old', and
			-- `new_resource' as `new'.
		require
			old_res_not_void: old_res /= Void;
			new_res_not_void: new_res /= Void
		do
			old_resource := old_res;
			new_resource := new_res
		end

feature -- Setting

	set_old_resource (a_resource: RESOURCE) is
			-- Set `old_resource' to `a_resource'.
		require
			a_resource_not_void: a_resource /= Void
		do
			old_resource := a_resource
		ensure
			old_resource_set: old_resource.is_equal (a_resource)
		end;

	set_new_resource (a_resource: RESOURCE) is
			-- Set `new_resource' to `a_resource'.
		require
			a_resource_not_void: a_resource /= Void
		do
			new_resource := a_resource
		ensure
			new_resource_set: new_resource.is_equal (a_resource)
		end

feature -- Properties

	old_resource: RESOURCE;
			-- The resource as before the modification

	new_resource: RESOURCE
			-- The resource as after the modification

invariant

	old_resource_not_void: old_resource /= Void;
	new_resource_not_void: new_resource /= Void

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

end -- class MODIFIED_RESOURCE
