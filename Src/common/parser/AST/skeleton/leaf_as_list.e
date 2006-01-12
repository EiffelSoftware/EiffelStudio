indexing
	description: "AST leaf list for roundtrip parser"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEAF_AS_LIST

inherit
	ARRAYED_LIST [LEAF_AS]
		export
			{ANY}grow
		redefine
			make, extend
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		undefine
			copy,
			is_equal
		end

create
	make

feature{NONE} -- Initialization

	make (n: INTEGER) is
		do
			Precursor (n)
		end

feature

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		require else
			leaf_position_valid: v.position > 0
		do
			Precursor (v)
		end

feature -- Operations/ Add and del

	put_add (pos: INTEGER; a_text: STRING) is
			-- Add `a_text' after position `pos'.
		require
			pos_not_removed: valid_add_position (pos)
			text_not_void: a_text /= Void
		do
			modifier_list.extend (create {ROUNDTRIP_ADDITION_MODIFIER}.make (pos, modifier_list.count, a_text))
		end

	put_del (start_pos, end_pos: INTEGER) is
			-- Remove `text' in `a_list' from `start_pos' to `end_pos'.
		require
			valid_del_position: valid_del_position (start_pos, end_pos)
		do
			modifier_list.extend (create {ROUNDTRIP_DELETION_MODIFIER}.make (start_pos, end_pos, modifier_list.count))
		end

	put_replace (start_pos, end_pos: INTEGER; a_text: STRING) is
			-- Replace text in `a_list' from `start_pos' to `end_pos' with `a_text'.
		require
			can_add: valid_add_position (start_pos)
			can_del: valid_del_position (start_pos, end_pos)
			text_not_void: a_text /= Void
		do
			put_add (start_pos, a_text)
			put_del (start_pos, end_pos)
		end

