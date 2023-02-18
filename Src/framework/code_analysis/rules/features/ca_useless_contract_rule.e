note
	description: "[
			RULE #9: Useless contract with void-safety
	
			If a certain variable is declared as attached, either explicitly or by
			the project setting "Are types attached by default?" then a contract
			declaring this variable not to be void is useless. This rule only applies
			if the project setting for Void safety is set to "Complete" (?).
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_USELESS_CONTRACT_RULE

inherit
	CA_STANDARD_RULE

	AST_ITERATOR
		redefine
			process_bin_ne_as,
			process_tagged_as
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_defaults
			create void_checking_contracts.make (5)
		end

feature {NONE} -- Implementation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
				a_checker.add_feature_pre_action (agent pre_process_feature)
		end

	pre_process_feature (a_feature: attached FEATURE_AS)
		do
			if
					-- This rule only applies if the Void-Safety is set to "Complete".
				is_project_setting_void_safety_complete
				and then attached {ROUTINE_AS} a_feature.body.content as l_routine
				and then attached l_routine.precondition as l_precondition
			then
				checking_tagged := True
				l_precondition.process (Current)
				checking_tagged := False

				check_for_violations (a_feature, True)

					-- Clean up for postcondition.
				void_checking_contracts.wipe_out
			end

			if
					-- This rule only applies if the Void-Safety is set to "Complete".
				is_project_setting_void_safety_complete
				and then attached {ROUTINE_AS} a_feature.body.content as l_routine
				and then attached l_routine.postcondition as l_postcondition
			then
				checking_tagged := True
				l_postcondition.process (Current)
				checking_tagged := False

				check_for_violations (a_feature, False)

					-- Clean up for next feature.
				void_checking_contracts.wipe_out
			end
		end

	process_tagged_as (a_tagged: attached TAGGED_AS)
		do
			if checking_tagged then
				current_tagged := a_tagged
			end

			Precursor(a_tagged)
		end

	check_for_violations (a_feature: attached FEATURE_AS; a_precondition: BOOLEAN)
		do
			if attached a_feature.body.arguments as l_args then
				across l_args as l_arg loop
					if l_arg.type.has_attached_mark then
						across l_arg.id_list as l_id loop
							if void_checking_contracts.has_key (l_id) then
								create_violation(a_feature, void_checking_contracts.at (l_id), a_precondition)
							end
						end
					end
				end
			end
		end

	process_bin_ne_as (a_bin: BIN_NE_AS)
		local
			operand: detachable EXPR_AS
		do
			if checking_tagged then
				if attached {VOID_AS} a_bin.right then
					operand := a_bin.left
				elseif attached {VOID_AS} a_bin.left then
					operand := a_bin.right
				end
				if
					attached {EXPR_CALL_AS} operand as l_expr_call
					and then attached {ACCESS_ASSERT_AS} l_expr_call.call as l_access_assert
					and then attached l_access_assert.feature_name as l_id
				then
						-- It is sufficient to report one issues per argument.
						-- The first one is kept only.
					void_checking_contracts.put (current_tagged, l_id.name_id)
				end
			end
			Precursor (a_bin)
		end

	create_violation (a_feature: attached FEATURE_AS; a_tagged: attached TAGGED_AS; a_precondition: BOOLEAN)
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_USELESS_CONTRACT_FIX
		do
			create l_violation.make_with_rule (Current)

			l_violation.set_location (a_tagged.start_location)

			l_violation.long_description_info.extend (a_feature.feature_names.first)

			create l_fix.make_with_feature_and_tagged_as (current_context.checking_class, a_feature, a_tagged, a_precondition)
			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.useless_contract_violation_1)

			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add (l_feature_name)
			end

			a_formatter.add (ca_messages.useless_contract_violation_2)
		end

	checking_tagged: BOOLEAN
		-- Are we checking tagged_as right now?

	current_tagged: TAGGED_AS

	void_checking_contracts: HASH_TABLE [TAGGED_AS, INTEGER]

	is_project_setting_void_safety_complete: BOOLEAN
			-- Is the project's setting for void safety set to "Complete"?
		local
			l_conf: CONF_OPTION
		do
			l_conf := current_context.universe.target.options
			Result := l_conf.void_safety.index = l_conf.void_safety_index_all
		end

feature -- Properties

	name: STRING = "useless_attachment_check"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.useless_contract_title
		end

	id: STRING_32 = "CA009"
			-- <Precursor>

	description: STRING_32
		do
			Result := ca_names.useless_contract_description
		end
end
