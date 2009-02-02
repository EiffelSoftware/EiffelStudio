note
	description: "Tracker for initialized attributes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ATTRIBUTE_INITIALIZATION_TRACKER

create
	make

feature {NONE} -- Creation

	make (n: like attribute_count)
			-- Create object to track at least `n' attributes.
		require
			non_negative_n: n >= 0
		do
			scope_keeper := factory.create_scope_keeper (n)
		ensure
			attribute_count_set: attribute_count = n
		end

feature -- Access

	is_attribute_set (position: like attribute_count): BOOLEAN
			-- Is an attribute with the given `position' set?
		require
			position_large_enough: position > 0
			position_small_emough: position <= attribute_count
		do
			Result := keeper.is_set (position)
		end

feature -- Measurement

	attribute_count: INTEGER_32
			-- Total number of attributes
		do
			Result := keeper.count
		ensure
			non_negative_result: Result >= 0
		end

feature {AST_CREATION_PROCEDURE_CHECKER} -- Element change

	set_attribute (position: like attribute_count)
			-- Mark that an attribute with the given `position' is set.
		require
			position_large_enough: position > 0
			position_small_emough: position <= attribute_count
		do
			keeper.set (position)
		ensure
			is_attribute_set: is_attribute_set (position)
		end

feature {AST_CONTEXT, AST_CREATION_PROCEDURE_CHECKER} -- Transformation

	keeper: AST_INITIALIZATION_KEEPER
			-- Storage to keep changes in the surrounding context
		do
			Result := scope_keeper
		end

feature {NONE} -- Initialization

	scope_keeper: AST_SCOPE_KEEPER
			-- Storage to keep changes in the surrounding context

	factory: AST_SCOPE_KEEPER_FACTORY
			-- Factory to create storage for attributes
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
