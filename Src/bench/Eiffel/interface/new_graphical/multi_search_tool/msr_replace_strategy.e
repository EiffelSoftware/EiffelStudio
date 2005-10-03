indexing
	description: "[
				Regular replace strategy, replace current item in replace_items,
				 after replacing items_matched are refreshed. `is_current_replaced_as_cluster'
				 can be rewritten to tell if a_item should be replaced as in a cluster, i.e a file.
				 `one_cluster_item_replaced' can be rewritten, it will be invoked when items in a cluster
				 are replaced.
				 ]"
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_REPLACE_STRATEGY

feature -- Access
	
	replace_items: ARRAYED_LIST [MSR_ITEM] is
			-- Replace items upon which replacing will be done.
		require
			is_replace_items_set: is_replace_items_set
		do
			Result := replace_item_internal
		ensure
			replace_item_not_void : Result = replace_item_internal
		end

	replace_string: STRING is
			-- Replacement string.
		require
			is_replace_string_set: is_replace_string_set
		do
			Result := replace_string_internal
		ensure	
			replace_string_not_void: Result = replace_string_internal
		end

feature -- Element change

	set_replace_items (items: ARRAYED_LIST [MSR_ITEM]) is
			-- Set `replace_item_internal' with items.
		require
			items_not_void: items /= Void
		do
			replace_item_internal := items
		ensure
			is_replace_items_set: is_replace_items_set
		end
		
	set_surrounding_text_range (n: INTEGER) is
			-- Set `surrounding_text_range_internal' with n.
		require
			larger_equal_than_zero: n >= 0
		do
			surrounding_text_range_internal := n
		end		
	
	set_replace_string (string: STRING) is
			-- Set `replace_string_internal' with string.
		require
			string_not_void: string /= Void
		do
			replace_string_internal := string
		ensure
			is_replace_string_set: is_replace_string_set
		end
	
feature -- Status report
	
	is_replace_items_set: BOOLEAN is
			-- Is `replace_items' set?
		do
			Result := (replace_item_internal /= Void)
		end	
	
	is_replace_string_set: BOOLEAN is
			-- Is replace_string set?
		do
			Result := (replace_string_internal /= Void)	
		end	
		
	is_replace_launched : BOOLEAN is
			-- Is replacing launched
		do
			Result := is_replace_launched_internal
		ensure
			is_replace_launched_internal: Result = is_replace_launched_internal
		end		
	
feature -- Basic operations
	
	replace is
			-- Launch replacement, one time. Other items are freshed.
		require
			replace_items_set: is_replace_items_set
			replace_string_set : is_replace_string_set
			replace_item_not_off : not replace_items.off
		local
		do
			replace_current_item (true)
			is_replace_launched_internal := true
		ensure
			is_replace_launched: is_replace_launched
			replace_items_current_in_the_same_place: old replace_items.index = replace_items.index
		end
		
	replace_all is
			-- All items will be replaced, cluster mode is used by default.
		local
			l_last_item, l_item : MSR_TEXT_ITEM
			l_string : STRING
			l_index: INTEGER
			l_refresh: BOOLEAN
		do
			l_refresh := false
			l_index := replace_items.index
			from
				replace_items.start
			until
				replace_items.after
			loop
				l_item ?= replace_items.item
				if l_item /= Void then
					if is_current_replaced_as_cluster (l_item) then
						l_item.pcre_regex.set_on_new_position_yielded (agent on_new_position_yielded (?, ?, l_item))
						if l_last_item = Void or (l_last_item /= Void and then l_last_item.pcre_regex /= l_item.pcre_regex) then
							l_item.pcre_regex.first_match
							l_string :=	l_item.pcre_regex.replace_all (replace_string)
							l_item.set_source_text_real_string (l_string)
								-- Let a way to deal with items in the same cluster. (i.e Save to files)
							one_cluster_item_replaced (l_item)
							l_last_item := l_item
						end						
					else
						replace
					end
					l_refresh := true
				end
				replace_items.forth
			end
			replace_items.go_i_th (l_index)
			if l_refresh then
				refresh_item_text
			end
			is_replace_launched_internal := true
		end		
	
