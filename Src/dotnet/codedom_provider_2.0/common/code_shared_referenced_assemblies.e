indexing
	description:	"Codedom referenced assemblies."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date:			"$Date$"
	revision:		"$Revision$"

class
	CODE_SHARED_REFERENCED_ASSEMBLIES

inherit
	CODE_CONFIGURATION
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature -- Access

	Referenced_assemblies: CODE_REFERENCES_LIST is
			-- List of assemblies used by codeDOM
		once
			create Result.make (16)
		ensure
			non_void_result: Result /= Void
		end		

	Default_assemblies: ARRAY [STRING] is
			-- Default assemblies added with `add_default_assemblies'
		once
			Result := <<"mscorlib.dll", "system.dll", "system.xml.dll">>
		end
	
feature -- Status Setting

	add_default_assemblies is
			-- Add mscorlib, system and system.xml if not already in list.
		local
			i, l_count: INTEGER
			l_assembly: STRING
		do
			from
				l_count := Default_assemblies.count
				i := 1
			until
				i > l_count
			loop
				l_assembly := Default_assemblies.item (i)
				if not Referenced_assemblies.has_file (l_assembly) then
					Referenced_assemblies.extend_file (l_assembly)
				end
				i := i + 1
			end
		end
		
	reset is
			-- Reset content of `Referenced_assemblies'.
		do
			Referenced_assemblies.wipe_out
			Referenced_assemblies.extend_file ("mscorlib.dll")
		end

invariant
	non_void_default_assemblies: Default_assemblies /= Void
	non_void_referenced_assemblies: Referenced_assemblies /= Void

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
end -- Class CODE_SHARED_REFERENCED_ASSEMBLIES

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