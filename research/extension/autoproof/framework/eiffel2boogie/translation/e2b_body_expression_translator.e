class
	E2B_BODY_EXPRESSION_TRANSLATOR

inherit

	E2B_EXPRESSION_TRANSLATOR
		redefine
			reset,
			process_array_const_b,
			process_creation_expr_b,
			process_routine_creation_b,
			process_string_b,
			process_tuple_access_b,
			process_tuple_const_b
		end

create
	make

feature -- Basic operations

	set_context_implementation (a_implementation: IV_IMPLEMENTATION)
			-- Set context of expression.
		do
			context_implementation := a_implementation
		end

	reset
			-- Reset expression translator.
		do
			Precursor
			context_implementation := Void
			create side_effect.make
		end

feature -- Visitors

	process_array_const_b (a_node: ARRAY_CONST_B)
			-- <Precursor>
		local
			i, n: INTEGER
			l_type: CL_TYPE_A
			l_target: IV_EXPRESSION
			l_pcall: IV_PROCEDURE_CALL
			l_assign: IV_ASSIGNMENT
			l_content_type: IV_TYPE
			l_block: IV_BLOCK
		do
			l_type := class_type_in_current_context (a_node.type)
			translation_pool.add_type (l_type)

			if a_node.expressions /= Void then
				n := a_node.expressions.count
			else
				n := 0
			end

			create_local (a_node.type)
			l_target := last_local
			create l_block.make

				-- Create array
			create l_pcall.make ("allocate")
			l_pcall.add_argument (factory.type_value (a_node.type))
			l_pcall.set_target (l_target)
			l_block.add_statement (l_pcall)

			create l_pcall.make ("ARRAY.make")
			l_pcall.add_argument (l_target)
			l_pcall.add_argument (factory.int_value (1))
			l_pcall.add_argument (factory.int_value (n))
			l_block.add_statement (l_pcall)

				-- Put all elements into array
			check attached {CL_TYPE_A} l_type.generics.first as t then
				l_content_type := types.for_class_type (t)
			end
			from
				i := 1
			until
				i > n
			loop
				if attached {EXPR_B} a_node.expressions [i] as e then
					create l_assign.make (
						factory.array_access (entity_mapping.heap, l_target, factory.int_value (i), l_content_type),
						process_argument_expression (e))
					l_block.add_statement (l_assign)
				end
				i := i + 1
			end
			last_expression := l_target
			side_effect.extend (if_safety_expression (l_block))
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B)
			-- <Precursor>
		local
			l_type: CL_TYPE_A
			l_feature: FEATURE_I
			l_target: IV_EXPRESSION
			l_target_type: CL_TYPE_A

			l_local: IV_ENTITY
			l_proc_call: IV_PROCEDURE_CALL
			l_handler: E2B_CUSTOM_CALL_HANDLER
		do
			l_type := class_type_in_current_context (a_node.type)
			l_feature := l_type.base_class.feature_of_rout_id (a_node.call.routine_id)
			check feature_valid: l_feature /= Void end
			translation_pool.add_type (l_type)

			create_local (l_type)
			l_local := last_local

			current_target := l_local
			current_target_type := l_type

				-- Is this a normal reference type?
			if l_local.type ~ types.ref then
				-- Call to `allocate'				
				create l_proc_call.make ("allocate")
				l_proc_call.node_info.set_line (a_node.call.line_number)
				l_proc_call.add_argument (factory.type_value (l_type))
				l_proc_call.set_target (l_local)
				side_effect.extend (if_safety_expression (l_proc_call))

					-- Call to creation procedure
				l_target := current_target
				l_target_type := current_target_type

				l_handler := translation_mapping.handler_for_call (current_target_type, l_feature)
				if l_handler /= Void then
					l_handler.handle_routine_call_in_body (Current, l_feature, a_node.parameters)
				else
					process_routine_call (l_feature, a_node.parameters, True)
				end

				current_target := l_target
				current_target_type := l_target_type

				last_expression := l_local
			else
					-- Or something special?
				check helper.is_class_logical (current_target_type.base_class) end

				l_handler := translation_mapping.handler_for_call (current_target_type, l_feature)
				check l_handler /= Void end
				l_handler.handle_routine_call_in_body (Current, l_feature, a_node.parameters)
			end

		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B)
			-- <Precursor>
		do
			if a_node.is_inline_agent then
				helper.add_unsupported_error (context_feature, {STRING_32} "Inline agents are not supported", context_line_number)
				last_expression := dummy_node (a_node.type)
			else
				(create {E2B_CUSTOM_AGENT_CALL_HANDLER}).handle_agent_creation (Current, a_node)
			end
		end

	process_string_b (a_node: STRING_B)
			-- <Precursor>
		do
			(create {E2B_CUSTOM_STRING_HANDLER}).handle_manifest_string_in_body (Current, a_node)
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B)
			-- <Precursor>
		local
			l_proc_call: IV_PROCEDURE_CALL
		do
			if a_node.source = Void then
				Precursor (a_node)
			else
				a_node.source.expression.process (Current)
				create l_proc_call.make ("update_heap")
				l_proc_call.add_argument (current_target)
				l_proc_call.add_argument (factory.entity (
					name_translator.boogie_field_for_tuple_field (current_target_type, a_node.position),
					types.field (last_expression.type)))
				l_proc_call.add_argument (last_expression)
				side_effect.extend (l_proc_call)
				last_expression := Void
			end
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B)
			-- <Precursor>
		local
			l_type: CL_TYPE_A
			l_local: IV_ENTITY
			l_proc_call: IV_PROCEDURE_CALL
			l_block: IV_BLOCK
		do
			l_type := class_type_in_current_context (a_node.type)
			create_local (l_type)
			l_local := last_local
			create l_block.make

			current_target := l_local
			current_target_type := l_type

				-- Call to `allocate'				
			create l_proc_call.make ("allocate")
			l_proc_call.node_info.set_line (a_node.line_number)
			l_proc_call.add_argument (factory.type_value (l_type))
			l_proc_call.set_target (l_local)
			l_block.add_statement (l_proc_call)

				-- Call to creation procedure
			create l_proc_call.make (name_translator.boogie_procedure_for_tuple_creation (l_type))
			l_proc_call.add_argument (l_local)
			across a_node.expressions as i loop
				l_proc_call.add_argument (process_argument_expression (i))
			end
			l_block.add_statement (l_proc_call)

			last_expression := l_local
			side_effect.extend (if_safety_expression (l_block))
		end

