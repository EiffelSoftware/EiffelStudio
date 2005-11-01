indexing
	description: "[
					Multi-searcher and replacer Container of search and replace strategy
					that then are used to deal with search and replace issures.
					]"
	date: "$Date$"
	revision: "$Revision$" 
	
class
	MSR

create
	make,
	make_with_strategy,
	make_with_search_strategy

feature {NONE} -- Initialization

	make is
			-- Set Text strategy as default to `search_strategy_internal'
		do
			create {MSR_SEARCH_TEXT_STRATEGY} search_strategy_internal.make_empty
			create {MSR_REPLACE_STRATEGY} replace_strategy_internal
		ensure
			is_replace_strategy_set : is_replace_strategy_set
		end
		
	make_with_strategy (p_search_strategy: MSR_SEARCH_STRATEGY; p_replace_strategy: MSR_REPLACE_STRATEGY) is	
			-- Set both `search_strategy_internal' and `replace_strategy_internal'.
		require
			p_search_strategy_not_void: p_search_strategy /= Void
			p_replace_strategy: p_replace_strategy /= Void
		do
			search_strategy_internal := p_search_strategy
			replace_strategy_internal := p_replace_strategy
		ensure
			is_replace_strategy_set : is_replace_strategy_set
		end
	
	make_with_search_strategy (p_search_strategy: MSR_SEARCH_STRATEGY) is
			-- Set `search_strategy_internal' with p_search_strategy.
		require
			p_search_strategy_not_void: p_search_strategy /= Void
		do
			search_strategy_internal := p_search_strategy
		end
		
feature -- Access

	search_strategy: MSR_SEARCH_STRATEGY is
			-- Search strategy
		do
			Result := search_strategy_internal
		ensure
			search_strategy_not_void: Result = search_strategy_internal
		end
		
	replace_strategy: MSR_REPLACE_STRATEGY is
			-- Replace strategy
		require
			is_replace_strategy_set: is_replace_strategy_set
		do
			Result := replace_strategy_internal
		ensure
			replace_strategy_not_void: Result = replace_strategy_internal
		end			
	
	item_matched: ARRAYED_LIST [MSR_ITEM] is
			-- Items repesenting search or replace results
		require
			is_search_launched : is_search_launched
		do
			Result := search_strategy_internal.item_matched
		ensure
			item_matched_not_void_if_launched: is_search_launched implies Result /= Void
		end
	
	item: MSR_ITEM is
			-- Current item in `item_matched'
		require
			is_search_launched: is_search_launched
			not_off: not off
		do
			Result := item_matched.item
		end	
		
