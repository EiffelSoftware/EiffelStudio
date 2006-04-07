indexing
	description: "Search options observer."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SEARCH_OPTION_OBSERVER

feature {EB_SEARCH_OPTION_OBSERVER_MANAGER} -- Element change

	on_case_sensitivity_changed (a_case_sensitive: BOOLEAN) is
			-- Case sensitivity option changed
		deferred
		end

	on_match_regex_changed (a_match_regex: BOOLEAN) is
			-- Match regex option changed
		deferred
		end

	on_whole_word_changed (a_whole_word: BOOLEAN) is
			-- Whole word option changed
		deferred
		end

	on_backwards_changed (a_bachwards: BOOLEAN) is
			-- Backwards option changed
		deferred
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
