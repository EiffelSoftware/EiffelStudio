indexing
	description: "Use to search in a CLASS_I"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
	make (a_keyword: STRING; a_range: INTEGER; a_class: CLASS_I; only_compiled_class: BOOLEAN) is
			-- Initialization with a class to be searched
		require
			a_class_not_void: a_class /= Void
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
		do
			make_search_strategy (a_keyword, a_range)
			set_class (a_class)
			only_compiled_class_searched := only_compiled_class
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
			if (not only_compiled_class_searched) or else class_i.is_compiled then
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
			only_compiled_class_searched := false
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
	
	only_compiled_class_searched: BOOLEAN

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
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
