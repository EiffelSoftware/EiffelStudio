indexing
	description: "Objects that search through the editor content for a given pattern"
	author: "Etienne AMODEO"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SEARCH_PERFORMER

inherit

	EB_UNDO_REDO_OBSERVER
		redefine
			on_changed
		end
create
	make

feature {NONE} -- Initialization

	make is
		do
			create search_results.make (0)
			create current_pattern.make (0)
		ensure
			search_results_is_not_void: search_results /= void	
		end

feature -- Access

	search_results: ARRAYED_LIST [SEARCH_POSITION]
			-- Stores the result of the search computed by `search_text'.
	
	current_position: INTEGER
			-- Number of the current occurrence of the searched word in the file.
	
	editor: EB_EDITOR 
			-- Editor in which the search is performed.

	text: EDITABLE_TEXT is
			-- Text displayed in `editor'.
		do
			Result := editor.text_displayed
		end

	current_file: FILE_NAME
			-- Class being displayed.

	current_pattern: STRING
			-- Word that is being searched.

feature -- Element Change

	set_editor (an_editor: EB_EDITOR) is
			-- set `editor' to `an_editor'.
		require
			editor_is_not_void: an_editor /= Void
		do
			if editor /= an_editor then
				if editor /= Void then
					editor.remove_history_observer (Current)
				end
				editor := an_editor
				editor.add_history_observer (Current)
				search_again := True
			end
		end

feature -- status report

	is_case_sensitive: BOOLEAN
			-- is the search case sensitive ?
			-- false by default

	search_whole_word: BOOLEAN
			-- is the searched word isolated ?

	replace_all: BOOLEAN
			-- Must all the occurrences of the searched word be replaced ?

	use_wildcards: BOOLEAN
			-- does pattern contain wildcards ?

	reverse: BOOLEAN
			-- search backward ?
	
feature -- status setting

	go_reverse is
			-- next search, search backward
		do
			reverse := True
		end

	set_case_sensitive (cs: BOOLEAN) is
			-- set whether the search is case_sensitive or not
		do
			search_again := search_again or (cs /= is_case_sensitive)
			is_case_sensitive := cs
		end

	set_search_whole_word (sww: BOOLEAN) is
			-- set whether the search pattern can be part of a word or not
		do
			search_again := search_again or (sww /= search_whole_word)
			search_whole_word := sww
		end

	set_replace_all (ra: BOOLEAN) is
			-- set whether all the occurrences of the searched word must be replaced 
		do
			search_again := search_again or (ra /= replace_all)
			replace_all := ra
		end

	force_search is
			-- force new search
		do
			search_again := true
		end

	set_use_wildcards (uw: BOOLEAN) is
			-- set whether pattern contains wildcards
		do
			search_again := search_again or (uw /= use_wildcards)
			use_wildcards := uw	
		end

feature -- Basic operations

	search (searched_string: STRING) is
			-- search `a_word' in the current class
		require
			searched_string_not_void: searched_string /= Void
		local
			cur_pos: INTEGER
		do
			search_again := search_again or else different_position_as_when_last_saved
			internal_search (searched_string)
			if not search_results.is_empty then
				if reverse then
					reverse := False
					if editor.has_selection then
						cur_pos := text.selection_start.pos_in_text
					else
						cur_pos := text.cursor.pos_in_text
					end
					go_to_previous_result (cur_pos)
				else
					cur_pos := text.cursor.pos_in_text
					go_to_next_result (cur_pos)
				end
			end
			select_and_show (True)
				-- selecting will make the cursor go forward
			save_cursor_position
		end

	replace (searched_string: STRING; replacing_string: STRING) is
			-- replace found word with the content of `the_replace_field'
		require
			searched_string_not_void: searched_string /= Void
			replacing_string_not_void: replacing_string /= Void
			text_is_editable: editor.is_editable
		do
			if replace_all then
				replace_all_occurrences (searched_string, replacing_string)
			else
				replace_current (searched_string, replacing_string)
			end			
		end

feature {NONE} -- Replacement

	replace_current (searched_string: STRING; replacing_string: STRING) is
			-- replace found word with the content of `the_replace_field'
		local
			current_result:  SEARCH_POSITION
			pos_in_file, difference: INTEGER
			cur_pos: INTEGER
		do
			search_again := search_again or else different_position_as_when_last_saved
			internal_search (searched_string)
			if not search_results.is_empty then
				if has_searched then
					cur_pos := text.cursor.pos_in_text
					go_to_next_result (cur_pos)
				end
				current_result := search_results.item
				select_and_show (False)
				editor.replace_selection (replacing_string)
				search_again := False
				difference := replacing_string.count - current_result.length
				pos_in_file := search_results.item.character_count + current_result.length
				from
					search_results.remove
				until
					search_again or search_results.after
				loop
					search_again := search_results.item.character_count <= pos_in_file
					search_results.item.add_offset (difference)
					search_results.forth
				end
				search_again := search_again or else search_results.is_empty
				internal_search (searched_string)
				if not search_results.is_empty then
					go_to_next_result (current_result.character_count + difference + 1)
					select_and_show (True)
				end
			end
			save_cursor_position
		end
	
	replace_all_occurrences (searched_string: STRING; replacing_string: STRING) is
			-- replace found word with the content of `the_replace_field'
		local
			current_result:  SEARCH_POSITION
			pos_in_file: INTEGER
			total_difference: INTEGER
		do
			internal_search (searched_string)
			from 
				search_results.start
			until
				search_results.after
			loop
				current_result := search_results.item
				search_results.forth
				pos_in_file := current_result.character_count + total_difference
				text.replace_for_replace_all (pos_in_file, current_result.length + pos_in_file, replacing_string)
				total_difference := total_difference - current_result.length + replacing_string.count 
			end
			editor.refresh
			search_again := True
		end

