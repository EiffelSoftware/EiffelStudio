note
	description: "Summary description for {PS_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_ITERATION_CURSOR [G -> ANY]

inherit

	ITERATION_CURSOR [G]

	PS_EIFFELSTORE_EXPORT
		export {NONE}
			all
		end

create {PS_QUERY}
	make

feature -- Access

	item: G
			-- Item at current cursor position.
		do
			check attached {G} query.result_cache[index] as res then
				Result := res
			end
		end

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := not query.is_executed or else (index > query.result_cache.count and query.result_cursor.after)
		end

feature -- Cursor movement

	forth
			-- Move to next position.
		do
			index := index + 1
			if index > query.result_cache.count and not query.result_cursor.after then
				query.result_cursor.forth
			end
		end

feature {NONE} -- Initialization

	query: PS_QUERY [ANY]
		-- The query to iterate over.

	index: INTEGER

	make (a_query: PS_QUERY[ANY])
			-- Initialization for `Current'.
		do
			query := a_query
			index := 1
		end


end
