note
	description: "The implementation for {PS_QUERY}.new_cursor."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_ITERATION_CURSOR [G -> ANY]

inherit

	ITERATION_CURSOR [G]

	PS_ABEL_EXPORT

create {PS_ABSTRACT_QUERY}
	make

feature -- Access

	query: PS_ABSTRACT_QUERY [ANY, G]
			-- The query to iterate over.

	item: G
			-- Item at current cursor position.
		do
			Result := query.result_cache [index]
		end

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := (not query.is_executed or query.is_closed) or else (index > query.result_cache.count and query.is_after)
		end

feature -- Cursor movement

	forth
			-- Move to next position.
		require else
				-- Relax the precondition. That way an across loop is safe to use.
			has_error: query.has_error
		do
			index := index + 1
			if query.has_error then
				query.do_rescue
			elseif index > query.result_cache.count and not query.is_after then
				query.retrieve_next
			end
		end

feature {NONE} -- Initialization

	index: INTEGER
			-- The current index in the query result cache.

	make (a_query: PS_ABSTRACT_QUERY [ANY, G])
			-- Initialization for `Current'.
		do
			query := a_query
			index := 1
		end


end
