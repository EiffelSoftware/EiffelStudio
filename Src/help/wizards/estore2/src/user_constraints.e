indexing
	description: "Class enabling to retrieve content of%
		%Oracle table USER_CONSTRAINTS."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	USER_CONSTRAINTS

create
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create owner.make (30)
			create constraint_name.make (30)
			create constraint_type.make (1)
			create table_name.make (30)
			create r_owner.make (30)
			create r_constraint_name.make (30)
			create delete_rule.make (9)
			create status.make (8)
			create deferrable.make (14)
				-- This attribute is an Eiffel reserved word: removed
				-- as not needed.
	--		create deferred.make (9)
			create validated.make (13)
			create generated.make (14)
			create bad.make (3)
			create rely.make (4)
			create last_change.make_now
		end

feature -- Implementation

	owner: STRING

	constraint_name: STRING

	constraint_type: STRING

	table_name: STRING

	search_condition: INTEGER

	r_owner: STRING

	r_constraint_name: STRING

	delete_rule: STRING

	status: STRING

	deferrable: STRING

	--deferred: STRING
	-- This attribute is an Eiffel reserved word: removed
	-- as not needed.

	validated: STRING

	generated: STRING

	bad: STRING

	rely: STRING

	last_change: DATE_TIME
	
end -- class USER_CONSTRAINTS
