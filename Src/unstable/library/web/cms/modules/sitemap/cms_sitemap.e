note
	description: "Container of sitemap items."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SITEMAP

inherit
	ITERABLE [CMS_SITEMAP_ITEM]

create
	make

feature -- Initialization

	make (a_date: DATE_TIME)
		do
			create items.make (100)
		end

feature -- Access

	items: ARRAYED_LIST [CMS_SITEMAP_ITEM]
			-- List of sitemap entries.

	count: INTEGER
			-- Number of change items.
		do
			Result := items.count
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [CMS_SITEMAP_ITEM]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

feature -- Change

	force (a_item: CMS_SITEMAP_ITEM)
			-- Add `a_item'.
		do
			items.force (a_item)
		end

feature -- Sorting

	sort
			-- Sort `items' from older, to newer.
		do
			sitemap_item_sorter.sort (items)
		end

	reverse_sort
			-- Sort `items' from newer to older.
		do
			sitemap_item_sorter.reverse_sort (items)
		end

feature {NONE} -- Implementation

	sitemap_item_sorter: QUICK_SORTER [CMS_SITEMAP_ITEM]
			-- New change item sorter.
		once
			create Result.make (create {COMPARABLE_COMPARATOR [CMS_SITEMAP_ITEM]})
		end

end
