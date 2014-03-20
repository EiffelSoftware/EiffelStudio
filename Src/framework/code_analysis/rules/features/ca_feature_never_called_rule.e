note
	description: "[
			RULE #3: Feature never called
			
			There is no use for a feature that is
			never called by any class (including the one where it is defined).
		]"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_FEATURE_NEVER_CALLED_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			is_enabled_by_default := False
			checks_library_classes := False
			default_severity_score := 40
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_class_pre_action (agent class_check)
		end

feature {NONE} -- Feature Visitor for Violation Check

	class_check (a_class: CLASS_AS)
			-- Checks `a_class' for features that are never called.
		local
			l_clients: ARRAYED_LIST [CLASS_C]
			has_callers: BOOLEAN
		do
			l_clients := current_context.checking_class.clients

			across
				current_context.checking_class.written_in_features as l_feat
			loop
				from
					has_callers := False
					l_clients.start
				until
					has_callers or l_clients.after
				loop
					if l_feat.item.callers_32 (l_clients.item, 0) /= Void then
						has_callers := True
					end
					l_clients.forth
				end

				if not has_callers then
					create_violation (l_feat.item)
				end
			end
		end

	create_violation (a_feature: attached E_FEATURE)
			-- Creates violation regarding `a_feature' never being called.
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_FEATURE_NEVER_CALLED_FIX
		do
			create l_violation.make_with_rule (Current)
			l_violation.set_location (a_feature.ast.start_location)
			l_violation.long_description_info.extend (a_feature.name_32)

			create l_fix.make_with_feature (current_context.checking_class, a_feature.ast, a_feature.name_32)
			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

feature -- Properties

	title: STRING_32
		do
			Result := ca_names.feature_never_called_title
		end

	id: STRING_32 = "CA003"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.feature_never_called_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.feature_never_called_violation_1)
			if attached {STRING_32} a_violation.long_description_info.first as l_feat_name then
				a_formatter.add_feature_name (l_feat_name, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.feature_never_called_violation_2)
		end

end
