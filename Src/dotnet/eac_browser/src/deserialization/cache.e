indexing
	description: "[
					
				]"
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
		

end -- class CACHE
