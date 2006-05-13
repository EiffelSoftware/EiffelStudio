indexing
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

feature{NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialize `name' with `a_name'.
		require
			a_name_valid: a_name /= Void
		do
			create search_engine.make
			create name.make_from_string (a_name)
			if not name.is_empty then
				initialize_search_engine
			end
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
		end

	make_with_setting (a_name: STRING; a_case_sensitive: BOOLEAN; a_identical_comparison: BOOLEAN) is
			-- Initialize `name' with `a_name'.
			-- If `a_case_sensitive' is True, enable case sensitive comparison.
			-- If `a_identical_comparison' is True, enable identical comparision,
			-- otherwise use regular expression to compare `name'.
		require
			a_name_valid: a_name /= Void
		do
			is_case_sensitive := a_case_sensitive
			is_identical_comparison := a_identical_comparison
			make (a_name)
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
			is_case_sensitive_set: is_case_sensitive = a_case_sensitive
			is_identical_comparison_set: is_identical_comparison = a_identical_comparison
		end

feature -- Access

	name: STRING
			-- Name used to compare with an item's name

	is_case_sensitive: BOOLEAN
			-- Is comparison between name case sensitive?
			-- Default: False

	is_identical_comparison: BOOLEAN
			-- Is comparsion between names identical comparison?
			-- If not, we use regular expression to compare names.

feature -- Setting

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'.
		require
			a_name_valid: a_name /= Void
		do
			create name.make_from_string (a_name)
			if not name.is_empty then
				initialize_search_engine
			end
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
		end

	enable_case_sensitive is
			-- Enable case sensitive name comparison.
		do
			is_case_sensitive := True
			initialize_search_engine
		ensure
			comparison_is_case_sensitive: is_case_sensitive
		end

	disable_case_sensitive is
			-- Disable case sensitive name comparison.
		do
			is_case_sensitive := False
			initialize_search_engine
		ensure
			comparison_is_not_case_sensitive: not is_case_sensitive
		end

	enable_identical_comparsion is
			-- Enable case sensitive name comparison.
		do
			is_identical_comparison := True
		ensure
			comparison_is_identical: is_identical_comparison
		end

	disable_identical_comparsion is
			-- Disable case sensitive name comparison.
		do
			is_identical_comparison := False
		ensure
			comparison_is_not_identical: not is_identical_comparison
		end

feature -- Evaluate

	is_name_same_as (a_name: STRING): BOOLEAN is
			-- Is `a_name' same as `name'?
			-- If `is_case_sensitive' is True, compare names case-sensitively.
		require
			a_name_attached: a_name /= Void
		do
			if name.is_empty then
				Result := a_name.is_empty
			else
				if is_identical_comparison then
					if is_case_sensitive then
						Result := name.is_equal (a_name)
					else
						Result := name.is_case_insensitive_equal (a_name)
					end
				else
					search_engine.match (a_name)
					Result := search_engine.has_matched
				end
			end
		end

feature{NONE} -- Implementation

	search_engine: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression matcher.

	initialize_search_engine is
			-- Recompile `search_engine'.
		require
			serach_engine_attached: search_engine /= Void
			not_name_is_empty: not name.is_empty
		local
			l_search_engine: like search_engine
		do
			l_search_engine := search_engine
			l_search_engine.reset
			l_search_engine.set_empty_allowed (False)
			l_search_engine.set_multiline (False)
			l_search_engine.set_caseless (not is_case_sensitive)
			l_search_engine.compile (name)
		end

invariant
	name_valid: name /= Void
	search_engine_attached: search_engine /= Void

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
