indexing
	description: "[
					
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE

--create
--	make
--
--feature {NONE} -- Initialization
--
--	make is
--		do
--			create assemblies.make
--		ensure
--			assemblies_set: assemblies /= Void
--		end
--
feature -- Access
	
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

end -- class CACHE
