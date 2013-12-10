note
	description: "Control file for MySQL performance tests."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROLLER

inherit
	ABSTRACT_CONTROLLER

create
	start_test

feature {NONE} -- Initialization

	create_repository: PS_REPOSITORY
			-- Create a new repository.
		local
			factory: PS_MYSQL_REPOSITORY_FACTORY
		do
			create factory.make
			factory.set_database ("eiffelstoretest")
			factory.set_user ("eiffelstoretest")
			factory.set_password ("eiffelstoretest")
			Result := factory.new_repository
		end

feature -- Access

	result_file: STRING = "../results/mysql.csv"
			-- The file (in CSV format) where the results can be stored.

end