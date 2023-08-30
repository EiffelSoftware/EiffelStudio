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

	parameters: detachable STRING_TABLE [detachable ANY]
			-- Optional additional parameters

	parameter (n: READABLE_STRING_GENERAL): detachable ANY
			-- Value for parameter name `n`.
		do
			if n.is_case_insensitive_equal ("size") then
				Result := size
			elseif n.is_case_insensitive_equal ("offset") then
				Result := offset
			elseif n.is_case_insensitive_equal ("order_by") then
				Result := order_by
			elseif n.is_case_insensitive_equal ("order_ascending") then
				Result := order_ascending
			elseif attached parameters as params then
				Result := params [n]
			end
		end

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

	set_parameter (a_value: detachable ANY; a_name: READABLE_STRING_GENERAL)
			-- Set optional parameter named `a_name`.
		local
			tb: like parameters
		do
			tb := parameters
			if tb = Void then
				create tb.make_equal_caseless (1)
				parameters := tb
			end
			tb.put (a_value, a_name)
		end

note
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
