note
	description: "[
			RULE #75: Feature export can be restricted
	
			An exported feature that is used only in unqualified calls may be changed to secret.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EXPORT_CAN_BE_RESTRICTED_RULE

inherit
	CA_STANDARD_RULE

	AST_ITERATOR
		redefine
			process_nested_expr_as
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_defaults
			checks_library_classes := False
		end

feature {NONE} -- Implementation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_class_pre_action (agent class_check)
		end

	class_check (a_class: CLASS_AS)
			-- Checks `a_class' for features that are exported but never called in a qualified way.
		local
			l_clients: ARRAYED_LIST[CLASS_C]
			l_has_clients_outside_hierarchy: BOOLEAN
		do
			l_clients := current_context.checking_class.clients

			across
				current_context.checking_class.written_in_features as l_feat
			loop
					-- Only check features that are exported
				if not l_feat.export_status.is_none then
					from
						l_clients.start
						l_has_clients_outside_hierarchy := False
					until
						l_clients.after
						or l_has_clients_outside_hierarchy
					loop
						if
							not l_clients.item.inherits_from (current_context.checking_class)
							and then l_feat.callers_32 (l_clients.item, 0) /= Void
						then
							l_has_clients_outside_hierarchy := True
						elseif
							l_feat.callers_32 (l_clients.item, 0) /= Void
							and then not has_qualified_calls (l_feat, l_clients.item)
						then
							create_violation (l_feat.ast)
						end

						l_clients.forth
					end
				end
			end
		end

	has_qualified_calls (a_feature: E_FEATURE; a_class: CLASS_C): BOOLEAN
		do
			found_qualified_call := False

			current_feature := a_feature.associated_feature_i
			current_feature_name := a_feature.name_32
			a_class.ast.process (Current)

			Result := found_qualified_call
		end

	process_nested_expr_as (a_nested: NESTED_EXPR_AS)
		do
			if
				a_nested.message.access_name_32.same_string (current_feature_name) and then
				attached current_context.node_type (a_nested.target, current_feature) as l_type and then
				l_type.name.is_equal (current_context.checking_class.name)
			then
				found_qualified_call := True
			end
		end

	current_feature: FEATURE_I
		-- Feature currently being checked.

	current_feature_name: READABLE_STRING_32
		-- Name of the feature being checked.

	found_qualified_call: BOOLEAN
		-- Has there been a qualified call found of the current feature?

	create_violation (a_feature: attached FEATURE_AS)
		local
			l_violation: CA_RULE_VIOLATION
		do
			create l_violation.make_with_rule (Current)

			l_violation.set_location (a_feature.start_location)
			l_violation.long_description_info.extend (current_feature_name)

			violations.extend (l_violation)
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.export_can_be_restricted_violation_1)

			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add (l_feature_name)
			end

			a_formatter.add (ca_messages.export_can_be_restricted_violation_2)
		end

feature -- Properties

	name: STRING = "unused_export"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.export_can_be_restricted_title
		end

	id: STRING_32 = "CA075"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.export_can_be_restricted_description
		end

end
