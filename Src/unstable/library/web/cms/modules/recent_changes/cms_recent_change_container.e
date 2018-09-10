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

	make (a_limit: NATURAL_32; a_date: detachable DATE_TIME; a_source: detachable READABLE_STRING_8; a_author: detachable READABLE_STRING_GENERAL)
		do
			limit := a_limit
			date := a_date
			source := a_source
			author := a_author
			create items.make (a_limit.to_integer_32)
		end

feature -- Settings

	limit: NATURAL_32

	date: detachable DATE_TIME

	source: detachable READABLE_STRING_8

	author: detachable READABLE_STRING_GENERAL

feature -- Access

	items: ARRAYED_LIST [CMS_RECENT_CHANGE_ITEM]
			-- List of recent events.	

	last_date_by_source: detachable STRING_TABLE [DATE_TIME]
			-- Last date during previous search for each source.

	last_date: detachable DATE_TIME
			-- More recent last date.
		do
			if attached last_date_by_source as tb then
				across
					tb as ic
				loop
					if Result = Void then
						Result := ic.item
					elseif Result < ic.item then
						Result := ic.item
					end
				end
			end
		end

	count: INTEGER
			-- Number of change items.
		do
			Result := items.count
		end

feature -- Element change

	set_last_date_for_source (dt: DATE_TIME; a_source: READABLE_STRING_GENERAL)
		local
			tb: like last_date_by_source
		do
			tb := last_date_by_source
			if tb = Void then
				create tb.make_caseless (1)
				last_date_by_source := tb
			end
			tb.force (dt, a_source)
		end

feature -- Helpers

	has_expected_author (a_item: CMS_RECENT_CHANGE_ITEM): BOOLEAN
			-- If `author` is set, is `a_item` authored by `author` ?
			-- otherwise return True.
		do
			if attached author as l_author_name then
				Result := attached a_item.author_name as l_item_author_name and then
							 l_author_name.same_string (l_item_author_name)
			else
					-- No filter on author name.
				Result := True
			end
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
		require
			has_expected_author (a_item)
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
