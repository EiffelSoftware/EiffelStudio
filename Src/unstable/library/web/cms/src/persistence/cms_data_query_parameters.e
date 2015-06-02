note
	description: "[
			Parameters associated with data query.
			It could be query over http, or storage.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_DATA_QUERY_PARAMETERS

create
	make

feature {NONE} -- Initialization

	make (a_offset: NATURAL_64; a_size: NATURAL)
		do
			offset := a_offset
			size := a_size
		ensure
			size_set: size = a_size
			offset_set: offset = a_offset
		end

feature -- Access

	size: NATURAL assign set_size
			-- Number of items per page.

	offset: NATURAL_64 assign set_offset
			--  lower index of `items' pagination.

	order_by: detachable READABLE_STRING_8
			-- field to order by.

	order_ascending: BOOLEAN
			-- is ascending ordering?

feature -- Element change

	set_size (a_size: NATURAL)
			-- Set `size' with `a_size'.
		do
			size := a_size
		ensure
			size_set: size = a_size
		end

	set_offset (a_offset: NATURAL_64)
			-- Set offset with `a_offset'.
		do
			offset := a_offset
		ensure
			limit_set: offset = a_offset
		end

	set_ascending_order_by_field (a_field: detachable READABLE_STRING_8)
			-- Pager with a order_by `a_field' asc.	
		do
			if a_field /= Void then
				order_by := a_field
				order_ascending := True
			else
				order_by := Void
			end
		ensure
			order_by_unset: a_field = Void implies order_by = Void
			order_by_set: a_field /= Void implies attached order_by as l_order_by and then l_order_by.same_string (a_field)
			asc_true: order_ascending
		end

	set_descending_order_by_field (a_field: detachable READABLE_STRING_8)
			-- Pager sorting descending with field `a_field' if set, otherwise remove sorting.	
		do
			if a_field /= Void then
				order_by := a_field
				order_ascending := False
			else
				order_by := Void
			end
		ensure
			order_by_unset: a_field = Void implies order_by = Void
			order_by_set: a_field /= Void implies attached order_by as l_order_by and then l_order_by.same_string (a_field)
			asc_fasle: not order_ascending
		end

end
