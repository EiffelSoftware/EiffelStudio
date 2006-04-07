indexing
	description: "Search option observer manager."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SEARCH_OPTION_OBSERVER_MANAGER

feature {EB_SEARCH_OPTION_OBSERVER} -- Element Change

	case_sensitivity_changed (a_case_sensitive: BOOLEAN) is
			-- Change case sensitivity option.
		do
			if observers /= Void then
				from
					observers.start
				until
					observers.after
				loop
					observers.item.on_case_sensitivity_changed (a_case_sensitive)
					observers.forth
				end
			end
		end

	match_regex_changed (a_match_regex: BOOLEAN) is
			-- Change match regex option.
		do
			if observers /= Void then
				from
					observers.start
				until
					observers.after
				loop
					observers.item.on_match_regex_changed (a_match_regex)
					observers.forth
				end
			end
		end

	whole_word_changed (a_whole_word: BOOLEAN) is
			-- Change whole word option.
		do
			if observers /= Void then
				from
					observers.start
				until
					observers.after
				loop
					observers.item.on_whole_word_changed (a_whole_word)
					observers.forth
				end
			end
		end

	backwards_changed (a_bachwards: BOOLEAN) is
			-- Change backwards option.
		do
			if observers /= Void then
				from
					observers.start
				until
					observers.after
				loop
					observers.item.on_backwards_changed (a_bachwards)
					observers.forth
				end
			end
		end

feature -- Observer Change

	add_observer (a_observer: EB_SEARCH_OPTION_OBSERVER) is
			-- Add an observer.
		require
			a_observer_not_void: a_observer /= Void
		do
			if observers = Void then
				create observers.make (5)
			end
			if not observers.has (a_observer) then
				observers.extend (a_observer)
			end
		ensure
			a_observer_exists: observers.has (a_observer)
		end

	remove_observer (a_observer: EB_SEARCH_OPTION_OBSERVER) is
			-- Remove an observer.
		require
			a_observer_not_void: a_observer /= Void
		do
			if observers /= Void then
				observers.prune (a_observer)
			end
		ensure
			a_observer_not_exist: not observers.has (a_observer)
		end

feature {NONE}-- Observers

	observers: ARRAYED_LIST [EB_SEARCH_OPTION_OBSERVER];
		-- Observers

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
