indexing
	description: "Class describing the notion of a query, that is %
				% either an attribute or a function without argument."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_QUERY

inherit

	SCROLLABLE_LIST_ELEMENT

creation
	make

feature -- Creation

	make (q_name, q_type: STRING) is
			-- Create a query with name `q_name' and returned
			-- type `q_type'.
		require
			valid_query_name: q_name /= Void and then not q_name.empty
			valid_query_type: q_type /= Void and then not q_type.empty
		do
			query_name := q_name
			query_type := q_type
		end

feature -- Attributes

	query_name: STRING
			-- Name of query

	query_type: STRING
			-- Name of the returned type

feature

	value: STRING is
			-- Value displayed in a scrollable list.
		do
			!! Result.make (10)
			Result.append (query_name)
			Result.append (": ")
			Result.append (query_type)
		end

end -- class APPLICATION_QUERY
