note
	description: "[
			RULE #59: Empty rescue clause
			
			An empty rescue clause should be avoided and leads to undesirable program behaviour.
		]"
	author: "Paolo Antonucci"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EMPTY_RESCUE_CLAUSE_RULE

inherit

	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_feature_pre_action (agent process_feature)
		end

feature {NONE} -- Rule checking

	process_feature (a_feature_as: FEATURE_AS)
			-- Process `a_feature_as'.
		local
			l_rescue_keyword: KEYWORD_AS
			l_viol: CA_RULE_VIOLATION
		do
				-- Sample violation:
				--
				-- do_something
				-- 		do
				--			io.put_string ("Hello world!")
				--		rescue
				--		end
				--

			if attached {ROUTINE_AS} a_feature_as.body.content as l_routine_as then
					-- routine_as.has_rescue is not very helpful, as it only tells us
					-- if the routine has a *non empty* rescue clause.
				l_rescue_keyword := l_routine_as.rescue_keyword (current_context.matchlist)
				if attached l_rescue_keyword and (l_routine_as.rescue_clause = Void or else l_routine_as.rescue_clause.is_empty) then
					create l_viol.make_with_rule (Current)
					l_viol.set_location (l_rescue_keyword.start_location)
					l_viol.long_description_info.extend (a_feature_as.feature_name.name_8)
					violations.extend (l_viol)
				end
			end
		end

feature -- Properties

	name: STRING = "empty_rescue"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.empty_rescue_clause_title
		end

	id: STRING_32 = "CA059"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.empty_rescue_clause_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.empty_rescue_clause_violation_1)
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add_feature_name (l_feature_name, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.empty_rescue_clause_violation_2)
		end

end
