note
	description: "[
			RULE #50: Local variable only used for Result
	
			In a function, a local variable that is never read and that is not assigned
			to any variable but the Result can be omitted. Instead the Result can be directly used.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_LOCAL_USED_FOR_RESULT_RULE

inherit
	CA_STANDARD_RULE

	AST_ITERATOR
		redefine
			process_assign_as,
			process_creation_as
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_defaults
			can_have_violations := True
			create all_locals.make (10)
			create {NONE_TYPE_AS} result_type.initialize (create {NONE_ID_AS}.make)
		end

feature {NONE} -- Implementation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_feature_pre_action (agent process_feature)
		end

	process_feature (a_feature: attached FEATURE_AS)
			-- <Precursor>
		do
			if
				attached a_feature.body.type as t and then
				attached a_feature.body.as_routine as l_routine and then
				attached l_routine.locals as l_locals
			then
				result_type := attachment_mark_free (t)

					-- Get all locals.
				across l_locals as l_local_dec loop
					if attached l_local_dec.item.type as local_type then
						across l_local_dec.item.id_list as l_id loop
							all_locals.extend ([l_id.item, local_type], l_local_dec.item.item_name_32 (l_id.target_index))
						end
					end
				end

				process_routine_as (l_routine)

				if
					can_have_violations and
					attached violating_assignment and
						 -- The violating assignment must not be nested.
					a_feature.index_of_instruction (violating_assignment) /= 0
				then
					create_violation (a_feature)
				end

					-- Reset the access id and booleans for the next feature.
				violating_assignment := Void
				can_have_violations := True
				has_found_result_assignment := False
				all_locals.wipe_out
			end
		end

	all_locals: STRING_TABLE [TUPLE [id: INTEGER; type: TYPE_AS]]
			-- Locals indexed by name with the corresponding local ID and type.

	process_assign_as (a_assign: attached ASSIGN_AS)
			-- <Precursor>
		do
			if
				can_have_violations and then
				attached {RESULT_AS} a_assign.target
			then
				if has_found_result_assignment then
						-- We cannot create any violations when there is more than 1 assignment to Result from a local variable.
						-- TODO: Allow for multiple assignments from the same local.
					can_have_violations := False
				else
					has_found_result_assignment := True
				end

				if
					can_have_violations and then
					attached {EXPR_CALL_AS} a_assign.source as l_expr_call and then
					attached {ACCESS_ID_AS} l_expr_call.call as l_access and then
					attached all_locals [l_access.access_name_32] as l and then
					result_type.equivalent (result_type, attachment_mark_free (l.type))
				then
					violating_assignment := a_assign
				end
			end

			Precursor (a_assign)
		end

	process_creation_as (a_create: CREATION_AS)
			-- <Precursor>
		do
			if
				can_have_violations and then
				attached {RESULT_AS} a_create.target
			then
					-- We cannot create any violations when there is a creation instruction for Result.
				can_have_violations := False
			end

			Precursor (a_create)
		end

	has_found_result_assignment: BOOLEAN
			-- Has the rule already found an assignment to Result?

	can_have_violations: BOOLEAN
			-- Can the rule still have valid violations?

	violating_assignment: ASSIGN_AS
			-- The assignment which violates this rule.

	create_violation (a_feature: attached FEATURE_AS)
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_LOCAL_USED_FOR_RESULT_FIX
		do
			create l_violation.make_with_rule (Current)

			l_violation.set_location (violating_assignment.start_location)

			if
				attached {EXPR_CALL_AS} violating_assignment.source as l_expr_call
				and then attached {ACCESS_ID_AS} l_expr_call.call as l_access
			then
				l_violation.long_description_info.extend (l_access.access_name_32)

				if attached current_context.checking_class.feature_named_32 (a_feature.feature_name.name_32) as l_feature_i then
					create l_fix.make_with_feature_type_and_index (current_context.checking_class, a_feature, current_context.node_type (l_access, l_feature_i), all_locals [l_access.access_name_32].id, l_access)
				end

			end

			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.local_used_for_result_violation_1)

			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add (l_feature_name)
			end

			a_formatter.add (ca_messages.local_used_for_result_violation_2)
		end

feature {NONE} -- Context

	result_type: TYPE_AS
			-- Type of result.

feature {NONE} -- Type properties

	attachment_mark_free (t: TYPE_AS): TYPE_AS
			-- `t` without any attachment marks.
		do
			if t.has_attached_mark or else t.has_detachable_mark then
				Result := t.twin
				Result.set_attachment_mark (Void, False, False)
			else
				Result := t
			end
		end

feature -- Properties

	name: STRING = "local_used_as_result"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.local_used_for_result_title
		end

	id: STRING_32 = "CA050"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.local_used_for_result_description
		end

end
