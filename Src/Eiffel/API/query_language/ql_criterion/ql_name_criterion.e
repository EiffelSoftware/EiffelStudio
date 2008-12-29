note
	description: "Object that represents a criterion to decide whether or not an item's name is equal to another name"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_NAME_CRITERION

inherit
	QL_CRITERION
		undefine
			item_type
		end

feature{NONE} -- Initialization

	make (a_name: STRING)
			-- Initialize `name' with `a_name'.
		require
			a_name_valid: a_name /= Void
		do
			create regexp_match_engine.make
			create wildcard_match_engine.make_empty
			set_name (a_name)
		end

	make_with_setting (a_name: STRING; a_case_sensitive: BOOLEAN; a_matching_strategy: INTEGER)
			-- Initialize `name' with `a_name', `is_case_sensitive' with `a_case_sensitive' and `matching_strategy' with `a_matching_strategy'.
		require
			a_name_valid: a_name /= Void
			a_matching_strategy_valid: is_matching_strategy_valid (a_matching_strategy)
		do
			is_case_sensitive := a_case_sensitive
			matching_strategy := a_matching_strategy
			make (a_name)
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
			is_case_sensitive_set: is_case_sensitive = a_case_sensitive
			matching_strategy_set: matching_strategy = a_matching_strategy
		end

feature -- Access

	name: STRING
			-- Name used to compare with an item's name

	lower_name: STRING
			-- `name' in lower case

	is_case_sensitive: BOOLEAN
			-- Is comparison between name case sensitive?
			-- Default: False

	matching_strategy: INTEGER
			-- Matching strategy

feature -- Matching strategy

	identity_matching_strategy: INTEGER = 1
			-- Identical strategy: two strings are only considered matched if they are (case-sensitively or case-insensitively) identical
			-- Result is affected also by `is_case_sensitive'.

	containing_matching_strategy: INTEGER = 2
			-- Normal strategy: a string is considered matched by a given pattern if the string is a substring of the given pattern
			-- Result is affected also by `is_case_sensitive'.

	wildcard_matching_strategy: INTEGER = 3
			-- Wildcard strategy: a string is considered matched by a given pattern (in form of wildcard) if the string satisfies the given pattern
			-- Result is affected also by `is_case_sensitive'.

	regular_expression_matching_strategy: INTEGER = 4
			-- Regular expression strategy: a string is considered matched by a given pattern (in form of regular expression) if the string satisfies the given pattern
			-- Result is affected also by `is_case_sensitive'.

feature -- Status report

	is_matching_strategy_valid (a_strategy: INTEGER): BOOLEAN
			-- Is `a_strategy' a valid matching strategy?
		do
			Result := a_strategy = identity_matching_strategy or else
					  a_strategy = containing_matching_strategy or else
					  a_strategy = wildcard_matching_strategy or else
					  a_strategy = regular_expression_matching_strategy
		end

feature -- Setting

	set_name (a_name: STRING)
			-- Set `name' with `a_name'.
		require
			a_name_valid: a_name /= Void
		do
			create name.make_from_string (a_name)
			create lower_name.make_from_string (a_name.as_lower)
			prepare_matching_strategy
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
			lower_name_set: lower_name /= Void and then lower_name.is_equal (a_name.as_lower)
		end

	enable_case_sensitive
			-- Enable case sensitive name comparison.
		do
			is_case_sensitive := True
			prepare_matching_strategy
		ensure
			comparison_is_case_sensitive: is_case_sensitive
		end

	disable_case_sensitive
			-- Disable case sensitive name comparison.
		do
			is_case_sensitive := False
			prepare_matching_strategy
		ensure
			comparison_is_not_case_sensitive: not is_case_sensitive
		end

	set_matching_strategy (a_strategy: INTEGER)
			-- Set `matching_strategy' with `a_strategy'.
		require
			a_strategy_valid: is_matching_strategy_valid (a_strategy)
		do
			matching_strategy := a_strategy
			prepare_matching_strategy
		ensure
			matching_strategy_set: matching_strategy = a_strategy
		end

