--| Guillaume - 09/26/97... NEW CLASS!!!!!



class
	SCROLLABLE_SUBQUERY

inherit
	SCROLLABLE_LIST_ELEMENT

creation
	make, make_first, make_with_operator

feature -- Creation

	make is
		do
			!! subquery.make(0)
			!! operator.make(0)
			index := 1
		end

	make_first ( a_subquery: STRING ) is
		do
			!! subquery.make(0)
			subquery := a_subquery
			!! operator.make(0)
			index := 1
		end

	make_with_operator ( an_operator, a_subquery: STRING; i: INTEGER ) is
		do
			!! subquery.make(0)
			!! operator.make(0)
			subquery := a_subquery
			operator := an_operator
			index := i
		end

feature -- Access

	value : STRING is
		do
			!! Result.make(0)
			Result.append( operator )
			Result.extend(' ')
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
