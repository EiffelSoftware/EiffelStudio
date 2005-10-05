indexing
	description: "Search in a text file."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_FILE_STRATEGY

inherit
	MSR_SEARCH_DIRECTORY_STRATEGY
		redefine
			launch, reset_all, set_path
		end

create
	
	make

feature -- Basic operations

	launch is
			-- Launch searching.
		local
			file : PLAIN_TEXT_FILE
			buffer_length : INTEGER
			text : STRING
			class_item: MSR_CLASS_ITEM
		do
			create item_matched_internal.make (0)
			buffer_length := 100
			text := ""
			create file.make (path)
			if path.out.substring (path.out.last_index_of ('.',path.out.count),path.out.count).is_equal (".e") then
				if file.exists then
					file.open_read
					if file.is_readable then
						from 
							file.start
						until
							file.end_of_file
						loop
							file.readstream (buffer_length)					
							text.append (file.laststring)
						end						
						create text_strategy.make (keyword, surrounding_text_range_internal, "", path, text)
						if case_sensitive then 
							text_strategy.set_case_sensitive 
						else 
							text_strategy.set_case_insensitive 
						end
						text_strategy.set_whole_word_matched (is_whole_word_matched)
						text_strategy.set_regular_expression_used (is_regular_expression_used)
						text_strategy.launch
						if text_strategy.is_launched then
							if text_strategy.item_matched.count > 0 then
								create class_item.make
								class_item.set_class_name (text_strategy.class_name)
								class_item.set_path (path_internal)
								class_item.set_source_text (text_strategy.text_to_be_searched_adapter)
								class_item.set_date (file.date)
								item_matched_internal.extend (class_item)
								from
									text_strategy.item_matched.start
								until
									text_strategy.item_matched.after
								loop
									class_item.children.extend (text_strategy.item_matched.item)
									text_strategy.item_matched.forth
								end
								item_matched_internal.finish
								item_matched_internal.merge_right (text_strategy.item_matched)
							end							
						end
					end
					file.close
				end									
			end
			launched := true
			item_matched_internal.start
		end

	reset_all is
			-- Reset all
		do
			Precursor	
			text_strategy := Void
		ensure then
			text_strategy_is_void: text_strategy = Void
		end		

feature {NONE} -- Implementation
	
	text_strategy: MSR_SEARCH_TEXT_STRATEGY
	
invariant
	invariant_clause: True -- Your invariant here

end
