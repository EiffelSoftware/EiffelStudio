indexing
	description: "Keeper for initialized local entities."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class AST_INITIALIZATION_KEEPER

feature -- Access

	is_local_set (position: like local_count): BOOLEAN
			-- Is a local with the given `position' set?
		require
			position_large_enough: position > 0
			position_small_emough: position <= local_count
		deferred
		end

	is_result_set: BOOLEAN
			-- Is Result set?
		deferred
		end

feature -- Status report: variables

	local_count: like max_local_count
			-- Maximum number of locals that can be registered

	max_local_count: INTEGER
			-- Maximum value of `local_count'
		deferred
		end

feature {AST_CONTEXT} -- Modification: variables

	set_local (position: like local_count)
			-- Mark that a local with the given `position' is set.
		require
			position_large_enough: position > 0
			position_small_emough: position <= local_count
		deferred
		end

	set_result
			-- Mark that "Result" is set.
		deferred
		end

feature -- Status report: nesting

	nesting_level: INTEGER
			-- Current nesting level of a compound
		deferred
		end

feature {AST_CONTEXT} -- Modification: nesting

	enter_realm
			-- Enter a new complex instruction with inner compound parts.
		deferred
		ensure
			is_nesting_level_incremented: nesting_level = old nesting_level + 1
		end

	update_realm
			-- Update realm variable information from the current state.
		deferred
		ensure
			is_nesting_level_preserved: nesting_level = old nesting_level
		end

	save_sibling
			-- Save variable information of a sibling in a complex instrution.
			-- For example, Then_part of Elseif condition.
		require
			is_nested: nesting_level > 0
		deferred
		ensure
			is_nesting_level_preserved: nesting_level = old nesting_level
		end

	leave_realm
			-- Leave a complex instruction and promote variable information to the outer compound.
		require
			is_nested: nesting_level > 0
		deferred
		ensure
			is_nesting_level_decremented: nesting_level = old nesting_level - 1
		end

	leave_optional_realm
			-- Leave a complex instruction and discard its variable information.
			-- For example, Debug instruction.
		require
			is_nested: nesting_level > 0
		deferred
		ensure
			is_nesting_level_decremented: nesting_level = old nesting_level - 1
		end

indexing
	copyright:	"Copyright (c) 2008, Eiffel Software"
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
