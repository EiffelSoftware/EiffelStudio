note
	description: "[
			RULE #35: Feature section not commented
	
			A feature section should have a comment.
			This comment serves as caption and is used for example by the 'Features' panel.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_FEATURE_SECTION_COMMENT_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			is_enabled_by_default := False
			default_severity_score := 30
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_feature_clause_pre_action (agent process_feature_clause)
		end

feature {NONE} -- Rule checking

	process_feature_clause (a_feature_clause: FEATURE_CLAUSE_AS)
			-- Checks whether feature section `a_feature_clause' has a comment / caption.
		local
			l_viol: CA_RULE_VIOLATION
			l_comment: STRING_32
			l_empty: BOOLEAN
		do
			if current_context.matchlist /= Void then
				if a_feature_clause.comment (current_context.matchlist).count = 0 then
						-- The comments list is empty.
					l_empty := True
				else
					create l_comment.make_from_string (a_feature_clause.comment (current_context.matchlist).first.content_32)
						 -- In case there are whitespaces after "--":
					l_comment.prune_all (' ')
					l_comment.prune_all ('%T')
					if l_comment.is_empty then
						l_empty := True
					end
				end
			end

			if l_empty then
				create l_viol.make_with_rule (Current)
				l_viol.set_location (a_feature_clause.start_location)
				violations.extend (l_viol)
			end
		end

feature -- Properties

	name: STRING = "missing_feature_clause_comment"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.feature_section_comment_title
		end

	id: STRING_32 = "CA035"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.feature_section_comment_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.feature_section_comment_violation)
		end

end
