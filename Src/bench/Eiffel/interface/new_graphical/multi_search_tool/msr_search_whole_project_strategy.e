indexing
	description: "Search strategy used to search the whole project"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_WHOLE_PROJECT_STRATEGY

inherit
	MSR_SEARCH_IN_SCOPE_STRATEGY
		redefine
			launch
		end

	SHARED_WORKBENCH

create
	make

feature -- Basic Operation	

	launch is
			-- Launch the search
		local
			classes: DS_HASH_SET [CLASS_I]
		do
			create item_matched_internal.make (1000)
			classes := universe.all_classes
			if classes /= Void and then not classes.is_empty then
				from
					classes.start
				until
					classes.after
				loop
					create class_strategy.make (keyword,
											surrounding_text_range_internal,
											classes.item_for_iteration,
											only_compiled_class_searched)
					if case_sensitive then
						class_strategy.set_case_sensitive
					else
						class_strategy.set_case_insensitive
					end
					class_strategy.set_regular_expression_used (is_regular_expression_used)
					class_strategy.set_whole_word_matched (is_whole_word_matched)
					class_strategy.launch
					if class_strategy.is_launched then
						item_matched_internal.finish
						item_matched_internal.merge_right (class_strategy.item_matched)
					end
					classes.forth
				end
			end
			launched := true
			if not item_matched_internal.is_empty then
				item_matched_internal.start
			end
		end
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
