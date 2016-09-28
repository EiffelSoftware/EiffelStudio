note
	description: "Objects that store tool bar items group infomation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make
			-- Creation method
		do
			create internal_group_info.make (1)
			create internal_is_new_group.make (1)
			create sub_grouping.make (10)
		end

feature -- Query

	total_items_count: INTEGER
			-- How many items
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

	maximum_width_sub: INTEGER
			-- Maximum width
			-- Calculation include sub level items
		local
			l_maximum_index: INTEGER
		do
			l_maximum_index := maximum_width_group_index.max_index
			go_group_i_th (l_maximum_index)
			if attached sub_grouping.item (l_maximum_index) as l_item then
				Result := l_item.maximum_width_sub
			else
					-- This function is calculate inlclude sub level
					-- But it's not calculate "sub sub" level, so we pass True here
				Result := group_maximum_width (l_maximum_index).max_width
			end
		end

	maximum_width: INTEGER
			-- Maximum width
			-- The calculation include sub level groups
		local
			l_temp_size: INTEGER
			l_group_count, l_max_group_count: INTEGER
		do
			from
				l_group_count := 1
				l_max_group_count := group_count
			until
				l_group_count > l_max_group_count
			loop
				l_temp_size := group_maximum_width (l_group_count).max_width
				if l_temp_size > Result then
					Result := l_temp_size
				end
				l_group_count := l_group_count + 1
			end
		end

	maximum_width_only_top_level: TUPLE [max_width: INTEGER; item_count: INTEGER]
			-- Maximum width
			-- The calculation not include sub level groups
		local
			l_snapshot: like internal_group_info
			l_new_group_snapshot: like internal_is_new_group
			l_temp_size: INTEGER
			l_item: HASH_TABLE [INTEGER_32, INTEGER_32]
			l_item_count: INTEGER
		do
			from
				Result := [0, 0]
				l_snapshot := internal_group_info.twin
				l_new_group_snapshot := internal_is_new_group.twin
				check same_size: l_new_group_snapshot.count = l_snapshot.count end
				l_snapshot.start
				l_new_group_snapshot.start
			until
				l_snapshot.after or l_new_group_snapshot.after
			loop
				if l_new_group_snapshot.item.item then
					l_temp_size := 0
					l_item_count := 0
				end
				-- Only first level.
				from
					l_item := l_snapshot.item
					l_item.start
				until
					l_item.after
				loop
					l_temp_size := l_temp_size + l_item.item_for_iteration
					l_item_count := l_item_count + 1
					l_item.forth
				end

				if l_temp_size > Result.max_width then
					Result.max_width := l_temp_size
					Result.item_count := l_item_count
				end

				l_snapshot.forth
				l_new_group_snapshot.forth
			end
		end

	maximum_width_group_index: TUPLE [max_index: INTEGER; max_row_item_count: INTEGER]
			-- Maximum width group index
			-- It compute sub-level groups
		local
			l_group_count: INTEGER
			l_total_group: INTEGER
			l_maximum_width: INTEGER
			l_temp_result: TUPLE [max_width: INTEGER_32; item_count: INTEGER_32]
		do
			from
				Result := [0, 0]
				l_group_count := 1
				l_total_group := group_count
			until
				l_group_count > l_total_group
			loop
				l_temp_result := group_maximum_width (l_group_count)
				if l_temp_result.max_width > l_maximum_width then
					l_maximum_width := l_temp_result.max_width
					Result.max_index := l_group_count
					Result.max_row_item_count := l_temp_result.item_count
				end
				l_group_count := l_group_count + 1
			end
		ensure
			valid: Result.max_index > 0 and Result.max_index <= group_count
		end

	maximum_width_top_group: SD_TOOL_BAR_GROUP_INFO
			-- The group which have maximum width
			-- The maximum width calculation inlucde sub level group items width calculation
		local
			l_result_index: INTEGER
		do
			l_result_index := maximum_width_top_group_index
			create Result.make
			go_i_th (l_result_index)
			if attached sub_grouping.item (l_result_index) as l_result then
				Result := l_result
			else
				Result.extend (item, True)
			end
		end

	maximum_width_top_group_index: INTEGER
			-- Maximum width top group index
			-- Calculation include sub level items width
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
				l_group_width := group_maximum_width (l_group_count).max_width
				if l_group_width > l_maximum_width then
					l_maximum_width := l_group_width
					Result := l_group_count
				end
				l_group_count := l_group_count + 1
			end
		ensure
			valid: Result > 0 and Result <= total_group_count
		end

	group_maximum_width (a_group_index: INTEGER): TUPLE [max_width: INTEGER; item_count: INTEGER]
			-- Maximum group width of a_group_index
			-- `a_group_index' is top level group index
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_group_count: INTEGER
			l_index_count, l_index_max: INTEGER
			l_temp_result: INTEGER
			l_temp_max_info: detachable TUPLE [max_width: INTEGER_32; item_count: INTEGER_32]
		do
			from
				Result := [0, 0]
				l_group_count := 1
				l_index_count := 1
				l_index_max := count
			until
				l_index_count > l_index_max or l_group_count > a_group_index
			loop
				go_i_th (l_index_count)
				if is_new_group then
					l_group_count := l_group_count + 1
				end
				if l_group_count = a_group_index then
					go_i_th (l_index_count)
					if attached sub_grouping.item (l_index_count) as l_item then
						l_temp_max_info := l_item.maximum_width_only_top_level
						l_temp_result := l_temp_max_info.max_width
						if l_temp_result > Result.max_width then
							Result.max_width := l_temp_result
							Result.item_count := l_temp_max_info.item_count
						end
					else
						l_temp_result := row_width (l_index_count)
						if l_temp_result > Result.max_width then
							Result.max_width := l_temp_result
								-- Result.item_count := internal_group_info.i_th (l_index_count).count is not correct,
								-- because this value is group count, not item count.
								-- We don't know how many items in this group.
								-- This `item_count' is used for stop calculation grouping infos.
								-- We don't want it stop here, so we assign a value which larger than 1.
							Result.item_count := {INTEGER}.max_value
						end
					end
				end
				l_index_count := l_index_count + 1
			end
		ensure
			valid: Result.max_width >= 0
		end

	row_width (a_row_index: INTEGER): INTEGER
			-- Row width
		require
			valid: a_row_index > 0 and a_row_index <= row_count
		local
			l_row: HASH_TABLE [INTEGER, INTEGER]
		do
			l_row := internal_group_info.i_th (a_row_index)
			from
				l_row.start
			until
				l_row.after
			loop
				Result := l_row.item (l_row.key_for_iteration) + Result
				l_row.forth
			end
		ensure
			valid: Result >= 0
		end

	row_count: INTEGER
			-- Row count
		do
			Result := internal_group_info.count
		end

	row_total_count: INTEGER
			-- Total row count
		do
			from
				start
			until
				after
			loop
				if attached sub_grouping.item (index) as l_item then
					Result := l_item.count + Result
				else
					Result := Result + 1
				end
				forth
			end
		ensure
			valid: Result >= 0
		end

	group_count: INTEGER
			-- Group count
			-- Start from 1 (not 0)
		do
			Result := 1
			from
				start
			until
				after
			loop
				if index /= 1 and then is_new_group then
					Result := Result + 1
				end
				forth
			end
		ensure
			valid: Result >= 0
		end

	total_group_count: INTEGER
			-- Total group count, include sub group count
		do
			Result := 1
			from
				start
			until
				after
			loop
				if is_new_group and not has_sub_info then
					Result := Result + 1
				end
				if attached sub_grouping.item (index) as l_item then
					check sub_group_must_new_group: index /= 1 implies is_new_group end
					Result := Result + l_item.total_group_count
					if index = 1 then
						-- We alreay plus 1 when index = 1
						-- So we should subtract 1
						Result := Result - 1
					end
				end
				forth
			end
		end

	group_item_count (a_group_index: INTEGER): INTEGER
			-- How many items in a group
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_group_count: INTEGER
		do
			from
				l_group_count := 1
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

	group_item_start_index (a_group_index: INTEGER): INTEGER
			-- Group item start index
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_item: HASH_TABLE [INTEGER, INTEGER]
		do
			go_group_i_th (a_group_index)
			l_item := item
			l_item.start
			Result := l_item.key_for_iteration
		end

	sub_grouping: HASH_TABLE [SD_TOOL_BAR_GROUP_INFO ,INTEGER]
			-- SD_TOOL_BAR`_GROUP_INFO is grouping info of items in one tool bar items group
			-- INTEGER is tool bar items group id. It is INTEGER in `internal_group_info'

