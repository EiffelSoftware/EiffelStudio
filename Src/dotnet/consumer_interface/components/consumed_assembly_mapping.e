note
	description: "Mapping between referenced assemblies and ids"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CONSUMED_ASSEMBLY_MAPPING

create
	make

feature {NONE} -- Initialization

	make (assembly_ids: LIST [CONSUMED_ASSEMBLY])
			-- Set `assemblies' with `assembly_ids'.
		require
			non_void_ids: assembly_ids /= Void
		do
			create assemblies.make (assembly_ids.count)
			assemblies.compare_objects
			across
				assembly_ids as a
			loop
				assemblies.extend (a)
				if attached {CONSUMED_ASSEMBLY} a as l_a and then
					l_a.name.is_case_insensitive_equal ("system.runtime")
				then
					system_runtime_assembly := a
				end
			end
		end

feature -- Access

	assemblies: ARRAYED_LIST [CONSUMED_ASSEMBLY]
			-- Referenced assemblies indexed by id

	system_runtime_assembly: detachable CONSUMED_ASSEMBLY


invariant
	attached_assemblies: assemblies /= Void

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


end -- class CONSUMED_ASSEMBLY_MAPPING
