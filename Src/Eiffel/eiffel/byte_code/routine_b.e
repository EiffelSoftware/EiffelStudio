note
	description: "Byte code generation for a routine call."

deferred class ROUTINE_B

inherit
	CALL_ACCESS_B
		redefine
			calls_special_features,
			context_type,
			enlarged,
			enlarged_on,
			has_call,
			is_feature_special,
			is_instance_free,
			is_single,
			is_target_type_fixed,
			optimized_byte_node,
			parameters,
			set_parameters,
			size
		end

feature -- Status report

	is_single: BOOLEAN
			-- <Precursor>
		do
				-- If a target class object is needed, no arguments are allowed.
				-- Smarter optimization may check that passed arguments do not include any arguments of enclosing feature,
				-- otherwise they can be moved or collected by GC.
			Result := (is_class_target_needed ⇒ not attached parameters) ∧ Precursor
		end

	is_instance_free: BOOLEAN
			-- <Precursor>

	is_target_free: BOOLEAN
			-- Is the feature independent of the target type of the call?
			-- (A non-object feature call can depend on the target type
			-- if the type is not bound to a specific class type (e.g., it's a formal, or an anchored type), or
			-- if it's a call to an internal feature or to an external with unqualifed calls to internal features.)
		require
			is_instance_free
		do
			if attached precursor_type as p then
				Result :=
					p.is_basic or else
					not p.is_formal and then
					not p.is_like and then
					attached p.base_class as b and then b.feature_of_rout_id (routine_id).is_target_free
			else
				check
					from_precondition: False
				end
			end
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

	is_once: BOOLEAN
			-- Is the current feature a once feature?
			--| Used when inlining is turned on in final mode
			--| to avoid inlining once routines.
		do
				-- False by default.
		end

	is_process_relative: BOOLEAN
			-- Is current feature process-relative?
		do
				-- False by default.
		end

	is_object_relative: BOOLEAN
			-- Is current feature object-relative?
		do
				-- False by default.
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
				Result := real_precursor_type
			end
		end

feature {NONE} -- Target type

	real_precursor_type: TYPE_A
			-- A real type of precursor type.
		require
			attached precursor_type
		do
			Result := context.real_type (precursor_type)
			if Result.is_multi_constrained then
				if attached multi_constraint_static as s then
					Result := context.real_type (s)
				else
					check has_multiconstraint_static: False end
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

	enlarged_on (type_i: TYPE_A): CALL_ACCESS_B
			-- Enlarged byte node evaluated in the context of `type_i'.
		local
			array_index: INTEGER
			target_type_id: INTEGER
			context_entry: ROUT_ENTRY
			target_type: TYPE_A
		do
				-- If this is a call to a precursor or a static call on a fixed type,
				-- the feature is known at compile time.
				-- Otherwise, even if `precursor_type` is set, it could be a static call on a variable type,
				-- e.g., "{G}.foo", that should be dealt with using dynamic dispatch.
			if
				attached precursor_type as p and then
				(is_instance_free implies not p.is_formal and then (p.is_like implies p.is_expanded))
			then
				array_index := -1
			end
			if context.workbench_mode then
--				if array_index >= 0 then
						-- Call the feature polymorphically.
					if
						not context.is_written_context and then
						attached type_i.base_class as c and then
						attached c.feature_of_rout_id (routine_id) as f and then
						f.is_attribute and then
						(call_kind = call_kind_qualified implies not system.seed_of_routine_id (f.rout_id_set.first).has_formal)
					then
							-- The function is redeclared into an attribute.
						create {ATTRIBUTE_BW} Result.fill_from_access (Current, f)
					else
						create {FEATURE_BW} Result.fill_from (Current)
					end
--				else
--						-- Perform a direct call.
--						-- TODO: add classes to handle direct internal and external calls.
--				end
			else
				target_type := type_i
				if target_type.is_multi_constrained and then attached multi_constraint_static as c then
					target_type := real_type (c)
				end
				if array_index >= 0 then
					array_index := eiffel_table.is_polymorphic_for_body (routine_id, target_type, context.original_class_type)
				end
				if array_index = -2 then
						-- There is no feature to call.
					create {VOID_CALL_BL} Result.make (Current)
				elseif array_index >= 0 then
						-- The call is polymorphic.
						-- Check whether this is a call to a routine or to an attribute.
					if
						not context.is_written_context and then
						attached {CL_TYPE_A} target_type as c and then
						attached c.base_class.feature_of_rout_id (routine_id) as f and then
						f.is_attribute and then
						(system.seed_of_routine_id (routine_id).type.is_expanded or else
							not
								(context.has_expanded_descendants_information and then
								context.has_expanded_descendants
									(context.real_type (type).type_id (context.context_class_type.type))))
					then
						create {ATTRIBUTE_BL} Result.fill_from_access (Current, f)
					else
							-- Make a polymorphic call.
						create {POLYMORPHIC_CALL_BL} Result.make (Current, array_index)
					end
				elseif attached {ROUT_TABLE} eiffel_table.poly_table (routine_id) as rout_table then
						-- The call is not polymorphic in the given context.
					target_type_id := target_type.type_id (context.original_class_type.type)
					if attached effective_entry (target_type, target_type_id, rout_table) as entry then
						context_entry := rout_table.context_item
						if entry.pattern_id /= context_entry.pattern_id then
								-- A trampoline is required to adapt argument and/or result type.
							create {TRAMPOLINE_CALL_BL} Result.make (Current, entry, context_entry, rout_table)
						else
								-- Figure out what type of a direct call should be performed.
							if entry.is_attribute then
								if entry.is_initialization_required then
										-- Call a wrapper.
									create {INTERNAL_CALL_BL} Result.make (Current, entry)
								else
										-- Access the attribute directly.
									create {ATTRIBUTE_BL} Result.fill_from_access
										(Current, system.class_of_id (entry.class_id).feature_of_feature_id (entry.feature_id))
								end
							elseif
								attached system.class_of_id (entry.class_id).feature_of_feature_id (entry.feature_id) as f and then
								(f.is_constant and then not f.is_once or else f.is_external)
							then
									-- TODO: review type structure to make `CONSTANT_B` a descendant of `CALL_ACCESS_B`
									-- and remove the type cast.
								if attached {EXTERNAL_B} direct_byte_node (f, type_i.is_separate) as e then
									create {EXTERNAL_CALL_BL} Result.make (e, entry)
								else
										-- Call a wrapper.
									create {INTERNAL_CALL_BL} Result.make (Current, entry)
								end
							else
									-- Call the internal feature directly.
								create {INTERNAL_CALL_BL} Result.make (Current, entry)
							end
						end
					else
							-- There is no feature to call.
						create {VOID_CALL_BL} Result.make (Current)
					end
				else
						-- There is no feature to call.
					create {VOID_CALL_BL} Result.make (Current)
				end
			end
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
