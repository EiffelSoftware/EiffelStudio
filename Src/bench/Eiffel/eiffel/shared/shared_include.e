-- Holds the list of include files to be generated for a given class
-- It prevents from generating twice the same #include in the C code

class
	SHARED_INCLUDE

feature

	shared_include_queue: LINKED_QUEUE [STRING] is
		once
			!! Result.make
			Result.compare_objects
		end

end -- class SHARED_INCLUDE

