note

	description: "Common Eiffel type related routines"
	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERL_G_TYPE_ROUTINES

inherit
	REFACTORING_HELPER

	SHARED_EIFFEL_PARSER

	SHARED_TYPES

	AUT_SHARED_INTERPRETER_INFO
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

	SHARED_STATELESS_VISITOR
		rename
			type_output_strategy as ast_type_output_strategy
		end

feature -- Access

	has_feature (a_class: CLASS_C; a_feature: FEATURE_I): BOOLEAN
			-- Does `a_class' contain `a_feature'?
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
		do
			Result := a_class.feature_table.has (a_feature.feature_name)
		end

	is_default_creatable (a_class: CLASS_C; a_system: SYSTEM_I): BOOLEAN
			-- Are objects of type `a_class' creatable via default creation?
		require
			a_class_not_void: a_class /= Void
			a_system_not_void: a_system /= Void
		do
			Result := a_class.allows_default_creation
		end

	generic_derivation (a_class: CLASS_C; a_system: SYSTEM_I): TYPE_A
			-- Generic derivation `a_class'; this is a type which has `a_class' as base class
			-- but where all formal parameters have been closed with types. The types to be used
			-- as actual paramenters will be ANY for unconstrained formal parameters and
			-- the constraining type for constrained parameters.
		require
			a_class_not_void: a_class /= Void
			a_class_is_generic: a_class.is_generic
			a_system_not_void: a_system /= Void
		do
			Result := generic_derivation_type_visitor.derived_type (a_class.actual_type, a_class)
		ensure
			result_attached: Result /= Void
		end

	generic_derivation_type_visitor: AUT_GENERIC_DERIVATION_TYPE_VISITOR
			-- Generic derivation type visitor
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	generic_derivation_of_type (a_type: TYPE_A; a_context: CLASS_C): TYPE_A
			-- Generic derivation for `a_type'
		do
			Result := generic_derivation_type_visitor.derived_type (a_type, a_context)
		end

	exported_creators (a_class: CLASS_C; a_system: SYSTEM_I): LINKED_LIST [STRING]
			-- Names of creators which are exported to class ANY from `a_class'
			-- Return an empty list of no valid creator is found.
		require
			a_class_attached: a_class /= Void
			a_system_attached: a_system /= Void
		local
			l_any_class: CLASS_C
			l_creator_tbl: HASH_TABLE [EXPORT_I, STRING]
		do
			create Result.make
			l_creator_tbl := a_class.creators
			l_any_class := a_system.any_class.compiled_representation
			if l_creator_tbl /= Void then
				from
					l_creator_tbl.start
				until
					l_creator_tbl.after
				loop
					if l_creator_tbl.item_for_iteration.is_exported_to (l_any_class) then
						Result.extend (l_creator_tbl.key_for_iteration)
					end
					l_creator_tbl.forth
				end
			end

			if a_class.allows_default_creation then
				Result.extend (a_class.default_create_feature.feature_name)
			end
		ensure
			result_attached: Result /= Void
		end

	creation_procedure_count (a_type: TYPE_A; a_system: SYSTEM_I): INTEGER
			-- Number of exported creation procedures for class associated with `a_type'.
			-- Return 0 if `a_type' is not creatable.
		require
			a_type_attached: a_type /= Void
			a_system_not_void: a_system /= Void
		do
			if a_type.has_associated_class then
				Result := exported_creators (a_type.base_class, a_system).count
			end
		ensure
			good_result:
				(not a_type.has_associated_class implies Result = 0) and then
				(a_type.has_associated_class implies Result = exported_creators (a_type.base_class, a_system).count)
		end

feature {NONE} -- Parsing class types

	base_type (a_name: READABLE_STRING_32): TYPE_A
			-- Type parsed from `a_name'.
			-- If `a_name' is "NONE", return {NONE_A}.
			-- If `a_name' is an unknown type, return Void.
			-- The result is resolved in `a_context_class'.
		require
			a_name_not_void: a_name /= Void
		local
			l_type_as: TYPE_AS
		do
			if a_name.is_case_insensitive_equal ("NONE") then
				Result := none_type
			else
					-- Parse `a_name' into a type AST node.
				type_parser.parse_from_string_32 ({STRING_32} "type " + a_name, Void)
				l_type_as := type_parser.type_node
				if l_type_as /= Void then
						-- Generate TYPE_A object from type AST node.
					Result := evaluated_base_type (l_type_as)
				else
					Result := none_type
				end
			end
		end

	evaluated_base_type (a_type: TYPE_AS): detachable TYPE_A
			-- Retrieve evaluated base type for given parsed type representation.
		require
			a_type_attached: a_type /= Void
		local
			l_roots: ARRAYED_LIST [SYSTEM_ROOT]
		do
			l_roots := system.root_creators
			from
				l_roots.start
			until
				l_roots.after or Result /= Void
			loop
				if attached l_roots.item_for_iteration.root_class.compiled_class as l_root_class then
					Result := type_a_generator.evaluate_type (a_type, l_root_class)
				end
				l_roots.forth
			end
		end

feature{NONE} -- Implementation

	add_feature_argument_type_in_input_creator (a_feature: FEATURE_I; a_context: TYPE_A; a_input_creator: AUT_RANDOM_INPUT_CREATOR)
			-- Add types of arguments in `a_feature' if any into `a_input_creator'.
			-- Types are evaluated in context `a_context'.
		require
			a_feature_attached: a_feature /= Void
			a_context_attached: a_context /= Void
			a_input_creator_attached: a_input_creator /= Void
		local
			l_arg_types: LIST [TYPE_A]
		do
			l_arg_types := feature_argument_types (a_feature, a_context)
			l_arg_types.do_all (agent a_input_creator.add_type)
		end

	feature_argument_types (a_feature: FEATURE_I; a_context: TYPE_A): LIST [TYPE_A]
			-- List of types for arguments in `a_feature'. Types are evaluated in context `a_context'.
			-- If `a_feature' doesn't have any argument, return an empty list.
		require
			a_feature_attached: a_feature /= Void
			a_context_attached: a_context /= Void
		local
			i: INTEGER
			count: INTEGER
		do
			create {LINKED_LIST [TYPE_A]} Result.make
			if a_feature.arguments /= Void then
				from
					i := 1
					count := a_feature.arguments.count
				until
					i > count
				loop
					Result.extend (a_feature.arguments.i_th (i).actual_type.instantiation_in (a_context, a_feature.written_in).deep_actual_type)
					i := i + 1
				end
			end
		ensure
			result_attached: Result /= Void
			good_result: not Result.has (Void)
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
