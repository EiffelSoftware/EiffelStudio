indexing

	description:
		"Class to represent subquery in a SCROLLABLE_LIST"
	date: "$Date$"
	revision: "$Revision$"


class
	EB_SUBQUERY_ITEM

inherit
	EV_LIST_ITEM

creation
	make_normal, make_first

feature -- Creation

	make_first ( par: EV_LIST; a_subquery: STRING ) is
		do
			!! subquery.make(0)
			subquery := a_subquery
			!! operator.make(0)
			number := 1
			make_with_text (par, value)
		end

	make_normal ( par: EV_LIST; an_operator, a_subquery: STRING; i: INTEGER ) is
		do
			!! subquery.make(0)
			!! operator.make(0)
			subquery := a_subquery
			operator := an_operator
			number := i
			make_with_text (par, value)
		end

feature -- Access

	value : STRING is
		do
			!! Result.make(0)
			Result.append( operator )
			if operator /= "" then
				Result.extend(' ')
			end
			Result.append( subquery )
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