feature -- Status report

	case_sensitive: BOOLEAN is
			-- If set, case will be matched when searching or replacing
		do
			Result := search_strategy_internal.case_sensitive
		end
	
	is_regular_expression_used : BOOLEAN is
			-- Regular expression is used in searching?
		do
			Result := search_strategy.is_regular_expression_used
		end
	
	is_whole_word_matched: BOOLEAN is
			-- Let searching match whole word?
		do
			Result := search_strategy.is_whole_word_matched
		end

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := (is_search_launched and then item_matched.off)
		end
		
	isfisrt: BOOLEAN is
			-- Current item is the first item?
		do
			Result := (is_search_launched and then item_matched.isfirst)
		end
	
	islast: BOOLEAN is
			-- Current item is the last item?
		do
			Result := (is_search_launched and then item_matched.islast)
		end
		
	is_empty: BOOLEAN is
			-- No matches?
		do
			Result := (is_search_launched and then item_matched.is_empty)
		end
	
	before: BOOLEAN is
			-- Is there no valid cursor position to the left of cursor?
		do
			Result := (is_search_launched and then item_matched.before)
		end
	
	is_replace_strategy_set : BOOLEAN is
			-- Is `replace_strategy_internal' set?
		do
			Result := (replace_strategy_internal /= Void)
		end

	is_replace_launched: BOOLEAN is
			-- Replace launched?
		require
			is_replace_strategy_set: is_replace_strategy_set
		do
			Result := replace_strategy_internal.is_replace_launched
		end		
	
	is_search_launched: BOOLEAN is
			-- The search launched?
		do
			Result := search_strategy_internal.is_launched	
		end
		
	is_first_text_item: BOOLEAN is
			-- Is `item' the first text item?
		local
			l_text_item: MSR_TEXT_ITEM
			l_index, l_first_text_index: INTEGER
			l_end_loop: BOOLEAN
		do
			l_index := index
			l_first_text_index := -1
			from
				start
				l_end_loop := false
			until
				after or l_end_loop
			loop
				l_text_item ?= item
				if l_text_item /= Void then
					l_end_loop := true
					l_first_text_index := index
				end
				forth
			end
			go_i_th (l_index)
			Result := (l_index = l_first_text_index)
		end		
	
	count: INTEGER is
			-- Number of items, all class and text items included
		require
			is_search_launched : is_search_launched
		do
			Result := item_matched.count
		ensure
			count_not_void: Result = item_matched.count
		end
	
	class_count: INTEGER is
			-- Number of top items that contain found text (normally number of classes or files)
		require
			is_search_launched : is_search_launched
		local
			l_index: INTEGER
			l_text_item: MSR_CLASS_ITEM
		do
			l_index := item_matched.index
			Result := 0
			from
				item_matched.start
			until
				item_matched.after
			loop
				l_text_item ?= item_matched.item
				if l_text_item /= Void then
					Result := Result + 1
				end
				item_matched.forth
			end
			if Result = 0 and not item_matched.is_empty then
				Result := 1
			end
			item_matched.go_i_th (l_index)
		end		
	
	text_found_count: INTEGER is
			-- Number of all buttom children items (normally number of texts found)
		require
			is_search_launched : is_search_launched
		local
			l_index: INTEGER
			l_text_item: MSR_TEXT_ITEM
		do
			l_index := item_matched.index
			Result := 0
			from
				item_matched.start
			until
				item_matched.after
			loop
				l_text_item ?= item_matched.item
				if l_text_item /= Void then
					Result := Result + 1
				end
				item_matched.forth
			end
			item_matched.go_i_th (l_index)
		end
		
	after : BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?			
		do
			Result := (is_search_launched and then item_matched.after)
		end
		
	index : INTEGER is
			-- Index of current position
		do
			if is_search_launched then
				Result := item_matched.index	
			end
		end
		
	exhausted: BOOLEAN is
			-- Has structure been completely explored?
		do
			Result := (is_search_launched and then item_matched.exhausted)
		end		
	
	index_of_item (p_item: MSR_ITEM; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of item identical to `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- 0 if none.
			-- (from CHAIN)
		require
			positive_occurrences: i > 0
			is_search_launched: is_search_launched
		do
			Result := item_matched.index_of (p_item, i)
		end
	
	contain_data (a_data: ANY) : BOOLEAN is
			-- Does `item_matches' contain `a_data'?
		local
			l_cursor: ARRAYED_LIST_CURSOR
		do
			if is_search_launched then
				l_cursor := item_matched.cursor
				from
					item_matched.start
				until
					item_matched.after
				loop
					Result := (item_matched.item.data = a_data)
					item_matched.forth
				end
				item_matched.go_to (l_cursor)
			end
		end

feature -- Status setting

	set_search_strategy (p_strategy: MSR_SEARCH_STRATEGY) is
			-- Set `search_strategy_internal'.
		require
			p_strategy_not_void: p_strategy /= Void
		do
			search_strategy_internal := p_strategy
		ensure
			search_strategy_internal_set: search_strategy_internal = p_strategy
		end

	set_replace_strategy (p_strategy: MSR_REPLACE_STRATEGY) is	
			-- Set `replace_strategy_internal'.
		require
			p_strategy_not_void: p_strategy /= Void
		do
			replace_strategy_internal := p_strategy
		ensure
			replace_strategy_internal_set: replace_strategy_internal = p_strategy
		end

	set_keyword (text: STRING) is
			-- Set keyword for searching.
		require
			text_not_void: text /= Void
		do
			search_strategy_internal.set_keyword (text)
		end
	
	set_surrounding_text_range (range: INTEGER) is
			-- Set maximul number of characters by each side of the found text.
		require
			surrounding_text_range_larger_and_equal_then_zero: range >= 0
		do
			search_strategy_internal.set_surrounding_text_range (range)
		end
		
	set_case_sensitive is
			-- Set search matching case.
		do
			search_strategy_internal.set_case_sensitive
		ensure
			case_sensitive: case_sensitive
		end
	
	set_case_insensitive is
			-- Set search caseless.
		do
			search_strategy_internal.set_case_insensitive
		ensure
			case_insensitive: not case_sensitive
		end
	
	set_replace_string (string: STRING) is
			-- String to replace 
		require
			string_not_void: string /= Void
			is_replace_strategy_set: is_replace_strategy_set
		do
			replace_strategy_internal.set_replace_string (string)
		end

	set_regular_expression_used (p_regular_expression_used: BOOLEAN) is
			-- Set is_regular_expression_used
		do
			search_strategy.set_regular_expression_used (p_regular_expression_used)			
		end
		
	set_whole_word_matched (p_whole_word_matched: BOOLEAN) is
			-- Set is_whole_word_matched
		do
			search_strategy.set_whole_word_matched (p_whole_word_matched)
		end	
	
feature -- Cursor movement

	back is
			-- Move cursor one position backward.
		require
			is_search_launched: is_search_launched
		do
			search_strategy_internal.item_matched.back
		end

	finish is
			-- Move cursor to last position if any.
		require
			is_search_launched: is_search_launched
		do
			search_strategy_internal.item_matched.finish
		end
		
	forth is
			-- Move cursor one position forward.
		require
			is_search_launched: is_search_launched
		do
			search_strategy_internal.item_matched.forth
		end

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		require
			is_search_launched: is_search_launched
		do
			search_strategy_internal.item_matched.go_i_th (i)
		end

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		require
			is_search_launched: is_search_launched
		do
			search_strategy_internal.item_matched.go_to (p)
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		require
			is_search_launched: is_search_launched
		do
			search_strategy_internal.item_matched.move (i)
		end

	search (v: MSR_ITEM) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- If structure does not include `v' ensure that
			-- `exhausted' will be true.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		require
			is_search_launched: is_search_launched
		do
			search_strategy_internal.item_matched.search (v)
		end

	start is
			-- Move cursor to first position if any.
		require
			is_search_launched: is_search_launched
		do
			search_strategy_internal.item_matched.start
		end
		
	go_to_first_text_item is
			-- Go to first text item, if none, off.
		require
			is_search_launched: is_search_launched
		local
			l_text_item: MSR_TEXT_ITEM
		do
			if not is_empty then
				from
					start
					l_text_item ?= item
				until
					after or l_text_item /= Void
				loop
					forth
					l_text_item ?= item
				end
			end
		end		

	go_to_next_text_item (reverse: BOOLEAN) is
			-- Go to next text item if exists, if reverse go to previous text item.
		local
			l_text_item: MSR_TEXT_ITEM
		do
			if is_search_launched then
				if reverse then
					if item_matched.isfirst or is_first_text_item then
						item_matched.finish
					else
						if not before then
							from
								back
								l_text_item ?= item
							until
								item_matched.isfirst or is_first_text_item or l_text_item /= Void or off
							loop
								back
								if not off then
									l_text_item ?= item
								end
							end
							if off then
								go_to_first_text_item
								if off then
									start
								end
							end
						end
					end
				else
					if item_matched.islast then
						go_to_first_text_item
					else
						if not item_matched.islast and not after then
							from
								forth
								if not off then
									l_text_item ?= item
								end
							until
								item_matched.islast or l_text_item /= Void or off
							loop
								forth
								if not off then
									l_text_item ?= item
								end
							end
							if off then
								item_matched.finish
							end
						end
					end
				end
			end
		end
		
	go_to_closest_item (a_position: INTEGER; backwards: BOOLEAN; a_data: ANY; compare_data: BOOLEAN) is
			-- Go to the item closest to `a_position', if compare_data compare data.
		local
			l_cursor: INTEGER
			l_start, l_end, last_encounter: INTEGER
			l_text_item: MSR_TEXT_ITEM
			l_end_loop: BOOLEAN
		do
			if is_search_launched then
				l_start := 0
				l_end := {INTEGER}.max_value
				
				l_cursor := item_matched.index
				if compare_data then
					if a_data = Void then
						go_to_next_text_item (backwards)
					else
						if backwards then
							from
								item_matched.start
								l_end_loop := false
								last_encounter := 0
							until
								item_matched.after or l_end_loop
							loop
								l_text_item ?= item_matched.item
								if l_text_item /= Void and then l_text_item.data = a_data then
									last_encounter := index
									if a_position <= l_text_item.end_index_in_unix_text then
										l_cursor := index
										l_end_loop := true
									end
								end
								item_matched.forth
							end
							if contain_data (a_data) then
								if l_end_loop then
									go_i_th (l_cursor)
									go_to_next_text_item (backwards)
								else
									go_i_th (last_encounter)
								end
							else
								go_i_th (l_cursor)
								go_to_next_text_item (backwards)
							end						
						else
							from
								item_matched.finish
								l_end_loop := false
								last_encounter := 0
							until
								item_matched.before or l_end_loop
							loop
								l_text_item ?= item_matched.item
								if l_text_item /= Void and then l_text_item.data = a_data then
									last_encounter := index
									if a_position > l_text_item.start_index_in_unix_text then
										l_cursor := index
										l_end_loop := true
									end
								end
								item_matched.back
							end
							if contain_data (a_data) then
								if l_end_loop then
									go_i_th (l_cursor)
									go_to_next_text_item (backwards)
								else
									go_i_th (last_encounter)
								end
							else
								go_i_th (l_cursor)
								go_to_next_text_item (backwards)
							end	
						end
					end
				else
					if backwards then
						from
							item_matched.start
							l_end_loop := false
							last_encounter := 0
						until
							item_matched.after or l_end_loop
						loop
							l_text_item ?= item_matched.item
							if l_text_item /= Void then
								last_encounter := index
								if a_position <= l_text_item.end_index_in_unix_text then
									l_cursor := index
									l_end_loop := true
								end
							end
							item_matched.forth
						end
						if l_end_loop then
							go_i_th (l_cursor)
							go_to_next_text_item (backwards)
						else
							go_i_th (last_encounter)
						end			
					else
						from
							item_matched.finish
							l_end_loop := false
							last_encounter := 0
						until
							item_matched.before or l_end_loop
						loop
							l_text_item ?= item_matched.item
							if l_text_item /= Void then
								last_encounter := index
								if a_position > l_text_item.start_index_in_unix_text then
									l_cursor := index
									l_end_loop := true
								end
							end
							item_matched.back
						end
						if l_end_loop then
							go_i_th (l_cursor)
							go_to_next_text_item (backwards)
						else
							go_i_th (last_encounter)
						end
					end
				end
			end
		end
		
feature -- Basic operations		
		
	reset_all is
			-- Reset
		do
			search_strategy_internal.reset_all
		end

	do_search is
			-- Launch searching
		do
			search_strategy_internal.launch
		end
	
	replace is
			-- Replace current item.
		require
			is_replace_strategy_set: is_replace_strategy_set
			is_search_launched : is_search_launched
			item_matched_not_off: not off
		do
			replace_strategy.set_surrounding_text_range (search_strategy.surrounding_text_range)
			replace_strategy.set_replace_items (search_strategy_internal.item_matched)
			replace_strategy_internal.replace
			last_replaced_text_internal := search_strategy_internal.item_matched.item.source_text
		ensure
			last_replaced_text_not_void: last_replaced_text_internal /= Void
			is_replace_launched: is_replace_launched
		end
	
	replace_all is
			-- Replace all item in the search result.
		require
			is_replace_strategy_set: is_replace_strategy_set
			is_search_launched : is_search_launched
		local
			i: INTEGER
		do
			i := index
			replace_strategy.set_surrounding_text_range (search_strategy.surrounding_text_range)
			replace_strategy.set_replace_items (search_strategy_internal.item_matched)
			replace_strategy.replace_all
			go_i_th (i)
		ensure
			keep_current_position: old index = index
		end

feature {NONE} -- Implementation

	search_strategy_internal: MSR_SEARCH_STRATEGY
			-- Search strategy
			
	replace_strategy_internal: MSR_REPLACE_STRATEGY
			-- Replace strategy
			
	last_replaced_text_internal: STRING
			-- The last result replacement has conducted.
			
invariant

	if_replace_launched_last_replaced_text_not_void: is_replace_launched implies last_replaced_text_internal /= Void
	search_strategy_internal_not_void: search_strategy_internal /= Void

end
