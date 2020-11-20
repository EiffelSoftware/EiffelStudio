note
	description: "Keeper for initialized variables."

deferred class AST_INITIALIZATION_KEEPER

inherit
	AST_NESTING_KEEPER

feature -- Access

	is_set (index: like count): BOOLEAN
			-- Is a variable with the given `index' set?
		require
			index_large_enough: index > 0
			index_small_enough: index <= count
		deferred
		end

	has_unset: BOOLEAN
			-- Are there any unset variables?
		deferred
		end

	has_unset_index (min_index, max_index: like count): BOOLEAN
			-- Are there any unset variables indexed between `min_index' and `max_index' inclusively?
		require
			valid_min_index: min_index > 0
			valid_max_index: max_index <= count
			valid_range: min_index - 1 <= max_index
		deferred
		end

feature -- Status report: variables

	count: like max_count
			-- Maximum number of variables that can be registered

	max_count: INTEGER
			-- Maximum value of `count'
		deferred
		end

feature {AST_ATTRIBUTE_INITIALIZATION_TRACKER, AST_LOCAL_INITIALIZATION_TRACKER} -- Modification: variables

	set (index: like count)
			-- Mark that a variable with the given `index' is set.
		require
			index_large_enough: index > 0
			index_small_enough: index <= count
		deferred
		ensure
			is_set: is_set (index)
		end

	unset (index: like count)
			-- Mark that a variable with the given `index' is unset.
		require
			index_large_enough: index > 0
			index_small_enough: index <= count
		deferred
		ensure
			is_unset: not is_set (index)
		end

	set_all
			-- Mark all variables as set.
		deferred
		ensure
			∀ i: 1 |..| count ¦ is_set (i)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
