indexing
	description: "Objects that store tool bar items group infomation."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_GROUP_INFO

inherit
	ANY
		redefine
			out
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			create internal_group_info.make (1)
			create internal_is_new_group.make (1)
			create sub_grouping.make_default
		end

feature -- Query

	total_items_count: INTEGER is
			-- How many items.
		do
			from
				internal_group_info.start
			until
				internal_group_info.after
			loop
				Result := Result + internal_group_info.item.count
				internal_group_info.forth
			end
		ensure
			valid: Result >= 0
		end

	maximum_width: INTEGER is
			-- Maximum width
		local
			l_maximum_index: INTEGER
		do
			l_maximum_index := maximum_width_group_index
			if not has_sub_info then
				Result := group_width (l_maximum_index)
			else
				Result := sub_grouping.item (l_maximum_index).maximum_width
			end
		end

	maximum_width_group: SD_TOOL_BAR_GROUP_INFO is
			-- Group which has maximum width.
		local
			l_maximum_group_index: INTEGER
			l_group_index_count: INTEGER
			l_new_group: BOOLEAN
		do
			create Result.make
			l_maximum_group_index := maximum_width_group_index
			from
				start
				l_new_group := True
			until
				after or l_group_index_count > l_maximum_group_index
			loop
				if is_new_group then
					l_group_index_count := 1 + l_group_index_count
				end
				if l_group_index_count = l_maximum_group_index then
					if not has_sub_info then
						Result.extend (item, l_new_group)
					else
						Result := sub_grouping.item (l_maximum_group_index)
					end
					l_new_group := False
				end
				forth
			end
		ensure
			not_void: Result /= Void
			positive: Result.group_count >= 1
		end

	maximum_width_group_index: INTEGER is
			-- Maximum width group index.
		local
			l_group_count: INTEGER
			l_total_group: INTEGER
			l_maximum_width: INTEGER
			l_group_width: INTEGER
		do
			from
				l_group_count := 1
				l_total_group := group_count
			until
				l_group_count > l_total_group
			loop
				l_group_width := group_width (l_group_count)
				if l_group_width > l_maximum_width then
					l_maximum_width := l_group_width
					Result := l_group_count
				end
				l_group_count := l_group_count + 1
			end
		ensure
			valid: Result > 0 and Result <= group_count
		end

	group_item_width (a_group_index: INTEGER): ARRAYED_LIST [INTEGER] is
			-- Group items index.
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_start_index: INTEGER
			l_end_index: INTEGER
			l_count: INTEGER
		do
			l_start_index := group_item_start_index (a_group_index)
			if a_group_index < group_count then
				l_end_index := group_item_start_index (a_group_index + 1)
			else
				-- a_group_index must be the last group.
				l_end_index := l_end_index.max_value
			end

			from
				create Result.make (1)
				l_count := l_start_index
			until
				l_count > items_width.count or l_count > l_end_index
			loop
				Result.extend (items_width.item (l_count))
				l_count := l_count + 1
			end
		ensure
			not_void: Result /= Void
		end

	group_width (a_group_index: INTEGER): INTEGER is
			-- Maximum group width of a_group_index.
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_group_count: INTEGER
		do
			from
				start
			until
				after or l_group_count > a_group_index
			loop
				if is_new_group then
					l_group_count := l_group_count + 1
				end
				if l_group_count = a_group_index then
					if not has_sub_info then
						Result := row_width (index)
					else
						Result := sub_grouping.item (index).maximum_width
					end
				end
				forth
			end
		ensure
			valid: Result >= 0
		end

	row_width (a_row_index: INTEGER): INTEGER is
			-- Row width.
		require
			valid: a_row_index > 0 and a_row_index <= row_count
		local
			l_row: ARRAYED_LIST [INTEGER]
		do
			l_row := internal_group_info.i_th (a_row_index)
			from
				l_row.start
			until
				l_row.after
			loop
				Result := items_width.item (l_row.item) + Result
				l_row.forth
			end
		ensure
			valid: Result >= 0
		end

	row_count: INTEGER is
			-- Row count
		do
			Result := internal_group_info.count
		end

	row_total_count: INTEGER is
			-- Total row count.
		do
			from
				start
			until
				after
			loop
				if has_sub_info then
					Result := sub_grouping.item (index).count + Result
				else
					Result := Result + 1
				end
				forth
			end
		ensure
			valid: Result >= 0
		end

	items_width: ARRAY [INTEGER]
			-- Store each item in `internal_group_info's width. It's serval EV_TOOL_BAR_ITEMs' width.

	group_count: INTEGER is
			-- Group count.
		do
			from
				start
			until
				after
			loop
				if is_new_group then
					Result := Result + 1
				end
				forth
			end
		ensure
			valid: Result >= 0
		end

	group_item_count (a_group_index: INTEGER): INTEGER is
			-- How many items in a group.
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_group_count: INTEGER
		do
			from
				start
			until
				after or l_group_count > a_group_index
			loop
				if is_new_group then
					l_group_count := l_group_count + 1
				end
				if l_group_count = a_group_index then
					Result := item.count + Result
				end
				forth
			end
		ensure
			valid: Result > 0
		end

	group_item_start_index (a_group_index: INTEGER): INTEGER is
			-- Group item start index.
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		do
			go_group_i_th (a_group_index)
			Result := item.first
		end

	sub_grouping: DS_HASH_TABLE [SD_TOOL_BAR_GROUP_INFO ,INTEGER]
			-- SD_tool_bar_GROUP_INFO is grouping info of items in one tool bar items group.
			-- INTEGER is tool bar items group id. It is INTEGER in `internal_group_info'.

