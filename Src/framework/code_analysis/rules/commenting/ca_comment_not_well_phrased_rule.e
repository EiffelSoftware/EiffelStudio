note
	description: "[
			RULE #73: Comment not well phrased
			
			The comment does not end with a period or question
			mark. This indicates that the comment is not well
			phrased. A comment should always consist of whole
			sentences.
		]"
	author: "Samuel Schmid"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_COMMENT_NOT_WELL_PHRASED_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_defaults
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_class_pre_action (agent check_feature_clause_comments)
			a_checker.add_feature_pre_action (agent check_feature_comments)
		end

feature {NONE} -- Implementation

	check_feature_comments (a_feature: attached FEATURE_AS)
			-- Checks for not well phrased feature comments in `a_feature'.
		local
			done: BOOLEAN
			comments: EIFFEL_COMMENTS
			comment: EIFFEL_COMMENT_LINE
			line: READABLE_STRING_32
			first_comment: EIFFEL_COMMENT_LINE
		do
			comments := a_feature.comment (current_context.matchlist)
			across
				comments as c
			until
				done
			loop
				comment := c
				line := comment.content_32
				if
					not attached first_comment and then
					not is_empty_comment (line)
				then
							-- There is no content before this comment.
					if starts_with_upper (line) then
						first_comment := comment
					else
						create_violation (comment)
						done := True
					end
				end
				if attached first_comment then
					if is_empty_comment (line) then
							-- The line above the empty line did not end with punctuation -> violation.
						create_violation (first_comment)
						done := True
					elseif ends_with_punctuation (line) then
							-- We only check until we found the first sentence.
						done := True
					elseif is_special_line (line) then
							-- This is a special comment like "-- <Precursor>".
							-- It is OK to have it as the first comment.
						if comment /= first_comment then
								-- The first comment should have ended with a puncuation.
							create_violation (first_comment)
						end
						done := True
					end
				end
			end

			if not done then
					-- The comment did not end well or there was no comment at all.
					-- If there are no comments, no errors are reported about their well-formedness.
				if attached first_comment then
						-- There is a non-empty comment.
					create_violation (first_comment)
				elseif not comments.is_empty then
						-- All comment lines are empty.
					create_violation (comments.first)
				end
			end
		end

	check_feature_clause_comments (a_class: attached CLASS_AS)
			-- Checks for not well phrased feature clause comments in `a_class'.
		local
			l_comment: EIFFEL_COMMENT_LINE
		do
			if attached a_class.features as l_features then
				across l_features as l_feature loop
					if attached l_feature.clients then
						l_comment := find_feature_clause_comment (l_feature.feature_keyword.index, l_feature.clients.clients.count)
					else
						l_comment := find_feature_clause_comment (l_feature.feature_keyword.index, 0)
					end

					if not is_empty_comment (l_comment.content_32) and then not starts_with_upper (l_comment.content_32) then
						create_violation (l_comment)
					end
				end
			end
		end

	find_feature_clause_comment (a_index: INTEGER; a_export_count: INTEGER): EIFFEL_COMMENT_LINE
		do
			Result := create {EIFFEL_COMMENT_LINE}.make_from_string_32 ("")
			if attached current_context.matchlist as l_trunk then
				if attached {BREAK_AS} l_trunk.at (a_index) as l_break then
					if current_context.matchlist.has_comment (l_break.token_region (current_context.matchlist)) then
							-- Case 1: feature -- Comment
						Result := current_context.matchlist.extract_comment (l_break.token_region (current_context.matchlist)).first
					elseif attached {SYMBOL_STUB_AS} l_trunk.at (a_index + 1) as l_symbol and then l_symbol.code = 297 then
							-- Case 2: feature {SOME_CLASS} (code 297 = '{')
						if current_context.matchlist.has_comment (l_trunk.at (a_index + 2 + a_export_count).token_region (current_context.matchlist)) then
								-- Case 3: feature {SOME_CLASS} -- Comment (index + 2 for the { and }.
							Result := current_context.matchlist.extract_comment (l_trunk.at (a_index + 2 + a_export_count).token_region (current_context.matchlist)).first

						end
							-- Case 4: feature {SOME_CLASS} (no comment)
					else
							-- Case 5: feature (no comment)
						Result := create {EIFFEL_COMMENT_LINE}.make_from_string_32 ("")
					end
				elseif attached {SYMBOL_STUB_AS} l_trunk.at (a_index) as l_symbol and then l_symbol.code = 297 then
						-- Case 6: feature{SOME_CLASS} (without space between feature and '{')
					if current_context.matchlist.has_comment (l_trunk.at (a_index + 1 + a_export_count).token_region (current_context.matchlist)) then
							-- Case 7: feature{SOME_CLASS} -- Comment
						Result := current_context.matchlist.extract_comment (l_trunk.at (a_index + 1 + a_export_count).token_region (current_context.matchlist)).first
					end
						-- Case 8: feature{SOME_CLASS} (no comment)
				end
			end
		end

	starts_with_upper (a_comment: READABLE_STRING_32): BOOLEAN
		require
			not_is_empty: not is_empty_comment (a_comment)
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_comment.count or not a_comment.at (i).is_space
			loop
				i := i + 1
			end
			Result := a_comment.at (i).is_upper or not a_comment.at (i).is_alpha
		end

	ends_with_punctuation (a_comment: READABLE_STRING_32): BOOLEAN
		require
			not_is_empty: not is_empty_comment (a_comment)
		local
			i: INTEGER
		do
			from
				i := a_comment.count
			until
				i <= 1 or not a_comment [i].is_space
			loop
				i := i - 1
			end
			Result := i >= 1 and then ending_punctuation.has (a_comment [i])
		end

	ending_punctuation: STRING_32 = ".?!:"
			-- Symbols that can be used to indicate end of a sentense.

	is_empty_comment (a_comment: READABLE_STRING_32): BOOLEAN
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				i > a_comment.count or not Result
			loop
				Result := a_comment.at (i).is_space
				i := i + 1
			end
		end

	is_special_line (c: READABLE_STRING_32): BOOLEAN
			-- Does comment `c` represent a special comment line
			-- that is complete, e.g. "-- <Precursor>"?
		local
			i, n: INTEGER
		do
			i := c.index_of (special_line [1], 1)
			n := special_line.count
			if i > 0 and then c.same_caseless_characters (special_line, 1, n, i) then
					-- Position to the first space character.
				i := i - 1
					-- Record where special line ends.
				n := i + n
					-- Test if all leading characters are spaces.
				from
				until
					i <= 0 or else not c [i].is_space
				loop
					i := i - 1
				end
				if i = 0 then
						-- All leading characters are spaces.
						-- Test if all trailing characters are spaces.
					from
						i := c.count
					until
						i <= n or else not c [i].is_space
					loop
						i := i - 1
					end
					Result := i = n
				end
			end
		end

	special_line: STRING_32 = "<Precursor>"
			-- A complete self-contained feature comment.

	create_violation (a_comment: EIFFEL_COMMENT_LINE)
		local
			l_violation: CA_RULE_VIOLATION
		do
			create l_violation.make_with_rule (Current)
			l_violation.set_location (create {LOCATION_AS}.make (a_comment.line, a_comment.column, 0, 0, 0, 0, 0))
			l_violation.long_description_info.extend (a_comment.content_32)
			violations.extend (l_violation)
		end

feature -- Properties

	name: STRING = "comment_style"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.comment_not_well_phrased_title
		end

	id: STRING_32 = "CA073"

	description: STRING_32
		do
			Result := ca_names.comment_not_well_phrased_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_comment_text then
				a_formatter.add_string ({STRING_32} "Starting at: %"" + l_comment_text + "%"")
			end
		end

end
