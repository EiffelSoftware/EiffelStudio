-- Holds the list of include files to be generated for a given class
-- It prevents from generating twice the same #include in the C code

class
	SHARED_INCLUDE

feature

	shared_include_queue: SEARCH_TABLE [INTEGER] is
		once
			create Result.make (10)
		end

end -- class SHARED_INCLUDE

