note
	description: "[
			RULE #24: From-until loop on ITERABLE can be reduced to across loop
	
			A from-until loop iterating through an
			{ITERABLE} data structure from beginning to end can be transformed into
			a (more recommendable) across loop.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_ITERABLE_LOOP_RULE

inherit
	CA_STANDARD_RULE

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			default_severity_score := 30
			severity := severity_hint
			create loops.make (0)
		end

	register_actions (c: CA_ALL_RULES_CHECKER)
		do
			c.add_feature_pre_action (agent process_feature)
			c.add_loop_pre_action (agent process_loop_start)
			c.add_loop_post_action (agent process_loop_end)
			c.add_instruction_call_pre_action (agent process_instruction_call)
				-- Clean up storage.
			loops.wipe_out
		end

feature {NONE} -- Rule checking

	iterable: CLASS_C
			-- The {ITERABLE} class.
		once
			Result := Eiffel_universe.compiled_classes_with_name ("ITERABLE").first.compiled_class
		end

	current_feature_i: FEATURE_I
			-- Currently checked feature.

	process_feature (a_feature: FEATURE_AS)
			-- Sets currently checked feature.
		do
			current_feature_i := current_context.checking_class.feature_named_32 (a_feature.feature_name.name_32)
		end

	process_loop_start (a: LOOP_AS)
			-- Checks `a_loop' for a rule violation.
		do
			loops.extend (({detachable READABLE_STRING_32}).default, ({detachable INSTR_CALL_AS}).default, ({detachable INSTR_CALL_AS}).default, a)
			check_until_part (a.stop, a)
			check_from_part (a.from_part)
			check_last_instruction (a.compound)
		ensure
			loops_updated: loops.count = old loops.count + 1
		end

	process_loop_end (a: LOOP_AS)
		require
			has_loop: not loops.is_empty
		local
			l_viol: CA_RULE_VIOLATION
			inner_loop: like loops.item
		do
			inner_loop := loops.last
			if
				attached inner_loop.cursor as variable and then
				attached inner_loop.start and then
				attached inner_loop.forth
			then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a.start_location)
				l_viol.long_description_info.extend (variable)
				violations.extend (l_viol)
			end
			loops.finish
			loops.remove
		ensure
			loops_updated: loops.count = old loops.count - 1
		end

	check_until_part (a_stop_condition: detachable EXPR_AS; a: LOOP_AS)
			-- Checks if `a_stop_condition' is of the form 'list.after', where list is
			-- a variable of a type that conforms to {ITERABLE}.
		do
			if
				attached a_stop_condition and then
				attached {EXPR_CALL_AS} a_stop_condition as l_call and then
				attached {NESTED_EXPR_AS} l_call.call as l_nested_call and then
				l_nested_call.message.access_name_8.is_case_insensitive_equal ("after") and then
				attached current_context.node_type (l_nested_call.target, current_feature_i) as t and then
				t.base_class.conform_to (iterable) and then
				attached {EXPR_CALL_AS} l_nested_call.target as c and then
				attached {ACCESS_FEAT_AS} c.call as f
			then
				loops.last.cursor := f.access_name_32
			end
		end

	loops: ARRAYED_LIST [TUPLE [cursor: detachable READABLE_STRING_32; start: detachable INSTR_CALL_AS; forth: detachable INSTR_CALL_AS; a: LOOP_AS]]
			-- Nested loops.

	check_from_part (a: detachable EIFFEL_LIST [INSTRUCTION_AS])
			-- Does `a_from' contain an instruction of the form `expected_var'.start?			
		local
			inner_loop: like loops.item
		do
			inner_loop := loops.last
			if
				attached a and then
				attached inner_loop.cursor as expected_var
			then
				across
					a as l_instr
				loop
					if
						attached {INSTR_CALL_AS} l_instr as l_call and then
						attached {NESTED_EXPR_AS} l_call.call as l_nested_call and then
						attached {EXPR_CALL_AS} l_nested_call.target as c and then
						attached {ACCESS_FEAT_AS} c.call as f and then
						f.access_name_32.is_case_insensitive_equal (expected_var) and then
						l_nested_call.message.feature_name.name_id = {PREDEFINED_NAMES}.start_name_id
					then
							-- We do not have to check the type of `l_target' since we know it is the expected variable
							-- that has already been checked for conformance to {ITERABLE}.
						inner_loop.start := l_call
					end
				end
			end
		end

	process_instruction_call (a: INSTR_CALL_AS)
		do
			if
				attached {NESTED_EXPR_AS} a.call as n and then
				attached {EXPR_CALL_AS} n.target as c and then
				attached {ACCESS_FEAT_AS} c.call as f and then
				attached loop_with_variable (f.access_name_32) as l and then
				l.start /= a and then
				l.forth /= a
			then
					-- Mark the loop as not matching the pattern
					-- because there is a procedure call on the loop variable.
				l.cursor := Void
			end
		end

	loop_with_variable (variable: READABLE_STRING_32): detachable like loops.item
			-- Descriptor of a loop with iteration variable if name `name` if found,
			-- `Void` otherwise.
		do
			across
				loops as l
			until
				attached Result
			loop
				if attached l.cursor as c and then c.is_case_insensitive_equal (variable) then
					Result := l
				end
			end
		end

	check_last_instruction (a: detachable EIFFEL_LIST [INSTRUCTION_AS])
			-- Is the last instruction of `a_loop_body' of the form `expected_var'.start?
		local
			inner_loop: like loops.item
		do
			inner_loop := loops.last
			if
				attached a and then
				attached inner_loop.cursor as expected_var and then
				attached {INSTR_CALL_AS} a.last as l_call and then
				attached {NESTED_EXPR_AS} l_call.call as l_nested_call and then
				attached {EXPR_CALL_AS} l_nested_call.target as c and then
				attached {ACCESS_FEAT_AS} c.call as f and then
				f.access_name_32.is_case_insensitive_equal (expected_var) and then
				l_nested_call.message.access_name_8.is_case_insensitive_equal ("forth")
			then
					-- We do not have to check the type of `l_target' since we know it is the expected variable
					-- that has already been checked for conformance to {ITERABLE}.
				inner_loop.forth := l_call
			end
		end

feature -- Properties

	name: STRING = "general_loop_on_iterable"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.iterable_loop_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.iterable_loop_description
		end

	id: STRING_32 = "CA024"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		do
			a_formatter.add (ca_messages.iterable_loop_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_name then
				a_formatter.add_local (l_name)
			end
			a_formatter.add (ca_messages.iterable_loop_violation_2)
		end

end
