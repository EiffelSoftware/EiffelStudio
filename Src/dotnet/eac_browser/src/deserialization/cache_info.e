indexing
	description: "EAC information - serialized"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_INFO

create
	make

feature {NONE} -- Initalization

	make is
			-- Initialize `assemblies'.
		local
		do
		ensure
		end
		
feature -- Access

	assemblies: ARRAY [CONSUMED_ASSEMBLY]
			-- Array of assemblies in EAC

feature {CACHE_WRITER} -- Element Settings
	
	add_assembly (ass: CONSUMED_ASSEMBLY) is
			-- Add `ass' to `assemblies'.
		require
			non_void_assembly: ass /= Void
			valid_assembly: not assemblies.has (ass)
		do
			assemblies.force (ass, assemblies.count + 1)
		end

	remove_assembly (ass: CONSUMED_ASSEMBLY) is
			-- Remove `ass' from `assemblies'.
		require
			non_void_assembly: ass /= Void
			valid_assembly: assemblies.has (ass)
		local
			i, j: INTEGER
			new: ARRAY [CONSUMED_ASSEMBLY]
		do
			create new.make (1, assemblies.count - 1)
			from
				i := 1
				j := 1
			until
				i > assemblies.count
			loop
				if not assemblies.item (i).is_equal (ass) then
					new.put (assemblies.item (i), j)
					j := j + 1
				end
				i := i + 1
			end
			assemblies := new
		ensure
			removed: not assemblies.has (ass)
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


end -- class CACHE_INFO
