note
	description: "[
		RULE #51: Empty and uncommented feature
		
		A routine which does not contain any instructions and has no comment too indicates that the implementation might be missing.
	]"
	author: "Paolo Antonucci"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EMPTY_UNCOMMENTED_ROUTINE_RULE

inherit

	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_feature_pre_action (agent process_feature)
			a_checker.add_do_pre_action (agent process_do)
			a_checker.add_once_pre_action (agent process_once)
		end

feature {NONE} -- Rule checking

	current_feature: detachable FEATURE_AS
			-- The feature currently being analyzed.

	process_do_once (a_as: INTERNAL_AS; a_do_once_keyword_index: INTEGER)
			-- Process `a_as'
		local
			l_comments: EIFFEL_COMMENTS
			l_break_leaf: LEAF_AS
			l_uncommented: BOOLEAN
			l_viol: CA_RULE_VIOLATION
		do
				-- Sample violation
				--
				-- feature -- Some feature group
				--
				--		restore_defaults
				--			do
				--			end
				--

			check
				attached current_feature
			end
			if
				attached current_feature as l_current_feature and then
				(not attached a_as.compound or else a_as.compound.is_empty) and then
				l_current_feature.body.is_routine
			then
				l_uncommented := True

				l_comments := l_current_feature.comment (current_context.matchlist)
				if not comments_are_empty (l_comments) then
					l_uncommented := False
				end

					-- The following line should never fail, at the very least we will have
					-- two more 'end' keywords in the current class.
				l_break_leaf := current_context.matchlist.at (a_do_once_keyword_index + 1)
				if attached {BREAK_AS} l_break_leaf as l_break and then l_break.has_comment then
					l_uncommented := False
				end

				if l_uncommented then
					create l_viol.make_with_rule (Current)
					l_viol.set_location (l_current_feature.start_location)
					l_viol.long_description_info.extend (l_current_feature.feature_name.name_32)
					violations.extend (l_viol)
				end
			end
		end

	process_do (a_do_as: DO_AS)
			-- Process `a_do_as'
		do
			process_do_once (a_do_as, a_do_as.do_keyword_index)
		end

	process_once (a_once_as: ONCE_AS)
			-- Process `a_once_as'
		do
			process_do_once (a_once_as, a_once_as.once_keyword_index)
		end

	process_feature (a_feature_as: FEATURE_AS)
			-- Set `a_feature_as' as the currently processed feature.
		do
			current_feature := a_feature_as
		end

	comments_are_empty (a_comments: detachable EIFFEL_COMMENTS): BOOLEAN
			-- Is the text of `a_comments' only composed of whitespace?
		do
			Result := true
			if attached a_comments then
				from
					a_comments.start
				until
					a_comments.after or not Result
				loop
					if not a_comments.item.content_32.is_whitespace then
						Result := false
					end
					a_comments.forth
				end
			end
		end

feature -- Properties

	name: STRING = "empty_feature"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.empty_uncommented_routine_title
		end

	id: STRING_32 = "CA051"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.empty_uncommented_routine_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.empty_uncommented_routine_violation_1)
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_feature_name then
				a_formatter.add_feature_name (l_feature_name, a_violation.affected_class)
			end
			a_formatter.add (ca_messages.empty_uncommented_routine_violation_2)
		end

end
