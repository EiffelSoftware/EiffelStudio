note
	description: "[
			RULE #92: Wrong loop iteration

			Often, from-until loops use an integer
			variable for iteration. Initialization, stop condition and the loop
			body follow a simple scheme. A loop following this scheme but violating
			it at some point is an indication for an error.
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_WRONG_LOOP_ITERATION_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			default_severity_score := 70
		end

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_loop_pre_action (agent process_loop)
		end

feature {NONE} -- Checking Loop For Pattern

	process_loop (a_loop: LOOP_AS)
			-- Checks `a_loop' for rule violations.
		do
			analyze_from_part (a_loop)
			if from_part_conforms then
				analyze_stop_condition (a_loop.stop)
				if is_valid_stop_condition and then attached a_loop.compound as l_comp then
					check_xxcrement (l_comp.last)
				end
			end
		end

	from_part_conforms: BOOLEAN
			-- Does the from part look at last in `analyze_from_part' correspond to the pattern we are
			-- looking for?

	analyze_from_part (a_loop: attached LOOP_AS)
			-- Analyzes the from part of `a_loop' in regard to whether it conform to what we
			-- are looking for.
		do
			from_part_conforms := False

			if
				attached a_loop.from_part as l_from
				and then l_from.count = 1
				and then attached {ASSIGN_AS} l_from.first as l_assign
				and then attached {ACCESS_ID_AS} l_assign.target as l_target
				and then l_target.is_local
				and then attached {INTEGER_AS} l_assign.source as l_start
				and then l_start.has_integer (64)
			then
					-- We have a from part like "j := 3". Something of the form "x := X", where
					-- x is a local variable and X is an integer constant.
				iteration_variable := l_target.feature_name
				loop_start := l_start.integer_64_value
				from_part_conforms := True
			end
		end

	is_valid_stop_condition: BOOLEAN
			-- Does the loop stop condition analyzed in `analyze_stop_condition'
			-- correspond to the pattern we are looking for?


	analyze_stop_condition (a_stop: attached EXPR_AS)
			-- Analyze stop condition `a_stop' with regard to to the pattern
			-- we are looking for.
		local
			l_viol: CA_RULE_VIOLATION
		do
			is_valid_stop_condition := False

			if
				attached {COMPARISON_AS} a_stop as l_comp
				and then attached {EXPR_CALL_AS} l_comp.left as l_call
				and then attached {ACCESS_ID_AS} l_call.call as l_access
				and then l_access.feature_name.is_equal (iteration_variable)
					-- The variable that is used for initialization is compared.
				and then attached {INTEGER_AS} l_comp.right as l_int
				and then l_int.has_integer (64)
			then
				is_valid_stop_condition := True -- The loop structure still follows the pattern.
				loop_end := l_int.integer_64_value
				if attached {BIN_GE_AS} l_comp or attached {BIN_GT_AS} l_comp then
						-- '>' or '>=' comparison.
						-- Check for wrong comparison symbol.
					if loop_start > loop_end then
						create l_viol.make_with_rule (Current)
						l_viol.set_location (a_stop.start_location)
						l_viol.long_description_info.extend (ca_messages.wrong_loop_iteration_violation_1)
						violations.extend (l_viol)
					end
				elseif attached {BIN_LE_AS} l_comp or attached {BIN_LT_AS} l_comp then
						-- '<' or '<=' comparison.
						-- Check for wrong comparison symbol.
					if loop_start < loop_end then
						create l_viol.make_with_rule (Current)
						l_viol.set_location (a_stop.start_location)
						l_viol.long_description_info.extend (ca_messages.wrong_loop_iteration_violation_1)
						violations.extend (l_viol)
					end
				end
			end
		end

	check_xxcrement (a_instruction: attached INSTRUCTION_AS)
			-- Does the loop iteration `a_instruction' correspond to the pattern
			-- we are looking for?
		local
			l_viol: CA_RULE_VIOLATION
		do
			if
				attached {ASSIGN_AS} a_instruction as l_assign
				and then attached {ACCESS_ID_AS} l_assign.target as l_target
				and then l_target.feature_name.is_equal (iteration_variable)
				and then attached {BINARY_AS} l_assign.source as l_bin
				and then attached {EXPR_CALL_AS} l_bin.left as l_call
				and then attached {ACCESS_ID_AS} l_call.call as l_left
				and then l_left.feature_name.is_equal (iteration_variable)
				and then attached {INTEGER_AS} l_bin.right
					-- We have an increment of the form "x := x +/- X", where x is our iteration variable
					-- and X is an integer constant.
				and then ((attached {BIN_PLUS_AS} l_bin and loop_start > loop_end)
					or (attached {BIN_MINUS_AS} l_bin and loop_start < loop_end))
			then
					-- Wrong iteration direction.
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_instruction.start_location)
				l_viol.long_description_info.extend (ca_messages.wrong_loop_iteration_violation_2)
				violations.extend (l_viol)
			end
		end

	loop_start, loop_end: INTEGER_64
			-- First and last value the loop counter has during iteration.

	iteration_variable: ID_AS
			-- The loop iteration variable (often times `i` or `j`).

feature -- Properties

	name: STRING = "suspicious_interation_scheme"
			-- <Precursor>

	title: STRING_32
			-- Rule title.
		do
			Result := ca_names.wrong_loop_iteration_title
		end

	description: STRING_32
			-- Rule description.
		do
			Result :=  ca_names.wrong_loop_iteration_description
		end

	id: STRING_32 = "CA092"
			-- <Precursor>

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
			-- Generates a formatted rule violation description for `a_formatter' based on `a_violation'.
		do
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_msg then
				a_formatter.add (l_msg)
			end
		end

end
