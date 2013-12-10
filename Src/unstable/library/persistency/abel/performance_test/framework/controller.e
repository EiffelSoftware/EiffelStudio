note
	description : "framework application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	CONTROLLER

create
	start_test

feature {NONE} -- Initialization

	start_test
			-- Run application.
		local
			test: EXECUTOR
			factory: PS_IN_MEMORY_REPOSITORY_FACTORY
		do
			--| Add your code here
			create factory.make
			repository := factory.new_repository
			create result_file.make_from_string ("../whatever.csv")
			create test.make (Current)
			test.perform_tests


--			print ("Hello Eiffel World!%N")
		end

feature

	object_count: INTEGER = 100

	selection_count: INTEGER = 10

	repository: PS_REPOSITORY

	result_file: FILE_NAME

end
