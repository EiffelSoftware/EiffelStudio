note
	description: "EAC information - serialized"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_INFO

feature -- Access

	assemblies: ARRAYED_LIST [CONSUMED_ASSEMBLY]
			-- Array of assemblies in EAC
		do
			if attached internal_assemblies as l_assemblies then
				Result := l_assemblies
			else
				create Result.make (10)
				Result.compare_objects
				internal_assemblies := Result
			end
		ensure
			assemblies_not_void: Result /= Void
		end

feature -- Status report

	is_dirty: BOOLEAN
			-- Is info ditry?

	has_assembly (ass: detachable CONSUMED_ASSEMBLY): BOOLEAN
			-- Does `assemblies' contain `ass'?
		do
			if ass = Void then
				Result := False
			else
				if attached internal_assemblies as l_assemblies then
					Result := l_assemblies.has (ass)
				else
					Result := False
				end
			end
		end

feature -- Element Settings

	add_assembly (ass: CONSUMED_ASSEMBLY)
			-- Add `ass' to `assemblies'.
		require
			non_void_assembly: ass /= Void
			valid_assembly: not has_assembly (ass)
		do
			assemblies.extend (ass)
			set_is_dirty (True)
		ensure
			is_dirty: is_dirty
		end

	update_assembly (a_assembly: CONSUMED_ASSEMBLY)
			-- Updates `a_assembly' in `assemblies'
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: has_assembly (a_assembly)
		local
			l_assemblies: like assemblies
		do
			l_assemblies := assemblies
			from
				l_assemblies.start
			until
				l_assemblies.after
			loop
				if l_assemblies.item.is_equal (a_assembly) then
					l_assemblies.replace (a_assembly)
					set_is_dirty (True)
					l_assemblies.finish
				end
				l_assemblies.forth
			end
		end

	remove_assembly (ass: CONSUMED_ASSEMBLY)
			-- Remove `ass' from `assemblies'.
		require
			non_void_assembly: ass /= Void
			valid_assembly: assemblies.has (ass)
		do
			assemblies.prune (ass)
			set_is_dirty (True)
		ensure
			removed: not has_assembly (ass)
		end

	set_is_dirty (a_dirty: BOOLEAN)
			-- Sets `is_dirty' with `a_dirty'
		do
			is_dirty := a_dirty
		ensure
			is_dirty_set: is_dirty = a_dirty
		end

feature {NONE} -- Implementation

	internal_assemblies: detachable ARRAYED_LIST [CONSUMED_ASSEMBLY]
			-- Storage for assemblies.

invariant
	non_void_assemblies: assemblies /= Void

note
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
