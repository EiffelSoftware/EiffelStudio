indexing
	description: "Class which encapsulates a class name reference."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_NAME

Creation
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			Create table_name.make(10)
		end

feature -- Implementation

	table_name: STRING
		-- Table Name.

end -- class CLASS_NAME
