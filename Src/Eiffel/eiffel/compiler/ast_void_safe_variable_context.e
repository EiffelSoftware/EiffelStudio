indexing
	description: "Void-safe context for third pass that tracks variables usage."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class AST_VOID_SAFE_VARIABLE_CONTEXT

inherit
		AST_VARIABLE_CONTEXT
			redefine
				default_create,
				enter_compound,
				is_attribute_initialized,
				is_attribute_set,
				leave_compound,
				set_attribute,
				start_creation_procedure,
				start_feature,
				wipe_out
			end

feature {NONE} -- Creation

	default_create
		do
			create {ARRAYED_STACK [INTEGER]} set_variables.make (10)
			create {ARRAYED_STACK [INTEGER]} nested_variables.make (10)
			create initialized_attributes.make (10)
		end

feature -- Status report

	is_attribute_set (feature_id: INTEGER): BOOLEAN
			-- Is an attribute identified by `feature_id' set (for the current compound)?
		do
			Result := not is_creation_procedure or else set_variables.has (- feature_id)
		end

	is_creation_procedure: BOOLEAN
			-- Is creation procedure being processed?

	is_attribute_initialized (feature_id: INTEGER): BOOLEAN
			-- Is attribute of `feature_id' initialized at end of a feature body?
		do
			Result := not is_creation_procedure or else initialized_attributes.has (feature_id)
		end

feature -- Modification

	start_creation_procedure
			-- Start processing of a creation procedure.
		do
			start_feature
			is_creation_procedure := True
		ensure then
			is_creation_procedure: is_creation_procedure
		end

	start_feature
			-- Start processing of a non-creation feature.
		do
			wipe_out
			is_creation_procedure := False
		ensure then
			not_is_creation_procedure: not is_creation_procedure
		end

	enter_compound
			-- Record that a new compound is entered.
		do
			nested_variables.put (0)
		ensure then
			compound_level_incremented: nested_variables.count = old nested_variables.count + 1
			compound_level_cleared: nested_variables.item = 0
		end

	leave_compound
			-- Record that a compound is terminated.
		local
			i: INTEGER
		do
			from
				i := nested_variables.item
			until
				i <= 0
			loop
				set_variables.remove
				i := i - 1
			end
			nested_variables.remove
		ensure then
			compound_level_reset: set_variables.count = old set_variables.count - old nested_variables.item
			compound_level_decremented: nested_variables.count = old nested_variables.count - 1
		end

	set_attribute (feature_id: INTEGER)
			-- Mark that an attribute identified by `feature_id' is set.
		do
			if is_creation_procedure then
				if not is_attribute_set (feature_id) then
					set_variables.put (- feature_id)
					nested_variables.replace (nested_variables.item + 1)
					if nested_variables.count = 1 then
							-- Attribute is set on the top level of the feature body.
						initialized_attributes.put (feature_id)
					end
				end
			end
		ensure then
			variable_count_incremented: (is_creation_procedure and then not old is_attribute_set (feature_id)) implies nested_variables.item = old nested_variables.item + 1
		end

	wipe_out
			-- Remove any information about variables usage.
		do
			set_variables.wipe_out
			nested_variables.wipe_out
			initialized_attributes.wipe_out
		end

feature {NONE} -- Variable stacks

	set_variables: STACK [INTEGER]
			-- Variables that are currently set

	nested_variables: STACK [INTEGER]
			-- Number of variables set for the nested compound
			-- E.g.: x:= f; y := g; if h then z := q  ... end
			-- at point ... set_variables = [x, y, z] and nested_variables = [2, 1]

	initialized_attributes: SEARCH_TABLE [INTEGER];
			-- Set of attributes that are properly initialized at the top level of a routine

indexing
	copyright:	"Copyright (c) 2007-2008, Eiffel Software"
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
