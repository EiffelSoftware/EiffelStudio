note
	description: "Object that represents a search engine used in EVS_GRID_WRAPPER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_GRID_SEARCH_ENGINE

feature -- Search

	search (a_grid_wrapper: EVS_GRID_WRAPPER [ANY]; a_start_from_current: BOOLEAN)
			-- Search in `a_grid_wrapper' for `a_keyword' and
			-- make sure result available in `last_result'.
			-- If `a_start_from_current' is True, search will start from current selected item, if any,
			-- otherwise, it will start from next item of current selected item.
		require
			keyword_attached: keyword /= Void
			not_keyword_is_empty: not keyword.is_empty
			a_grid_wrapper_attached: a_grid_wrapper /= Void
		deferred
		end

feature -- Result

	last_result: EVS_GRID_SEARCH_RESULT
			-- Last result from `search'
		do
			if last_result_internal = Void then
				create last_result_internal.make
			end
			Result := last_result_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	enable_case_sensitive_match
			-- Enable case sensitive match.
		do
			is_case_sensitive_match := True
		ensure
			case_sensitive_enabled: is_case_sensitive_match
		end

	disable_case_sensitive_match
			-- Disable case sensitive match.
		do
			is_case_sensitive_match := False
		ensure
			case_sensitive_disabled: not is_case_sensitive_match
		end

	enable_regular_expression_match
			-- Enable regular expression match.
		do
			is_regular_expression_match := True
		ensure
			regular_expr_enabled: is_regular_expression_match
		end

	disable_regular_expression_match
			-- Disable regular expression match.
		do
			is_regular_expression_match := False
		ensure
			regular_expr_disabled: not is_regular_expression_match
		end

	enable_wholeword_match
			-- Enable wholeword match.
		do
			is_wholeword_match := True
		ensure
			wholeword_match_enabled: is_wholeword_match
		end

	disable_wholeword_match
			-- Disable wholeword match.
		do
			is_wholeword_match := False
		ensure
			wholeword_match_disabled: not is_wholeword_match
		end

	enable_wholecell_match
			-- Enable wholecell match.
		do
			is_wholecell_match := True
		ensure
			wholecell_match_enabled: is_wholecell_match
		end

	disable_wholecell_match
			-- Disable wholecell match.
		do
			is_wholecell_match := False
		ensure
			wholecell_match_disabled: not is_wholecell_match
		end

	enable_only_search_in_selected_item
			-- Enable only search in selected items.
		do
			only_search_in_selected_item := True
		ensure
			only_search_in_selected_items_enabled: only_search_in_selected_item
		end

	disable_only_search_in_selected_item
			-- Disable only search in selected items.
		do
			only_search_in_selected_item := False
		ensure
			only_search_in_selected_items_disabled: not only_search_in_selected_item
		end

	set_keyword (a_keyword: like keyword)
			-- Set `keyword' with `a_keyword'.
		require
			a_keyword_attached: a_keyword /= Void
			not_a_keyword_is_empty: not a_keyword.is_empty
		do
			if keyword = Void then
				create keyword.make_from_string (a_keyword)
			else
				keyword.wipe_out
				keyword.append (a_keyword)
			end
		ensure
			keyword_set: attached keyword as k and then k.same_string (a_keyword)
		end

feature -- Access

	keyword: STRING_32
			-- Keyword used in `search'

feature -- Status report

	is_case_sensitive_match: BOOLEAN
			-- Does `search' match case sensitive?

	is_regular_expression_match: BOOLEAN
			-- Does `search' use regular expression?

	is_wholeword_match: BOOLEAN
			-- Does `search' match wholeword?

	is_wholecell_match: BOOLEAN
			-- Does `search' match wholecell?

	only_search_in_selected_item: BOOLEAN
			-- Does `search' only perform on selected items?

feature{NONE} -- Implementation

	last_result_internal: like last_result
			-- Internal `last_result'

invariant
	last_result_attached: last_result /= Void

note
        copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
        license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