feature {NONE} -- Implementation

	string_formatter: MSR_FORMATTER is
			-- String formatter. i.e. Mute every GOBO regular expression meta-characters in a string.
		once
			Result := create {MSR_FORMATTER}
		end

	replace_item_internal: ARRAYED_LIST [MSR_ITEM]
			-- Items to be replaced
			
	replace_string_internal: STRING
			-- Replacement string.

	surrounding_text_range_internal : INTEGER
			-- maximal number of charactors by oneside of text in a item's context text.
	
	one_cluster_item_replaced (a_item : MSR_TEXT_ITEM) is
			-- Consequent text items that come from the same text are replaced, a_item is one of them.
		require
			a_item_not_void: a_item /= Void
		do
		end
		
	is_current_replaced_as_cluster (a_item: MSR_TEXT_ITEM) : BOOLEAN  is
			-- When replacing all, should a_item be replaced as in a cluster as a fast way? Once Result returns
			-- true, text items surrounding a_item will be replaced in cluster as fast way. Former replacing
			-- in this cluster will be discarded.
		do
			Result := true
		end
			
	replace_current_item (refresh_finding: BOOLEAN) is
			-- Replace current_item. If refresh_finding, 
			-- surrounding and line number will be freshed in all items.
		local
			l_item : MSR_TEXT_ITEM
			l_off_set : INTEGER
		do
			l_item ?= replace_items.item
			if l_item /= Void then
			 	l_item.source_text.replace_substring (	actual_replacement (l_item),
			 													replace_items.item.start_index, 
			 													replace_items.item.end_index)
				l_item.context_text.replace_substring (	actual_replacement (l_item), 
																l_item.start_index_in_context_text, 
																l_item.text.count + l_item.start_index_in_context_text - 1
																)
				l_off_set := actual_replacement (l_item).count - replace_items.item.text.count
				l_item.set_end_index (l_item.end_index + l_off_set)
			 	refresh_item_capture_positions
			 		-- refresh_item_capture_positions counts on old finding context,
			 		-- so set_text later than refresh_item_capture_positions
			 	l_item.set_text (actual_replacement (l_item))
			 	if refresh_finding then
			 		refresh_item_text
			 	end
			end
		end
		
	refresh_item_text is	
			-- Refresh all item context, according to start and end index.
		require
			replace_items_set: is_replace_items_set
			replace_string_set : is_replace_string_set
		local
			l_text_item, last_item: MSR_TEXT_ITEM
			l_current_position: INTEGER
			present_start, present_end: INTEGER
			line_number, start_count_line_position: INTEGER
		do
			l_current_position := replace_items.index
			from 
				replace_items.start
			until
				replace_items.after
			loop
				l_text_item ?= replace_items.item
				if l_text_item /= Void then
						
					if replace_items.index > 1 then
						last_item ?= replace_items [replace_items.index - 1]
					end
					if last_item /= Void and then l_text_item.source_text = last_item.source_text then
						start_count_line_position := last_item.start_index
						line_number := last_item.line_number + string_formatter.occurrences_in_bound('%N', l_text_item.source_text, start_count_line_position, l_text_item.start_index)
						l_text_item.set_percent_r_count (last_item.percent_r_count + string_formatter.occurrences_in_bound ('%R', l_text_item.source_text, start_count_line_position, l_text_item.start_index))			
					else
						start_count_line_position := 1
						line_number := string_formatter.occurrences_in_bound('%N', l_text_item.source_text, start_count_line_position, l_text_item.start_index) + 1
						l_text_item.set_percent_r_count (string_formatter.occurrences_in_bound ('%R', l_text_item.source_text, start_count_line_position, l_text_item.start_index))			
					end
					l_text_item.set_line_number (line_number)
								
					if l_text_item.start_index - surrounding_text_range_internal > 0 then
						present_start := l_text_item.start_index - surrounding_text_range_internal
						l_text_item.set_start_index_in_context_text (surrounding_text_range_internal + 1)
					else
						present_start := 1
						l_text_item.set_start_index_in_context_text (l_text_item.start_index)
					end
					if l_text_item.end_index + surrounding_text_range_internal < l_text_item.source_text.count then
						present_end := l_text_item.end_index + surrounding_text_range_internal
					else
						present_end := l_text_item.source_text.count
					end
					l_text_item.set_context_text (l_text_item.source_text.substring (present_start,present_end))
				end
				replace_items.forth
			end
			replace_items.go_i_th (l_current_position)
		ensure
			replace_items_current_in_the_same_place: old replace_items.index = replace_items.index
		end
		
	refresh_item_capture_positions is
			-- Calculate new positions and refresh the rest items' start and end index.
		require
			replace_items_set: is_replace_items_set
			replace_string_set : is_replace_string_set
		local
			l_off_set: INTEGER
			l_text_item: MSR_TEXT_ITEM
			l_current_position: INTEGER
			l_start_index: INTEGER
			s: STRING
		do
			l_off_set := replace_string.count - replace_items.item.text.count
			s := replace_string
			s := replace_items.item.text
			l_current_position := replace_items.index
			l_start_index := replace_items.item.end_index
			from 
				replace_items.forth
				if replace_items.off then
					l_text_item := Void
				else
					l_text_item ?= replace_items.item
				end
			until
				replace_items.after or l_text_item = Void
			loop
				if l_text_item /= Void then
					l_text_item.set_end_index (l_text_item.end_index + l_off_set)
					l_text_item.set_start_index (l_text_item.start_index + l_off_set)
				end
				replace_items.forth
				if replace_items.off then
					l_text_item := Void
				else
					l_text_item ?= replace_items.item
				end				
			end		
			replace_items.go_i_th (l_current_position)
		ensure
			replace_items_current_in_the_same_place: old replace_items.index = replace_items.index
		end
	
	append_replacement_to_string (a_string, a_replacement: STRING; a_text_item: MSR_TEXT_ITEM) is
			-- Append to `a_string' a copy of `a_replacement' where all occurrences
			-- of \n\ have been replaced by the corresponding n-th captured substrings
			-- if any. This code if from GOBO RX_REGULAR_EXPRESSION but changed some here.
		require
			a_string_not_void: a_string /= Void
			a_replacement_not_void: a_replacement /= Void
		local
			i, j, nb, ref: INTEGER
			c: CHARACTER
		do
			nb := a_replacement.count
			from
				i := 1
			until
				i > nb
			loop
				c := a_replacement.item (i)
				if c = '\' then
					from
						i := i + 1
						j := i
						ref := 0
					until
						i > nb or else (a_replacement.item_code (i) < 48 or a_replacement.item_code (i) > 57)
					loop
						c := a_replacement.item (i)
						ref := ref * 10 + c.code - 48
						i := i + 1
					end
					if i <= nb then
						c := a_replacement.item (i)
						if c = '\' then
							if i > j then
								if ref <= a_text_item.captured_submatches.count then
									a_string.append (a_text_item.captured_submatches [ref])
								end
							else
								a_string.append_character (c)
							end
							i := i + 1
						else
							a_string.append_character ('\')
							i := j
						end
					else
						a_string.append_character ('\')
						i := j
					end
				else
					a_string.append_character (c)
					i := i + 1
				end
			end
		end
		
	actual_replacement (a_item: MSR_TEXT_ITEM): STRING is
			-- All /n/ have been replaced by the corresponding n-th captured substrings if any
		require
			a_item_not_void: a_item /= Void
		local
			re: STRING
		do
			re := ""
			if a_item.captured_submatches.count > 0 then
				append_replacement_to_string (re, replace_string, a_item)
			else
				re := replace_string
			end			
			Result := re
		end
		
	on_new_position_yielded (a_start, a_end : INTEGER; a_item : MSR_TEXT_ITEM) is
			-- When replacing all, start and end indexes will be yielded one by one.
			-- a_item is the item replacing.
		require
			a_item_not_void: a_item /= Void
		local
			l_item: MSR_TEXT_ITEM
			s: STRING
		do
			if not replace_items.off then
				l_item ?= replace_items.item
				if not replace_items.off and l_item /= Void then
					l_item ?= replace_items.item
					if l_item /= Void and then a_item.pcre_regex = l_item.pcre_regex then
						l_item.set_start_index (a_start)
						l_item.set_end_index (a_end)
						l_item.set_text (actual_replacement (l_item))
						s := l_item.source_text
						print (replace_items.index.out + "%N")
					end
				end
				if not replace_items.islast then
					replace_items.forth	
				end
			end
		end	
	
	is_replace_launched_internal : BOOLEAN
		-- Is replace launched?
	
invariant

	invariant_clause: True -- Your invariant here

end
