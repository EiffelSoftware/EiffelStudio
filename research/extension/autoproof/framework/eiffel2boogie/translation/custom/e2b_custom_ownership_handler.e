note
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_CUSTOM_OWNERSHIP_HANDLER

inherit

	E2B_CUSTOM_CALL_HANDLER

	SHARED_WORKBENCH

	SHARED_SERVER

feature -- Status report

	is_handling_call (a_target_type: TYPE_A; a_feature: FEATURE_I): BOOLEAN
			-- <Precursor>
		do
			Result := (translation_mapping.builtin_any_functions.has (a_feature.feature_name) or
				translation_mapping.builtin_any_procedures.has (a_feature.feature_name) or
				translation_mapping.ghost_access.has (a_feature.feature_name) or
				translation_mapping.ghost_setter.has (a_feature.feature_name))
		end

feature -- Basic operations

	handle_routine_call_in_body (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		local
			l_name: STRING
			l_call: IV_PROCEDURE_CALL
			l_type: IV_TYPE
			l_trig: IV_FUNCTION_CALL
			l_old_side_effect: LINKED_LIST [IV_STATEMENT]
		do
			l_name := a_feature.feature_name
			if l_name ~ "use_definition" then
				l_old_side_effect := a_translator.side_effect
				a_translator.clear_side_effect
				a_translator.process_parameters (a_parameters)
				a_translator.restore_side_effect (l_old_side_effect)
				check a_translator.last_parameters.count = 1 end
				if attached {IV_FUNCTION_CALL} a_translator.last_parameters.first as l_fcall then
					create l_trig.make (name_translator.boogie_function_trigger (l_fcall.name), types.bool)
					l_trig.arguments.append (l_fcall.arguments)
					a_translator.side_effect.extend (create {IV_ASSERT}.make_assume (l_trig))
				end
			elseif l_name ~ "transitive_owns" then
				a_translator.process_builtin_function_call (a_feature, a_parameters, "trans_owns")
			elseif l_name ~ "ownership_domain" then
				a_translator.process_builtin_function_call (a_feature, a_parameters, "domain")
			elseif translation_mapping.builtin_any_functions.has (l_name) then
				a_translator.process_builtin_function_call (a_feature, a_parameters, l_name)
			elseif l_name ~ "unwrap_no_inv" then
				a_translator.process_builtin_routine_call (a_feature, a_parameters, "unwrap")
			elseif translation_mapping.builtin_any_procedures.has (l_name) then
				pre_builtin_call (a_translator, a_feature)
				a_translator.process_builtin_routine_call (a_feature, a_parameters, l_name)
				post_builtin_call (a_translator, a_feature)
			elseif translation_mapping.ghost_access.has (l_name) then
				if l_name ~ "closed" then
					l_type := types.bool
					a_translator.set_last_expression (factory.function_call ("is_closed", << a_translator.entity_mapping.heap, a_translator.current_target >>, l_type))
				else
					l_type := translation_mapping.ghost_access_type (l_name)
					a_translator.set_last_expression (factory.heap_access (a_translator.entity_mapping.heap, a_translator.current_target, l_name, l_type))
				end
			elseif translation_mapping.ghost_setter.has (l_name) then
				l_name := l_name.substring (5, l_name.count)
				a_translator.process_builtin_routine_call (a_feature, a_parameters, "xyz")
				l_call ?= a_translator.side_effect.last
				a_translator.side_effect.finish
				a_translator.side_effect.remove	-- last side effect is actual call, here to non-existing "xyz"
				a_translator.set_last_expression (Void)
				l_call := factory.procedure_call ("update_heap", <<
					a_translator.current_target,
					factory.entity (l_name, types.field ((create {E2B_SPECIAL_MAPPING}.make).ghost_access_type (l_name))),
					l_call.arguments.i_th (2)>>)
				l_call.node_info.set_line (a_translator.context_line_number)
				a_translator.side_effect.extend (l_call)
			else
				check false end
			end
		end

	handle_routine_call_in_contract (a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		local
			l_name: STRING
			l_type: IV_TYPE
			l_tag_filters: LIST [STRING]
			l_attr: FEATURE_I
			l_partial_inv_class: CLASS_C
		do
			l_name := a_feature.feature_name
			if translation_mapping.builtin_any_functions.has (l_name) then
				if l_name ~ "inv_without" then
					l_tag_filters := extract_tags (a_parameters)
						-- Determine the class whose invariant is taken as reference:
						-- if target is Current, then it is the origin class of the contract clause,
						-- otherwise, it is the type of the target
					if a_translator.current_target.same_expression (a_translator.entity_mapping.current_expression) then
						l_partial_inv_class := a_translator.origin_class
					else
						l_partial_inv_class := a_translator.current_target_type.base_class
					end
					check_valid_class_inv_tags (l_partial_inv_class, a_translator.context_feature, a_translator.context_line_number, l_tag_filters)
					translation_pool.add_filtered_invariant_function (a_translator.current_target_type, Void, l_tag_filters, l_partial_inv_class)
					a_translator.set_last_expression(factory.function_call (
							name_translator.boogie_function_for_filtered_invariant (a_translator.current_target_type, Void, l_tag_filters, l_partial_inv_class),
							<< a_translator.entity_mapping.heap, a_translator.current_target >>, types.bool))
				elseif l_name ~ "inv_only" then
					l_tag_filters := extract_tags (a_parameters)
					if a_translator.current_target.same_expression (a_translator.entity_mapping.current_expression) then
						l_partial_inv_class := a_translator.origin_class
					else
						l_partial_inv_class := a_translator.current_target_type.base_class
					end
					check_valid_class_inv_tags (l_partial_inv_class, a_translator.context_feature, a_translator.context_line_number, l_tag_filters)
					translation_pool.add_filtered_invariant_function (a_translator.current_target_type, l_tag_filters, Void, l_partial_inv_class)
					a_translator.set_last_expression(factory.function_call (
						name_translator.boogie_function_for_filtered_invariant (a_translator.current_target_type, l_tag_filters, Void, l_partial_inv_class),
						<< a_translator.entity_mapping.heap, a_translator.current_target >>, types.bool))
				elseif l_name ~ "inv" then
						a_translator.process_builtin_routine_call (a_feature, a_parameters, "user_inv")
				elseif l_name ~ "is_field_writable" then
					if attached {STRING_B} a_parameters.first.expression as l_string then
						-- ToDo: can origin class be different?
						l_attr := helper.attribute_from_string (l_string.value, a_translator.current_target_type, a_translator.current_target_type.base_class, a_translator.context_feature, a_translator.context_line_number)
						if attached l_attr then
							a_translator.set_last_expression (factory.frame_access (
								a_translator.context_writable,
								a_translator.current_target,
								helper.field_from_attribute (l_attr, a_translator.current_target_type)))
						end
					else
						helper.add_semantic_error (a_translator.context_feature, messages.first_argument_string, a_translator.context_line_number)
					end
				elseif l_name ~ "is_fully_writable" then
					a_translator.set_last_expression (factory.function_call (
						"has_whole_object",
						<< a_translator.context_writable, a_translator.current_target>>,
						types.bool))
				elseif l_name ~ "is_field_readable" then
					if attached a_translator.context_readable then
						if attached {STRING_B} a_parameters.first.expression as l_string then
							l_attr := helper.attribute_from_string (l_string.value, a_translator.current_target_type, a_translator.current_target_type.base_class, a_translator.context_feature, a_translator.context_line_number)
							if attached l_attr then
								a_translator.set_last_expression (factory.frame_access (
									a_translator.context_readable,
									a_translator.current_target,
									helper.field_from_attribute (l_attr, a_translator.current_target_type)))
							end
						else
							helper.add_semantic_error (a_translator.context_feature, messages.first_argument_string, a_translator.context_line_number)
						end
					else
						helper.add_semantic_warning (a_translator.context_feature, messages.invalid_context_for_read_predicate, a_translator.context_line_number)
						a_translator.set_last_expression (factory.true_)
					end
				elseif l_name ~ "is_fully_readable" then
					if attached a_translator.context_readable then
						a_translator.set_last_expression (factory.function_call (
							"has_whole_object",
							<< a_translator.context_readable, a_translator.current_target>>,
							types.bool))
					else
						helper.add_semantic_warning (a_translator.context_feature, messages.invalid_context_for_read_predicate, a_translator.context_line_number)
						a_translator.set_last_expression (factory.true_)
					end
				elseif l_name ~ "transitive_owns" then
					a_translator.process_builtin_routine_call (a_feature, a_parameters, "trans_owns")
				elseif l_name ~ "ownership_domain" then
					a_translator.process_builtin_routine_call (a_feature, a_parameters, "domain")
				elseif l_name ~ "universe" then
					a_translator.set_last_expression (factory.entity ("universe", types.set (types.ref)))
				elseif l_name ~ "is_fresh" then
					a_translator.set_last_expression (factory.not_ (factory.heap_access (
						factory.old_ (factory.global_heap),
						a_translator.current_target, "allocated", types.bool)))
				else
					a_translator.process_builtin_routine_call (a_feature, a_parameters, l_name)
				end
			elseif translation_mapping.ghost_access.has (l_name) then
				if l_name ~ "closed" then
					l_type := types.bool
					a_translator.set_last_expression (factory.function_call ("is_closed", << a_translator.entity_mapping.heap, a_translator.current_target >>, l_type))
				else
					l_type := translation_mapping.ghost_access_type (l_name)
					a_translator.set_last_expression (factory.heap_access (a_translator.entity_mapping.heap, a_translator.current_target, l_name, l_type))
				end
			else
					-- cannot happen
				check False end
			end
		end

	extract_tags (a_parameters: BYTE_LIST [PARAMETER_B]): LIST [STRING]
		do
			check a_parameters.count = 1 end
			create {LINKED_LIST [STRING]} Result.make
			Result.compare_objects
			if attached {STRING_B} a_parameters.first.expression as l_string then
				Result.extend (l_string.value)
			elseif attached {TUPLE_CONST_B} a_parameters.first.expression as l_tuple then
				across l_tuple.expressions as i loop
					if attached {STRING_B} i.item as l_string then
						Result.extend (l_string.value)
					else
						check False end
					end
				end
			else
				check False end
			end
		end

	check_valid_class_inv_tags (a_class: CLASS_C; a_context_feature: FEATURE_I; a_line_number: INTEGER; a_tags: LIST [STRING])
			-- Check if `a_tags' only lists valid class invariant of `a_class'.
			-- Otherwise report error in feature `a_context_feature'.
		local
			l_tags_copy: LINKED_LIST [STRING]
			l_string: STRING
		do
			create l_tags_copy.make
			l_tags_copy.append (a_tags)
			l_tags_copy.compare_objects
				-- Remove default tags
			across translation_mapping.default_tags as t loop
				l_tags_copy.prune_all (t.item)
			end
				-- Remove user-defined tags
			check_flat_inv_tags (a_class, l_tags_copy)
			if not l_tags_copy.is_empty then
				l_string := ""
				across l_tags_copy as i loop
					l_string.append (i.item)
					l_string.append (", ")
				end
				l_string.remove_tail (2)
				helper.add_semantic_error (a_context_feature, messages.invalid_tag (l_string, a_class.name_in_upper), a_line_number)
			end
		end

	check_flat_inv_tags (a_class: CLASS_C; a_tags: LIST [STRING])
			-- Remove from `a_tags' all class invariant tags present in `a_class' and its ancestors.
		local
			l_asserts: BYTE_LIST [BYTE_NODE]
			l_assert: ASSERT_B
			l_classes: FIXED_LIST [CLASS_C]
		do
			if inv_byte_server.has (a_class.class_id) then
				from
					l_asserts := inv_byte_server.item (a_class.class_id).byte_list
					l_asserts.start
				until
					l_asserts.after
				loop
					l_assert ?= l_asserts.item_for_iteration
					check l_assert /= Void end
					if l_assert.tag /= Void then
						a_tags.prune_all (l_assert.tag)
					end
					l_asserts.forth
				end
			end
			from
				l_classes := a_class.parents_classes
				l_classes.start
			until
				l_classes.after
			loop
				if l_classes.item.class_id /= system.any_id then
					check_flat_inv_tags (l_classes.item, a_tags)
				end
				l_classes.forth
			end
		end

	pre_builtin_call (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I)
			-- Insert code before calling a built-in procedure `a_feature_name'.
		local
			l_type_translator: E2B_TYPE_TRANSLATOR
			l_check: IV_EXPRESSION
		do
				-- If processing a call to `wrap',
				-- generate appropriate guarded assignments to implicit model queries and an invariant check
			if a_feature.feature_name ~ "wrap" then
				if use_static_invariant (a_translator) then
						-- Check exact invariant definition.
					create l_type_translator
					l_type_translator.translate_inline_invaraint_check (a_translator.current_target_type, a_translator.current_target)

					across helper.ghost_attributes (a_translator.current_target_type.base_class) as a loop
						set_implicit_ghost (a_translator, a.item)
					end

					across l_type_translator.last_clauses as c loop
						c.item.node_info.set_line (a_translator.context_line_number)
						c.item.node_info.set_attribute ("cid", a_feature.written_class.class_id.out)
						c.item.node_info.set_attribute ("rid", a_feature.rout_id_set.first.out)
						if options.is_inv_check_independent then
							a_translator.add_independent_check (c.item)
						else
							a_translator.side_effect.extend (c.item)
						end
					end
				else
						-- Use dynamically bound invariant function.
					l_check := factory.function_call ("user_inv", << a_translator.entity_mapping.heap, a_translator.current_target >>, types.bool)
					a_translator.add_safety_check (l_check, "inv", "unknown_invariant", a_translator.context_line_number)
					a_translator.last_safety_check.node_info.set_attribute ("cid", a_feature.written_class.class_id.out)
					a_translator.last_safety_check.node_info.set_attribute ("rid", a_feature.rout_id_set.first.out)
				end
			end
		end

	post_builtin_call (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I)
			-- Insert code after calling a built-in procedure `a_feature_name'.
		local
			l_assume: IV_ASSERT
		do
				-- If processing a call to `unwrap',
				-- assume either generic `user_inv' or class-specific invariant function, depending if the target is `Current'.
			if a_feature.feature_name ~ "unwrap" then
				if use_static_invariant (a_translator) then
						-- Use exact invariant definition.
					create l_assume.make_assume (
						factory.function_call (name_translator.boogie_function_for_invariant (a_translator.current_target_type),
						<< a_translator.entity_mapping.heap, a_translator.current_target >>,
						types.bool))
					a_translator.side_effect.extend (l_assume)
				else
						-- Use dynamically bound invariant function.
					create l_assume.make_assume (
						factory.function_call ("user_inv",
						<< a_translator.entity_mapping.heap, a_translator.current_target >>,
						types.bool))
					a_translator.side_effect.extend (l_assume)
					if not helper.is_manual_inv (a_translator.context_feature)
						and not helper.is_manual_inv_class (a_translator.context_type.base_class) then
						create l_assume.make_assume (factory.function_call ("inv_frame_trigger", << a_translator.current_target >>, types.bool))
						a_translator.side_effect.extend (l_assume)
					end
				end
			end
		end

	use_static_invariant (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR): BOOLEAN
			-- Should the static definition of the ivnariant be used for the current target of `a_translator'?
		do
				-- Yes if the current target is "Current" and the context feature is not marked as nonvariant,
				-- or the type of the target is exact.
			Result := (a_translator.current_target.same_expression (a_translator.entity_mapping.current_expression) and
				not helper.is_nonvariant (a_translator.context_feature)) or
				helper.is_type_exact (a_translator.current_target_type, a_translator.current_target_type, a_translator.context_feature)
		end

	set_implicit_ghost (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_attr: FEATURE_I)
			-- If the definition of `a_attr' in `current_target_type' is statically known,
			-- generate a guarded update and store it in the side effect of `a_translator'.
		local
			l_function: IV_FUNCTION
			l_field: IV_ENTITY
			l_pcall: IV_PROCEDURE_CALL
			l_fcall: IV_FUNCTION_CALL
			l_if: IV_CONDITIONAL
		do
				-- Get definition of `a_field_name' for `current_target_type';
				-- if it exists, generate a guarded assignment.			
			l_field := helper.field_from_attribute (a_attr, a_translator.current_target_type)
			l_function := boogie_universe.function_named (
				name_translator.boogie_function_for_ghost_definition (a_translator.current_target_type, l_field.name))
			if attached l_function then
				create l_pcall.make ("update_heap")
				l_pcall.add_argument (a_translator.current_target)
				l_pcall.add_argument (l_field)
				l_pcall.add_argument (factory.function_call (l_function.name,
					<< a_translator.entity_mapping.heap, a_translator.current_target >>,
					types.field_content_type (l_field.type)))
				l_pcall.node_info.set_attribute ("default", a_attr.feature_name_32)
				l_pcall.node_info.set_line (a_translator.context_line_number)

					-- Create a condition that l_field is in the modify clause of the current function
					-- (modify clause is used instead of writable, since it is not possible to prove that something is not writable)
				create l_fcall.make (name_translator.boogie_function_for_write_frame (a_translator.context_feature, a_translator.context_type), types.frame)
				l_fcall.add_argument (factory.global_heap)
				across a_translator.context_implementation.procedure.arguments as i loop
					l_fcall.add_argument (i.item.entity)
				end

				create l_if.make_if_then (factory.frame_access (l_fcall, a_translator.current_target, l_field),
					factory.singleton_block (l_pcall))
				a_translator.side_effect.extend (l_if)
			end
		end

end
