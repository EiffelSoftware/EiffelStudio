note
	description: "[
		RULE #88: Mergeable feature clauses
		
		Feature clauses with the same export status and comment could possibly
		be merged into one, or their comments could be made more specific.
	]"
	author: "Paolo Antonucci"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_MERGEABLE_FEATURE_CLAUSES_RULE

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
			a_checker.add_class_pre_action (agent class_pre)
			a_checker.add_class_post_action (agent class_pre)
			a_checker.add_feature_clause_pre_action (agent process_feature_clause)
		end

feature {NONE} -- Rule checking

	class_pre (a_class_as: CLASS_AS)
			-- To be run at the beginning of the analysis of a class.
		do
			create seen_feature_table.make_caseless (32)
		end

	class_post (a_class_as: CLASS_AS)
			-- To be run at the end of the analysis of a class.
		do
			seen_feature_table := Void
		end

	process_feature_clause (a_feature_clause_as: FEATURE_CLAUSE_AS)
			-- Process `a_feature_clause_as'.
		local
			l_viol: CA_RULE_VIOLATION
			l_key: STRING_32
			l_comment_text: STRING_32
		do
				-- Sample violation
				--
				-- class
				--		MY_CLASS
				--
				-- feature -- My feature group
				--
				--	-- some features here
				--
				-- feature -- My feature group
				--
				--	-- some more features
				--

			l_comment_text := stringify_comments (a_feature_clause_as.comment (current_context.matchlist))
			check
				attached seen_feature_table
			end
			if not l_comment_text.is_empty and attached seen_feature_table as l_seen_feature_table then
					-- If the comment is empty, we ignore this feature clause.
					-- There is another rule in charge of complaining about uncommented feature clauses.
				l_key := stringify_clients (a_feature_clause_as.clients) + "%U" + l_comment_text
				if l_seen_feature_table.has (l_key) then
					create l_viol.make_with_rule (Current)
					l_viol.set_location (a_feature_clause_as.start_location)
					l_viol.long_description_info.extend (l_comment_text)
					violations.extend (l_viol)
				else
					l_seen_feature_table.put (a_feature_clause_as, l_key)
				end
			end
		end

	seen_feature_table: detachable STRING_TABLE [FEATURE_CLAUSE_AS]
			-- Contains the features that have been met so far. The key is a combination
			-- of the feature comment and the exports.

	stringify_comments (a_comments: EIFFEL_COMMENTS): STRING_32
			-- Convert `a_comments' to a string representation, ignoring
			-- whitespace at the beginning and the end of each line.
		local
			l_adjusted_comment: STRING_32
		do
			create Result.make (512) -- Should be more space than enough
			across
				a_comments as ic
			loop
				l_adjusted_comment := ic.item.content_32
				l_adjusted_comment.adjust
				Result.append_string (l_adjusted_comment)
			end
		end

	stringify_clients (a_clients: CLIENT_AS): STRING_32
			-- Convert `a_clients' to a string representation.
		local
			l_client_list: ARRAYED_LIST [READABLE_STRING_32]
		do
			if
				not attached a_clients or else
				not attached a_clients.clients as l_inner_clients
			then
				create Result.make_empty
			else
				create l_client_list.make (l_inner_clients.count)
				across
					l_inner_clients as cs
				loop
					l_client_list.extend (cs.item.name_32)
				end
				;(create {QUICK_SORTER [READABLE_STRING_GENERAL]}.make
					(create {STRING_COMPARATOR}.make)).sort (l_client_list)
				create Result.make (256) -- Should be more space than enough
				across
					l_client_list as ic
				loop
					Result.append (ic.item + {STRING_32} " ")
				end
			end
		end

feature -- Properties

	name: STRING = "duplicate_feature_clause"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.mergeable_feature_clauses_title
		end

	id: STRING_32 = "CA088"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.mergeable_feature_clauses_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.mergeable_feature_clauses_violation_1)
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_comment_text then
				a_formatter.add_quoted_text (l_comment_text)
			end
			a_formatter.add (ca_messages.mergeable_feature_clauses_violation_2)
		end

end
