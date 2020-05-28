note
	description: "[
				This class iterates over asts of classes, extracts the arguments to the translation functions from the i18n 
				library, generates appropriate PO_ENTRYs for them and adds them to a PO_FILE.
				To use it one should call set_po_file, set_translate_feature, set_translate_plural_feature and setup first.
				Then it is sufficient to do an process_node_as on the ast in question.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_AST_ITERATOR

inherit
	AST_ROUNDTRIP_ITERATOR
		redefine
			process_access_feat_as,
			process_access_id_as,
			process_feature_clause_as,
			process_string_as,
			process_agent_routine_creation_as
		end

	CHARACTER_ROUTINES

	UNICODE_CONVERSION
		rename
			reset as u_reset
		end

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Creation

	make
		(
		output_file: PO_FILE;
		translation_f: like translation_feature;
		plural_translation_f: like plural_translation_feature;
		translation_in_context_f: like translation_in_context_feature;
		plural_translation_in_context_f: like plural_translation_in_context_feature;
		feature_clause: like feature_clause_name;
		source_name: READABLE_STRING_32;
		text: READABLE_STRING_32
		)
			-- Create a iterator for source file of name `source_name`.
		do
			po_file := output_file
			source_file_name := source_name
			translation_feature := translation_f
			plural_translation_feature := plural_translation_f
			translation_in_context_feature := translation_in_context_f
			plural_translation_in_context_feature := plural_translation_in_context_f
			feature_clause_name := feature_clause
			source_text := text
		ensure
			po_file_set: po_file = output_file
			translation_feature_set: translation_feature = translation_f
			plural_translation_feature_set: plural_translation_feature = plural_translation_f
			translation_in_context_feature_set: translation_in_context_feature = translation_in_context_f
			plural_translation_in_context_feature_set: plural_translation_in_context_feature = plural_translation_in_context_f
			feature_clause_name_set: feature_clause_name = feature_clause
			source_file_name_set: source_file_name = source_name
			source_text_set: source_text = text
		end

feature -- Access

	po_file: PO_FILE
		-- Po file to generate entries in.

	translation_feature: STRING_32
		-- Name of translate feature in i18n

	plural_translation_feature: STRING_32
		-- Name of plural_translate feature in i18n

	translation_in_context_feature: STRING_32
		-- Name of translation in context feature in context in i18n

	plural_translation_in_context_feature: STRING_32
		-- Name of plural translation in context feature in i18n

	feature_clause_name: STRING_32
		-- Feature clause name to extract translations from

	source_file_name: STRING_32
		-- Source file name.

	source_text: READABLE_STRING_32
		-- Source file text.

feature {NONE} -- Status report

	is_extracting_strings: BOOLEAN
			-- Indicates if strings are extracted for internationalization

