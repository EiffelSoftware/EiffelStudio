indexing
	description: "[
					
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE


feature -- Access
	
	assemblies_informations: HASH_TABLE [ASSEMBLY_INFORMATION, STRING] is
			-- Comments related to an assembly. The key is the {CONSUMED_ASSEMBLY}.out field.
		once
			create Result.make (10)
		ensure
			assemblies_informations_set: Result /= Void
		end
	
	assemblies: LINKED_LIST [CONSUMED_ASSEMBLY] is
			-- linked list of all assemblies contained in EAC. Is initialize during construction of widget tree.
		once
			create Result.make
		ensure
			assemblies_set: Result /= Void
		end

	types: HASH_TABLE [STRING, STRING] is
			-- hash table with key: dotnet_type_name and value: eiffel_type_name
		once
			create Result.make (10000)
		ensure
			non_void_result: Result /= Void
		end

	consumed_types: HASH_TABLE [CONSUMED_TYPE, STRING] is
			-- hash table with key: a_file_name and value: a_consumed_type
		once
			create Result.make (20)
		ensure
			non_void_result: Result /= Void
		end

	deserialize_information_assembly (an_assembly: CONSUMED_ASSEMBLY) is
			-- Deserialize informations of `an_assembly' and store it in `assemblies_informations'.
			-- It would be interesting to launch this process in a Thread.
--		local
--			my_thread: ASSEMBLY_INFORMATION_THREAD
--		do
--			create my_thread.make (an_assembly)
--			my_thread.launch
--		end
		local
			l_assembly_info: ASSEMBLY_INFORMATION
		do
			if not Assemblies_informations.has (an_assembly.out) then
				create l_assembly_info.make
				l_assembly_info.initialize ((create {EAC_COMMON_PATH}).dotnet_framework_path + an_assembly.name + ".xml")
				if l_assembly_info /= Void then
					(create {CACHE}).assemblies_informations.put (l_assembly_info, an_assembly.out)
				end
			end
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


end -- class CACHE
