note
	description: "[
				This class iterates over asts of classes, extracts the arguments to the translation functions from the i18n 
				library, generates appropriate PO_ENTRYs for them and adds them to a PO_FILE.
				To use it one should call set_po_file, set_translate_feature, set_translate_plural_feature and setup first.
				Then it is sufficient to do an process_node_as on the ast in question.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "leof@student.ethz.ch"
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

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Access

	po_file: PO_FILE
		-- Po file to generate entries in.

	translate_feature : STRING
		-- Name of translate feature in i18n

	translate_plural_feature: STRING
		-- Name of plural_translate feature in i18n

	feature_clause_name: STRING
		-- Feature clause name to extract translations from

	source_file_name: STRING
		-- Source file name.

	source_text: STRING
		-- Source file text.

feature -- Element change

	set_translate_feature (a: like translate_feature)
			-- Set translator function name to `a'.
		require
			a_not_void: a /= Void
		do
			translate_feature := a
		ensure
			a_set: a.is_equal (translate_feature)
		end

	set_translate_plural_feature (a: like translate_plural_feature)
			-- Set plural translator function name to `a'.
		require
			a_not_void: a /= Void
		do
			translate_plural_feature := a
		ensure
			a_set: a.is_equal (translate_plural_feature)
		end

	set_feature_clause_name (a: like feature_clause_name)
			-- Set translator feature clause name to `a'.
		require
			a_not_void: a /= Void
		do
			feature_clause_name := a
		ensure
			a_set: a.is_equal (feature_clause_name)
		end

	set_po_file (po: PO_FILE)
			-- Set `po_file' to `po'.
		require
			po_not_void: po /= Void
		do
			po_file := po
		ensure
			po_file_set: po_file = po
		end

	set_source_file_name (a_str: STRING)
			-- Set `source_file_name' to `a_str'.
		require
			a_str_not_void: a_str /= Void
		do
			source_file_name := a_str
		ensure
			source_file_name_set: source_file_name = a_str
		end

	set_source_text (a_file: STRING)
			-- Set `source_text' to `a_file'.
		require
			a_file_not_void: a_file /= Void
		do
			source_text := a_file
		ensure
			source_text_set: source_text = a_file
		end

feature {NONE} -- Status report

	is_extracting_strings: BOOLEAN
			-- Indicates if strings are extracted for internationalization

