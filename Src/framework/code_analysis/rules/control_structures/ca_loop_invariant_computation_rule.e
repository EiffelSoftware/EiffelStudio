note
	description: "[
			RULE #21: Loop invariant computation within loop
	
			A loop invariant computation that lies within a loop should be moved outside the loop.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_LOOP_INVARIANT_COMPUTATION_RULE

inherit
	CA_STANDARD_RULE

	AST_ITERATOR
		redefine
			process_access_id_as,
			process_assign_as
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			severity := severity_hint
			create locals_assign.make (10)
			create assign_instr.make (10)
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_loop_pre_action (agent pre_process_loop)
			a_checker.add_loop_post_action (agent post_process_loop)
			a_checker.add_feature_pre_action (agent pre_process_feature)
			a_checker.add_feature_post_action (agent post_process_feature)
		end

feature -- Properties

	name: STRING = "invariant_in_loop"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.loop_invariant_comp_within_loop_title
		end

	id: STRING_32 = "CA021"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.loop_invariant_comp_within_loop_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.loop_invariant_comp_within_loop_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_instruction then
				a_formatter.add (l_instruction)
			end
			a_formatter.add (ca_messages.loop_invariant_comp_within_loop_violation_2)
		end

feature {NONE} -- Rule Checking

	pre_process_feature (a_feature: FEATURE_AS)
		do
			-- Get all locals.
			if attached a_feature.body.as_routine as l_routine and then attached l_routine.locals as l_locals then
				across l_locals as l_local_dec loop
					across l_local_dec.id_list as l_id loop
						locals_assign.put (0, l_local_dec.item_name (l_local_dec.id_list.index_of (l_id, 1)))
					end
				end
			end
		end

	pre_process_loop (a_loop: LOOP_AS)
		do
			-- Process the loop body to read all the assignments.
			if attached a_loop.compound then
				loop_body := a_loop.compound

				is_checking_assigns := True
				loop_body.process (Current)
				is_checking_assigns := False

				-- Remove locals that have 2 or more assignments.
				across locals_assign as l_local loop
					if l_local >= 2 then
						locals_assign.force (0, @ l_local.key)
					end
				end

				is_checking_reads := True

				from
					body_index := 1
					loop_body.start
				until
					loop_body.after
				loop
					loop_body.item.process (Current)

					loop_body.forth
					body_index := body_index + 1
				end

				is_checking_reads := False

			end
		end

	post_process_loop (a_loop: LOOP_AS)
		do
			-- Create violations and reset attributes for the next loop.
			across locals_assign as l_local loop
				if l_local > 0 then
					create_violation (loop_body.at (assign_instr.at (@ l_local.key)), a_loop)
					locals_assign.force (0, @ l_local.key)
				end
			end

			assign_instr.wipe_out

		end

	post_process_feature (a_feature: FEATURE_AS)
		do
			-- Reset locals for next feature.
			locals_assign.wipe_out
		end

	is_constant (a_expr: EXPR_AS): BOOLEAN
		do
			Result := attached {INTEGER_AS} a_expr or
					  attached {CHAR_AS} a_expr or
					  attached {STRING_AS} a_expr or
					  attached {BOOL_AS} a_expr or
					  attached {REAL_AS} a_expr or
					  attached {CONVERTED_EXPR_AS} a_expr as l_converted and then attached {REAL_AS} l_converted.expr
		end

	create_violation (a_instruction: attached INSTRUCTION_AS; a_loop: attached LOOP_AS)
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_MOVE_INSTRUCTION_WITHIN_LOOP_FIX
		do
			create l_violation.make_with_rule (Current)
			l_violation.set_location (a_instruction.start_location)
			l_violation.long_description_info.extend (a_instruction.text_32 (current_context.matchlist))

			create l_fix.make_with_loop_and_instruction (current_context.checking_class, a_loop, a_instruction, True)
			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

feature {NONE} -- Visitor redefines

	process_access_id_as (a_access_id: ACCESS_ID_AS)
		local
			l_name: STRING_8
		do
			if is_checking_reads then
				l_name := a_access_id.access_name_8
				if locals_assign.has (l_name) and then body_index < assign_instr.at (l_name) then
					-- Local variable is read before an assignment to it, hence it cannot violate this rule.
					locals_assign.force (0, l_name)
				end
			end

			Precursor (a_access_id)
		end

	process_assign_as (a_assign: ASSIGN_AS)
		do
			if
				is_checking_assigns
				and then attached {ACCESS_ID_AS} a_assign.target as l_access
				and then locals_assign.has (l_access.access_name_8)
			then
				if loop_body.has (a_assign) then
					if  is_constant(a_assign.source) then
						locals_assign.force (locals_assign.at (l_access.access_name_8) + 1, l_access.access_name_8)

						-- Caution: if duplicates assignments are in the loop body, this will only get the index of the first
						-- assignment, but since we do not handle the case with 2 or more assignments this does not matter.
						assign_instr.force (loop_body.index_of(a_assign, 1), l_access.access_name_8)
					else
						-- If there is a non constant assignment to the local variable we cannot move it outside of the loop,
						-- hence we put the value 2 to make sure the local variable won't be considered. (We cannot remove it
						-- from the table because we need the same table for all the loops in the current feature).
						locals_assign.force (2, l_access.access_name_8)
					end
				else
					-- The assign is nested in the loop, hence we cannot know whether it is executed or not (e.g. in an if-block),
					-- therefore we put the value 2 to make sure the local variable won't be considered. (We cannot remove it
					-- from the table because we need the same table for all the loops in the current feature).
					locals_assign.force (2, l_access.access_name_8)
				end

			end

			Precursor (a_assign)
		end

feature {NONE} -- Attributes

	locals_assign: HASH_TABLE [INTEGER, STRING_8]

	assign_instr: HASH_TABLE [INTEGER, STRING_8]

	loop_body: EIFFEL_LIST[INSTRUCTION_AS]

	body_index: INTEGER

	is_checking_assigns: BOOLEAN
			-- Is the analysis currently checking assignments?

	is_checking_reads: BOOLEAN
			-- Is the analysis currently checking accesses?

end
