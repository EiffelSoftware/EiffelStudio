class FILTER_LIST

inherit
	ARRAYED_LIST [CL_TYPE_I]
		rename
			append as list_append,
			search as list_search,
			make as list_make
		export
			{NONE} all
			{ANY} start, item, forth, after, extend, cursor, go_to
		end

create
	make

feature -- Initialization

	make is
		do
			list_make (2)
			compare_objects
		end

feature -- Search

	has_item (v: like item): BOOLEAN is
			-- Patch
		require
			v_not_void: v /= Void
		local
			l_area: like area
			i, nb: INTEGER
		do
			from
				l_area := area
				i := 0
				nb := count - 1
			until
				i > nb or else Result
			loop
				Result := l_area.item (i).same_as (v)
				i := i + 1
			end
		end

	clean is
			-- Clean the list of all the removed classes
		local
			l_area: like area
			l_new_area: like area
			i, nb, l_count: INTEGER
			l_item: like item
		do
			from
				l_area := area
				nb := count - 1
				list_make (count)
				l_new_area := area
				i := 0
			until
				i > nb
			loop
				l_item := l_area.item (i)
				if l_item.is_valid then
					l_new_area.put (l_item, l_count)
					l_count := l_count + 1
				end
				i := i + 1
			end
			count := l_count
		end

end
