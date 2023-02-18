note
	description: "[
			RULE #87: Mergeable conditionals
	
			Successive conditional instructions with the same condition can be merged.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_MERGEABLE_CONDITIONALS_RULE

inherit
	CA_STANDARD_RULE

	AST_ITERATOR
		redefine
			process_access_id_as,
			process_assign_as
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_defaults
			create all_locals.make
			create locals_in_condition.make
			all_locals.compare_objects
			locals_in_condition.compare_objects
		end

feature {NONE} -- Implementation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_pre_action (agent pre_process_feature)
			a_checker.add_feature_post_action (agent post_process_feature)
			a_checker.add_eiffel_list_pre_action (agent pre_process_eiffel_list)
		end

	pre_process_feature (a_feature: FEATURE_AS)
		do
			if
				attached a_feature.body.as_routine as l_routine
				and then attached l_routine.locals as l_locals
			then
					-- Get all locals.
				across l_locals as l_local_dec loop
					across l_local_dec.id_list as l_id loop
						all_locals.extend (l_local_dec.item_name (l_local_dec.id_list.index_of (l_id, 1)))
					end
				end
			end
		end

	post_process_feature (a_feature: FEATURE_AS)
		do
				-- Reset locals for the next feature.
			all_locals.wipe_out
		end

	pre_process_eiffel_list (a_list: EIFFEL_LIST [AST_EIFFEL])
			-- Checks `a_list' for patterns that may be rule violations.
		local
			l_previous, l_current: INSTRUCTION_AS
		do
				-- Check if it is an instruction compound and not another kind
				-- of list such as a type declaration.
			if
				attached {EIFFEL_LIST [INSTRUCTION_AS]} a_list as l_instr
				and then l_instr.count >= 2
			then
				from
					a_list.start
					l_current := l_instr.item
					a_list.forth
				until
					a_list.after
				loop
					l_previous := l_current
					l_current := l_instr.item
					if
						attached {IF_AS} l_previous as l_if_1
						and then attached {IF_AS} l_current as l_if_2
						and then l_if_1.condition.text_32 (current_context.matchlist).is_equal
								(l_if_2.condition.text_32 (current_context.matchlist))
						and then is_condition_valid(l_if_1.condition) -- Because the conditions are equal, we only need to check one of them.
						and then is_body_valid (l_if_1)
					then
						create_violation(l_if_1, l_if_2)
					end
						-- Reset possibly saved locals in the condition for the next if blocks.
					locals_in_condition.wipe_out
					a_list.forth
				end
			end
		end

	is_condition_valid (a_cond: EXPR_AS): BOOLEAN
			-- Checks if the condition only contains local or constant booleans.
		do
			found_invalid_term := False

			a_cond.process (Current)

			Result := not found_invalid_term
		end

	is_body_valid (a_if: IF_AS): BOOLEAN
			-- Checks if the body changes any of the locals used in the condition of the first if block.
		do
			local_accessed := False

			if attached a_if.compound as l_compound then
				l_compound.process (Current)
			end

			if attached a_if.else_part as l_else then
				l_else.process (Current)
			end

			Result := not local_accessed
		end

	process_access_id_as (a_access: ACCESS_ID_AS)
		do
			if not all_locals.has (a_access.access_name) then
				found_invalid_term := True
			else
				locals_in_condition.extend (a_access.access_name)
			end
		end

	process_assign_as (a_assign: ASSIGN_AS)
		do
			if locals_in_condition.has (a_assign.target.access_name) then
				local_accessed := True
			end
		end

	all_locals: LINKED_LIST [STRING]

	locals_in_condition: LINKED_LIST [STRING]
			-- All the locals used in the condition expression of the first if block.

	found_invalid_term: BOOLEAN
			-- Used for evaluating boolean expressions.		

	local_accessed: BOOLEAN
			-- Used for evaluating boolean expressions.

	create_violation (a_if_1: IF_AS; a_if_2: IF_AS)
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_MERGEABLE_CONDITIONALS_FIX
		do
			create l_violation.make_with_rule (Current)

			l_violation.set_location (a_if_1.start_location)

			create l_fix.make_with_ifs (current_context.checking_class, a_if_1, a_if_2)
			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.mergeable_conditionals_violation_1)
		end

feature -- Properties

	name: STRING = "mergeable_conditionals"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.mergeable_conditionals_title
		end

	id: STRING_32 = "CA087"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.mergeable_conditionals_description
		end

end

