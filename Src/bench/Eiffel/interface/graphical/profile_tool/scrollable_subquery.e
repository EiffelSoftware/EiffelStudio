indexing

	description:
		"Class to represent subquery in a SCROLLABLE_LIST";
	date: "$Date$";
	revision: "$Revision$"


class
	SCROLLABLE_SUBQUERY

inherit
	SCROLLABLE_LIST_ELEMENT

create
	make, make_first

feature -- Creation

	make_first ( a_subquery: STRING ) is
		do
			create subquery.make(0)
			subquery := a_subquery
			create operator.make(0)
			index := 1
		end

	make ( an_operator, a_subquery: STRING; i: INTEGER ) is
		do
			create subquery.make(0)
			create operator.make(0)
			subquery := a_subquery
			operator := an_operator
			index := i
		end

feature -- Access

	value : STRING is
		do
			create Result.make(0)
			Result.append( operator )
			if operator /= "" then
				Result.extend(' ')
			end
			Result.append( subquery )
		end
	
	set_index (idx: INTEGER) is
		do
			index := idx
		end

feature -- Attributes

	operator,
		-- boolean operator

	subquery: STRING
		-- the subquery

	index: INTEGER
		-- index of the subquery in the query

end -- SCROLLABLE_SUBQUERY
