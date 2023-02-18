note
	description: "[
			RULE #22: Unreachable code
	
			Code that will never be executed should be removed. It may be there for debug
			purposes or due to a programmer's mistake. One example is a series of instructions
			(in the same block) which follows an assertion that always evaluates to false.
		]"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNREACHABLE_CODE_RULE

inherit
	CA_STANDARD_RULE

	AST_ITERATOR
		redefine
			process_access_feat_as,
			process_check_as,
			process_eiffel_list,
			process_guard_as,
			process_if_as,
			process_inline_agent_creation_as,
			process_precursor_as
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
		end

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
		do
			a_checker.add_routine_pre_action (agent (r: ROUTINE_AS)
				do
					is_unreachable := False
					safe_process (r.routine_body)
					is_unreachable := False
					safe_process (r.rescue_clause)
				end)
		end

feature -- Properties

	name: STRING = "unreachable_code"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.unreachable_code_title
		end

	id: STRING_32 = "CA022"
		-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.unreachable_code_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.unreachable_code_violation_1)
			a_formatter.add (a_violation.affected_class.name_in_upper)
			a_formatter.add (ca_messages.unreachable_code_violation_2)
		end

feature {NONE} -- Status report

	is_unreachable: BOOLEAN
			-- Is current instruction unreachable?

feature {NONE} -- Rule Checking

	process_eiffel_list (l: EIFFEL_LIST [AST_EIFFEL])
		local
			done: BOOLEAN
		do
			if attached {EIFFEL_LIST [INSTRUCTION_AS]} l as instructions then
				across
					instructions as i
				until
					done
				loop
					if is_unreachable then
						create_violation (instructions, @ i.target_index)
						done := True
					else
						i.process (Current)
					end
				end
			else
				Precursor (l)
			end
		end

	process_access_feat_as (a: ACCESS_FEAT_AS)
			-- <Precursor>
		do
			if a.is_feature then
				process_feature_call (a.first, a.class_id)
			end
			Precursor (a)
		end

	process_precursor_as (a: PRECURSOR_AS)
			-- <Precursor>
		do
			process_feature_call (a.first, a.class_id)
			Precursor (a)
		end

	process_feature_call (routine_id: like {ID_SET_ACCESSOR}.routine_ids.first; class_id: like {CLASS_C}.class_id)
			-- Process a call to a feature of routine ID `routine_id` in class of class ID `class_id`.
		do
			is_unreachable :=
				class_id /= 0 and then
				system.has_class_of_id (class_id) and then
				attached system.class_of_id (class_id) as c and then
				c.has_feature_table and then
				routine_id > 0 and then
				attached c.feature_of_rout_id (routine_id) as f and then
				f.is_failing
		end

	process_inline_agent_creation_as (a: INLINE_AGENT_CREATION_AS)
			-- <Precursor>
		local
			old_is_unreachable: BOOLEAN
		do
			old_is_unreachable := is_unreachable
			Precursor (a)
				-- Reset checks after agent creation.
			is_unreachable := old_is_unreachable
		end

	process_check_as (a: CHECK_AS)
			-- <Precursor>
		do
			is_unreachable := attached a.check_list as l and then ∃ t: l ¦ is_expr_false (t.expr)
		end

	process_guard_as (a: GUARD_AS)
			-- <Precursor>
		do
			if attached a.check_list as l and then ∃ t: l ¦ is_expr_false (t.expr) then
				is_unreachable := True
				if attached a.compound as c then
					create_violation (c, 1)
				end
			end
		end

	process_if_as (a: IF_AS)
			-- <Precursor>
		local
			next_is_unreachable: BOOLEAN
			new_is_unreachable: BOOLEAN
		do
			a.condition.process (Current)
			next_is_unreachable := is_unreachable or else is_expr_true (a.condition)
			if attached a.compound as c then
				if is_unreachable or else is_expr_false (a.condition) then
					create_violation (c, 1)
				else
					c.process (Current)
				end
			end
			new_is_unreachable := is_unreachable
			if attached a.elsif_list as l then
				across l as e loop
					is_unreachable := next_is_unreachable
					if next_is_unreachable then
						create_violation (l, @ e.target_index)
					else
						e.expr.process (Current)
						next_is_unreachable := next_is_unreachable or is_unreachable or is_expr_true (e.expr)
						if attached e.compound as c then
							if is_unreachable or else is_expr_false (e.expr) then
								create_violation (c, 1)
							else
								c.process (Current)
							end
						end
					end
					new_is_unreachable := new_is_unreachable and is_unreachable
				end
			end
			is_unreachable := next_is_unreachable
			if attached a.else_part as e then
				safe_process (e)
				is_unreachable := new_is_unreachable and is_unreachable
			end
		end

	is_expr_true (a_expr: EXPR_AS): BOOLEAN
		do
			Result := attached {BOOL_AS} a_expr as l_bool and then l_bool.value
		end

	is_expr_false (a_expr: EXPR_AS): BOOLEAN
		do
			Result := attached {BOOL_AS} a_expr as l_bool and then not l_bool.value
		end

	create_violation (l: EIFFEL_LIST [AST_EIFFEL]; a_index: INTEGER)
		local
			l_violation: CA_RULE_VIOLATION
		do
			create l_violation.make_with_rule (Current)
			l_violation.set_location (l.at (a_index).start_location)
			if attached {EIFFEL_LIST [INSTRUCTION_AS]} l as li then
				l_violation.fixes.extend (create {CA_UNREACHABLE_CODE_FIX}.make_with_list_and_index (current_context.checking_class, li, a_index))
			end
			violations.extend (l_violation)
				-- Avoid reporting duplicates.
			is_unreachable := False
		ensure
			not is_unreachable
		end

end