feature {NONE} -- Implementation : Private status

	search_again: BOOLEAN
			-- is search forced ?

	has_searched: BOOLEAN
			-- did `internal_search' actually looked for pattern in text ?

feature {NONE} -- Search implementation

	internal_search (searched_string: STRING) is
			-- search `a_word' in the current class
		require
			editor_is_not_void: editor /= Void
		local
			buffer: SEARCH_BUFFER
			kmp_matcher: KMP_MATCHER
		do
			has_searched := search_again
						or else
					current_file /= editor.file_name
						or else
					 (not searched_string.is_equal (current_pattern))
			if has_searched then
				current_file := editor.file_name
				current_pattern := searched_string
				create buffer.make_from_string (editor.text)
				search_again := False
				if use_wildcards and then (current_pattern.has ('*') or else current_pattern.has ('?')) then
					create {KMP_WILD} kmp_matcher.make (current_pattern, buffer)
				else
					create {KMP_MATCHER} kmp_matcher.make (current_pattern, buffer)
				end
				if is_case_sensitive then
					kmp_matcher.enable_case_sensitive
				else
					kmp_matcher.disable_case_sensitive
				end
				process_search (kmp_matcher)
			end
		end

feature {NONE} -- Implementation

	go_to_next_result (cur_pos:INTEGER) is
			-- set `current_position' so that current search result is the first after
			-- position `cur_pos' in text
		do
			from
				search_results.start
			until
				search_results.after or else search_results.item.character_count >= cur_pos
			loop
				search_results.forth
			end
			if search_results.after then
				search_results.start
			end
		end

	go_to_previous_result (cur_pos:INTEGER) is
			-- set `current_position' so that current search result is the first after
			-- position `cur_pos' in text
		do
			from
				search_results.finish
			until
				search_results.before or else search_results.item.character_count < cur_pos
			loop
				search_results.back
			end
			if search_results.before then
				search_results.finish
			end
		end

	process_search (kmp_matcher: KMP_MATCHER) is
		local
			indices, lengths: ARRAYED_LIST [INTEGER]
			sp: SEARCH_POSITION
			store: BOOLEAN
			txt, word, pattern: STRING
			start, stop: INTEGER
		do
			kmp_matcher.find_matching_indices
			indices := kmp_matcher.matching_indices
			lengths := kmp_matcher.lengths
			txt := kmp_matcher.text
			pattern := kmp_matcher.pattern
			from
				create search_results.make (indices.count)
				lengths.start
				indices.start
			until
				indices.after
			loop
				store := True
				if search_whole_word then
					start := indices.item
					stop := indices.item + lengths.item - 1 
					word := txt.substring (start, stop)
					store := 	 (start = 1 or else is_separator (txt @ (start - 1)))
								and then
							 (stop = txt.count or else is_separator (txt @ (stop + 1)))
								and then
							 (same_separators (word, pattern))
				end
				if store then
					create sp.make (indices.item, lengths.item)
					search_results.extend (sp)
				end
				indices.forth
				lengths.forth
			end
		end

	select_and_show (show: BOOLEAN) is
			-- select the `current_position'-th occurrence of the searched word in the editor
			-- if `show' is true, center the display on the selection.
		local
			pos_in_file: INTEGER
			s_a :BOOLEAN 
		do
			if search_results.off then
				editor.deselect_all
				editor.refresh
			else
				s_a := search_again
				pos_in_file := search_results.item.character_count
				editor.select_region (pos_in_file , search_results.item.length + pos_in_file)
				if show then 
					editor.show_selection (False)
				end
				search_again := s_a
			end
		end
	
	is_separator (c: CHARACTER): BOOLEAN is
		do
			Result := not (c.is_alpha or else c = '_')
		end

	same_separators (w, p: STRING): BOOLEAN is
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				i > w.count or not Result
			loop
				if is_separator (w.item (i)) then
					Result := w.occurrences (w.item (i)) = p.occurrences (w.item (i))
				end
				i := i + 1
			end
		end

	save_cursor_position is
			-- Save current cursor position.
		local
			cur: TEXT_CURSOR
		do
			cur := text.cursor
			x_pos_when_moved := cur.x_in_characters
			y_pos_when_moved := cur.y_in_lines
		end

	different_position_as_when_last_saved: BOOLEAN is
			-- Is the cursor at the same position as when its
			-- position was saved for the last time?
		local
			cur: TEXT_CURSOR
		do
			cur := text.cursor
			Result := 
					x_pos_when_moved /= cur.x_in_characters
						or else
					y_pos_when_moved /= cur.y_in_lines

		end

	x_pos_when_moved: INTEGER
			-- x position of cursor when saved.
			
	y_pos_when_moved: INTEGER
			-- y position of cursor when saved.

			
feature {UNDO_REDO_STACK} -- Observer pattern

	on_changed is
		do
			search_again := True
		end 
	
end -- class EB_SEARCH_PERFORMER
