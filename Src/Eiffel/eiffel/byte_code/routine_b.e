note
	description: "Byte code generation for a routine call."

deferred class ROUTINE_B

inherit
	CALL_ACCESS_B
		redefine
			calls_special_features,
			context_type,
			enlarged,
			has_call,
			is_feature_special,
			is_target_type_fixed,
			optimized_byte_node,
			parameters,
			set_parameters,
			size
		end

feature -- Status report

	is_instance_free: BOOLEAN
			-- Is the call instance-free, i.e. does not need a target object?

	is_target_free: BOOLEAN
			-- Is the feature independent on the target type of the call?
			-- (An instance-free feature can depend on the target type if it makes unqualifed calls to features that are redeclared in descendants.)
		do
			Result :=
				attached precursor_type as p and then
				(p.is_basic or else
				attached p.base_class as b and then b.feature_of_rout_id (routine_id).is_target_free or else
				attached multi_constraint_static as t and then attached t.base_class as b and then b.feature_of_rout_id (routine_id).is_target_free)
		end

	is_class_target_needed: BOOLEAN
			-- Does a call need a class target rather than an object target?
			-- The class target may be required for instance-free calls that depend on the target type.
		do
			Result := is_instance_free and then not is_target_free
		ensure
			is_instance_free: Result implies is_instance_free
			not_is_target_free: Result implies not is_target_free
		end

	is_target_type_fixed: BOOLEAN
			-- <Precursor>
		do
			Result :=
				attached precursor_type as p and then
					(not is_class_target_needed or else
					p.is_basic or else
					p.is_standalone)
		end

	has_call: BOOLEAN = True
			-- <Precursor>

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_A): BOOLEAN
			-- Search for feature_name in `special_routines'.
			-- This is used for simple types only.
			-- If found return True (and keep reference position).
			-- Otherwize, return false
		do
			Result := special_routines.has (feature_name_id, compilation_type, target_type)
		end

feature -- Access

	parameters: detachable BYTE_LIST [PARAMETER_B]
			-- Arguments of the call (if any).

feature -- Context type

	context_type: TYPE_A
			-- Context type of the access (properly instantiated)
		do
			if precursor_type = Void then
				Result := Precursor
			else
				Result := Context.real_type (precursor_type)
				if Result.is_multi_constrained then
					check
						has_multi_constraint_static: has_multi_constraint_static
					end
					Result := context.real_type (multi_constraint_static)
				end
			end
		end

feature -- Modification

	set_parameters (p: like parameters)
			-- Assign `p' to `parameters'.
		local
			i: INTEGER
		do
			parameters := p
			if attached p then
					-- Set all parameter parents to `Current'.
				from
					i := p.count
				until
					i = 0
				loop
					p [i].set_parent (Current)
					i := i - 1
				end
			end
		end

feature -- C code generation

	enlarged: CALL_ACCESS_B
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		do
				-- Fallback to default implementation.
			Result := enlarged_on (context_type)
		end

feature -- Array optimization

	optimized_byte_node: like Current
		do
			Result := Current
			if parameters /= Void then
				parameters := parameters.optimized_byte_node
			end
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			if parameters /= Void then
				Result := parameters.calls_special_features (array_desc)
			end
		end

feature -- Inlining

	size: INTEGER
			-- <Precursor>
		do
			if parameters /= Void then
				Result := 1 + parameters.size
			else
				Result := 1
			end
		end

feature {NONE} -- Access

	effective_entry (target_type: TYPE_A; target_type_id: INTEGER; routine_table: ROUT_TABLE): detachable ROUT_ENTRY
			-- An entry to call (if any) when there is only one reachable version of the feature
			-- for the type `target_type` of ID `target_type_id` in the table `routine_table`.
		require
			target_type_id = target_type.type_id (context.context_cl_type)
		do
			if attached precursor_type then
					-- The feature to call is fixed.
				routine_table.goto (target_type_id)
			else
					-- The feature to call corresponds to the target type or a conforming descendant.
				routine_table.goto_implemented (target_type, context.context_class_type)
			end
			if routine_table.is_implemented then
				Result := routine_table.item
			end
		ensure
			attached Result implies attached routine_table.context_item
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