feature -- Translation

	process_attribute_call (a_feature: FEATURE_I)
			-- Process call to attribute `a_feature'.
		local
			l_content_type: IV_TYPE
			l_field: IV_ENTITY
		do
			translation_pool.add_referenced_feature (a_feature, current_target_type)

			check current_target /= Void end
			l_content_type := types.for_class_type (feature_class_type (a_feature))
			l_field := factory.entity (name_translator.boogie_procedure_for_feature (a_feature, current_target_type), types.field (l_content_type))

				-- Add a reads check
			if context_readable /= Void then
					-- Using subsumption here, since in a query call chains it can trigger for the followings checks
				add_safety_check_with_subsumption (factory.frame_access (context_readable, current_target, l_field), "access", "attribute_readable", context_line_number)
				last_safety_check.node_info.set_attribute ("cid", a_feature.written_class.class_id.out)
				last_safety_check.node_info.set_attribute ("rid", a_feature.rout_id_set.first.out)
				check system.class_of_id (a_feature.written_class.class_id).feature_of_rout_id (a_feature.rout_id_set.first).feature_name_id = a_feature.feature_name_id end
			end

			last_expression := factory.heap_access (entity_mapping.heap, current_target, l_field.name, l_content_type)
		end

	process_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_for_creator: BOOLEAN)
			-- Process feature call.
		local
			l_inlining_depth: INTEGER
		do
			if options.inlining_depth > 0 and not helper.is_skipped (a_feature) then
				l_inlining_depth := options.inlining_depth
				options.set_inlining_depth (options.inlining_depth - 1)
				process_inlined_routine_call (a_feature, a_parameters)
				options.set_inlining_depth (l_inlining_depth)
			elseif
				helper.is_inlining_routine (a_feature) and then
				(inlined_routines.has (a_feature.body_index) implies inlined_routines.item (a_feature.body_index) < options.max_recursive_inlining_depth)
			then
				process_inlined_routine_call (a_feature, a_parameters)
			else
				process_normal_routine_call (a_feature, a_parameters, a_for_creator)
			end
		end

	process_normal_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_for_creator: BOOLEAN)
			-- Process feature call.
		local
			l_pcall: IV_PROCEDURE_CALL
			l_fcall: IV_FUNCTION_CALL
		do
			translation_pool.add_referenced_feature (a_feature, current_target_type)
			if a_feature.has_return_value and helper.is_functional (a_feature) then
				check not a_for_creator end
				create l_fcall.make (name_translator.boogie_function_for_feature (a_feature, current_target_type, False), types.for_class_type (feature_class_type (a_feature)))
				l_fcall.add_argument (entity_mapping.heap)
				if not helper.is_static (a_feature) then
					l_fcall.add_argument (current_target)
				end
				process_parameters (a_parameters)
				l_fcall.arguments.append (last_parameters)

					-- Add precondition check
				add_function_precondition_check (a_feature, l_fcall)

					-- Add read frame check
				add_read_frame_check (a_feature)

					-- This checks that functionals are well-defined, from the corresponding fake procedure
				add_recursion_termination_check (a_feature)

				last_expression := l_fcall
			elseif helper.has_functional_representation (a_feature) and a_feature.is_once then
					-- Once function: translate as a constant
				create l_fcall.make (name_translator.boogie_function_for_feature (a_feature, current_target_type, False), types.for_class_type (feature_class_type (a_feature)))
				last_expression := l_fcall
			else
				if helper.is_setter (context_feature) and
					not a_feature.has_return_value  and not helper.is_setter (a_feature) then
						-- Setter calling a non-setter procedure: unsound framing
					helper.add_semantic_error (context_feature, messages.nonsetter_call_from_setter (a_feature.feature_name_32), context_line_number)
				end

				if a_for_creator or
						(name_translator.is_creator_name (context_implementation.procedure.name) and helper.is_creator_of_class (a_feature, current_target_type.base_class)) then
						-- Either we are translating a creation expression (`a_for_creator'),
						-- or we are inside a creation procedure and calling another creation procedure,
						-- so the creation semantics will be used
					create l_pcall.make (name_translator.boogie_procedure_for_creator (a_feature, current_target_type))
				else
					create l_pcall.make (name_translator.boogie_procedure_for_feature (a_feature, current_target_type))
					if helper.is_creator (a_feature) then
						-- A feature specified to be creator-only, but called as a regular procedure
						helper.add_semantic_error (context_feature, messages.creator_call_as_procedure (a_feature.feature_name_32), context_line_number)
					end
				end

				l_pcall.node_info.set_line (context_line_number)
				l_pcall.node_info.set_attribute ("cid", current_target_type.base_class.class_id.out)
				l_pcall.node_info.set_attribute ("rid", a_feature.rout_id_set.first.out)
				check system.class_of_id (current_target_type.base_class.class_id).feature_of_rout_id (a_feature.rout_id_set.first).feature_name_id = a_feature.feature_name_id end

				if not helper.is_static (a_feature) then
					l_pcall.add_argument (current_target)
				end
				process_parameters (a_parameters)
				l_pcall.arguments.append (last_parameters)

					-- Add read frame check
				add_read_frame_check (a_feature)
					-- This checks termination of non-functional routines, when they are called from their own implementation
				add_recursion_termination_check (a_feature)
					-- This adds an extra framing check if we are inside a context with a local frame
				add_loop_frame_check (a_feature)

					-- Process call
				if a_feature.has_return_value then
					create_local (feature_class_type (a_feature))
					l_pcall.set_target (last_local)
					last_expression := last_local
				else
						-- No expression generated, this has to be a call statement
					last_expression := Void
				end
				side_effect.extend (if_safety_expression (l_pcall))
			end
		end

	process_builtin_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_builtin_name: STRING)
			-- Process feature call.
		local
			l_call: IV_PROCEDURE_CALL
		do
			create l_call.make (a_builtin_name)
			if not helper.is_static (a_feature) then
				l_call.add_argument (current_target)
			end

			process_parameters (a_parameters)
			l_call.arguments.append (last_parameters)

				-- Process call
			if a_feature.has_return_value then
				create_local (feature_class_type (a_feature))
				l_call.set_target (last_local)
				last_expression := last_local
			else
					-- No expression generated, this has to be a call statement
				last_expression := Void
			end
			l_call.node_info.set_line (context_line_number)
			l_call.node_info.set_attribute ("cid", a_feature.written_in.out)
			l_call.node_info.set_attribute ("rid", a_feature.rout_id_set.first.out)
			side_effect.extend (if_safety_expression (l_call))
		end

	process_builtin_function_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_builtin_name: STRING)
			-- Process feature call.
		require
			a_feature.has_return_value
		local
			l_call: IV_FUNCTION_CALL
		do
			create l_call.make (a_builtin_name, types.for_class_type (feature_class_type (a_feature)))
			l_call.add_argument (entity_mapping.heap)
			if not helper.is_static (a_feature) then
				l_call.add_argument (current_target)
			end

			process_parameters (a_parameters)
			l_call.arguments.append (last_parameters)

			last_expression := l_call
		end

	process_special_feature_call (a_handler: E2B_CUSTOM_CALL_HANDLER; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		do
			a_handler.handle_routine_call_in_body (Current, a_feature, a_parameters)
		end

	inlined_routines: HASH_TABLE [INTEGER, INTEGER]
			-- Routines currently being inlined.
		once
			create Result.make (5)
		end

	process_inlined_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- Process feature call.
		local
			l_translator: E2B_INSTRUCTION_TRANSLATOR
			l_block: IV_BLOCK
			l_entity_mapping: E2B_ENTITY_MAPPING
		do
				-- TODO: look for all possible descendant-implementations for feature
				-- and add a nondeterministic goto that selects between all of those
				-- implementations

--			if l_features.count > 1 then
--					-- More than one possible feature to inline
--			elseif l_features.count = 1 then
--					-- Exactly one feature to inline
--			else
--					-- No possible feature to inline (deferred or external)
--				process_normal_routine_call (a_feature, a_parameters)
--			end

			translation_pool.add_write_frame_function (a_feature, current_target_type)

			if inlined_routines.has (a_feature.body_index) then
				inlined_routines.force (inlined_routines.item (a_feature.body_index) + 1, a_feature.body_index)
			else
				inlined_routines.force (1, a_feature.body_index)
			end


			process_parameters (a_parameters)

				-- Set up entity mapping
			create l_entity_mapping.make_copy (entity_mapping)
			l_entity_mapping.clear_arguments
			l_entity_mapping.clear_locals
				-- Map `Current'
			l_entity_mapping.set_current (current_target)
				-- Map arguments
			across last_parameters as l_args loop
				l_entity_mapping.set_argument (@ l_args.cursor_index, l_args)
			end
				-- Map `Result'
			if a_feature.has_return_value then
				create_local (feature_class_type (a_feature))
				l_entity_mapping.set_result (last_local)
			end

			create l_block.make
			create l_translator.make (context_implementation, a_feature, current_target_type)
			l_translator.set_current_block (l_block)
			l_translator.set_entity_mapping (l_entity_mapping)

			l_translator.process_feature_of_type (a_feature, current_target_type)
			helper.set_up_byte_context (context_feature, context_type)

			side_effect.extend (if_safety_expression (l_block))

			if a_feature.has_return_value then
				last_expression := l_entity_mapping.result_expression
			else
				last_expression := Void
			end

			inlined_routines.force (inlined_routines.item (a_feature.body_index) - 1, a_feature.body_index)
		end

	add_loop_frame_check (a_feature: FEATURE_I)
			-- If there is a local frame, check that `a_feature's frame is a subframe of it.
		local
			l_fcall: IV_FUNCTION_CALL
		do
			if local_writable /= Void and not helper.is_lemma (a_feature) then
				create l_fcall.make (name_translator.boogie_function_for_write_frame (a_feature, current_target_type), types.frame)
				l_fcall.add_argument (entity_mapping.heap)
				if not helper.is_static (a_feature) then
					l_fcall.add_argument (current_target)
				end
				l_fcall.arguments.append (last_parameters)
				add_safety_check (factory.function_call ("Frame#Subset", <<l_fcall, local_writable>>, types.bool),
					"check", "frame_writable", context_line_number)
			end
		end

	add_independent_check (a_statement: IV_STATEMENT)
			-- Add `a_statement' to `side_effects', but avoid learning anything from it.
		local
			l_if: IV_CONDITIONAL
		do
			create l_if.make (Void)
			l_if.then_block.add_statement (a_statement)
			l_if.then_block.add_statement (create {IV_ASSERT}.make_assume (factory.false_))
			side_effect.extend (l_if)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2015 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
