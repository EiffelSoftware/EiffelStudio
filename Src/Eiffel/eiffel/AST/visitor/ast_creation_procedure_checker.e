note
	description: "Validator of creation procedures that ensures they set all the attributes as required."

class
	AST_CREATION_PROCEDURE_CHECKER

inherit
	AST_ITERATOR
		redefine
			process_access_assert_as,
			process_access_feat_as,
			process_access_id_as,
			process_access_inv_as,
			process_address_current_as,
			process_assign_as,
			process_assigner_call_as,
			process_bin_eq_as,
			process_bin_ne_as,
			process_binary_as,
			process_case_as,
			process_case_expression_as,
			process_converted_expr_as,
			process_creation_as,
			process_creation_expr_as,
			process_current_as,
			process_debug_as,
			process_eiffel_list,
			process_elseif_as,
			process_elseif_expression_as,
			process_guard_as,
			process_if_as,
			process_if_expression_as,
			process_inline_agent_creation_as,
			process_inspect_as,
			process_inspect_expression_as,
			process_iteration_as,
			process_like_cur_as,
			process_loop_as,
			process_named_expression_as,
			process_nested_expr_as,
			process_once_as,
			process_precursor_as,
			process_result_as,
			process_retry_as,
			process_routine_as,
			process_routine_creation_as,
			process_separate_instruction_as,
			process_un_old_as,
			process_unary_as
		end

	SHARED_ERROR_HANDLER
		export {NONE} all end

	SHARED_SERVER
		export {NONE} all end

	SHARED_WORKBENCH
		export {NONE} all end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Creation

	make (f: FEATURE_I; c: AST_CONTEXT)
			-- Create a new validator for creation procedure `f' and check it.
		require
			f_attached: f /= Void
			c_attached: c /= Void
		local
			s: GENERIC_SKELETON
			i: INTEGER
		do
			tmp_creation_server.remove_procedure (f.rout_id_set.first, c.current_class.class_id)
			creation_procedure := f
			context := c
			create {ARRAYED_STACK [INTEGER_32]} bodies.make (1)
				-- Last entry is used to track initialization of a result in an attribute with a body.
				-- See also `result_position`.
			create attribute_initialization.make (c.attributes.count + 1)
			create uninitialized_keeper.make (1)
			create {AST_COLLECTION_KEEPER} keeper.make_from_array (<<attribute_initialization.keeper, uninitialized_keeper>>)
			from
				s := current_class.skeleton
				i := s.count
			until
				i <= 0
			loop
				if not current_class.feature_of_feature_id (s [i].feature_id).type.is_initialization_required then
						-- Mark an attribute that does not require initialization as set.
					attribute_initialization.set_attribute (i)
				end
				i := i - 1
			end
			process (f)
			use_current (f.body.last_token (Void))
			check_attributes
			if has_qualified_call then
				tmp_creation_server.set_has_qualified_call (has_qualified_call, f.rout_id_set.first, current_class.class_id)
			end
		end

feature {NONE} -- Processing

	process (f: FEATURE_I)
			-- Process AST of the feature `f'.
		require
			f_attached: f /= Void
			f_not_processed: not bodies.has (f.body_index)
		local
			g: FEATURE_I
			s: ASSERT_ID_SET
			a: INH_ASSERT_INFO
			i: INTEGER
			q: BOOLEAN
			c: BOOLEAN
		do
			if has_qualified_call implies attribute_initialization.has_unset_index (1, current_class.skeleton.count) then
				g := context.current_feature
				q := is_qualified
				is_qualified := False
				c := is_creation
				is_creation := False
				context.set_current_feature (f)
					-- Put body index to stack to avoid recursion
				bodies.put (f.body_index)
					-- Process preconditions
				s := f.assert_id_set
				if s /= Void then
					from
						i := s.count
					until
						i <= 0
					loop
						a := s.item (i)
						check a_attached: a /= Void end
						if
							a.has_precondition and then
							attached body_server.item (a.written_in, a.body_index) as p and then
							attached {ROUTINE_AS} p.body.content as b
						then
							context.set_written_class (system.class_of_id (a.written_in))
							b.precondition.process (Current)
						end
						i := i - 1
					end
				end
					-- Process routine body
				context.set_written_class (f.written_class)
				safe_process (f.body)
					-- Process postcondition
				if s /= Void then
					from
						i := s.count
					until
						i <= 0
					loop
						a := s.item (i)
						check a_attached: a /= Void end
						if a.has_postcondition and then
							attached body_server.item (a.written_in, a.body_index) as p and then
							attached {ROUTINE_AS} p.body.content as b
						then
							context.set_written_class (system.class_of_id (a.written_in))
							b.postcondition.process (Current)
						end
						i := i - 1
					end
				end
					-- Remove body index
				bodies.remove
				is_creation := c
				is_qualified := q
				context.set_current_feature (g)
				context.set_written_class (g.written_class)
			end
		end

	check_attributes
			-- Verify that all attributes are properly initialized.
		do
			collect_unset_attributes
			if attached unset_attributes as u then
					-- Report error if necessary.
				error_handler.insert_error (create {VEVI}.make_attributes
					(u, current_class.class_id, creation_procedure, uninitialized_keeper.location, uninitialized_keeper.written_feature))
					-- Mark all attributes as set to avoid reporting duplicate errors.
					-- This cannot be done outside of the condition because `collect_unset_attributes' returns `Void'
					-- not only when there are no unset attributes but also when "Current" is not used (bug#18643).
				attribute_initialization.set_all
					-- After all attributes are set "Current" is considered initialized to do less checks.
				uninitialized_keeper.unuse
			end
		end

	collect_unset_attributes
			-- Collect attributes that are not set in `unset_attributes'.
		local
			s: GENERIC_SKELETON
			i: INTEGER
			e: NATURAL_32
			f: FEATURE_I
			u: like unset_attributes
		do
			if
				not is_checking_all and then
				uninitialized_keeper.is_used
			then
				s := current_class.skeleton
				i := s.count
				if attribute_initialization.has_unset_index (1, i) then
						-- Avoid recursion because all attributes will be checked anyway.
					is_checking_all := True
						-- Make sure attribute initialization checks do not affect each other.
						-- Treat each attribute initialization in its own section that does not interfere with the other one.
					keeper.enter_realm
					from
						e := error_handler.error_level
					until
						i <= 0
					loop
						if not attribute_initialization.is_attribute_set (i) and then not is_checking_one then
							f := current_class.feature_of_feature_id (s [i].feature_id)
							check_attribute (f)
							if is_unset then
								if not attached u then
									create u.make (1)
								end
								u.extend (f)
							end
							if i > 1 and then e = error_handler.error_level then
									-- Move to the next independent section of checks if there are no errors.
									-- If there are errors, avoid reporting repeated errors.
								keeper.save_sibling
							end
						end
							-- It's safe to assume that the attribute that was checked, is initialized.
						attribute_initialization.set_attribute (i)
						i := i - 1
					end
						-- Avoid affecting outer scopes with updated attribute status information.
					keeper.leave_optional_realm
				else
						-- Update initialization status of Current.
					uninitialized_keeper.unuse
				end
					-- All attributes are checked.
				is_checking_all := False
			end
				-- Report attributes that are not set.
			unset_attributes := u
		end

	check_attribute (f: FEATURE_I)
			-- Verify that the attribute `f' is initialized if required
			-- including recursive check of self-initializing attribute body
			-- and set `is_unset' if the attribute is not set and is not self-initializing.
		require
			f_attached: f /= Void
		local
			i: INTEGER
			is_processed: BOOLEAN
			is_attribute_unset: BOOLEAN
		do
			if not is_checking_one then
					-- It's OK to check an attribute.
					-- Block recursion if all attributes are going to be checked anyway.
				is_checking_one := is_checking_all
				i := context.attributes.item (f.feature_id)
				if
					not attribute_initialization.is_attribute_set (i) and then
					attached {ATTRIBUTE_I} f as a
				then
					if a.has_body then
							-- Attribute might be self-initializing.
						if bodies.has (a.body_index) then
								-- It is being processed.
							is_processed := True
						else
								-- It has to be processed.
							process (f)
						end
					end
						-- Recheck if attribute is set.
					if not is_processed and then not attribute_initialization.is_attribute_set (i) then
							-- Attribute is not properly initialized.
						is_attribute_unset := True
					end
				end
					-- Unblock recursion for single attribute checks.
				is_checking_one := False
			end
				-- Record status of the attribute.
				-- Local variable is required to avoid issues with recursive calls.
			is_unset := is_attribute_unset
		end

feature {AST_EIFFEL} -- Visitor: routine body

	process_once_as (a: ONCE_AS)
			-- <Precursor>
		do
			if
				a.has_key_object or else
				context.current_feature = creation_procedure and then context.current_feature.is_once_creation (context.current_class)
			then
					-- Because this is once-per-object or a current creation procedure of a once class,
					-- it should be safe to process the routine as a normal one.
				Precursor (a)
			else
					-- Attributes set by the once feature are not considered as initialized,
					-- because the next call to it will not execute the body.
				keeper.enter_realm
				Precursor (a)
				attribute_initialization.keeper.leave_optional_realm
				uninitialized_keeper.leave_realm
			end
		end

feature {AST_EIFFEL} -- Visitor: access to features

	process_access_assert_as (a: ACCESS_ASSERT_AS)
			-- <Precursor>
		do
			process_access_feat_as (a)
		end

	process_access_id_as (a: ACCESS_ID_AS)
			-- <Precursor>
		do
			process_access_feat_as (a)
		end

	process_access_inv_as (a: ACCESS_INV_AS)
			-- <Precursor>
		do
			process_access_feat_as (a)
		end

	process_access_feat_as (a: ACCESS_FEAT_AS)
			-- <Precursor>
		local
			f: FEATURE_I
			i: INTEGER
		do
			process_assigner_source
			safe_process (a.internal_parameters)
			if not a.is_local and then not a.is_argument then
				if not is_qualified then
					f := written_class.feature_of_name_id (a.feature_name.name_id)
					if attached f then
							-- This is indeed a feature rather than a local or an argument.
							-- Find it in the current class.
						if current_class /= written_class then
							f := current_class.feature_of_rout_id (f.rout_id_set.first)
						end
							-- Check whether this is an attachment or a call.
						if f.is_attribute and then is_attachment then
								-- Mark attribute as set.
							set_attribute (f)
						elseif not bodies.has (f.body_index) then
								-- This feature has not been processed yet.
							if f.is_routine then
									-- Evaluate routine body.
								process (f)
									-- Assume there is a qualified feature call if `f` is a once function
									-- that returns a reference object or an expanded object with a reference.
								if f.is_once and then f.type.has_reference then
									record_qualified_call (a)
								end
							elseif f.is_attribute then
									-- Check attribute initialization.
								check_attribute (f)
								if is_unset then
									error_handler.insert_error (create {VEVI}.make_attribute
										(f, current_class.class_id, creation_procedure, a.feature_name, context.current_feature))
										-- Mark that the attribute is initialized to avoid repeated errors.
									set_attribute (f)
								end
							end
						end
					end
				else
					i := a.class_id
					if system.has_class_of_id (i) and then attached system.class_of_id (i) as c then
							-- Look for a feature in the recorded class.
						f := c.feature_of_name_id (a.feature_name.name_id)
							-- `f' is the feature in the ancestor class.
							-- Evaluating the corresponding descendant version
							-- can improve reachability analysis.
						debug ("to_implement")
							;(create {REFACTORING_HELPER}).to_implement ("Find a version of the feature in the descendant class.")
						end
						if not error_handler.has_error and then attached f and then is_creation then
							record_creation (f, a)
						end
					end
				end
				if attached f and then not f.has_return_value and then f.is_failing then
						-- The feature never exits, all bets after calling it are off.
						-- In particular all the attributes may be considered initialized.
					attribute_initialization.set_all
				end
			end
			if attached a.internal_parameters as p and then not p.routine_ids.is_empty then
					-- There is a parenthesis alias call.
				record_qualified_call (p)
				i := p.class_id
				if
					system.has_class_of_id (i) and then
					attached system.class_of_id (i) as c and then
					attached c.feature_of_rout_id (p.routine_ids.first) as h and then
					not h.has_return_value and then
					h.is_failing
				then
						-- The feature never exits, all bets after calling it are off.
						-- In particular all the attributes may be considered initialized.
					attribute_initialization.set_all
				end
			end
		end

	process_precursor_as (a: PRECURSOR_AS)
			-- <Precursor>
		local
			c: CLASS_C
			j: INTEGER_32
			k: INTEGER_32
			n: STRING
			p: LIST [CLASS_C]
			r: ROUT_ID_SET
			rc: INTEGER_32
		do
			safe_process (a.parameters)
			if attached a.parent_base_class as t then
				if attached Universe.class_named (t.class_name.name, context.current_class.group) as i then
					n := i.name
				else
					-- A class of name `t.class_name.name' does not exist in the universe.
					-- The error is reported elsewhere, use an empty name, so that the loop
					-- below does not find any matching parent.
					n := ""
				end
			end
			r := context.current_feature.rout_id_set
			rc := r.count
			from
					-- `context.written_class' is used instead of `context.current_class'
					-- as the feature being processed can be inherited.
				p := context.written_class.parents_classes
				k := p.count
			until
				k <= 0
			loop
				c := p [k]
				if attached n implies c.name.is_equal (n) then
						-- Check if parent has an effective precursor.
					from
						j := 1
					until
						j > rc
					loop
						if attached c.feature_of_rout_id (r.item (j)) as f and then not f.is_deferred then
							process (f)
						end
						j := j + 1
					variant
						rc - j + 1
					end
				end
				k := k - 1
			variant
				k
			end
		end

feature {NONE} -- Dependency

	record_creation (f: FEATURE_I; a: ACCESS_FEAT_AS)
			-- Record that current feature calls creation procedure `f' in `a'.
		require
			is_creation
		local
			reported_attributes: SPECIAL [INTEGER]
		do
				-- Check whether creation procedure has reference arguments or (recursively) expanded arguments with reference fields
				-- otherwise it does not depend on uninitialized objects.
			if
				attached f.arguments as arguments and then
				across arguments as p some p.item.has_reference end
			then
					-- Record dependency.
				collect_unset_attributes
				if uninitialized_keeper.is_used and then attached unset_attributes as u then
						-- There are some unset attributes.
						-- Record them for potential error report.
					create reported_attributes.make_empty (u.count)
					across
						u as q
					loop
						reported_attributes.extend (q.item.rout_id_set.first)
					end
					tmp_creation_server.put_uninitialized_creation
						(f.rout_id_set.first, a.class_id, creation_procedure.rout_id_set.first, current_class.class_id,
						reported_attributes, uninitialized_keeper.location, uninitialized_keeper.written_feature.rout_id_set.first)
				else
					tmp_creation_server.put_creation (f.rout_id_set.first, a.class_id, creation_procedure.rout_id_set.first, current_class.class_id)
				end
			end
		end

feature {AST_EIFFEL} -- Visitor: Agents

	process_routine_creation_as (a: ROUTINE_CREATION_AS)
			-- <Precursor>
		local
			e: like {ERROR_HANDLER}.error_level
		do
				-- Record current error level to avoid reporting errors
				-- when there are issues with target and arguments.
			e := error_handler.error_level
				-- Check target and arguments.
			Precursor (a)
				-- Check if "Current" is used implicitly.
			if
				error_handler.error_level = e and then
				not a.has_target and then
				context.is_void_safe_construct
			then
					-- Strict void safety: the agent implicitly relies on "Current".
					-- The latter has to be initialized.
				use_current (a.feature_name)
			end
		end

	process_inline_agent_creation_as (a: INLINE_AGENT_CREATION_AS)
			-- <Precursor>
		local
			e: like {ERROR_HANDLER}.error_level
		do
				-- Record current error level to avoid reporting errors
				-- when there are issues with target and arguments.
			e := error_handler.error_level
				-- Check arguments.
			safe_process (a.operands)
			if
				error_handler.error_level = e and then
				context.is_void_safe_construct
			then
					-- Strict void safety: the agent implicitly relies on "Current".
					-- The latter has to be initialized.
				use_current (a.start_location)
			end
		end

feature {AST_EIFFEL} -- Visitor: Result

	process_result_as (a: RESULT_AS)
			-- <Precursor>
		do
			if context.current_feature.is_attribute and then not attribute_initialization.is_attribute_set (result_position) then
				if not is_attachment and then context.is_void_safe_initialization then
						-- Result is not properly set.
					error_handler.insert_error (create {VEVI}.make_result (context, a))
				end
					-- Mark Result as properly set
					-- because now it is attached or to avoid repeated errors.
				attribute_initialization.set_attribute (result_position)
			end
		end

feature {AST_EIFFEL} -- Visitor: Current

	process_current_as (a: CURRENT_AS)
			-- <Precursor>
		do
			use_current (a)
		end

	process_address_current_as (a: ADDRESS_CURRENT_AS)
			-- <Precursor>
		do
			use_current (a.current_keyword)
		end

	process_like_cur_as (a: LIKE_CUR_AS)
			-- <Precursor>
		do
				-- `Current' used as an anchor is safe.
		end

feature {NONE} -- Current tracking

	use_current (location: LOCATION_AS)
			-- Record that "Current" is used at `location'.
		do
				-- All attributes have to be set before `Current' can be used.
			if not uninitialized_keeper.is_used and then attribute_initialization.has_unset_index (1, context.attributes.count) then
					-- Objects may be uninitialized, but they are tracked.
				uninitialized_keeper.use (location, context.current_feature)
			end
			if current_class.is_expanded then
					-- Objects of expanded type should be initialized.
				check_attributes
			end
		end

feature {NONE} -- Attribbute initialization

	set_attribute (a: FEATURE_I)
			-- Mark attribute `a' as initialized.
		do
				-- Update attribute initialization status.
			attribute_initialization.set_attribute (context.attributes.item (a.feature_id))
				-- Check if Current is still uninitialized.
			if uninitialized_keeper.is_used and then not attribute_initialization.has_unset_index (1, context.attributes.count) then
					-- Update initialization status of Current.
				uninitialized_keeper.unuse
			end
		end

feature {AST_EIFFEL} -- Visitor: reattachment

	process_assign_as (a: ASSIGN_AS)
			-- <Precursor>
		do
			a.source.process (Current)
			is_attachment := True
			a.target.process (Current)
			is_attachment := False
		end

	process_creation_as (a: CREATION_AS)
			-- <Precursor>
		local
			q: BOOLEAN
			c: BOOLEAN
		do
			q := is_qualified
			is_qualified := True
			c := is_creation
			is_creation := True
			safe_process (a.call)
			is_creation := c
			is_qualified := q
			is_attachment := True
			a.target.process (Current)
			is_attachment := False
		end

feature {AST_EIFFEL} -- Visitor: compound

	process_compound (c: EIFFEL_LIST [INSTRUCTION_AS])
			-- <Precursor>
		do
			if c /= Void then
				c.process (Current)
					-- Check if use of Current should be reset if all attributes are now initialized.
					-- This is required to avoid reporting uninitialized attributes in code like
					--   if ... then ... use Current ... initialize attributes ... end
					--   some.qualified.call
				collect_unset_attributes
			end
		end

	process_case_as (a: CASE_AS)
			-- <Precursor>
		do
			a.interval.process (Current)
			process_compound (a.compound)
			keeper.save_sibling
		end

	process_case_expression_as (a: CASE_EXPRESSION_AS)
			-- <Precursor>
		do
			a.interval.process (Current)
			a.content.process (Current)
			keeper.save_sibling
		end

	process_debug_as (a: DEBUG_AS)
			-- <Precursor>
		do
			keeper.enter_realm
			process_compound (a.compound)
			keeper.leave_optional_realm
		end

	process_elseif_as (a: ELSIF_AS)
			-- <Precursor>
		do
			a.expr.process (Current)
			process_compound (a.compound)
			keeper.save_sibling
		end

	process_elseif_expression_as (a: ELSIF_EXPRESSION_AS)
			-- <Precursor>
		do
			a.condition.process (Current)
			a.expression.process (Current)
			keeper.save_sibling
		end

	process_guard_as (a: GUARD_AS)
			-- <Precursor>
		do
			if attached a.check_list as l then
				safe_process (l)
				if across l as tagged some attached {BOOL_AS} tagged.item.expr as b and then not b.value end then
						-- The check always fails.
						-- All the variables may be considered properly initialized.
					attribute_initialization.set_all
				end
			end
			keeper.enter_realm
			process_compound (a.compound)
			keeper.leave_realm
		end

	process_if_as (a: IF_AS)
			-- <Precursor>
		do
			a.condition.process (Current)
			keeper.enter_realm
			process_compound (a.compound)
			keeper.save_sibling
			safe_process (a.elsif_list)
			process_compound (a.else_part)
			keeper.save_sibling
			keeper.leave_realm
		end

	process_if_expression_as (a: IF_EXPRESSION_AS)
			-- <Precursor>
		do
			a.condition.process (Current)
			keeper.enter_realm
			a.then_expression.process (Current)
			keeper.save_sibling
			safe_process (a.elsif_list)
			a.else_expression.process (Current)
			keeper.save_sibling
			keeper.leave_realm
		end

	process_inspect_as (a: INSPECT_AS)
			-- <Precursor>
		do
			a.switch.process (Current)
			keeper.enter_realm
			safe_process (a.case_list)
			if attached a.else_part as e then
				process_compound (e)
				keeper.save_sibling
			end
			keeper.leave_realm
		end

	process_inspect_expression_as (a: INSPECT_EXPRESSION_AS)
			-- <Precursor>
		do
			a.switch.process (Current)
			keeper.enter_realm
			safe_process (a.case_list)
			if attached a.else_part as e then
				e.process (Current)
				keeper.save_sibling
			end
			keeper.leave_realm
		end

	process_iteration_as (a: ITERATION_AS)
			-- <Precursor>
		do
			Precursor (a)
				-- Iteration implicitly makes several qualified calls that include:
				-- "new_cursor", "after", "forth".
			record_qualified_call (a.expression)
		end

	process_loop_as (a: LOOP_AS)
			-- <Precursor>
		do
			safe_process (a.iteration)
			safe_process (a.from_part)
			safe_process (a.invariant_part)
			safe_process (a.stop)
			if attached a.compound as c then
				keeper.enter_realm
				keeper.save_sibling
				process_compound (c)
				keeper.save_sibling
				keeper.leave_realm
			end
			safe_process (a.variant_part)
			if not attached a.iteration and then attached {BOOL_AS} a.stop as b and then not b.value then
					-- The loop never terminates.
					-- All the variables may be considered properly initialized.
				attribute_initialization.set_all
			end
		end

	process_named_expression_as (a: NAMED_EXPRESSION_AS)
			-- <Precursor>
		do
			Precursor (a)
			keeper.save_sibling
		end

	process_retry_as (a: RETRY_AS)
			-- <Precursor>
		do
				-- The code after this instruction is never reached.
				-- All the variables may be considered properly initialized.
			attribute_initialization.set_all
		end

	process_routine_as (a: ROUTINE_AS)
			-- <Precursor>
		local
			f: FEATURE_I
		do
			if a.is_attribute then
					-- Make sure result position is never set except during checking of an attribute body.
				keeper.enter_realm
			end
				-- Process feature body.
			safe_process (a.precondition)
			keeper.enter_realm
			a.routine_body.process (Current)
			safe_process (a.postcondition)
			keeper.save_sibling
			safe_process (a.rescue_clause)
			keeper.leave_realm
			if a.is_attribute then
					-- Check if "Result" is properly set.
				if attribute_initialization.is_attribute_set (result_position) then
						-- Record attribute as initialized one
						-- because "Result" is properly set at the end of the body.
					f := context.current_feature
					if current_class /= written_class then
						f := current_class.feature_of_rout_id (f.rout_id_set.first)
					end
				end
					-- Discard any initialization information because
					-- execution of attribute body is not guaranteed.
				keeper.leave_optional_realm
				if attached f then
						-- Mark attribute as initialized.
					set_attribute (f)
				end
			end
		end

	process_separate_instruction_as (a_as: SEPARATE_INSTRUCTION_AS)
			-- <Precursor>
		do
			keeper.enter_realm
			keeper.enter_realm
			a_as.arguments.process (Current)
			keeper.leave_realm
			safe_process (a_as.compound)
			keeper.leave_realm
		end

feature {AST_EIFFEL} -- Visitor: nested call

	process_assigner_call_as (a: ASSIGNER_CALL_AS)
			-- <Precursor>
		do
			assigner_source := a.source
			a.target.process (Current)
			assigner_source := Void
		end

	process_bin_eq_as (a: BIN_EQ_AS)
			-- <Precursor>
		do
				-- Avoid defaulting to `process_binary_as'.
			a.left.process (Current)
			a.right.process (Current)
		end

	process_bin_ne_as (a: BIN_NE_AS)
			-- <Precursor>
		do
			process_bin_eq_as (a)
		end

	process_binary_as (a: BINARY_AS)
			-- <Precursor>
		do
			debug ("to_implement") -- TODO
				(create {REFACTORING_HELPER}).to_implement ("Exclude expanded types from qualified calls if they do not involve references.")
			end
			a.left.process (Current)
			process_assigner_source
			a.right.process (Current)
			record_qualified_call (a)
		end

	process_converted_expr_as (a: CONVERTED_EXPR_AS)
			-- <Precursor>
		do
			Precursor (a)
			record_qualified_call (a)
		end

	process_creation_expr_as (a: CREATION_EXPR_AS)
			-- <Precursor>
		local
			q: BOOLEAN
			c: BOOLEAN
		do
			q := is_qualified
			is_qualified := True
			c := is_creation
			is_creation := True
			Precursor (a)
			is_creation := c
			is_qualified := q
		end

	process_nested_expr_as (a: NESTED_EXPR_AS)
			-- <Precursor>
		local
			q: BOOLEAN
			c: BOOLEAN
			s: like assigner_source
		do
			q := is_qualified
			c := is_creation
			s := assigner_source
			assigner_source := Void
			a.target.process (Current)
			is_qualified := True
			is_creation := False
			assigner_source := s
			a.message.process (Current)
			is_creation := c
			is_qualified := q
			record_qualified_call (a)
		end

	process_un_old_as (a: UN_OLD_AS)
			-- <Precursor>
		do
				-- Avoid defaulting to `process_unary_as'.
			a.expr.process (Current)
		end

	process_unary_as (a: UNARY_AS)
			-- <Precursor>
		do
			debug ("to_implement") -- TODO
				(create {REFACTORING_HELPER}).to_implement ("Exclude expanded and separate types from qualified calls.")
			end
			Precursor (a)
			process_assigner_source
			record_qualified_call (a)
		end

	process_eiffel_list (a: EIFFEL_LIST [AST_EIFFEL])
			-- <Precursor>
		local
			q: BOOLEAN
			c: BOOLEAN
		do
			q := is_qualified
			is_qualified := False
			c := is_creation
			is_creation := False
			Precursor (a)
			is_creation := c
			is_qualified := q
		end

	process_assigner_source
			-- Process assigner source (if available).
		local
			q: BOOLEAN
			c: BOOLEAN
		do
			if attached assigner_source as s then
				assigner_source := Void
				q := is_qualified
				is_qualified := False
				c := is_creation
				is_creation := False
				s.process (Current)
				is_creation := c
				is_qualified := q
			end
		end

feature {NONE} -- Visitor: qualified calls

	record_qualified_call (a: AST_EIFFEL)
			-- Record that a construct `a' corresponds to a qualified call.
		do
				-- Flag construct as using a qualified call.
			has_qualified_call := True
				-- Make sure the call is not made when uninitialized Current is used.
			if context.is_void_safe_construct then
				check_attributes
			end
		end

feature {NONE} -- Status report

	is_attachment: BOOLEAN
			-- Is attachment being performed?

	is_qualified: BOOLEAN
			-- Is qualified call being performed?

	is_creation: BOOLEAN
			-- Is creation call being performed?

	is_checking_all: BOOLEAN
			-- Are all attributes being checked?

	is_checking_one: BOOLEAN
			-- Is an attribute being checked?

	has_qualified_call: BOOLEAN
			-- Is there a qualified call?

feature {NONE} -- Access

	assigner_source: detachable EXPR_AS
			-- A source of an assigner command (if any).

	is_unset: BOOLEAN
			-- Is attribute passed to `check_attribute' unset?

	unset_attributes: detachable ARRAYED_LIST [FEATURE_I]
			-- Attributes that are not set at the point where they are checked
			-- by `collect_unset_attributes'.

	context: AST_CONTEXT
			-- Associated context.

	current_class: CLASS_C
			-- Class for which the validation is performed.
		do
			Result := context.current_class
		end

	creation_procedure: FEATURE_I
			-- Creation procedure that is being checked.

	written_class: CLASS_C
			-- Class where the code is written.
		do
			Result := context.written_class
		end

	attribute_initialization: AST_ATTRIBUTE_INITIALIZATION_TRACKER
			-- Storage to track attributes usage.

	uninitialized_keeper: AST_SINGLE_USE_KEEPER
			-- Keeper to track use of uninitialized `Current'.

	keeper: AST_NESTING_KEEPER
			-- Keeper to track variables.

	result_position: INTEGER
			-- Position of result in the `attributes_initialization'.
		do
			Result := context.attributes.count + 1
		end

	bodies: STACK [INTEGER_32]
			-- Bodies that are being processed.

;note
	ca_ignore: "CA033", "CA033: too large class"
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
