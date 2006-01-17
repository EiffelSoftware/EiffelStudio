indexing
	description: "Abstract notion of a category of resources."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class RESOURCE_CATEGORY

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		deferred
		end

feature -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources for Current.
		require
			rt_valid: rt /= Void
		deferred
		end

feature -- Status report

	page_number: INTEGER 
			-- Page number of category in preference tool

feature -- Status setting

	set_page_number (a_nbr: INTEGER) is
			-- Set `page_number' to `a_nbr'.
		require
			position_nbr: a_nbr > 0
		do
			page_number := a_nbr
		ensure
			set: page_number = a_nbr
		end;

feature -- Access

	users: LINKED_LIST [RESOURCE_USER];
			-- Users of Current

	add_user (a_user: RESOURCE_USER) is
			-- Add `a_user' to `users'.
		do
			users.extend (a_user)
		end;

	modified_resources: LINKED_LIST [CELL2 [RESOURCE, RESOURCE]];
			-- Modified resources for Current

	add_modified_resource (a_modified_resource: CELL2 [RESOURCE, RESOURCE]) is
			-- Add `a_modified_resource' to `a_modified_resources'.
		require
			a_modified_resource_not_void: a_modified_resource /= Void
			a_modified_resource_is_valid:
				a_modified_resource.item1 /= Void and
				a_modified_resource.item2 /= Void
		do
			modified_resources.extend (a_modified_resource)
		end;

feature -- Update

	update is
			-- Update all users to reflect Current.
		do
			from
				modified_resources.start
			until
				modified_resources.after
			loop
				from
					users.start
				until
					users.after
				loop
					users.item.dispatch_modified_resource (modified_resources.item.item1, modified_resources.item.item2);
					users.forth
				end;
				modified_resources.forth
			end
			from
				users.start
			until
				users.after
			loop
				users.item.finish_update;
				users.forth
			end;
			modified_resources.wipe_out
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class RESOURCE_CATEGORY
