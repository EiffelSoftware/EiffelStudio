note
	description: "Assembly ids mapping"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ASSEMBLY_MAPPING

feature -- Access

	assembly_mapping: HASH_TABLE [INTEGER, STRING]
			-- Assembly id keyed by assembly full name
		do
			Result := assembly_mapping_cell.item
		end

	referenced_type_from_type (t: SYSTEM_TYPE): CONSUMED_REFERENCED_TYPE
			-- Consumed type from `t'
		require
			non_void_type: t /= Void
		local
			l_name: STRING
			am: like assembly_mapping
			l_type: detachable SYSTEM_TYPE
			l_assembly: detachable ASSEMBLY
			l_full_name: detachable SYSTEM_STRING
		do
			if t.is_by_ref then
				l_type := t.get_element_type
				check l_type_attached: l_type /= Void end
				Result := referenced_type_from_type (l_type)
				Result.set_is_by_ref
			else
				am := assembly_mapping
				l_assembly := t.assembly
				check l_assembly_attached: l_assembly /= Void end
				l_full_name := l_assembly.full_name
				check l_full_name_attached: l_full_name /= Void end
				am.search (l_full_name)
				check found: am.found end
				l_name := t.full_name
				if t.is_array then
					l_type := t.get_element_type
					check l_type_attached: l_type /= Void end
					create {CONSUMED_ARRAY_TYPE} Result.make (
						l_name, am.found_item,
						referenced_type_from_type (l_type))
				else
					create Result.make (l_name, am.found_item)
				end
			end
		end

feature -- Basic Operations

	reset_assembly_mapping
			-- Reset assembly mapping
		do
			assembly_mapping_cell.put (create {HASH_TABLE [INTEGER, STRING]}.make (20))
		end

feature {NONE} -- Implementation

	assembly_mapping_cell: CELL [HASH_TABLE [INTEGER, STRING]]
		once
			create Result.put (create {HASH_TABLE [INTEGER, STRING]}.make (20))
		end

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


end -- class SHARED_ASSEMBLY_MAPPING
