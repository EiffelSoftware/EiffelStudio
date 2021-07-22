note
	description: "[
			RULE #5: Object test with object test local on read-only variable (locals, object test locals, arguments)
	
			For local variables, feature arguments,
			and object test locals it is unnecessary to let the attached keyword
			create a new and safe local reference.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_UNNEEDED_OT_LOCAL_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			default_severity_score := 40
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_object_test_pre_action (agent process_object_test)
		end

feature -- Properties

	name: STRING = "redundant_object_test_local"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.unneeded_ot_local_title
		end

	id: STRING_32 = "CA005"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.unneeded_ot_local_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)

		do
			a_formatter.add ("'")
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_name then
				a_formatter.add_local (l_name)
			end
			a_formatter.add (ca_messages.unneeded_ot_local_violation_1)
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.at (2) as l_name then
				a_formatter.add_local (l_name)
			end
			a_formatter.add ("'.")
		end

feature {NONE} -- AST Visits

	process_object_test (a_ot: OBJECT_TEST_AS)
			-- Checks `a_ot' for rule violations.
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_UNNEEDED_OT_LOCAL_FIX
		do
				-- Artificial Exception to test exception handling.
--			l_violation := Void
--			print (l_violation.csv_line)

				-- The expression to be tested must be a simple call.
			if
				attached {EXPR_CALL_AS} a_ot.expression as l_call
				and then attached {ACCESS_ID_AS} l_call.call as l_access
					-- Testing if an object test local is used.
				and then attached a_ot.name as l_ot_local
					-- There must be no dynamic type check.
				and then a_ot.type = Void
					-- Now we have to check whether the tested expression is a local,
					-- an argument, or an object test local.
				and then (l_access.is_local or l_access.is_readonly)
			then
				create l_violation.make_with_rule (Current)
				l_violation.set_location (a_ot.start_location)
				l_violation.long_description_info.extend (l_access.access_name_32)
				l_violation.long_description_info.extend (l_ot_local.name_32)

					-- Add the fix.
				create l_fix.make_with_ot (current_context.checking_class, a_ot)
				l_violation.fixes.extend (l_fix)

				violations.extend (l_violation)
			end
		end

end
