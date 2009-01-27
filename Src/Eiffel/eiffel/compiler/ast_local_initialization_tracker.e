note
	description: "Tracker for initialized locals."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_LOCAL_INITIALIZATION_TRACKER

create
	make

feature {NONE} -- Creation

	make (n: like local_count)
			-- Create object to track at least `n' locals.
		require
			non_negative_n: n >= 0
		do
				-- One index is used for result
			scope_keeper := factory.create_scope_keeper (n + 1)
		ensure
			local_count_set: local_count = n
		end

feature {NONE} -- Access

	result_index: INTEGER_32
			-- Index for Result local entity
		do
			Result := local_count + 1
		end

feature -- Access

	is_local_set (position: like local_count): BOOLEAN
			-- Is a local with the given `position' set?
		require
			position_large_enough: position > 0
			position_small_emough: position <= local_count
		do
			Result := keeper.is_set (position)
		end

	is_result_set: BOOLEAN
			-- Is Result set?
		do
			Result := keeper.is_set (result_index)
		end

feature -- Measurement

	local_count: INTEGER_32
			-- Total number of locals
		do
				-- One index is reserved for Result.
			Result := keeper.count - 1
		ensure
			non_negative_result: Result >= 0
		end

feature {AST_CONTEXT} -- Element change

	set_local (position: like local_count)
			-- Mark that a local with the given `position' is set.
		require
			position_large_enough: position > 0
			position_small_emough: position <= local_count
		do
			keeper.set (position)
		ensure
			is_local_set: is_local_set (position)
		end

	set_result
			-- Mark that "Result" is set.
		do
			keeper.set (result_index)
		ensure
			is_result_set: is_result_set
		end

feature {AST_CONTEXT} -- Transformation

	keeper: AST_INITIALIZATION_KEEPER
			-- Storage to keep changes in the surrounding context
		do
			Result := scope_keeper
		end

feature {NONE} -- Initialization

	scope_keeper: AST_SCOPE_KEEPER
			-- Storage to keep changes in the surrounding context

	factory: AST_SCOPE_KEEPER_FACTORY
			-- Factory to create storage for locals
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

invariant
	keeper_attached: keeper /= Void

note
	copyright:	"Copyright (c) 2009, Eiffel Software"
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
