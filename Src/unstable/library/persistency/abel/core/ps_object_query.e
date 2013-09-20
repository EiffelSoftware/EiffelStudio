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

	result_cursor: PS_RESULT_CURSOR [G]
			-- Iteration cursor containing the result of the query.

feature -- Status report

	is_object_query: BOOLEAN = True
			-- Is `Current' an instance of PS_OBJECT_QUERY?

feature -- Basic operations

	set_criterion (a_criterion: PS_CRITERION)
			-- Set the criteria `a_criterion', against which the objects will be selected.
		require else
			set_before_execution: not is_executed
			criterion_can_handle_objects: is_criterion_fitting_generic_type (a_criterion)
		do
			criteria := a_criterion
		end

feature -- Cursor generation

	new_cursor: PS_RESULT_CURSOR [G]
			-- Return the result_cursor.
		do
			--TODO: according to class ITERABLE, this should return a fresh copy of the cursor.
			Result := result_cursor
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

end