feature -- Command

	set_sub_group_info (a_sub_grouping_info: SD_TOOL_BAR_GROUP_INFO; a_group_index: INTEGER)
			-- Set sub grouping info
		require
			valid: a_group_index > 0 and a_group_index <= count
		do
			sub_grouping.force (a_sub_grouping_info, a_group_index)
		ensure
			has: sub_grouping.has_item (a_sub_grouping_info)
		end

	out: STRING
			-- <Precursor>
		do
			Result := "%NSD_TOOL_BAR_GROUP_INFO:"
			Result := Result + "%N                   group count: " + group_count.out
			Result := Result + "%N                   total item count: " + total_items_count.out
			Result := Result + "%N                   total group count: " + total_group_count.out
			Result := Result + "%N                   ==========================================="
			from
				start
			until
				after
			loop
				Result := Result + "%N                   is_new_group? " + is_new_group.out
				Result := Result + "%N                   has_sub_group?" + has_sub_info.out
				Result := Result + "%N                   -------------------------------------------"
				if attached sub_grouping.item (index) as l_item then
					Result := Result + "%N                   <<<<<<<<<<<<< sub info start >>>>>>>>>>>>>> "
					Result := Result + l_item.out
					Result := Result + "%N                   <<<<<<<<<<<<< sub info end >>>>>>>>>>>>>> "
				end
				forth
			end
			Result := Result + "%N                   ==========================================="
		end

