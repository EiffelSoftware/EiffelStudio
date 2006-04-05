indexing
	description: "Shared imports, used to resolve external types."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_IMPORTS

inherit
	CODE_SHARED_REFERENCED_ASSEMBLIES
		export
			{NONE} all
		end

feature -- Access

	imports: LIST [STRING] is
			-- Imports
		do
			Result := imports_cell.item
		ensure
			attached_imports: Result /= Void
		end

	found_type: SYSTEM_TYPE
			-- Last type found with `search_type' if any

feature -- Status Report

	found: BOOLEAN
			-- Did last call to `search_type' yield a result?

feature -- Basic Operations

	search_attribute_type (a_name: STRING) is
			-- Search for custom attribute type `a_name'.
			-- Set `found_type' and `found' accordingly.
		require
			attached_name: a_name /= Void
		do
			search_type (a_name)
			if not found then
				search_type (a_name + "Attribute")
			end
		end
		
	search_type (a_name: STRING) is
			-- Search for external type with simple name `a_name' in loaded assemblies and referenced assemblies.
			-- Set `found_type' and `found' accordingly.
		require
			attached_name: a_name /= Void
		local
			l_name, l_import: STRING
			l_imports: LIST [STRING]
		do
			search_type_with_fullname (a_name)
			if not found then
				-- Now search with `System' prefix since CodeDom might
				-- use simple names for basic types (e.g. 'Int32' 'Boolean')
				create l_name.make (a_name.count + 7)
				l_name.append ("System.")
				l_name.append (a_name)
				search_type_with_fullname (l_name)
				if not found then
					l_imports := imports
					if l_imports /= Void and then not l_imports.is_empty then
						from
							l_imports.start
						until
							l_imports.after or found
						loop
							l_import := l_imports.item
							if not l_import.is_equal ("System") then
								create l_name.make (a_name.count + l_import.count + 1)
								l_name.append (l_import)
								l_name.append_character ('.')
								l_name.append (a_name)
								search_type_with_fullname (l_name)
							end
							l_imports.forth
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	imports_cell: CELL [LIST [STRING]] is
			-- Imports cell
		local
			l_list: ARRAYED_LIST [STRING]
		once
			create l_list.make (10)
			l_list.compare_objects
			create Result.put (l_list)
		ensure
			attached_cell: Result /= Void
		end

	search_type_with_fullname (a_name: STRING) is
			-- Search for external type with full name `a_name' in loaded assemblies and referenced assemblies.
		local
			l_type: SYSTEM_TYPE
		do
			l_type := {SYSTEM_TYPE}.get_type (a_name)
			if l_type = Void then
				from
					Referenced_assemblies.start
				until
					Referenced_assemblies.after or l_type /= Void
				loop
					l_type := Referenced_assemblies.item.assembly.get_type (a_name)
					Referenced_assemblies.forth
				end
			end
			found := l_type /= Void
			found_type := l_type
		end
		
invariant
	attached_imports: imports /= Void

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
end -- class CODE_SHARED_IMPORTS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------