feature -- Evaluate

	is_name_same_as (a_name: STRING): BOOLEAN
			-- Is `a_name' same as `name'?
			-- If `is_case_sensitive' is True, compare names case-sensitively.
		require
			a_name_attached: a_name /= Void
		do
			Result := string_matcher.item ([a_name])
		end

feature{NONE} -- Implementation

	regexp_match_engine: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression match engine

	wildcard_match_engine: KMP_WILD
			-- Wildcard matcher engine

	initialize_regexp_match_engine
			-- Recompile `regexp_match_engine'.
		require
			serach_engine_attached: regexp_match_engine /= Void
			not_name_is_empty: not name.is_empty
		local
			l_search_engine: like regexp_match_engine
		do
			l_search_engine := regexp_match_engine
			l_search_engine.set_anchored (False)
			l_search_engine.reset
			l_search_engine.set_empty_allowed (False)
			l_search_engine.set_multiline (False)
			l_search_engine.set_caseless (not is_case_sensitive)
			l_search_engine.compile (name)
		end

	initialize_wildcard_match_engine
			-- Initialize wildcard matcher.
		do
			if is_case_sensitive then
				wildcard_match_engine.enable_case_sensitive
			else
				wildcard_match_engine.disable_case_sensitive
			end
			wildcard_match_engine.set_pattern (name)
		end

feature{NONE} -- Matchers

	identity_matcher (a_string: STRING): BOOLEAN
			-- Identity matcher
		require
			a_string_attached: a_string /= Void
		do
			if a_string.is_empty then
				Result := name.is_empty
			else
				if is_case_sensitive then
					Result := a_string.is_equal (name)
				else
					Result := a_string.is_case_insensitive_equal (name)
				end
			end
		end

	containing_matcher (a_string: STRING): BOOLEAN
			-- Containing matcher
		require
			a_string_attached: a_string /= Void
		do
			if a_string.is_empty then
				Result := name.is_empty
			else
				if is_case_sensitive then
					Result := a_string.has_substring (name)
				else
					Result := a_string.as_lower.has_substring (lower_name)
				end
			end
		end

	wildcard_matcher (a_string: STRING): BOOLEAN
			-- Wildcard matcher
		require
			a_string_attached: a_string /= Void
		do
			if a_string.is_empty then
				Result := name.is_empty
			else
				wildcard_match_engine.set_text (a_string)
				Result := wildcard_match_engine.pattern_matches
			end
		end

	regexp_matcher (a_string: STRING): BOOLEAN
			-- Wildcard matcher
		require
			a_string_attached: a_string /= Void
		do
			if a_string.is_empty then
				Result := name.is_empty
			else
				regexp_match_engine.match (a_string)
				Result := regexp_match_engine.has_matched
			end
		end

	prepare_matching_strategy
			-- Prepare matching strategy according to `matching_strategy'.
		require
			matching_strategy_valid: is_matching_strategy_valid (matching_strategy)
		local
			l_matcher: like string_matcher
		do
			inspect
				matching_strategy
			when {QL_NAME_CRITERION}.identity_matching_strategy then
				l_matcher := agent identity_matcher
			when {QL_NAME_CRITERION}.containing_matching_strategy then
			l_matcher := agent containing_matcher
			when {QL_NAME_CRITERION}.wildcard_matching_strategy then
				if not name.is_empty then
					initialize_wildcard_match_engine
				end
				l_matcher := agent wildcard_matcher
			when {QL_NAME_CRITERION}.regular_expression_matching_strategy then
				if not name.is_empty then
					initialize_regexp_match_engine
				end
				l_matcher := agent regexp_matcher
			end
			set_string_matcher (l_matcher)
		ensure
			string_matcher_set: string_matcher /= Void
		end

	string_matcher: FUNCTION [ANY, TUPLE [a_string: STRING], BOOLEAN]
			-- String matcher used to match `a_string'

	set_string_matcher (a_matcher: like string_matcher)
			-- Set `string_matcher' with `a_matcher'.
		do
			string_matcher := a_matcher
		ensure
			string_matcher_set: string_matcher = a_matcher
		end

invariant
	name_valid: name /= Void
	lower_name_valid: lower_name /= Void
	regexp_match_engin_attached: regexp_match_engine /= Void
	wildcard_attached: wildcard_match_engine /= Void

note
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
