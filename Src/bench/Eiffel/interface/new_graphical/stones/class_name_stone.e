indexing
	description: "Stone containing an Eiffel class name"
	author: "Sam O'Connor"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLASS_NAME_STONE

feature -- Access

	class_name: STRING is
			-- Name of class associated with current
		deferred
		end
	
end -- class CLASS_NAME_STONE