feature {NONE} -- Implementation

	analyse_call (node: ACCESS_FEAT_AS)
			-- Analyze if call which `node' represents is a call to a translate feature.
			--
			-- `node': AST node of a feature call which is analyzed
		local
			l_feature_name: STRING_32
		do
			last_analysis_found_entry := False
			if attached node.parameters as p then
				l_feature_name := node.access_name_32
				if l_feature_name /= Void and then l_feature_name.is_case_insensitive_equal (translation_feature) then
					if attached {STRING_AS} p.first as l_singular then
						add_singular_entry (l_singular, Void)
						last_analysis_found_entry := True
					end
				elseif l_feature_name /= Void and then l_feature_name.is_case_insensitive_equal (plural_translation_feature) then
					if
						attached {STRING_AS} p.first as l_singular and then
						attached {STRING_AS} p.i_th (p.lower+1) as l_plural
					then
						add_plural_entry (l_singular, l_plural, Void)
						last_analysis_found_entry := True
					end
				elseif l_feature_name /= Void and then l_feature_name.is_case_insensitive_equal (translation_in_context_feature) then
					if
						attached {STRING_AS} p.first as l_singular and then
						attached {STRING_AS} p.i_th (p.lower+1) as l_context
					then
						add_singular_entry (l_singular, l_context)
						last_analysis_found_entry := True
					end
				elseif l_feature_name /= Void and then l_feature_name.is_case_insensitive_equal (plural_translation_in_context_feature) then
					if
						attached {STRING_AS} p.first as l_singular and then
						attached {STRING_AS} p.i_th (p.lower+1) as l_plural and then
						attached {STRING_AS} p.i_th (p.lower+2) as l_context
					then
						add_plural_entry (l_singular, l_plural, l_context)
						last_analysis_found_entry := True
					end
				end
			end
		end

	analyse_feature_clause (node: FEATURE_CLAUSE_AS)
			-- Analyze if a feature clause is an internationalized feature clause.
			--
			-- `node': AST node of a feature clause which is analyzed
		local
			l_comment: EIFFEL_COMMENTS
			l_line: EIFFEL_COMMENT_LINE
			l_string: STRING_32
			i, l_count: INTEGER
		do
			l_comment := node.comment (match_list)
			if l_comment /= Void and then not l_comment.is_empty then
				l_line := l_comment.first
				if l_line /= Void then
					l_string := l_line.content_32
					if l_string /= Void then
						l_string.left_adjust
						l_string.right_adjust
						if not l_string.is_empty then
							from
								i := 1
								l_count := l_string.count
							until
								i > l_count or else not l_string.item (i).is_alpha_numeric
							loop
								i := i + 1
							end
							if i <= l_count then
								l_string.keep_head (i - 1)
							end
								-- Check if the feature clause name matches the set feature clause name.
							if l_string.is_case_insensitive_equal (feature_clause_name) then
								is_extracting_strings := True
							end
						end
					end
				end
			end
		end

	analyse_agent_routine_creation (node: AGENT_ROUTINE_CREATION_AS)
			-- Analyze if agent creation AS contain something like:
			-- agent translation_manager.translation ("Name"))
			-- or
			-- agent translation ("Name"))
			--
			-- `node': AST node of a agent routine creation
		local
			l_feature_name: STRING_32
		do
			last_analysis_found_entry := False
				-- Case: agent translation ("Name")) and agent target.translation ("Name"))
			if attached node.feature_name as l_f then
				l_feature_name := l_f.name_32
				if attached node.operands as l_operands then
					if l_feature_name.is_case_insensitive_equal (translation_feature) then
						if l_operands.count = 1 and then attached {STRING_AS} l_operands.first.expression as l_singular then
							add_singular_entry (l_singular, Void)
							last_analysis_found_entry := True
						end
					elseif l_feature_name.is_case_insensitive_equal (plural_translation_feature) then
						if
							l_operands.count = 3 and then
							attached {STRING_AS} l_operands.i_th (1).expression as l_singular and then
							attached {STRING_AS} l_operands.i_th (2).expression as l_plural
						then
							add_plural_entry (l_singular, l_plural, Void)
							last_analysis_found_entry := True
						end
					elseif l_feature_name.is_case_insensitive_equal (translation_in_context_feature) then
						if l_operands.count = 2 and then attached {STRING_AS} l_operands.first.expression as l_singular and then attached {STRING_AS} l_operands.i_th (2) as l_context then
							add_singular_entry (l_singular, l_context)
							last_analysis_found_entry := True
						end
					elseif l_feature_name.is_case_insensitive_equal (plural_translation_in_context_feature) then
						if
							l_operands.count = 4 and then
							attached {STRING_AS} l_operands.i_th (1).expression as l_singular and then
							attached {STRING_AS} l_operands.i_th (2).expression as l_plural and then
							attached {STRING_AS} l_operands.i_th (3).expression as l_context
						then
							add_plural_entry (l_singular, l_plural, l_context)
							last_analysis_found_entry := True
						end
					end
				end
			end
		end

	process_access_id_as (l_as: ACCESS_ID_AS)
			-- Process `l_as'.
			--
			-- `l_as': AST node representing an access on an identifier
		local
			l_old_extracting: like is_extracting_strings
		do
			l_old_extracting := is_extracting_strings
				-- Disable further extracting when we found any entry.
			analyse_call (l_as)
			if last_analysis_found_entry then
				is_extracting_strings := False
			end
			Precursor (l_as)
			is_extracting_strings := l_old_extracting
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
			-- Process `l_as'.
			--
			-- `l_as': AST node representing an access on a feature
		local
			l_old_extracting: like is_extracting_strings
		do
			l_old_extracting := is_extracting_strings
				-- Disable further extracting when we found any entry.
			analyse_call (l_as)
			if last_analysis_found_entry then
				is_extracting_strings := False
			end
			Precursor (l_as)
			is_extracting_strings := l_old_extracting
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS)
			-- Process `l_as'.
		local
			l_old_extracting: like is_extracting_strings
		do
			l_old_extracting := is_extracting_strings
				-- Disable further extracting when we found any entry.
			analyse_agent_routine_creation (l_as)
			if last_analysis_found_entry then
				is_extracting_strings := False
			end
			Precursor (l_as)
			is_extracting_strings := l_old_extracting
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
			-- <Precursor>
		do
			analyse_feature_clause (l_as)
			Precursor (l_as)
			is_extracting_strings := False
		ensure then
			not_is_extracting_strings: not is_extracting_strings
		end

	process_string_as (l_as: STRING_AS)
			-- <Precursor>
		do
			if is_extracting_strings then
				add_singular_entry (l_as, Void)
			end
			Precursor (l_as)
		end

feature {NONE} -- Implementation

	current_line (a_pos: INTEGER; a_text: READABLE_STRING_32): READABLE_STRING_32
			-- Line text at `a_pos'
		require
			a_text_not_void: a_text /= Void
			a_pos_valid: a_pos <= a_text.count
		local
			l_start, l_end: INTEGER
		do
			l_start := a_text.last_index_of ('%N', a_pos)
			l_end := a_text.index_of ('%N', a_pos)
			if l_start = 0 then
				Result := a_text.substring (1, l_end - 1)
			elseif l_end = 0 then
				Result := a_text.substring (l_start + 1, a_text.count)
			else
				Result := a_text.substring (l_start + 1, l_end - 1)
			end
		ensure
			Result_not_void: Result /= Void
		end

	append_comments (a_as: LOCATION_AS; a_node: PO_FILE_ENTRY)
			-- Append comments to `a_node'.
		require
			a_as_not_void: a_as /= Void
			a_node_not_void: a_node /= Void
		local
			l_line: STRING_32
		do
				-- Extract source code.
			if a_as.position <= source_text.count then
				l_line := current_line (a_as.position, source_text)
				l_line.left_adjust
				l_line.right_adjust
				a_node.add_automatic_comment ({STRING_32} "Source code: " + l_line)
			end
				-- Append location.
			a_node.add_reference_comment (source_file_name + ":" + a_as.line.out)
		end

	add_singular_entry (l_as: STRING_AS; a_context: detachable STRING_AS)
			-- Add singular entry into the po file, if possible
		require
			l_as_not_void: attached l_as
		local
			singular_entry: PO_FILE_ENTRY_SINGULAR
			l_msgid, l_msgctxt: STRING_32
		do
			l_msgid := l_as.value_32
			handle_special_chars (l_msgid)
			if attached a_context and then not a_context.value_32.is_empty then
				l_msgctxt := a_context.value_32
				handle_special_chars (l_msgctxt)
			end
			if not po_file.has_entry (l_msgid, l_msgctxt) then
				create singular_entry.make (source_file_name, l_msgid)
				singular_entry.set_msgctxt (l_msgctxt)
				append_comments (l_as, singular_entry)
				po_file.add_entry (singular_entry)
			else
				if attached l_msgctxt then
					localized_print ({STRING_32} "WARNING: Replicate found: %"" + l_msgid + "%" in context %"" + l_msgctxt + "%"%N")
				else
					localized_print ({STRING_32} "WARNING: Same message found: %"" + l_msgid + "%"%N")
				end
				if
					attached po_file.entry (l_msgid, l_msgctxt) as l_entry and then
					attached l_entry.source_name as l_name
				then
					localized_print ({STRING_32} "%TExising entry: " + l_name + "%N")
				end
			end
		end

	add_plural_entry (l_as_1, l_as_2: STRING_AS; a_context: detachable STRING_AS)
			-- Add single entry into the po file, if possible
		require
			l_as_not_void: attached l_as_1 and attached l_as_2
		local
			plural_entry: PO_FILE_ENTRY_PLURAL
			l_msgid, l_msgctxt: STRING_32
		do
			l_msgid := l_as_1.value_32
			handle_special_chars (l_msgid)
			if attached a_context and then not a_context.value_32.is_empty then
				l_msgctxt := a_context.value_32
				handle_special_chars (l_msgctxt)
			end
			if not po_file.has_entry (l_msgid, l_msgctxt) then
				create plural_entry.make (source_file_name, l_msgid)
				plural_entry.set_msgctxt (l_msgctxt)
				l_msgid := l_as_2.value_32
				handle_special_chars (l_msgid)
				plural_entry.set_msgid_plural (l_msgid)
				append_comments (l_as_1, plural_entry)
				po_file.add_entry (plural_entry)
			else
				if attached l_msgctxt then
					localized_print ({STRING_32} "WARNING: Same message found: %"" + l_msgid + "%" in context %"" + l_msgctxt + "%"%N")
				else
					localized_print ({STRING_32} "WARNING: Same message found: %"" + l_msgid + "%"%N")
				end
				if
					attached po_file.entry (l_msgid, l_msgctxt) as l_entry and then
					attached l_entry.source_name as l_name
				then
					localized_print ({STRING_32} "%TExising entry: " + l_name + "%N")
				end
			end
		end

	handle_special_chars (a_s: STRING_32)
			-- Replace "%"" with "\%"".
			-- Replace "\" with "\\".
			-- Replace "%N" with "\n".
		require
			a_s_not_void: a_s /= Void
		do
			a_s.replace_substring_all ({STRING_32} "\", {STRING_32} "\\")
			a_s.replace_substring_all ({STRING_32} "%"", {STRING_32} "\%"")
			a_s.replace_substring_all ({STRING_32} "%N", {STRING_32} "\n")
			a_s.replace_substring_all ({STRING_32} "%T", {STRING_32} "\t")
		end

	last_analysis_found_entry: BOOLEAN;
			-- Did last analysis find an entry?

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
