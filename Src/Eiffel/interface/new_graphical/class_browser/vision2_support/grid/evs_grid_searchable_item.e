indexing
	description: "[
					Object that represents a searchable and replacable grid item
					Usage:
					 1. `grid_item' is used to bind an real EV_GRID_ITEM to current searchable item.
					    In fact, this searchable item is just a shell over an real EV_GRID_ITEM.
					 2. `image' is the text in which search is performed.					    
					 3. Implement `internal_replace' to do exact text replacement. And user should
					    use `replace' because in `replace' `veto_replace_function is checked and
					    `replace_succeeded_actions' and `replace_failed_actions' are called accordingly.
					    Remember to set `last_replace_successful' in `internal_replace'.


				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_GRID_SEARCHABLE_ITEM

inherit
	EVS_GRID_COORDINATED

feature -- Item position

	column_index: INTEGER is
			-- Column index of `grid_item'
		do
			Result := grid_item.column.index
		ensure then
			result_positive: Result > 0
		end

	row_index: INTEGER is
			-- Row index of `grid_item'.
		do
			Result := grid_item.row.index
		ensure then
			result_positive: Result > 0
		end

feature -- Setting

	set_veto_replace_function (a_veto_function: like veto_replace_function) is
			-- Set `veto_replace_function' with `a_veto_function'.
		do
			veto_replace_function := a_veto_function
		ensure
			veto_replace_function_set: veto_replace_function = a_veto_function
		end

feature -- Replacement

	replace (original, new: STRING) is
			-- Replace every occurrence of `original' with `new' in `image'.
		require
			original_exists: original /= Void
			new_exists: new /= Void
			original_not_empty: not original.is_empty
		local
			l_is_vetoed: BOOLEAN
		do
				-- Check veto condition.
			if veto_replace_function /= Void then
				veto_replace_function.call ([original, new])
				l_is_vetoed := veto_replace_function.last_result
			end
				-- Apply replacement and call registered actions.
			if not l_is_vetoed then
				internal_replace (original, new)
			else
				last_replace_successful := False
			end
			if last_replace_successful then
				if not replace_succeeded_actions.is_empty then
					replace_succeeded_actions.call ([])
				end
			else
				if not replace_failed_actions.is_empty then
					replace_failed_actions.call ([])
				end
			end
		end

feature -- Status report

	is_column_index_available: BOOLEAN is
			-- Is `column_index' available?
		do
			Result := grid_item.is_parented
		ensure then
			good_result: Result implies grid_item.is_parented
		end

	is_row_index_available: BOOLEAN is
			-- Is `row_index' available?
		do
			Result := grid_item.is_parented
		ensure then
			good_result: Result implies grid_item.is_parented
		end

feature -- Access

	image: STRING is
			-- String representation of current used in search
		deferred
		ensure
			result_attached: Result /= Void
		end

	grid_item: EV_GRID_ITEM is
			-- EV_GRID item associated with current
		deferred
		ensure
			result_attached: Result /= Void
		end

	veto_replace_function: FUNCTION [ANY, TUPLE [STRING, STRING], BOOLEAN]
			-- Parameter [TUPLE [original, new: STRING]]
			-- (ETL3 TUPLE with named parameters)	
			-- Function used to determine whether or not replacement of every occurrence of `original'
			-- by `new' in `image' can be applied.

	replace_succeeded_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when a `replace' succeeds
		do
			if replace_succeeded_actions_internal = Void then
				create replace_succeeded_actions_internal.make
			end
			Result := replace_succeeded_actions_internal
		ensure
			result_attached: Result /= Void
		end

	replace_failed_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when a `replace' fails
		do
			if replace_failed_actions_internal = Void then
				create replace_failed_actions_internal.make
			end
			Result := replace_failed_actions_internal
		ensure
			result_attached: Result /= Void
		end

	last_replace_successful: BOOLEAN
			-- Is last `replace' successful?

feature{NONE} -- Implementation

	replace_succeeded_actions_internal: like replace_succeeded_actions
			-- Internal `replace_succeeded_actions'

	replace_failed_actions_internal: like replace_failed_actions
			-- Internal `replace_failed_actions'

	internal_replace (original, new: STRING) is
			-- Replace every occurrence of `original' with `new' in `image'.
		require
			original_exists: original /= Void
			new_exists: new /= Void
			original_not_empty: not original.is_empty
		deferred
		end

invariant
	grid_item_attached: grid_item /= Void
	grid_item_not_destroyed: not grid_item.is_destroyed
	image_attached: image /= Void

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