feature {NONE} -- Implementation

	analyse_call (node: ACCESS_FEAT_AS)
			-- Analyze if call which `node' represents is a call to a translate feature.
			--
			-- `node': AST node of a feature call which is analyzed
		local
			l_feature_name: STRING
			param1: STRING_AS
			param2: STRING_AS
		do
			l_feature_name := node.access_name
			if l_feature_name /= Void and then l_feature_name.is_case_insensitive_equal (translate_feature) then
				if node.parameters /= Void then
					param1 ?= node.parameters.first
					if param1 /= Void then
						add_singular_entry (param1)
					end
				end
			elseif l_feature_name /= Void and then l_feature_name.is_case_insensitive_equal (translate_plural_feature) then
				if node.parameters /= Void then
					param1 ?= node.parameters.first
					param2 ?= node.parameters.i_th (node.parameters.index_set.lower+1) --should be 2d item :)
					if param1 /= Void and then param2 /= Void then
						add_plural_entry (param1, param2)
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
			l_string: STRING
			i, l_count: INTEGER
		do
			l_comment := node.comment (match_list)
			if l_comment /= Void and then not l_comment.is_empty then
				l_line := l_comment.first
				if l_line /= Void then
					l_string := l_line.content
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
			l_feature_name: STRING
		do
				-- Case: agent translation ("Name")) and agent target.translation ("Name"))
			if attached node.feature_name as l_f then
				l_feature_name := l_f.name
				if attached node.operands as l_operands then
					if l_feature_name.is_case_insensitive_equal (translate_feature) then
						if l_operands.count = 1 and then attached {STRING_AS} l_operands.first.expression as l_param then
							add_singular_entry (l_param)
						end
					elseif l_feature_name.is_case_insensitive_equal (translate_plural_feature) then
						if
							l_operands.count = 3 and then
							attached {STRING_AS} l_operands.i_th (1).expression as l_param1 and then
							attached {STRING_AS} l_operands.i_th (2).expression as l_param2
						then
							add_plural_entry (l_param1, l_param2)
						end
					end
				end
			end
		end

	process_access_id_as (l_as: ACCESS_ID_AS)
			-- Process `l_as'.
			--
			-- `l_as': AST node representing an access on an identifier
		do
			analyse_call(l_as)
			Precursor (l_as)
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
			-- Process `l_as'.
			--
			-- `l_as': AST node representing an access on a feature
		do
			analyse_call(l_as)
			Precursor (l_as)
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS)
			-- Process `l_as'.
		do
			analyse_agent_routine_creation (l_as)
			Precursor (l_as)
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
				add_singular_entry (l_as)
			end
			Precursor (l_as)
		end

feature {NONE} -- Implementation

	utf8: UC_UTF8_ROUTINES
			-- UTF8 routines
		once
			create Result
		end

	utf8_string (a_string: STRING_32): STRING
			-- Convert `a_string' to UTF-8 encoding
			-- This function also writes 5 and 6-bytes characters, which are not part of the UTF-8 standard
		require
			string_not_void: a_string /= Void
		local
			i: INTEGER
		do
			check
				a_string_is_valid_string_8: a_string.is_valid_as_string_8
			end
			create Result.make (a_string.count)
			from
				i := 1
			until
				i > a_string.count
			loop
				utf8.append_code_to_utf8 (Result, a_string.item_code (i))
				i := i + 1
			end
		end

	current_line (a_pos: INTEGER; a_text: STRING): STRING
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
				-- We need to do this for the moment, because the source comes from the file directly.
				-- Nothing guarentee UTF-8 encoding. There can be source converted into wrong character
				-- because of encoding mismatching. But it is not that important in comment for now.
				-- And it is much better than producing invalid text. (non-utf-8)
			Result := utf8_string (Result)
		ensure
			Result_not_void: Result /= Void
		end

	append_comments (a_as: LOCATION_AS; a_node: PO_FILE_ENTRY)
			-- Append comments to `a_node'.
		require
			a_as_not_void: a_as /= Void
			a_node_not_void: a_node /= Void
		local
			l_line: STRING
		do
				-- Extract source code.
			if source_text /= Void and then a_as.position <= source_text.count then
				l_line := current_line (a_as.position, source_text)
				l_line.left_adjust
				l_line.right_adjust
				a_node.add_automatic_comment ("Source code: " + l_line)
			end
				-- Append location.
			if source_file_name /= Void then
				a_node.add_reference_comment (source_file_name + ":" + a_as.line.out)
			end
		end

	add_singular_entry (l_as: STRING_AS)
			-- Add singular entry into the po file, if possible
		require
			l_as_not_void: attached l_as
		local
			singular_entry: PO_FILE_ENTRY_SINGULAR
			temp: STRING -- utf8
		do
			temp := l_as.value
			handle_special_chars (temp)
			if (not po_file.has_entry (temp)) then
				create singular_entry.make (temp)
				append_comments (l_as, singular_entry)
				po_file.add_entry (singular_entry)
			end
		end

	add_plural_entry (l_as_1, l_as_2: STRING_AS)
			-- Add single entry into the po file, if possible
		require
			l_as_not_void: attached l_as_1 and attached l_as_2
		local
			plural_entry: PO_FILE_ENTRY_PLURAL
			temp: STRING -- utf8
		do
			temp := l_as_1.value
			handle_special_chars (temp)
			if (not po_file.has_entry(temp)) then
				create plural_entry.make (temp)
				temp := l_as_2.value
				handle_special_chars (temp)
				plural_entry.set_msgid_plural (temp)
				append_comments (l_as_1, plural_entry)
				po_file.add_entry (plural_entry)
			end
		end

	handle_special_chars (a_s: STRING)
			-- Replace "%"" with "\%"".
			-- Replace "\" with "\\".
			-- Replace "%N" with "\n".
		require
			a_s_not_void: a_s /= Void
		do
			a_s.replace_substring_all ("\", "\\")
			a_s.replace_substring_all ("%"", "\%"")
			a_s.replace_substring_all ("%N", "\n")
			a_s.replace_substring_all ("%T", "\t")
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