feature -- Command

	set_sub_group_info (a_sub_grouping_info: SD_TOOL_BAR_GROUP_INFO; a_group_index: INTEGER) is
			-- Set sub grouping info.
		require
			valid: a_group_index > 0 and a_group_index <= items_width.count
		do
			sub_grouping.force (a_sub_grouping_info, a_group_index)
		ensure
			has: sub_grouping.has_item (a_sub_grouping_info)
		end

	set_items_width (a_items_width: ARRAY [INTEGER]) is
			-- Set item width.
		require
			not_void: a_items_width /= Void
			count_valid: a_items_width.count = total_items_count
		do
			items_width := a_items_width
		ensure
			set: items_width = a_items_width
		end

	out: STRING is
			-- Redefine
		do
			Result := "%NSD_tool_bar_GROUP_INFO:"
			Result := Result + "%N                   group count: " + group_count.out
			Result := Result + "%N                   total item count: " + total_items_count.out
		end

feature -- Query for iteration

	after: BOOLEAN is
			-- If no items left?
		do
			Result := internal_group_info.after
		end

	before: BOOLEAN is
			-- If no items before?
		do
			Result := internal_group_info.before
		end

	count: INTEGER is
			-- Count of how many rows.
		do
			Result := internal_group_info.count
		end

	index: INTEGER is
			-- Index of current row.
		do
			Result := internal_group_info.index
		end

	item: ARRAYED_LIST [INTEGER] is
			-- One row info.
		do
			Result := internal_group_info.item
		end

	has_sub_info: BOOLEAN is
			-- Do current index has sub grouping information?
		do
			Result := sub_grouping.has (index)
		end

	i_th (a_index: INTEGER): ARRAYED_LIST [INTEGER] is
			-- Item at a_index.
		do
			Result := internal_group_info.i_th (a_index)
		end

	is_new_group: BOOLEAN is
			-- If current `item' is new group base on last `item'?
		do
			Result := internal_is_new_group.item
		end

feature -- Command for iteration

	start is
			-- Go to first item.
		do
			internal_group_info.start
			internal_is_new_group.start
		end

	finish is
			-- Go to last position.
		do
			internal_group_info.finish
			internal_is_new_group.finish
		end

	forth is
			-- Go to next row info.
		do
			internal_group_info.forth
			internal_is_new_group.forth
		end

	back is
			-- Go to row info before.
		do
			internal_group_info.back
			internal_is_new_group.back
		end

	extend (a_group_index_info: ARRAYED_LIST [INTEGER]; a_new_group: BOOLEAN) is
			-- Extend a_group_info
		require
			not_void:a_group_index_info /= Void
		do
			internal_group_info.extend (a_group_index_info)
			internal_is_new_group.extend (a_new_group)
		ensure
			same_size: internal_group_info.count = internal_is_new_group.count
		end

	go_i_th (a_index: INTEGER) is
			-- Go to `a_index' position.
		do
			internal_group_info.go_i_th (a_index)
			internal_is_new_group.go_i_th (a_index)
		end

	replace (a_item: ARRAYED_LIST [INTEGER]; a_new_group: BOOLEAN) is
			-- Replace current item by a_item.
		do
			internal_group_info.replace (a_item)
			internal_is_new_group.replace (a_new_group)
		end

feature {NONE} -- Implementation

	go_group_i_th (a_group_index: INTEGER) is
			-- Move index to a_group_index
		require
			valid: a_group_index > 0
		local
			l_group_count: INTEGER
			l_stop: BOOLEAN
		do
			from
				start
			until
				after or l_stop
			loop
				if is_new_group then
					l_group_count := l_group_count + 1
				end
				if l_group_count = a_group_index then
					l_stop := True
				end
				forth
			end
		end

	internal_group_info: ARRAYED_LIST [ARRAYED_LIST [INTEGER]]
			-- Grouping formation, INTEGER is group_index of SD_TOOL_BAR_CONTENT.

	internal_is_new_group: ARRAYED_LIST [BOOLEAN]
			-- Store each item in `internal_group_info' is a new row?

invariant
	not_void: internal_group_info /= Void
	same_size: internal_group_info.count = internal_is_new_group.count

end
