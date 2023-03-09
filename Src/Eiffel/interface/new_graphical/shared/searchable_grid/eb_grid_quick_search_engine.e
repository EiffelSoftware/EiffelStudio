note
	description: "Objects that represents a search engine for search through quick search bar"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_QUICK_SEARCH_ENGINE

inherit

	EVS_GRID_INCREMENTAL_SEARCH_ENGINE

feature -- Search

	search (a_grid_wrapper: EVS_GRID_WRAPPER [ANY]; a_start_from_current: BOOLEAN)
			-- Search in `a_grid_wrapper' for `a_keyword' and
			-- make sure result available in `last_result'.
		local
			l_itr: like grid_iterator
			l_original_x, l_original_y: INTEGER
			l_search_strategy: like msr_search_strategy
			l_item: EVS_GRID_SEARCHABLE_ITEM
			done: BOOLEAN
			l_image: STRING_32
			l_step_count: INTEGER
		do
			last_result.wipe_out
			l_search_strategy := msr_search_strategy
			prepare_search_strategy (l_search_strategy)
			l_itr := grid_iterator (a_grid_wrapper)
			if is_wrap_search_enabled then
				l_itr.enable_wrap_iteration
			else
				l_itr.disable_wrap_iteration
			end
			if not l_itr.off then
				l_original_x := l_itr.item_column_index
				l_original_y := l_itr.item_row_index
				if is_search_foreward then
					from
						if not a_start_from_current then
							l_itr.forth
							l_step_count := l_step_count + 1
						end
					until
						l_itr.after or done
					loop
						l_item := l_itr.item
						if l_item /= Void then
							l_image := l_item.image
							if not l_image.is_empty then
								l_search_strategy.set_text_to_be_searched (l_item.image)
								l_search_strategy.launch
								if not l_search_strategy.item_matched.is_empty then
									last_result.extend (l_item)
									done := True
								end
							end
						end
						if not done and then (l_step_count > 0 and l_itr.is_same_position (l_original_x, l_original_y)) then
							done := True
						end
						l_itr.forth
						l_step_count := l_step_count + 1
					end
				else
					from
						if not a_start_from_current then
							l_itr.back
							l_step_count := l_step_count + 1
						end
					until
						l_itr.before or done
					loop
						l_item := l_itr.item
						if l_item /= Void then
							l_image := l_item.image
							if not l_image.is_empty then
								l_search_strategy.set_text_to_be_searched (l_item.image)
								l_search_strategy.launch
								if not l_search_strategy.item_matched.is_empty then
									last_result.extend (l_item)
									done := True
								end
							end
						end
						if not done and then (l_step_count > 0 and l_itr.is_same_position (l_original_x, l_original_y)) then
							done := True
						end
						l_itr.back
						l_step_count := l_step_count + 1
					end
				end
			end
		ensure then
			last_result_correct: last_result.count <= 1
		end

feature{NONE} -- Implementation

	prepare_search_strategy (a_strategy: like msr_search_strategy)
			-- Prepare `a_strategy' before `search',
			-- e.g. setup search conditions.			
		require
			a_strategy_attached: a_strategy /= Void
		do
			a_strategy.set_keyword (keyword)
			if is_case_sensitive_match then
				a_strategy.set_case_sensitive
			else
				a_strategy.set_case_insensitive
			end
			a_strategy.set_regular_expression_used (is_regular_expression_match)
			a_strategy.set_whole_word_matched (is_wholeword_match)
		ensure
			a_strategy_prepared:
				a_strategy.keyword.is_equal (keyword) and then
				(is_case_sensitive_match implies a_strategy.case_sensitive) and then
				(not is_case_sensitive_match implies not a_strategy.case_sensitive) and then
				(is_regular_expression_match implies a_strategy.is_regular_expression_used) and then
				(is_wholeword_match implies a_strategy.is_whole_word_matched)

		end

	msr_search_strategy: MSR_SEARCH_INCREMENTAL_STRATEGY
			-- MSR search strategy used to search
		do
			if msr_search_strategy_internal = Void then
				create msr_search_strategy_internal.make_empty
				msr_search_strategy_internal.set_text_in_file_path (create {PATH}.make_empty)
			end
			Result := msr_search_strategy_internal
		ensure
			result_attached: Result /= Void
		end

	msr_search_strategy_internal: like msr_search_strategy;
			-- Internal `msr_search_strategy'

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
