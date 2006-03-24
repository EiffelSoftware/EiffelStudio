indexing
	description: "Object that represents a resultset from an EQL query"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_RESULT [G -> EQL_RESULT_ITEM]

inherit
	EQL_TREE_NODE [G]
		rename
			make as tree_node_make
		redefine
			itr,
			distinct_itr,
			modification_count,
			increase_modification_count
		end

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			node_list_make
			root_node := Current
		end

feature -- Iterator

	itr: EQL_RESULT_ITERATOR [G] is
			-- Iterator for Current
		do
			create Result.make (Current)
		end

	distinct_itr: EQL_DISTINCT_RESULT_ITERATOR [G] is
			-- Distinct iterator
		do
			create Result.make (Current)
		end

feature{EQL_ITERATOR} -- Modification counter

	modification_count: NATURAL_64
			-- Count of modification, used by fail fast iterators

feature{EQL_TREE_NODE} -- Modification counter operation

	increase_modification_count is
			-- Increase `modification_count' by `1'.
			-- If `modification_count' reaches its `max_value', reset it to 0.
		do
			if modification_count = {NATURAL_64}.max_value then
				modification_count := 0
			else
				modification_count := modification_count + 1
			end
		ensure then
			good_result: ((old modification_count = {NATURAL_64}.max_value) implies modification_count = 0) and
						 ((old modification_count < {NATURAL_64}.max_value) implies modification_count = old modification_count + 1)
		end

end
