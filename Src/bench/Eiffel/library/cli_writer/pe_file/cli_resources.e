indexing
	description: "Container for manifest resources binary stored in memory."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_RESOURCES

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize new instance of CLI_RESOURCES.
		do
			create resources.make (2)
		end

feature -- Access

	item: MANAGED_POINTER is
			-- Concatenation of all resources.
		do
			if not resources.is_empty then
				from
					resources.start
					Result := resources.item.twin
					resources.forth
				until
					resources.after
				loop
					Result.append (resources.item)
					resources.forth
				end
			end
		ensure
			item_valid: not resources.is_empty implies Result /= Void
		end
		
feature -- Status report

	count: INTEGER is
			-- Size of all resources.
		do
			from
				resources.start
			until
				resources.after
			loop
				Result := Result + resources.item.count
				resources.forth
			end
		ensure
			count_positive: Result >= 0
		end

	i_th_position (i: INTEGER): INTEGER is
			-- Position of `i'-th resource in memory.
		require
			valid_index: valid_index (i)
		local
			j: INTEGER
		do
			from
				resources.start
				j := 1
			until
				j = i
			loop
				Result := Result + resources.item.count
				resources.forth
				j := j + 1
			end
		ensure
			i_th_position_positive: Result >= 0
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index?
		do
			Result := resources.valid_index (i)
		end
	
feature -- Settings

	extend (p: MANAGED_POINTER) is
			-- Convenience feature.
		do
			resources.extend (p)
		ensure
			inserted: resources.has (p)
		end		

feature {NONE} -- Implementation: Access

	resources: ARRAYED_LIST [MANAGED_POINTER]
			-- List of all recorded resources.

invariant
	resources_not_void: resources /= Void
	resources_compare_references: not resources.object_comparison

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

end -- class CLI_RESOURCES
