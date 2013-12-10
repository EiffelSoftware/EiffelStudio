note
	description : "The controller for in-memory tests."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROLLER

inherit
	ABSTRACT_CONTROLLER
		redefine
				-- Due to the missing filter functionality we'll reduce the selection for in-memory queries.
			selection_count
		end

create
	start_test

feature {NONE} -- Initialization

	create_repository: PS_REPOSITORY
			-- Create a new repository.
		local
			factory: PS_IN_MEMORY_REPOSITORY_FACTORY
		do
			create factory.make
			Result := factory.new_repository
		end

feature

	selection_count: INTEGER = 1
			-- The default number of objects that should be selected by
			-- tests involving queries with criteria.

	result_file: STRING = "../results/memory.csv"
			-- The file (in CSV format) where the results can be stored.

end
