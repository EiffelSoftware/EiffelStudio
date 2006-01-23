indexing
	description: "EAC information - serialized"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_INFO

inherit
	SHARED_CLR_VERSION
		export
			{NONE} all
			{ANY} clr_version
		end

create
	make

feature {NONE} -- Initalization

	make is
			-- Initialize `assemblies'.
		local
			di: DIRECTORY_INFO
			info_path: STRING
		do
			info_path := (create {CACHE_READER}).Absolute_info_path
			create di.make (info_path.substring (1, info_path.last_index_of ('\', info_path.count)).to_cil)
			di.create_
			create internal_assemblies.make (1, 0)
			internal_assemblies.compare_objects
		ensure
			non_void_assemblies: assemblies /= Void
		end

feature -- Access

	assemblies: ARRAY [CONSUMED_ASSEMBLY] is
			-- Array of assemblies in EAC
		do
			Result := internal_assemblies
			if Result = Void then
				create Result.make (1, 0)
				internal_assemblies := Result
			end
		ensure
			assemblies_not_void: Result /= Void
		end

feature -- Status report

	is_dirty: BOOLEAN
			-- Is info ditry?

	has_assembly (ass: CONSUMED_ASSEMBLY): BOOLEAN is
			-- Does `assemblies' contain `ass'?
		do
			if ass = Void then
				Result := False
			else
				if internal_assemblies = Void then
					Result := False
				else
					Result := internal_assemblies.has (ass)
				end
			end
		end

feature {CACHE_WRITER} -- Element Settings

	add_assembly (ass: CONSUMED_ASSEMBLY) is
			-- Add `ass' to `assemblies'.
		require
			non_void_assembly: ass /= Void
			valid_assembly: not has_assembly (ass)
		do
			if internal_assemblies = Void then
				create internal_assemblies.make (1, 1)
			end
			internal_assemblies.force (ass, internal_assemblies.count + 1)
			set_is_dirty (True)
		end

	update_assembly (a_assembly: CONSUMED_ASSEMBLY) is
			-- Updates `a_assembly' in `assemblies'
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: has_assembly (a_assembly)
		local
			i, nb: INTEGER
			l_done: BOOLEAN
			l_assemblies: like internal_assemblies
		do
			l_assemblies := internal_assemblies
			from
				i := 1
				nb := l_assemblies.count
			until
				l_done or i > nb
			loop
				if l_assemblies.item (i) /= Void and then l_assemblies.item (i).is_equal (a_assembly) then
					l_assemblies.put (a_assembly, i)
					set_is_dirty (True)
					l_done := True
				else
					i := i + 1
				end
			end
		end

	remove_assembly (ass: CONSUMED_ASSEMBLY) is
			-- Remove `ass' from `assemblies'.
		require
			non_void_assembly: ass /= Void
			valid_assembly: assemblies.has (ass)
		local
			i, nb, j: INTEGER
			new: ARRAY [CONSUMED_ASSEMBLY]
			l_assemblies: like internal_assemblies
		do
			l_assemblies := internal_assemblies
			create new.make (1, l_assemblies.count - 1)
			if l_assemblies.object_comparison then
				new.compare_objects
			end
			from
				i := 1
				j := 1
				nb := l_assemblies.count
			until
				i > nb
			loop
				if l_assemblies.item (i) /= Void and then not l_assemblies.item (i).is_equal (ass) then
					new.put (l_assemblies.item (i), j)
					set_is_dirty (True)
					j := j + 1
				end
				i := i + 1
			end
			internal_assemblies := new
		ensure
			removed: not has_assembly (ass)
		end

	set_is_dirty (a_dirty: BOOLEAN) is
			-- Sets `is_dirty' with `a_dirty'
		do
			is_dirty := a_dirty
		ensure
			is_dirty_set: is_dirty = a_dirty
		end

feature {NONE} -- Implementation

	internal_assemblies: ARRAY [CONSUMED_ASSEMBLY]
			-- Storage for assemblies.

invariant
	non_void_assemblies: assemblies /= Void

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


end -- class CACHE_INFO