feature -- Status reporting

	byte_count: INTEGER is
			-- Number in bytes of characters in `Current'.
		do
			if is_empty then
				Result := 0
			else
				Result := last.end_position
			end
		end

	valid_add_position (a_pos: INTEGER): BOOLEAN is
			-- Is `pos' a valid position for add?
			-- e.g. `pos' has not been removed.
		do
			Result := position_in_range (a_pos)
			if Result then
				from
					modifier_list.start
				until
					modifier_list.after or not Result
				loop
					Result := modifier_list.item.can_add (a_pos)
					modifier_list.forth
				end
			end
		end

	valid_del_position (start_pos, end_pos: INTEGER): BOOLEAN is
			-- Can text in `a_list' from `start_pos' to `end_pos' be deleted?
		require
			start_pos_less_or_equal_than_end_pos: start_pos <= end_pos
		do
			Result := position_in_range (start_pos) and position_in_range (end_pos)
			if Result then
				from
					modifier_list.start
				until
					modifier_list.after or not Result
				loop
					Result := modifier_list.item.can_del (start_pos, end_pos)
					modifier_list.forth
				end
			end
		end

	position_in_range (pos: INTEGER): BOOLEAN is
			-- Is `pos' in range?
		do
			Result := (pos >= 1) and then (pos <= byte_count)
		end

	text (start_pos, end_pos: INTEGER): STRING is
			-- Text with all registered modification applied to from `start_pos' to `end_pos'
		require
			start_pos_less_or_equal_than_end_pos: start_pos <= end_pos
			position_in_range: position_in_range (start_pos) and position_in_range (end_pos)
		local
			l_index: INTEGER
			l_sp: INTEGER
			done: BOOLEAN
			l_str: STRING
		do
			create Result.make (end_pos - start_pos + 1)
			if
				modifier_list.is_empty or else
				(region_before (start_pos, end_pos, modifier_list.first.start_position, modifier_list.first.end_position) or
				 region_after (start_pos, end_pos, modifier_list.last.start_position, modifier_list.last.end_position)
				)
			then
				Result := text_in_region (start_pos, end_pos)
			else
				from
					modifier_list.start
					done := False
					l_index := start_pos
					create l_str.make (100)
				until
					done or modifier_list.after
				loop
					l_sp := modifier_list.item.start_position
					if l_sp <= end_pos then
						if l_index < l_sp then
							Result.append (text_in_region (l_index, l_sp - 1))
							l_index := l_sp
						end
						modifier_list.item.modify (Result)
						l_index := modifier_list.item.modified_index
						if l_index > end_pos then
							done := True
						end
					end
					modifier_list.forth
				end
				if l_index <= end_pos then
					Result.append (text_in_region (l_index, end_pos))
				end
			end
		end

	all_text: STRING is
			-- -- Text with all registered modification applied
		do
			Result := text (1, byte_count)
		end

	original_text (start_pos, end_pos: INTEGER): STRING is
			-- Original text from `start_pos' to `end_pos'
		require
			start_pos_less_or_equal_than_end_pos: start_pos <= end_pos
			position_in_range: position_in_range (start_pos) and position_in_range (end_pos)
		do
			Result := text_in_region (start_pos, end_pos)
		end

	all_original_text: STRING is
			-- Original text in `Current'
		do
			Result := original_text (1, byte_count)
		end

feature -- Item searching

	item_by_start_position (start_pos: INTEGER): LEAF_AS is
			-- Item in `Current' whose `start_position' equals to `start_pos'
			-- Return Void if no item in `Current' satisfies.
		local
			l_left, l_right, l_middle: INTEGER
			done: BOOLEAN
			l_pos: INTEGER
		do
			l_left := 1
			l_right := count
			from

			until
				l_left > l_right or done
			loop
				l_middle := (l_left + l_right) // 2
				l_pos := i_th (l_middle).start_position
				if l_pos = start_pos then
					Result := i_th (l_middle)
					done := True
				elseif start_pos > l_pos then
					l_left := l_middle + 1
				else
					l_right := l_middle - 1
				end
			end
		end

	item_by_end_position (end_pos: INTEGER): LEAF_AS is
			-- Item in `Current' whose `end_position' equals to `end_pos'
			-- Return Void if no item in `Current' satisfies.
		local
			l_left, l_right, l_middle: INTEGER
			done: BOOLEAN
			l_pos: INTEGER
		do
			l_left := 1
			l_right := count
			from

			until
				l_left > l_right or done
			loop
				l_middle := (l_left + l_right) // 2
				l_pos := i_th (l_middle).end_position
				if l_pos = end_pos then
					Result := i_th (l_middle)
					done := True
				elseif end_pos > l_pos then
					l_left := l_middle + 1
				else
					l_right := l_middle - 1
				end
			end
		end

	item_by_position (a_pos: INTEGER): LEAF_AS is
			-- Item in `Current' between which `a_pos' is located
			-- Return Void if no item in `Current' satisfies.
		local
			l_left, l_right, l_middle: INTEGER
			done: BOOLEAN
			l_start_pos: INTEGER
			l_end_pos: INTEGER
		do
			l_left := 1
			l_right := count
			from

			until
				l_left > l_right or done
			loop
				l_middle := (l_left + l_right) // 2
				l_start_pos := i_th (l_middle).start_position
				l_end_pos := i_th (l_middle).end_position

				if a_pos >= l_start_pos and a_pos <= l_end_pos then
					Result := i_th (l_middle)
					done := True
				elseif a_pos > l_end_pos then
					l_left := l_middle + 1
				else
					l_right := l_middle - 1
				end
			end
		end

feature{NONE} -- Implementation

	modifier_list: SORTED_TWO_WAY_LIST [ROUNDTRIP_MODIFIER] is
			-- List where all modification to `Current' are stored
		do
			if internal_modifier_list = Void then
				create internal_modifier_list.make
			end
			Result := internal_modifier_list
		end

	internal_modifier_list: like modifier_list
			-- Internal list where all modification to `Current' are stored		

	text_in_region (start_pos, end_pos: INTEGER): STRING is
			-- Original string in `Current' from `start_pos' to `end_pos'
		require
			start_pos_less_or_equal_than_end_pos: start_pos <= end_pos
			position_in_range: position_in_range (start_pos) and position_in_range (end_pos)
		local
			l_index: INTEGER
		do
			if text_buffer = Void then
				create text_buffer.make (byte_count)
				l_index := index
				from
					start
				until
					after
				loop
					text_buffer.append (item.text (Void))
					forth
				end
				index := l_index
			end
			Result := text_buffer.substring (start_pos, end_pos)
		ensure
			Result_not_void: Result /= Void
		end

	text_buffer: STRING
			-- Buffer used to reproduce origianl source code

	valid_region (start_pos, end_pos: INTEGER): BOOLEAN is
			-- Is region from `start_pos' to `end_pos' a valid region within `Current'?
		do
			Result := position_in_range (start_pos) and position_in_range (end_pos) and start_pos <= end_pos
		end

	region_before (start_pos1, end_pos1, start_pos2, end_pos2: INTEGER): BOOLEAN is
			-- Is region from `start_pos1' to `end_pos1' before region from `start_pos2' to `end_pos2'?
		require
			region_valid: valid_region (start_pos1, end_pos1) and valid_region (start_pos2, end_pos2)
		do
			Result := end_pos1 < start_pos2
		end

	region_after (start_pos1, end_pos1, start_pos2, end_pos2: INTEGER): BOOLEAN is
			-- Is region from `start_pos1' to `end_pos1' after region from `start_pos2' to `end_pos2'?
		require
			region_valid: valid_region (start_pos1, end_pos1) and valid_region (start_pos2, end_pos2)
		do
			Result := start_pos1 > end_pos2
		end

	region_overlapped (start_pos1, end_pos1, start_pos2, end_pos2: INTEGER): BOOLEAN is
			-- Is region from `start_pos1' to `end_pos1' overlapped with region from `start_pos2' to `end_pos2'?
		require
			region_valid: valid_region (start_pos1, end_pos1) and valid_region (start_pos2, end_pos2)
		do
			Result := not region_before (start_pos1, end_pos1, start_pos2, end_pos2) and
					 not region_after (start_pos1, end_pos1, start_pos2, end_pos2)
		end


end
