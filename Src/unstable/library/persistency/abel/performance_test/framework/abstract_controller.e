note
	description: "Common code for performance test controllers."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_CONTROLLER


feature {NONE} -- Initialization

	start_test
			-- Run application.
		local
			test: EXECUTOR
		do
			repository := create_repository
			create test.make (Current)
			test.perform_tests
		end

	create_repository: PS_REPOSITORY
			-- Create a new repository.
		deferred
		end


feature -- Access

	object_count: INTEGER
			-- The default number of objects in the database.
		do
			Result := 100000
		end

	selection_count: INTEGER
			-- The default number of objects that should be selected by
			-- tests involving queries with criteria.
		do
			Result := 10
		end

	repository: PS_REPOSITORY
		-- The repository on which the  tests should be run.


	result_file: STRING
			-- The file (in CSV format) where the results can be stored.
		deferred
		end

end
