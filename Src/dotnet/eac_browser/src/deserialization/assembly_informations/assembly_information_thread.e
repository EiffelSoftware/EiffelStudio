indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	ASSEMBLY_INFORMATION_THREAD

inherit
	THREAD

create
	make

feature -- Initialization

	make (an_assembly: CONSUMED_ASSEMBLY) is
			-- 
		require
			non_void_an_assembly: an_assembly /= Void
		do
			assembly := an_assembly
		ensure
			assembly_set: assembly = an_assembly
		end
		
feature -- Access

	assembly: CONSUMED_ASSEMBLY
			-- Assembly on witch we want informations.

feature -- Implementation

	assembly_path: STRING is "C:\WINNT\Microsoft.NET\Framework\v1.0.3705\"

	execute is
			-- define the deferred feature from THREAD.
		local
			l_assembly_info: ASSEMBLY_INFORMATION
		do
			create l_assembly_info.make (assembly_path + assembly.name + ".xml")
			if l_assembly_info /= Void then
				(create {CACHE}).assemblies_informations.put (l_assembly_info, assembly.out)
			end
		end
		
invariant
	non_void_assembly: assembly /= VOid
	
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


end -- class ASSEMBLY_INFORMATION_THREAD
