note
	description: "Container of recent change items, and associated parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_RECENT_CHANGE_CONTAINER

inherit
	ITERABLE [CMS_RECENT_CHANGE_ITEM]

create
	make

feature -- Initialization

	make (a_limit: NATURAL_32; a_date: detachable DATE_TIME; a_source: detachable READABLE_STRING_8)
		do
			limit := a_limit
			date := a_date
			source := a_source
			create items.make (a_limit.to_integer_32)
		end

feature -- Settings

	limit: NATURAL_32

	date: detachable DATE_TIME

	source: detachable READABLE_STRING_8

feature -- Access

	items: ARRAYED_LIST [CMS_RECENT_CHANGE_ITEM]
			-- List of recent events.	

	count: INTEGER
			-- Number of change items.
		do
			Result := items.count
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [CMS_RECENT_CHANGE_ITEM]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

feature -- Change

	force (a_item: CMS_RECENT_CHANGE_ITEM)
			-- Add `a_item'.
		do
			items.force (a_item)
		end

feature -- Sorting

	sort
			-- Sort `items' from older, to newer.
		do
			change_item_sorter.sort (items)
		end

	reverse_sort
			-- Sort `items' from newer to older.
		do
			change_item_sorter.reverse_sort (items)
		end

feature {NONE} -- Implementation

	change_item_sorter: QUICK_SORTER [CMS_RECENT_CHANGE_ITEM]
			-- New change item sorter.
		once
			create Result.make (create {COMPARABLE_COMPARATOR [CMS_RECENT_CHANGE_ITEM]})
		end

end
