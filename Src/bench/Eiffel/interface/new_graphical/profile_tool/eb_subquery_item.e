indexing
	description	: "Class to represent subquery in a EV_MULTI_COLUMN_LIST"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SUBQUERY_ITEM

inherit
	EV_MULTI_COLUMN_LIST_ROW

creation
	make_normal, make_first

feature -- Creation

	make_first (a_subquery: STRING) is
		do
			create subquery.make (0)
			subquery := a_subquery
			create operator.make (0)
			number := 1
			default_create
			extend (value)
		end

	make_normal (an_operator, a_subquery: STRING; i: INTEGER) is
		do
			create subquery.make (0)
			create operator.make (0)
			subquery := a_subquery
			operator := an_operator
			number := i
			default_create
			extend (value)
		end

feature -- Access

	value : STRING is
		do
			create Result.make (0)
			Result.append (operator)
			if operator /= "" then
				Result.extend (' ')
			end
			Result.append (subquery)
		end
	
	set_number (idx: INTEGER) is
		do
			number := idx
		end

feature -- Attributes

	operator,
		-- boolean operator

	subquery: STRING
		-- the subquery

	number: INTEGER
		-- index of the subquery in the query

end -- class EB_SUBQUERY_ITEM
