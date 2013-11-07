note
	description: "[
	Represents a query for objects of type G.
	Objects of this type can be used directly to iterate through the query result.
	Example: across my_query as cur
			 loop 
				-- do something with cur.item 
			 end
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_QUERY [G -> ANY]

inherit

	ITERABLE [G]

	PS_QUERY [G]
		redefine
			set_criterion
		end

create
	make, make_with_criterion

feature -- Access

	new_cursor: ITERATION_CURSOR [G]
			-- Return a fresh cursor over the query result.
			-- | Note: The result is loaded lazily upon calling `{ITERATION_CURSOR}.forth'.
			-- | Note: The results are cached interanlly, thus it is possible to iterate over the result
			-- | many times without performance impact.
		do
			create {PS_ITERATION_CURSOR[G]} Result.make (Current)
		end

feature -- Status report

	is_object_query: BOOLEAN = True
			-- Is `Current' an instance of PS_OBJECT_QUERY?

feature -- Element change

	set_criterion (a_criterion: PS_CRITERION)
			-- Set the criteria `a_criterion', against which the objects will be selected.
		require else
			set_before_execution: not is_executed
			criterion_can_handle_objects: is_criterion_fitting_generic_type (a_criterion)
		do
			criteria := a_criterion
		end

feature {NONE} -- Initialization

	make
			-- Create a query for all objects of type G (no filtering criteria).
		do
			initialize
		end

	create_result_cursor
			-- Create a new result set.
		do
			create result_cursor.make
		end

feature {PS_EIFFELSTORE_EXPORT} -- Access

	result_cursor: PS_RESULT_CURSOR [G]
			-- Iteration cursor containing the result of the query.

end
