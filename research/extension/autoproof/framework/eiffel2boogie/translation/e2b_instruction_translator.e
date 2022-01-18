note
	description: "Translates Eiffel instructions to Boogie."

class
	E2B_INSTRUCTION_TRANSLATOR

inherit

	E2B_VISITOR
		rename
			safe_process as safe_process_b
		redefine
			process_assign_b,
			process_check_b,
			process_debug_b,
			process_guard_b,
			process_if_b,
			process_inspect_b,
			process_instr_call_b,
			process_loop_b,
			process_nested_b,
			process_retry_b,
			process_reverse_b
		end

	E2B_SHARED_CONTEXT
		export {NONE} all end

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

	SHARED_BYTE_CONTEXT
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (a_implementation: IV_IMPLEMENTATION; a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Initialize instruction translator with the specified context.
		require
			a_type_attached: attached a_type
			a_feature_attached: attached a_feature
			a_implementation_attached: attached a_implementation
		do
			create entity_mapping.make
			create locals_map.make (5)
			local_writable := Void
			context_readable := Void
			current_implementation := a_implementation
			current_feature := a_feature
			current_type := a_type
			current_block := current_implementation.body
			if attached types.for_class_type (a_type) as t then
				entity_mapping.set_current (create {IV_ENTITY}.make
						(if attached {IV_ENTITY} entity_mapping.current_expression as e then
							e.name
						else
							{E2B_ENTITY_MAPPING}.default_current_name
						end, t))
			end
			if a_feature.has_return_value then
				entity_mapping.set_default_result (helper.class_type_in_context (a_feature.type, a_feature.written_class, a_feature, a_type))
			end
		end

feature -- Access

	current_implementation: IV_IMPLEMENTATION
			-- Boogie procedure implementation currently being processed.

	current_feature: FEATURE_I
			-- Feature that is currently being processed.

	current_type: CL_TYPE_A
			-- Type containing feature that is currently being processed.

	current_block: IV_BLOCK
			-- Current block that receives statements.

	entity_mapping: E2B_ENTITY_MAPPING
			-- Name mapping used.

	context_writable: IV_EXPRESSION
			-- Writable frame of the enclosing context.
		do
			if local_writable = Void then
				Result := factory.global_writable
			else
				Result := local_writable
			end
		end

	context_readable: IV_EXPRESSION
		-- Readable  frame of the enclosing context if defined, otherwise Void.

feature -- Element change

	set_entity_mapping (a_entity_mapping: E2B_ENTITY_MAPPING)
			-- Set `entity_mapping' to `a_entity_mapping'.
		do
			entity_mapping := a_entity_mapping
		ensure
			entity_mapping_set: entity_mapping = a_entity_mapping
		end

	set_current_block (a_block: IV_BLOCK)
			-- Set `current_block' to `a_block'.
		do
			current_block := a_block
		ensure
			current_block_set: current_block = a_block
		end

	set_context_readable (a_readable: IV_EXPRESSION)
			-- Set `context_readable' to `a_readable'.
		do
			context_readable := a_readable
		end

feature -- Basic operations

	process_feature_of_type (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Process body of feature `a_feature' of type `a_type'.
		local
			l_type: CL_TYPE_A
			l_name: READABLE_STRING_8
			l_ownership_handler: E2B_CUSTOM_OWNERSHIP_HANDLER
			l_feature: FEATURE_I
			l_expr_translator: E2B_BODY_EXPRESSION_TRANSLATOR
			l_call: IV_PROCEDURE_CALL
		do

			create l_ownership_handler
			create l_expr_translator.make
			l_expr_translator.set_context (a_feature, a_type)
			l_expr_translator.set_context_implementation (current_implementation)

				-- OWNERSHIP: start of routine body
			if options.is_ownership_enabled then
					-- Public procedures unwrap Current in the beginning, unless lemma or marked with explicit wrapping
				if helper.is_public (a_feature) and not a_feature.has_return_value and
					not helper.is_explicit (a_feature, "wrapping") and not helper.is_lemma (a_feature) and not helper.is_nonvariant (a_feature) then
					l_feature := system.any_type.base_class.feature_named ("unwrap")
					l_expr_translator.set_context_line_number (a_feature.body.start_location.line)

					l_ownership_handler.pre_builtin_call (l_expr_translator, l_feature)
					current_block.statements.append (l_expr_translator.side_effect)
					l_expr_translator.side_effect.wipe_out

					l_call := factory.procedure_call ("unwrap", << entity_mapping.current_expression >>)
					l_call.node_info.set_attribute ("default", "wrapping")
					l_call.node_info.set_attribute ("cid", system.any_id.out)
					l_call.node_info.set_attribute ("rid", l_feature.rout_id_set.first.out)
					l_call.node_info.set_line (a_feature.body.start_location.line)
					current_block.add_statement (l_call)

					l_ownership_handler.post_builtin_call (l_expr_translator, l_feature)
					current_block.statements.append (l_expr_translator.side_effect)
					l_expr_translator.side_effect.wipe_out
				end
			end


			helper.set_up_byte_context (a_feature, a_type)
			if attached Context.byte_code as l_byte_code then
				if l_byte_code.compound /= Void and then not l_byte_code.compound.is_empty then
					if l_byte_code.locals /= Void then
						across l_byte_code.locals as i loop
							l_name := helper.unique_identifier ("local")
							l_type := helper.class_type_in_context (i, a_feature.written_class, a_feature, current_type)
							entity_mapping.set_local (@ i.cursor_index, create {IV_ENTITY}.make (l_name, types.for_class_type (l_type)))
							current_implementation.add_local (l_name, types.for_class_type (l_type))
						end
					end
					process_compound (l_byte_code.compound)
				end
			end

				-- OWNERSHIP: end of routine body
			if options.is_ownership_enabled then
				if not helper.is_explicit (a_feature, "wrapping") and not helper.is_lemma (a_feature) and not helper.is_nonvariant (a_feature) then
					if helper.is_public (a_feature) and not a_feature.has_return_value then
						l_feature := system.any_type.base_class.feature_named ("wrap")
						l_expr_translator.set_context_line_number (a_feature.body.end_location.line)

						l_ownership_handler.pre_builtin_call (l_expr_translator, l_feature)
						current_block.statements.append (l_expr_translator.side_effect)
						l_expr_translator.side_effect.wipe_out

						l_call := factory.procedure_call ("wrap", << entity_mapping.current_expression >>)
						l_call.node_info.set_attribute ("default", "wrapping")
						l_call.node_info.set_attribute ("cid", system.any_id.out)
						l_call.node_info.set_attribute ("rid", l_feature.rout_id_set.first.out)
						l_call.node_info.set_line (a_feature.body.end_location.line)
						current_block.add_statement (l_call)

						l_ownership_handler.post_builtin_call (l_expr_translator, l_feature)
						current_block.statements.append (l_expr_translator.side_effect)
						l_expr_translator.side_effect.wipe_out
					end
				end
			end

		end

	process_compound (a_compound: BYTE_LIST [BYTE_NODE])
			-- Process `a_compound'.
		do
			safe_process_b (a_compound)
		end

feature -- Processing

	process_assign_b (a_node: ASSIGN_B)
			-- <Precursor>
		local
			l_feature: FEATURE_I
			l_type: CL_TYPE_A

			l_target, l_source: IV_EXPRESSION
			l_field: IV_ENTITY
			l_assignment: IV_ASSIGNMENT
			l_call: IV_PROCEDURE_CALL
			l_assert: IV_ASSERT
		do
			set_current_origin_information (a_node)

				-- Create target node
			if attached {RESULT_B} a_node.target as l_result then
				check current_feature.has_return_value end
				l_target := entity_mapping.result_expression
			elseif attached {LOCAL_B} a_node.target as l_local then
				l_target := entity_mapping.local_ (l_local.position)
			elseif attached {ATTRIBUTE_B} a_node.target as l_attribute then
				l_feature := helper.feature_for_call_access (l_attribute, current_type)
				check
					valid_feature: l_feature /= Void
					correct_feature: l_feature.rout_id_set.first = l_attribute.routine_id
				end
				l_type := helper.class_type_in_context (l_feature.type, current_feature.written_class, current_feature, current_type)
				translation_pool.add_referenced_feature (l_feature, current_type)
				l_target := factory.heap_access (
					entity_mapping.heap,
					entity_mapping.current_expression,
					name_translator.boogie_procedure_for_feature (l_feature, current_type),
					types.for_class_type (l_type))
			else
				check should_never_happen: False end
			end

				-- Create source node
			if helper.is_functional (current_feature) then
					-- Process as contract expression if it is the body of functional
					-- (otherwise hard to deal with preconditions)
				process_contract_expression (a_node.source, False)
				across last_safety_checks as i loop
					add_statement (i)
				end
			else
				process_expression (a_node.source)
			end
			l_source := last_expression

				-- Check for possible boxing of basic types
			if a_node.target.type.is_reference then
				if a_node.source.type.is_boolean then
					l_source := factory.function_call ("boxed_bool", << l_source >>, types.ref)
				elseif a_node.source.type.is_integer or a_node.source.type.is_natural then
					l_source := factory.function_call ("boxed_int", << l_source >>, types.ref)
				end
			end

				-- Create assignment node
			if a_node.target.is_attribute and options.is_ownership_enabled then
					-- OWNERSHIP: call update heap instead of direct heap assignment				
				create l_field.make (name_translator.boogie_procedure_for_feature (l_feature, current_type), types.field (types.for_class_type (l_type)))
				create l_call.make ("update_heap")
				l_call.add_argument (entity_mapping.current_expression)
				l_call.add_argument (l_field)
				l_call.add_argument (l_source)
				l_call.node_info.set_line (a_node.line_number)

				if local_writable /= Void then
						-- There is a local frame: create a framing check
					create l_assert.make (factory.frame_access (local_writable, entity_mapping.current_expression, l_field))
					l_assert.node_info.set_type ("assign")
					l_assert.node_info.set_tag ("attribute_writable")
					l_assert.node_info.set_line (a_node.line_number)
					l_assert.set_attribute_string (":subsumption 0")
					add_statement (l_assert)
				end

				add_statement (l_call)
			else
				create l_assignment.make (l_target, l_source)
				add_statement (l_assignment)
			end
			add_trace_statement (a_node)
		end

	process_check_b (a_node: CHECK_B)
			-- <Precursor>
		do
			if attached a_node.check_list as ls then
				across
					ls as l
				loop
					check
						attached {ASSERT_B} l as l_assert
					then
						process_single_check (l_assert)
					end
				end
			end
		end

	process_single_check (a_assert: ASSERT_B)
			-- Process single check statement.
		local
			l_statement: IV_ASSERT
			l_array: ARRAY_CONST_B
			l_other: EXPR_B
		do
			if attached {BIN_TILDE_B} a_assert.expr as l_tilde then
				if attached {ARRAY_CONST_B} l_tilde.left as i then
					l_array := i
					l_other := l_tilde.right
				elseif attached {ARRAY_CONST_B} l_tilde.right as i then
					l_array := i
					l_other := l_tilde.left
				end
			end
			if l_array /= Void then
				check l_other.type.base_class.name.same_string ("ARRAY") end
				process_array_content_check (a_assert, l_array, l_other)
			else
				set_current_origin_information (a_assert)
				process_contract_expression (a_assert.expr, False)

				if attached a_assert.tag and then a_assert.tag.is_case_insensitive_equal_general ("assume") then
						-- This is an assume: translate as
						--	assume checks; assume free_checks; assume last_expression
					across last_safety_checks as i loop
						i.set_free (True)
						add_statement (i)
					end
					create l_statement.make_assume (last_expression)
				else
						-- This is an assert: tranlsate as
						--	assert checks; assume free_checks; assert last_expression												
					across last_safety_checks as i loop
						add_statement (i)
					end
					create l_statement.make (last_expression)
					l_statement.node_info.set_type ("check")
					l_statement.node_info.set_tag (a_assert.tag)
					l_statement.node_info.set_line (a_assert.line_number)
				end
				add_statement (l_statement)
			end
		end

	process_array_content_check (a_assert: ASSERT_B; a_array: ARRAY_CONST_B; a_other: EXPR_B)
			-- Process a check instruction comparing array contents.
		local
			l_assert: IV_ASSERT
			l_array: IV_EXPRESSION
			l_content_type: IV_TYPE
		do
			set_current_origin_information (a_assert)
			process_contract_expression (a_other, False)
			l_array := last_expression
				-- Check array size
			create l_assert.make (factory.equal (
				factory.function_call ("fun.ARRAY.count", << entity_mapping.heap, l_array >>, types.int),
				factory.int_value (a_array.expressions.count)))
			l_assert.node_info.set_type ("check")
			l_assert.node_info.set_tag ("array_size_equal")
			l_assert.node_info.set_line (a_assert.line_number)
			add_statement (l_assert)
				-- Check array contents
			across a_array.expressions as i loop
				process_contract_expression (i, False)
				l_content_type := types.for_class_type (helper.class_type_in_context (a_array.type.generics.first, current_feature.written_class, current_feature, current_type))
				create l_assert.make (factory.equal (
					factory.function_call ("fun.ARRAY.item", << entity_mapping.heap, l_array, factory.int_value (@ i.cursor_index) >>, l_content_type),
					last_expression))
				l_assert.node_info.set_type ("check")
				l_assert.node_info.set_tag ("array_item_" + @ i.cursor_index.out)
				l_assert.node_info.set_line (a_assert.line_number)
				add_statement (l_assert)
			end
		end

	process_debug_b (a_node: DEBUG_B)
			-- Process `a_node'.
		do
			if a_node.compound /= Void then
					-- This debug clause is activated
				process_compound (a_node.compound)
			else
					-- This debug clause is not activated
				-- TODO: what to do?
			end
		end

	process_guard_b (a_node: GUARD_B)
			-- Process `a_node'.
		do
			process_check_b (a_node)
			if a_node.compound /= Void then
				process_compound (a_node.compound)
			end
		end

	process_if_b (a_node: IF_B)
			-- <Precursor>
		local
			l_if: IV_CONDITIONAL
			l_nested_if: IV_CONDITIONAL
			l_temp_block: IV_BLOCK
		do
			set_current_origin_information (a_node)

			l_temp_block := current_block

				-- if condition
			process_expression (a_node.condition)
			create l_if.make (last_expression)
			add_statement (l_if)

				-- then block
			current_block := l_if.then_block
			process_compound (a_node.compound)

				-- elseif blocks
			current_block := l_if.else_block
			if attached a_node.elsif_list as ls then
				across
					ls as l
				loop
					check
						attached {ELSIF_B} l as l_elseif
					then
						set_current_origin_information (l_elseif)
							-- elseif condition
						process_expression (l_elseif.expr)
						create l_nested_if.make (last_expression)
						add_statement (l_nested_if)
							-- elseif block
						current_block := l_nested_if.then_block
						process_compound (l_elseif.compound)
							-- else block
						current_block := l_nested_if.else_block
					end
				end
			end

				-- else block
			if attached a_node.else_part as e then
				process_compound (e)
			end

				-- restore context
			current_block := l_temp_block
		end

	process_inspect_b (a_node: INSPECT_B)
			-- <Precursor>
		local
			l_temp_block, l_head_block, l_else_block, l_end_block: IV_BLOCK
			l_case_blocks: ARRAY [IV_BLOCK]
			l_case_conditions: ARRAY [IV_EXPRESSION]
			l_index: INTEGER
			l_entity: IV_ENTITY
			l_condition, l_lower, l_upper: IV_EXPRESSION
			l_binary: IV_BINARY_OPERATION
			l_assign: IV_ASSIGNMENT
			l_assume: IV_ASSERT
			l_goto: IV_GOTO
		do
			set_current_origin_information (a_node)

			l_temp_block := current_block
			create l_head_block.make
			create l_else_block.make_name (helper.unique_identifier ("inspect_else"))
			create l_end_block.make_name (helper.unique_identifier ("inspect_end"))

			create l_case_blocks.make_empty
			create l_case_conditions.make_empty

			create l_entity.make (helper.unique_identifier ("switch"), types.int)
			current_implementation.add_local (l_entity.name, types.int)

			set_current_block (l_head_block)
			process_expression (a_node.switch)
			create l_assign.make (l_entity, last_expression)
			add_statement (l_assign)

			if attached a_node.case_list as case_list then
				across
					case_list as ls
				loop
					l_index := @ ls.target_index
					check
						attached {CASE_B} ls as l_case
					then
						if l_case.interval /= Void and then not l_case.interval.is_empty then
							from
								l_condition := Void
								l_case.interval.start
							until
								l_case.interval.after
							loop
								process_contract_expression (l_case.interval.item.lower, False)
								l_lower := last_expression
									-- TODO: check side effect
								process_contract_expression (l_case.interval.item.upper, False)
								l_upper := last_expression
									-- TODO: check side effect

								l_binary := factory.and_ (
									factory.less_equal (l_lower, l_entity),
									factory.less_equal (l_entity, l_upper))

								if l_condition = Void then
									l_condition := l_binary
								else
									l_condition := factory.or_ (l_condition, l_binary)
								end

								l_case.interval.forth
							end
						else
							create {IV_VALUE} l_condition.make ("false", types.bool)
						end

						set_current_origin_information (l_case)

						l_case_blocks.force (create {IV_BLOCK}.make_name (helper.unique_identifier ("inspect_case")), l_index)
						set_current_block (l_case_blocks.item (l_index))
						create l_assume.make_assume (l_condition)
						add_statement (l_assume)
						process_compound (l_case.compound)
						create l_goto.make (l_end_block)
						add_statement (l_goto)

						l_case_conditions.force (l_condition, l_index)
					end
				end
			end

				-- Else part
			set_current_block (l_else_block)
			across l_case_conditions as i loop
				create l_assume.make_assume (factory.not_ (i))
				add_statement (l_assume)
			end
			if a_node.else_part /= Void then
				process_compound (a_node.else_part)
			end
			create l_goto.make (l_end_block)
			add_statement (l_goto)

				-- Switch in head
			set_current_block (l_head_block)
			create l_goto.make (l_else_block)
			across l_case_blocks as i loop
				l_goto.add_target (i)
			end
			add_statement (l_goto)

				-- Add blocks
			set_current_block (l_temp_block)
			add_statement (l_head_block)
			across l_case_blocks as i loop
				add_statement (i)
			end
			add_statement (l_else_block)
			add_statement (l_end_block)
		end

	process_instr_call_b (a_node: INSTR_CALL_B)
			-- <Precursor>
		do
			set_current_origin_information (a_node)
				-- Instruction call is in the side effect of the expression,
				-- so the generated expression itself is ignored.
			process_expression (a_node.call)
			add_trace_statement (a_node)
		end

	process_loop_b (a_node: LOOP_B)
			-- <Precursor>
		do
			if options.is_automatic_loop_unrolling_enabled and a_node.invariant_part = Void then
				process_loop_unrolled (a_node)
			else
				process_loop_normal (a_node)
			end
		end

	process_loop_normal (a_node: LOOP_B)
			-- Process loop in normal way.
		do
			if a_node.stop /= Void then
				process_from_loop_normal (a_node)
			else
--				process_across_loop_normal (a_node)
			end
		end

	process_from_loop_normal (a_node: LOOP_B)
			-- Process from loop in normal way.
		require
			from_loop: a_node.stop /= Void and a_node.iteration_exit_condition = Void
		local
			l_pre_heap: IV_ENTITY
			l_frame: like process_loop_modifies
			l_old_writable: IV_EXPRESSION
			l_condition: IV_EXPRESSION
			l_goto: IV_GOTO
			l_temp_block, l_head_block, l_body_block, l_end_block: IV_BLOCK
			l_assume: IV_ASSERT
			l_variant_locals: ARRAYED_LIST [IV_ENTITY]
			l_variant_exprs: ARRAYED_LIST [IV_EXPRESSION]
			l_assignment: IV_ASSIGNMENT
			l_modifies, l_decreases: ARRAYED_LIST [E2B_ASSERT_ORIGIN]
		do
			set_current_origin_information (a_node)

			l_temp_block := current_block
			create l_head_block.make_name (helper.unique_identifier("loop_head"))
			create l_body_block.make_name (helper.unique_identifier("loop_body"))
			create l_end_block.make_name (helper.unique_identifier("loop_end"))

				-- From part
			if a_node.from_part /= Void then
				a_node.from_part.process (Current)
			end

				-- Save pre-loop state
			create l_pre_heap.make (helper.unique_identifier ("PreLoopHeap"), types.heap)
			current_implementation.add_local (l_pre_heap.name, l_pre_heap.type)
			create l_assignment.make (l_pre_heap, entity_mapping.heap)
			add_statement (l_assignment)

				-- Collect modify and decreases clauses
			create l_modifies.make (3)
			create l_decreases.make (3)
			if attached a_node.invariant_part as i then
				across
					i as node
				loop
					if not attached {ASSERT_B} node as l_invariant then
							-- Unexpected byte node.
					elseif helper.is_clause_modify (l_invariant) then
						l_modifies.extend (create {E2B_ASSERT_ORIGIN}.make (l_invariant, current_feature.written_class))
					elseif helper.is_clause_decreases (l_invariant) then
						l_decreases.extend (create {E2B_ASSERT_ORIGIN}.make (l_invariant, current_feature.written_class))
					end
				end
			end

				-- Process modifies
			l_frame := process_loop_modifies (l_modifies)
			l_old_writable := local_writable
			local_writable := l_frame.writable

				-- Goto head
			create l_goto.make (l_head_block)
			add_statement (l_goto)
			add_statement (l_head_block)
			current_block := l_head_block

				-- Process invariants
			process_loop_invariants (a_node.invariant_part, l_pre_heap, l_frame.frame)

				-- Condition
			set_current_origin_information (a_node.stop)
			process_contract_expression (a_node.stop, False)
			across last_safety_checks as i loop
				add_statement (i)
			end

			l_condition := last_expression
			create l_goto.make (l_body_block)
			l_goto.add_target (l_end_block)
			add_statement (l_goto)
			current_block := l_temp_block

				-- Body block
			add_statement (l_body_block)
			current_block := l_body_block
			create l_assume.make_assume (factory.not_ (l_condition))
			add_statement (l_assume)

				-- Variant initization
			create l_variant_exprs.make (3)
			create l_variant_locals.make (3)
			process_loop_variants (a_node.variant_part, l_decreases, l_condition, l_variant_exprs, l_variant_locals)

				-- Body
			process_compound (a_node.compound)

				-- Variant checks
			if a_node.variant_part /= Void and l_variant_exprs.count = 1 then
				set_current_origin_information (a_node.variant_part)
			elseif a_node.compound /= Void then
				set_current_origin_information (a_node.compound)
			else
				set_current_origin_information (a_node)
			end
			add_termination_check (l_variant_locals, l_variant_exprs)

				-- Goto head
			create l_goto.make (l_head_block)
			add_statement (l_goto)
			current_block := l_temp_block

				-- End
			add_statement (l_end_block)
			current_block := l_end_block
			create l_assume.make_assume (l_condition)
			add_statement (l_assume)

				-- Revert to the old local writable
			local_writable := l_old_writable

			current_block := l_temp_block
		end

	process_across_loop_normal (a_node: LOOP_B)
			-- Process across loop in a normal way.
		require
			from_loop: a_node.stop = Void and a_node.iteration_exit_condition /= Void
		local
			l_condition: IV_EXPRESSION
--			l_invariant: ASSERT_B
			l_goto: IV_GOTO
			l_temp_block, l_head_block, l_body_block, l_end_block: IV_BLOCK
			l_assert: IV_ASSERT
			l_assume: IV_ASSERT
			l_variant: IV_ENTITY
			l_assignment: IV_ASSIGNMENT

--			l_assign: ASSIGN_B
--			l_object_test_local: OBJECT_TEST_LOCAL_B
--			l_nested: NESTED_B
--			l_access: ACCESS_EXPR_B
--			l_bin_free: BIN_FREE_B
--			l_name: STRING
		do
			set_current_origin_information (a_node.advance_code.first)

--			l_assign ?= a_node.iteration_initialization.first
--			check l_assign /= Void end
--			l_object_test_local ?= l_assign.target
--			check l_object_test_local /= Void end
--			l_nested ?= l_assign.source
--			check l_nested /= Void end
--			l_access ?= l_nested.target
--			check l_access /= Void end

--			l_name := l_nested.target.type.base_class.name_in_upper
--			if l_name ~ "ARRAY" then
----				create {E2B_ARRAY_ACROSS_HANDLER} l_across_handler.make (Current, a_node, l_nested.target, l_object_test_local)
--			elseif l_name ~ "INTEGER_INTERVAL" then
--				l_bin_free ?= l_access.expr
--				check l_bin_free /= Void end
----				create {E2B_INTERVAL_ACROSS_HANDLER} l_across_handler.make (Current, a_node, l_bin_free, l_object_test_local)
--			else
--				check False end
--			end

			l_temp_block := current_block
			create l_head_block.make_name (helper.unique_identifier("loop_head"))
			create l_body_block.make_name (helper.unique_identifier("loop_body"))
			create l_end_block.make_name (helper.unique_identifier("loop_end"))

				-- From part
			if a_node.iteration_initialization /= Void then
				a_node.iteration_initialization.process (Current)
			end
			create l_goto.make (l_head_block)
			add_statement (l_goto)
			add_statement (l_head_block)
			current_block := l_head_block

				-- Invariants
			if attached a_node.invariant_part as i then
				across
					i as node
				loop
					if attached {ASSERT_B} node as l_invariant then
						set_current_origin_information (l_invariant)
						process_contract_expression (l_invariant.expr, False)
						across last_safety_checks as c loop
							add_statement (c)
						end
						create l_assert.make (last_expression)
						l_assert.node_info.set_type ("loop_inv")
						l_assert.node_info.set_tag (l_invariant.tag)
						l_assert.node_info.set_line (l_invariant.line_number)
						add_statement (l_assert)
					end
				end
			end

				-- Variant
			if a_node.variant_part /= Void then
				set_current_origin_information (a_node.variant_part)
				create l_variant.make (helper.unique_identifier ("variant"), types.int)
				current_implementation.add_local (l_variant.name, types.int)
				process_expression (a_node.variant_part.expr)
				create l_assignment.make (l_variant, last_expression)
				add_statement (l_assignment)
				create l_assert.make (factory.less_equal (factory.int_value (0), l_variant))
				l_assert.node_info.set_type ("loop_var_ge_zero")
				add_statement (l_assert)
			end

				-- Condition
			set_current_origin_information (a_node.iteration_exit_condition)
			process_contract_expression (a_node.iteration_exit_condition, False)
			l_condition := last_expression
			create l_goto.make (l_body_block)
			l_goto.add_target (l_end_block)
			add_statement (l_goto)
			current_block := l_temp_block

				-- Body
			add_statement (l_body_block)
			current_block := l_body_block

			create l_assume.make_assume (factory.not_ (l_condition))
			add_statement (l_assume)
			process_compound (a_node.compound)
			if a_node.variant_part /= Void then
				set_current_origin_information (a_node.variant_part)
				process_expression (a_node.variant_part.expr)
				create l_assert.make (factory.less (last_expression, l_variant))
				l_assert.node_info.set_type ("loop_var_decr")
				add_statement (l_assert)
			end
			create l_goto.make (l_head_block)
			add_statement (l_goto)
			current_block := l_temp_block

			add_statement (l_end_block)
			current_block := l_end_block

			create l_assume.make_assume (l_condition)
			add_statement (l_assume)

			current_block := l_temp_block
		end

	process_loop_unrolled (a_node: LOOP_B)
			-- Process loop with unrolling.
		local
			l_condition: IV_EXPRESSION
			l_goto: IV_GOTO
			l_temp_block, l_head_block, l_body_block, l_end_block, l_force_end_block: IV_BLOCK
			l_assert: IV_ASSERT
			l_assume: IV_ASSERT
			l_not: IV_UNARY_OPERATION
			l_op: IV_BINARY_OPERATION
			l_variant: IV_ENTITY
			l_assignment: IV_ASSIGNMENT
			l_unroll_counter: INTEGER
		do
			l_temp_block := current_block

				-- Init condition
			set_current_origin_information (a_node.stop)
			process_expression (a_node.stop)
			l_condition := last_expression

				-- Init variant
			if a_node.variant_part /= Void then
				create l_variant.make (helper.unique_identifier ("variant"), types.int)
				current_implementation.add_local (l_variant.name, types.int)
			end

				-- Init end block
			l_temp_block := current_block
			create l_end_block.make_name (helper.unique_identifier("loop_end"))

				-- From part
			set_current_origin_information (a_node)
			if a_node.from_part /= Void then
				a_node.from_part.process (Current)
			end

				-- Unrolled body
			from
				l_unroll_counter := 1
			until
				l_unroll_counter > options.loop_unrolling_depth
			loop
				create l_head_block.make_name (helper.unique_identifier("loop_head"+l_unroll_counter.out))
				create l_body_block.make_name (helper.unique_identifier("loop_body"+l_unroll_counter.out))

					-- goto head
				create l_goto.make (l_head_block)
				add_statement (l_goto)

					-- head
				current_block := l_temp_block
				add_statement (l_head_block)
				current_block := l_head_block

					-- Invariants
				if attached a_node.invariant_part as i then
					across
						i as node
					loop
						if attached {ASSERT_B} node as l_invariant then
							set_current_origin_information (l_invariant)
							process_contract_expression (l_invariant.expr, False)
							create l_assert.make (last_expression)
							l_assert.node_info.set_type ("loop_inv")
							l_assert.node_info.set_tag (l_invariant.tag)
							l_assert.node_info.set_line (l_invariant.line_number)
							add_statement (l_assert)
						end
					end
				end

					-- Variant
				if a_node.variant_part /= Void then
					set_current_origin_information (a_node.variant_part)
					process_expression (a_node.variant_part.expr)
					create l_assignment.make (l_variant, last_expression)
					add_statement (l_assignment)
					create l_op.make (l_variant, ">=", create {IV_VALUE}.make ("0", types.int), types.bool)
					create l_assert.make (l_op)
					l_assert.node_info.set_type ("loop_var_ge_zero")
					add_statement (l_assert)
				end

					-- goto end or body
				create l_goto.make (l_body_block)
				l_goto.add_target (l_end_block)
				add_statement (l_goto)

					-- body
				current_block := l_temp_block
				add_statement (l_body_block)
				current_block := l_body_block

				create l_not.make ("!", l_condition, types.bool)
				create l_assume.make_assume (l_not)
				add_statement (l_assume)
				process_compound (a_node.compound)

				if a_node.variant_part /= Void then
					set_current_origin_information (a_node.variant_part)
					process_expression (a_node.variant_part.expr)
					create l_op.make (last_expression, "<", l_variant, types.bool)
					create l_assert.make (l_op)
					l_assert.node_info.set_type ("loop_var_decr")
					add_statement (l_assert)
				end

				l_unroll_counter := l_unroll_counter + 1
			end

			if options.is_sound_loop_unrolling_enabled then
				create l_goto.make (l_head_block)
				add_statement (l_goto)
			else
				create l_force_end_block.make_name (helper.unique_identifier("force_end"))
				create l_goto.make (l_force_end_block)
				add_statement (l_goto)

					-- force end
				current_block := l_temp_block
				add_statement (l_force_end_block)
				current_block := l_force_end_block

					-- Invariants
				if attached a_node.invariant_part as i then
					across
						i as node
					loop
						if attached {ASSERT_B} node as l_invariant then
							set_current_origin_information (l_invariant)
							process_contract_expression (l_invariant.expr, False)
							create l_assert.make (last_expression)
							add_statement (l_assert)
						end
					end
				end

					-- Variant
				if a_node.variant_part /= Void then
					set_current_origin_information (a_node.variant_part)
					current_implementation.add_local (l_variant.name, types.int)
					process_expression (a_node.variant_part.expr)
					create l_assignment.make (l_variant, last_expression)
					add_statement (l_assignment)
					create l_op.make (l_variant, ">=", create {IV_VALUE}.make ("0", types.int), types.bool)
					create l_assert.make (l_op)
					add_statement (l_assert)
				end
			end

				-- end
			current_block := l_temp_block
			add_statement (l_end_block)
			current_block := l_end_block

			create l_assume.make_assume (l_condition)
			add_statement (l_assume)

			current_block := l_temp_block
		end

	process_nested_b (a_node: NESTED_B)
			-- <Precursor>
		do
			set_current_origin_information (a_node)
				-- Instruction call is in the side effect of the expression,
				-- so the generated expression itself is ignored.
			process_expression (a_node)
			add_trace_statement (a_node)
		end

	process_retry_b (a_node: RETRY_B)
			-- <Precursor>
		local
			l_havoc: IV_HAVOC
		do
			create l_havoc.make (factory.global_heap.name)
			l_havoc.set_origin_information (origin_information (a_node))
			current_block.add_statement (l_havoc)
		end

	process_reverse_b (a_node: REVERSE_B)
			-- <Precursor>
		local
			l_havoc: IV_HAVOC
		do
			create l_havoc.make (factory.global_heap.name)
			l_havoc.set_origin_information (origin_information (a_node))
			current_block.add_statement (l_havoc)
		end

feature {NONE} -- Loop processing

	process_loop_modifies (a_modifies: LIST [E2B_ASSERT_ORIGIN]): TUPLE [frame: IV_ENTITY; writable: IV_ENTITY]
			-- Process `a_modifies', initialize the loop frame and writable sets and return the correspoding local variables.
		require
			modifies_exists: a_modifies /= Void
		local
			l_writable, l_frame: IV_ENTITY
			l_assert: IV_ASSERT
			l_assume: IV_ASSERT
		do
			if not a_modifies.is_empty then
				create l_frame.make (helper.unique_identifier ("LoopFrame"), types.frame)
				current_implementation.add_local (l_frame.name, l_frame.type)
				add_statement (create {IV_HAVOC}.make (l_frame.name))

				process_modifies (a_modifies, l_frame)
				across last_safety_checks as i loop
					add_statement (i)
				end
				create l_assume.make_assume (last_frame)
				add_statement (l_assume)

				create l_assert.make (factory.function_call ("Frame#Subset", <<l_frame, context_writable>>, types.bool))
				l_assert.node_info.set_type ("check")
				l_assert.node_info.set_tag ("frame_writable")
				l_assert.node_info.set_line (a_modifies.first.clause.line_number)
				l_assert.set_attribute_string (":subsumption 0")
				add_statement (l_assert)

					-- Initialize the local writable set: superset of the frame and closed under ownership domains
				create l_writable.make (helper.unique_identifier ("LoopWritable"), types.frame)
				current_implementation.add_local (l_writable.name, l_writable.type)
				add_statement (create {IV_HAVOC}.make (l_writable.name))
				create l_assume.make_assume (factory.function_call ("Frame#Subset", <<l_frame, l_writable>>, types.bool))
				add_statement (l_assume)
				create l_assume.make_assume (factory.function_call ("closed_under_domains", <<l_writable, factory.global_heap>>, types.bool))
				add_statement (l_assume)
			end
			Result := [l_frame, l_writable]
		ensure
			result_exists: Result /= Void
			exist_together: (Result.frame = Void) = (Result.writable = Void)
		end

	process_loop_invariants (a_invariants: BYTE_LIST [BYTE_NODE]; a_pre_heap, a_loop_frame: IV_EXPRESSION)
			-- Process loop invariants `a_invariants' and add default invariants
			-- with pre-loop heap `a_pre-heap' and the loop frame `a_loop_frame' (if exists, otherwise Void).
		local
			l_inv: IV_ASSERT
		do
			if a_invariants /= Void then
				across
					a_invariants as node
				loop
						-- Ignore modifies and decreases clauses
					if
						attached {ASSERT_B} node as l_invariant and then
						not helper.is_clause_modify (l_invariant) and then not
						helper.is_clause_decreases (l_invariant)
					then
						set_current_origin_information (l_invariant)
						process_contract_expression (l_invariant.expr, False)
						if l_invariant.tag /= Void and then l_invariant.tag.is_case_insensitive_equal_general ("assume") then
								-- Free invariant: translate as
								--	assume checks; assume free_checks; assume last_expression
							across last_safety_checks as i loop
								i.set_free (True)
								add_statement (i)
							end
							create l_inv.make (last_expression)
						else
								-- Regular invariant: translate as
								--	assert checks; assume free_checks; assert last_expression							
							across last_safety_checks as i loop
								add_statement (i)
							end
							create l_inv.make (last_expression)
							l_inv.node_info.set_type ("loop_inv")
							l_inv.node_info.set_tag (l_invariant.tag)
							l_inv.node_info.set_line (l_invariant.line_number)
						end
						add_statement (l_inv)
					end
				end
			end
				-- Default invariants (free)			
			create l_inv.make_assume (factory.function_call ("HeapSucc", <<a_pre_heap, factory.global_heap>>, types.bool))
			add_statement (l_inv)
			if options.is_ownership_enabled then
				if a_loop_frame = Void then
						-- Nothing outside routine's frame has changed compared to old(Heap)
						-- (here we have to compare to old(Heap) because the routines's frame referes to ownership domains then.
					create l_inv.make_assume (factory.writes_routine_frame (current_feature, current_type, current_implementation.procedure))
				else
						-- Nothing outside loop's frame has changed since before the loop
						-- (here we have to compare to before the loop because the loop's frame referes to ownership domains then.
					create l_inv.make_assume (factory.function_call ("same_outside", <<a_pre_heap, factory.global_heap, a_loop_frame>>, types.bool))
				end
				add_statement (l_inv)
				create l_inv.make_assume (factory.function_call ("global", << factory.global_heap>>, types.bool))
				add_statement (l_inv)
			end
		end

	process_loop_variants (a_variant: VARIANT_B; a_decreases: LIST [E2B_ASSERT_ORIGIN]; a_exit_condition: IV_EXPRESSION; a_variant_exprs, a_variant_locals: LIST [IV_EXPRESSION])
			-- Process variant `a_variant' and decreases clauses `a_decreases'
			-- and fill `a_variant_exprs' and `a_variant_locals' with variant expressions and local variables that store their value at the biginning of the iteration;
			-- add assignments of expressions to locals.
		local
			l_variant: IV_ENTITY
			l_assignment: IV_ASSIGNMENT
		do
			if a_variant /= Void then
				set_current_origin_information (a_variant)
				process_contract_expression (a_variant.expr, False)
				a_variant_exprs.extend (last_expression)
			end
			process_decreases (a_decreases)
			a_variant_exprs.append (last_decreases)

			if a_variant_exprs.is_empty then
					-- No decreases clause: apply default
				if attached {IV_BINARY_OPERATION} a_exit_condition as binop and then binop.left.type.is_integer then
					if binop.operator ~ ">" or binop.operator ~ ">=" then
						-- for A > B and A >= B, use the decreases B - A
						a_variant_exprs.extend (factory.minus (binop.right, binop.left))
					elseif binop.operator ~ "<" or binop.operator ~ "<=" then
						-- for A < B and A <= B, use the decreases A - B
						a_variant_exprs.extend (factory.minus (binop.left, binop.right))
					elseif binop.operator ~ "==" then
						-- for A = B, use the absolute value of A - B
						a_variant_exprs.extend (factory.conditional (factory.less_equal (binop.right, binop.left),
							factory.minus (binop.left, binop.right),
							factory.minus (binop.right, binop.left)))
					end
					-- ToDo: come up with a way to create default variants for other types
				end

					-- If still empty, add a trivially wrong variant
				if a_variant_exprs.is_empty and options.is_generating_trivial_loop_variants then
					a_variant_exprs.extend (factory.int_value (0))
				end
			elseif a_variant_exprs.first = Void then
				-- Decreases empty set (*): do not check termination
				a_variant_exprs.wipe_out
			end

				-- In case an empty decreases clause is added in addition to a loop variant
			a_variant_exprs.prune_all (Void)

			across
				a_variant_exprs as i
			loop
				if i.type.has_rank then
					create l_variant.make (helper.unique_identifier ("variant"), i.type)
					current_implementation.add_local (l_variant.name, l_variant.type)
					a_variant_locals.extend (l_variant)

					create l_assignment.make (l_variant, i)
					add_statement (l_assignment)
				else
					helper.add_semantic_error (current_feature, messages.variant_bad_type (@ i.target_index), -1)
				end
			end
		end

feature {NONE} -- Implementation

	current_origin_information: detachable IV_STATEMENT_ORIGIN

	set_current_origin_information (a_node: BYTE_NODE)
			-- Set origin information to be used by first side effect or statement generated.
		do
			current_origin_information := origin_information (a_node)
		end

	origin_information (a_node: BYTE_NODE): IV_STATEMENT_ORIGIN
			-- Origin information of node `a_node'.
		local
			l_error: BOOLEAN
		do
			create Result
			Result.set_file (current_feature.written_class.file_name)
			Result.set_line (if l_error then -1 else a_node.line_number end)
		rescue
				-- a_node.line_number might result in a postcondition violation
			l_error := True
			retry
		end

	add_statement (a_statement: IV_STATEMENT)
			-- Add statement and possibly add origin information.
		do
			if attached current_origin_information as coi then
				a_statement.set_origin_information (coi)
				current_origin_information := Void
			end
			current_block.add_statement (a_statement)
		end

	add_trace_statement (a_node: BYTE_NODE)
			-- Add statement and possibly add origin information.
		do
			if options.is_trace_enabled then
				current_block.add_statement (factory.trace (name_translator.boogie_procedure_for_feature (current_feature, current_type) + ":" + a_node.line_number.out))
			end
		end

	process_expression (a_expr: BYTE_NODE)
			-- Process expression `a_expr'.
		local
			l_translator: E2B_BODY_EXPRESSION_TRANSLATOR
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_translator.set_context_implementation (current_implementation)
			if attached current_origin_information as coi then
				l_translator.set_context_line_number (coi.line)
			end
			l_translator.copy_entity_mapping (entity_mapping)
			l_translator.locals_map.merge (locals_map)
			l_translator.set_local_writable (local_writable)
			l_translator.set_context_readable (context_readable)
			a_expr.process (l_translator)
			across
				l_translator.side_effect as stmts
			loop
				if @ stmts.is_first and attached current_origin_information as coi then
					stmts.set_origin_information (coi)
					current_origin_information := Void
				end
				current_block.add_statement (stmts)
			end
			last_expression := l_translator.last_expression
			if last_expression = Void then
				last_expression := factory.false_
			end
			locals_map.merge (l_translator.locals_map)
			create entity_mapping.make_copy (l_translator.entity_mapping)
		end

	process_contract_expression (a_expr: BYTE_NODE; a_use_triggers: BOOLEAN)
			-- Process expression `a_expr'.
		local
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			if attached current_origin_information as coi then
				l_translator.set_context_line_number (coi.line)
			end
			l_translator.copy_entity_mapping (entity_mapping)
			l_translator.locals_map.merge (locals_map)
			l_translator.set_local_writable (local_writable)
			l_translator.set_context_readable (context_readable)
			l_translator.set_use_triggers (a_use_triggers)
			a_expr.process (l_translator)
			last_expression := l_translator.last_expression
			last_safety_checks := l_translator.side_effect
			if last_expression = Void then
				last_expression := factory.false_
			end
			locals_map.merge (l_translator.locals_map)
			create entity_mapping.make_copy (l_translator.entity_mapping)
		end

	process_modifies (a_modifies: LIST [E2B_ASSERT_ORIGIN]; a_lhs: IV_EXPRESSION)
			-- Generate frame definition of `a_lhs' using `a_modifies' and store it in `last_frame' .
		local
			l_routine_translator: E2B_ROUTINE_TRANSLATOR
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
		do
			create l_routine_translator.make
			l_routine_translator.set_context (current_feature, current_type)

			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_translator.copy_entity_mapping (entity_mapping)
			l_translator.locals_map.merge (locals_map)
			last_frame := l_routine_translator.frame_definition (l_routine_translator.modify_expressions_of (a_modifies, l_translator), a_lhs, <<>>)
			last_safety_checks := l_translator.side_effect
			locals_map.merge (l_translator.locals_map)
		end

	process_decreases (a_decreases: LIST [E2B_ASSERT_ORIGIN])
			-- Translate termination metrics encoded by `a_decreases' and store them in `last_decreases'.
		local
			l_routine_translator: E2B_ROUTINE_TRANSLATOR
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
		do
			create l_routine_translator.make
			l_routine_translator.set_context (current_feature, current_type)

			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_translator.copy_entity_mapping (entity_mapping)
			l_translator.locals_map.merge (locals_map)
			last_decreases := l_routine_translator.decreases_expressions_of (a_decreases, l_translator)
			last_safety_checks := l_translator.side_effect
			locals_map.merge (l_translator.locals_map)
		end

	add_termination_check (l_old_variants, l_new_variants: LIST [IV_EXPRESSION])
			-- Given expressions for old and new values of variants, add statements checking that the new variants are strinctly less and the order is well-founded.
		local
			l_translator: E2B_BODY_EXPRESSION_TRANSLATOR
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_translator.set_context_implementation (current_implementation)
			if attached current_origin_information as coi then
				l_translator.set_context_line_number (coi.line)
			end
			l_translator.copy_entity_mapping (entity_mapping)
			l_translator.locals_map.merge (locals_map)
			l_translator.set_local_writable (local_writable)
			l_translator.add_termination_check (l_old_variants, l_new_variants)
			across
				l_translator.side_effect as stmts
			loop
				if @ stmts.is_first and attached current_origin_information as c then
					stmts.set_origin_information (c)
					current_origin_information := Void
				end
				current_block.add_statement (stmts)
			end
			locals_map.merge (l_translator.locals_map)
		end

	last_expression: IV_EXPRESSION
			-- Last generated expression.

	last_safety_checks: LINKED_LIST [IV_ASSERT]
			-- List of safety checks generated while processing last contract expression.

	last_frame: IV_EXPRESSION
			-- Last generated frame definition.

	last_decreases: LIST [IV_EXPRESSION]
			-- Last generated decreases expressions.

	locals_map: HASH_TABLE [IV_EXPRESSION, INTEGER]
			-- Mapping for object test locals.

	local_writable: detachable IV_EXPRESSION
			-- Writable frame of the current loop.			

;note
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
