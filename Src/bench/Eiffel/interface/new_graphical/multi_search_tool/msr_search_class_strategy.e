indexing
	description: "Use to search in a CLASS_I"
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_CLASS_STRATEGY

inherit
	MSR_SEARCH_STRATEGY
		redefine
			make,
			launch,
			reset_all,
			is_search_prepared
		end
		
create
	make,
	make_with_class

feature {NONE} -- Initialization

	make is
			-- Initailzation
		do
			Precursor
			reset_all
		end
		
	make_with_class (a_class: CLASS_I) is
			-- Initialization with a class to be searched
		require
			a_class_not_void: a_class /= Void
		do
			make
			set_class (a_class)
		end

feature -- Basic operation

	launch is
			-- Launch the search
		local
			class_item: MSR_CLASS_ITEM
		do
			create item_matched_internal.make (0)
			create text_strategy.make
			if case_sensitive then 
				text_strategy.set_case_sensitive 
			else
				text_strategy.set_case_insensitive 
			end
			text_strategy.set_keyword (keyword)
			text_strategy.set_surrounding_text_range (surrounding_text_range_internal)
			text_strategy.set_text_in_file_path (class_i.file_name)
			text_strategy.set_text_to_be_searched (class_text)
			text_strategy.set_whole_word_matched (is_whole_word_matched)
			text_strategy.set_regular_expression_used (is_regular_expression_used)
			text_strategy.set_class_name (class_i.name)
			text_strategy.set_data (class_i)
			text_strategy.launch
			if text_strategy.is_launched then
				if text_strategy.item_matched.count > 0 then
					create class_item.make
					class_item.set_class_name (text_strategy.class_name)
					class_item.set_path (class_i.file_name)
					class_item.set_source_text (text_strategy.text_to_be_searched_adapter)
					class_item.set_data (class_i)
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
			launched := true
			if not item_matched_internal.is_empty then
				item_matched_internal.start
			end
		end
	
	reset_all is
			-- Reset all
		do
			Precursor
			text_strategy := Void
			class_i := Void
			class_text := Void
		end

feature -- Status report

	is_class_set: BOOLEAN is	
			-- Is the `class_i' set?
		do
			Result := (class_i /= Void)
		end
		
	is_search_prepared: BOOLEAN is
			-- Is search prepared?
		do
			Result := 
			Precursor and
			is_class_set	
		end	

feature -- Element change

	set_class (a_class: CLASS_I) is
			-- Set `class_i' with a_class.
		require
			a_class_not_void: a_class /= Void
		do
			class_i := a_class
			class_text := class_i.text
		ensure
			class_i_not_void: class_i /= Void
		end

feature {NONE} -- Implementation

	text_strategy: MSR_SEARCH_TEXT_STRATEGY
			-- Actual search strategy used to search in a class text
	
	class_i: CLASS_I
			-- Class to be searched
	
	class_text: STRING
			-- String buffer to store class text temporarily

invariant
	invariant_clause: True -- Your invariant here
	class_text_not_void_after_class_set: is_class_set implies (class_text /= Void)
end
