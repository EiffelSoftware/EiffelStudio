indexing
	description: "Class enabling to retrieve content of%
		%Oracle table USER_CONS_COLUMNS."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	USER_CONS_COLUMNS

create
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create owner.make (30)
			create constraint_name.make (30)
			create table_name.make (30)
			create column_name.make (4000)
		end

feature -- Implementation

	owner: STRING

	constraint_name: STRING

	table_name: STRING

	column_name: STRING

	position: INTEGER
	
end -- class USER_CONS_COLUMNS
