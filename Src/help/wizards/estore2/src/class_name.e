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
			Create table_type.make(10)
			Create table_schem.make(10)
			Create remarks.make(10)
			Create table_cat.make(10)
		end

feature -- Implementation

	table_name: STRING
		-- Table Name.

	table_type: STRING

	table_schem: STRING

	table_cat: STRING

	remarks: STRING

end -- class CLASS_NAME
