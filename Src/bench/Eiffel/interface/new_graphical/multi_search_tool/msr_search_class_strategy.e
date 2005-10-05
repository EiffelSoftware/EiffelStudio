indexing
	description: "Use to search in a CLASS_I"
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_CLASS_STRATEGY

inherit
	MSR_SEARCH_STRATEGY
		redefine
			launch,
			reset_all,
			is_search_prepared
		end
		
create
	make

feature {NONE} -- Initialization
		
	make (a_keyword: STRING; a_range: INTEGER; a_class: CLASS_I) is
			-- Initialization with a class to be searched
		require
			a_class_not_void: a_class /= Void
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
		do
			make_search_strategy (a_keyword, a_range)
			set_class (a_class)
		end

feature -- Basic operation

	launch is
			-- Launch the search
		local
			l_class_item: MSR_CLASS_ITEM
			l_matched: ARRAYED_LIST [MSR_ITEM]
			l_children: ARRAYED_LIST [MSR_TEXT_ITEM]
			l_item: MSR_TEXT_ITEM
		do
			create item_matched_internal.make (0)
			create text_strategy.make (keyword, surrounding_text_range_internal, class_i.name, class_i.file_name, class_text)
			if case_sensitive then 
				text_strategy.set_case_sensitive 
			else
				text_strategy.set_case_insensitive 
			end
			text_strategy.set_whole_word_matched (is_whole_word_matched)
			text_strategy.set_regular_expression_used (is_regular_expression_used)
			text_strategy.set_data (class_i)
			text_strategy.set_date (class_i.date)
			text_strategy.launch
			if text_strategy.is_launched then
				if text_strategy.item_matched.count > 0 then
					create l_class_item.make (text_strategy.class_name, class_i.file_name, text_strategy.text_to_be_searched_adapter)
					l_class_item.set_data (class_i)
					l_class_item.set_date (class_i.date)
					item_matched_internal.extend (l_class_item)
					
					l_matched := text_strategy.item_matched
					create l_children.make (l_matched.count)
					from
						l_matched.start
					until
						l_matched.after
					loop
						l_item ?= l_matched.item
						check
							l_item_attached: l_item /= Void
						end
						if l_item /= Void then
							l_children.extend (l_item)	
						end
						l_matched.forth
					end
					l_class_item.set_children (l_children)
					item_matched_internal.append (text_strategy.item_matched)
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
			if class_text = Void then
				class_text := ""
			end
		ensure
			class_i_not_void: class_i /= Void
			class_text_attached: class_text /= Void
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
