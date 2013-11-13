note
	description: "Summary description for {PS_SMART_OBJECT_GRAPH_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SMART_OBJECT_GRAPH_CURSOR

inherit
	PS_ABEL_EXPORT
	ITERABLE [PS_COMPLEX_PART]
	ITERATION_CURSOR [PS_COMPLEX_PART]

create
	make

feature

	after: BOOLEAN
		do
			Result := internal_cursor.after
		end

	item: PS_COMPLEX_PART
		do
			check attached {PS_COMPLEX_PART} internal_cursor.item as i then
				Result := i
			end
		ensure then
			has_operation: Result.write_operation /= Result.write_operation.no_operation
		end

	forth
		do
			from
				internal_cursor.forth
			until
				after or internal_cursor.item.write_operation /= internal_cursor.item.write_operation.no_operation
			loop
				internal_cursor.forth
			end
		end

	new_cursor: ITERATION_CURSOR[PS_COMPLEX_PART]
		do
			Result := Current
		end

feature {NONE} -- Initialization

	make (graph: PS_OBJECT_GRAPH_PART)
			-- Initialization for `Current'
		do
			internal_cursor := graph.new_cursor
			if internal_cursor.item.write_operation = internal_cursor.item.write_operation.no_operation then
				forth
			end
		end

	internal_cursor: PS_OBJECT_GRAPH_CURSOR

end
