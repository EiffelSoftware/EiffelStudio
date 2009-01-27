note
	description: "Tracker for scopes of arguments."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ARGUMENT_SCOPE_TRACKER

create
	make

feature {NONE} -- Creation

	make (n: like argument_count)
			-- Create object to track at least `n' arguments.
		require
			non_negative_n: n >= 0
		do
			keeper := factory.create_scope_keeper (n)
		ensure
			argument_count_set: argument_count = n
		end

feature -- Access

	is_argument_attached (position: like argument_count): BOOLEAN
			-- Is a argument with the given `position' attached?
		require
			position_large_enough: position > 0
			position_small_emough: position <= argument_count
		do
			Result := keeper.is_attached (position)
		end

feature -- Measurement

	argument_count: INTEGER_32
			-- Total number of arguments
		do
			Result := keeper.count
		ensure
			non_negative_result: Result >= 0
		end

feature {AST_SCOPE_COMBINED_PRECONDITION} -- Element change

	start_argument_scope (position: like argument_count)
			-- Mark that an argument with the given `position' cannot be void.
		require
			position_large_enough: position > 0
			position_small_emough: position <= argument_count
		do
			keeper.start_scope (position)
		ensure
			is_argument_attached: is_argument_attached (position)
		end

feature {AST_SCOPE_COMBINED_PRECONDITION} -- Transformation

	keeper: AST_SCOPE_KEEPER
			-- Storage to keep changes in the surrounding context

feature {NONE} -- Initialization

	factory: AST_SCOPE_KEEPER_FACTORY
			-- Factory to create storage for arguments
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
