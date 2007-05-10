indexing
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
			process_access_id_as
		end

	CHARACTER_ROUTINES

feature -- Access

	po_file: PO_FILE
		-- Po file to generate entries in.

	translate_feature : STRING
		-- Name of translate feature in i18n

	translate_plural_feature: STRING
		-- Name of plural_translate feature in i18n

	source_file_name: STRING
		-- Source file name.

	source_text: STRING
		-- Source file text.

	set_translate_feature (a: like translate_feature) is
			-- Set translator function name
		require
			a_not_void: a /= Void
		do
			translate_feature := a
		ensure
			a_set: a.is_equal (translate_feature)
		end

	set_translate_plural_feature (a: like translate_plural_feature) is
			-- Set plural translator function name
		require
			a_not_void: a /= Void
		do
			translate_plural_feature := a
		ensure
			a_set: a.is_equal (translate_plural_feature)
		end

	set_po_file (po: PO_FILE) is
			-- Set the `po_file'.
		require
			po_not_void: po /= Void
		do
			po_file := po
		end

	set_source_file_name (a_str: STRING) is
			-- Set `source_file_name' with `a_str'.
		do
			source_file_name := a_str
		ensure
			source_file_name_set: source_file_name = a_str
		end

	set_source_text (a_file: STRING) is
			-- Set `source_text' with `a_file'.
		do
			source_text := a_file
		ensure
			source_text_set: source_text = a_file
		end

feature {NONE} -- Implementation

	analyse_call(node: ACCESS_FEAT_AS) is
		local
			l_feature_name: STRING
			param1: STRING_AS
			param2: STRING_AS
			plural_entry: PO_FILE_ENTRY_PLURAL
			singular_entry: PO_FILE_ENTRY_SINGULAR
			temp:  STRING_32
		do
			l_feature_name := node.access_name
			if l_feature_name /= Void and then l_feature_name.is_case_insensitive_equal (translate_feature) then
				if node.parameters /= Void then
					param1 ?= node.parameters.first
					if param1 /= Void then
						temp := param1.value.as_string_32
						handle_special_chars (temp)
						if (not po_file.has_entry (temp)) then
							create singular_entry.make (utf8_string (temp))
							append_comments (param1, singular_entry)
							po_file.add_entry (singular_entry)
						end
					end
				end
			elseif l_feature_name /= Void and then l_feature_name.is_case_insensitive_equal (translate_plural_feature) then
				if node.parameters /= Void then
					param1 ?= node.parameters.first
					param2 ?= node.parameters.i_th (node.parameters.index_set.lower+1) --should be 2d item :)
					if param1 /= Void and then param2 /= Void then
						temp := param1.value.as_string_32
						handle_special_chars (temp)
						if (not po_file.has_entry(temp)) then
							create plural_entry.make (utf8_string (temp))
							temp := param2.value.as_string_32
							handle_special_chars (temp)
							plural_entry.set_msgid_plural (utf8_string (temp))
							append_comments (param1, plural_entry)
							po_file.add_entry (plural_entry)
						end
					end
				end
			end
		end

	process_access_id_as(l_as: ACCESS_ID_AS) is
			-- eh?
		do
			analyse_call(l_as)
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
			-- process a feature
			-- what do we want from a feature?
			-- it must be a feature call to feature i18n of SHARED_I18N_LOCALIZATOR
			-- (check others later)
		do
			analyse_call(l_as)
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

feature {NONE} -- Implementation

	utf8: UC_UTF8_ROUTINES is
			-- UTF8 routines
		once
			create Result
		end

	utf8_string (a_string: STRING_32): STRING is
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

	current_line (a_pos: INTEGER; a_text: STRING): STRING is
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

	append_comments (a_as: LOCATION_AS; a_node: PO_FILE_ENTRY) is
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
				a_node.add_automatic_comment (utf8_string ("Source code: " + l_line))
			end
				-- Append location.
			if source_file_name /= Void then
				a_node.add_reference_comment (utf8_string (source_file_name + ":" + a_as.line.out))
			end
		end

	handle_special_chars (a_s: STRING_32) is
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

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