feature -- Query for iteration

	after: BOOLEAN
			-- If no items left?
		do
			Result := internal_group_info.after
		end

	before: BOOLEAN
			-- If no items before?
		do
			Result := internal_group_info.before
		end

	count: INTEGER
			-- Count of how many rows
		do
			Result := internal_group_info.count
		end

	index: INTEGER
			-- Index of current row
		do
			Result := internal_group_info.index
		end

	item: HASH_TABLE [INTEGER, INTEGER]
			-- One row info
		do
			Result := internal_group_info.item
		end

	has_any_sub_info: BOOLEAN
			-- Do current grouping has any sub infos?
		do
			Result := sub_grouping.count > 0
		end

	has_sub_info: BOOLEAN
			-- Do current index has sub grouping information?
		do
			Result := sub_grouping.has (index)
		end

	i_th (a_index: INTEGER): HASH_TABLE [INTEGER, INTEGER]
			-- Item at a_index
		do
			Result := internal_group_info.i_th (a_index)
		end

	is_new_group: BOOLEAN
			-- If current `item' is new group base on last `item'?
		do
			Result := internal_is_new_group.item
		end

feature -- Command for iteration

	start
			-- Go to first item
		do
			internal_group_info.start
			internal_is_new_group.start
		end

	finish
			-- Go to last position
		do
			internal_group_info.finish
			internal_is_new_group.finish
		end

	forth
			-- Go to next row info
		do
			internal_group_info.forth
			internal_is_new_group.forth
		end

	back
			-- Go to row info before
		do
			internal_group_info.back
			internal_is_new_group.back
		end

	extend (a_group_index_info: HASH_TABLE [INTEGER, INTEGER]; a_new_group: BOOLEAN)
			-- Extend a_group_info
		require
			not_void:a_group_index_info /= Void
		do
			internal_group_info.extend (a_group_index_info)
			internal_is_new_group.extend (a_new_group)
		ensure
			same_size: internal_group_info.count = internal_is_new_group.count
		end

	go_i_th (a_index: INTEGER)
			-- Go to `a_index' position
		do
			internal_group_info.go_i_th (a_index)
			internal_is_new_group.go_i_th (a_index)
		end

	replace (a_item: HASH_TABLE [INTEGER, INTEGER]; a_new_group: BOOLEAN)
			-- Replace current item by a_item
		do
			internal_group_info.replace (a_item)
			internal_is_new_group.replace (a_new_group)
		end

feature {NONE} -- Implementation

	go_group_i_th (a_group_index: INTEGER)
			-- Move index to a_group_index
		require
			valid: a_group_index > 0
		local
			l_group_count: INTEGER
			l_stop: BOOLEAN
		do
			from
				l_group_count := 1
				start
			until
				after or l_stop
			loop
				if is_new_group then
					l_group_count := l_group_count + 1
				end
				if l_group_count = a_group_index then
					l_stop := True
				else
					forth
				end
			end
		ensure
			not_after: not after
		end

	internal_group_info: ARRAYED_LIST [HASH_TABLE [INTEGER, INTEGER]]
			-- Grouping formation.
			-- The order of items in arrayed list is the same order as ..........
			-- 1st INTEGER store each item in `internal_group_info's width or it's serval SD_TOOL_BAR_ITEMs' width
			-- 2nd INTEGER is group_index of SD_TOOL_BAR_CONTENT

	internal_is_new_group: ARRAYED_LIST [BOOLEAN]
			-- Store each item in `internal_group_info' is a new row?

invariant
	not_void: internal_group_info /= Void
	same_size: internal_group_info.count = internal_is_new_group.count

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
