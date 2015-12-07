note
	description: "Container of entity associated with taxonomy term."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TAXONOMY_ENTITY_CONTAINER

inherit
	ITERABLE [CMS_TAXONOMY_ENTITY]

create
	make

feature -- Initialization

	make (a_taxo_info: like taxonomy_info; a_limit: NATURAL_32;  a_date: detachable DATE_TIME; a_type: detachable READABLE_STRING_8)
		do
			taxonomy_info := a_taxo_info
			limit := a_limit
			date := a_date
			content_type := a_type
			create items.make (a_limit.to_integer_32)
		end

feature -- Settings

	limit: NATURAL_32
			-- Maximum container size.

	date: detachable DATE_TIME
			-- Contents related to entities listed on `taxonomy_info'.

	content_type: detachable READABLE_STRING_8
			-- Filter by content type if not Void.

feature -- Access

	taxonomy_info: LIST [TUPLE [entity: READABLE_STRING_32; typename: detachable READABLE_STRING_32]]
			-- Associated information.

	items: ARRAYED_LIST [CMS_TAXONOMY_ENTITY]
			-- List of recent events.	

	count: INTEGER
			-- Number of change items.
		do
			Result := items.count
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [CMS_TAXONOMY_ENTITY]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

feature -- Change

	force (a_item: CMS_TAXONOMY_ENTITY)
			-- Add `a_item'.
		do
			items.force (a_item)
		end

feature -- Sorting

	sort
			-- Sort `items' from older, to newer.
		do
			item_sorter.sort (items)
		end

	reverse_sort
			-- Sort `items' from newer to older.
		do
			item_sorter.reverse_sort (items)
		end

feature {NONE} -- Implementation

	item_sorter: QUICK_SORTER [CMS_TAXONOMY_ENTITY]
			-- New change item sorter.
		once
			create Result.make (create {COMPARABLE_COMPARATOR [CMS_TAXONOMY_ENTITY]})
		end

end
