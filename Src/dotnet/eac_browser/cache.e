indexing
	description: "[
					
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE

feature -- Access

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
