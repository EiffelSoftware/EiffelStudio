indexing
	description: "Extractor used to eis entry from a piece of note/indexing clause"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_NOTE_PICKER

inherit
	ES_EIS_SHARED

feature {NONE} -- Implementation

	fill_from_key_value (a_key: !STRING;
						a_value: !STRING;
						a_eis_tuple: !TUPLE [
											name: STRING_32;
											protocol: STRING_32;
											source: STRING_32;
											tags: ARRAY [STRING_32];
											id: STRING;
											others: HASH_TABLE [STRING_32, STRING_32]]) is
			-- Fill `a_eis_tuple' from `a_key' and `a_value'.
			-- There is still problem of the attached type for tuples.
		require
			tags_not_void: a_eis_tuple.tags /= Void
			others_not_void: a_eis_tuple.others /= Void
		do
			if a_eis_tuple.name = Void and then a_key.is_case_insensitive_equal ({ES_EIS_TOKENS}.name_string) then
				a_eis_tuple.name := a_value
			elseif a_eis_tuple.protocol = Void and then a_key.is_case_insensitive_equal ({ES_EIS_TOKENS}.protocol_string) then
				a_eis_tuple.protocol := a_value
			elseif a_eis_tuple.source = Void and then a_key.is_case_insensitive_equal ({ES_EIS_TOKENS}.source_string) then
				a_eis_tuple.source := a_value
			elseif a_key.is_case_insensitive_equal ({ES_EIS_TOKENS}.tag_string) then
						-- To add more tags support.
				a_eis_tuple.tags := parse_tags (a_value)
			else
					-- Others
				if not a_key.is_case_insensitive_equal ({ES_EIS_TOKENS}.ise_support_string) then
					a_eis_tuple.others.force (a_value, a_key)
				end
			end
		end

	eis_entry_from_index (a_index: !INDEX_AS; a_eis_id: ?STRING): ?EIS_ENTRY is
			-- EIS entry from `a_clause'
		local
			l_index_list: EIFFEL_LIST [ATOMIC_AS]
			l_atomic: ATOMIC_AS
			l_attribute_pair: !STRING
			l_others: !HASH_TABLE [STRING_32, STRING_32]
			l_tags: !ARRAYED_LIST [STRING_32]

			l_entry_tuple: !TUPLE [
							name: STRING_32;
							protocol: STRING_32;
							source: STRING_32;
							tags: ARRAYED_LIST [STRING_32];
							id: STRING;
							others: HASH_TABLE [STRING_32, STRING_32]]
		do
			if a_index.tag /= Void and then a_index.tag.name.is_case_insensitive_equal ({ES_EIS_TOKENS}.eis_string) then
				l_index_list := a_index.index_list
				l_entry_tuple := [Void, Void, Void, Void, Void, Void]
				create l_others.make (3)
				create l_tags.make (2)
				l_entry_tuple.others := l_others
				l_entry_tuple.tags := l_tags
				l_entry_tuple.id := a_eis_id
				from
					l_index_list.start
				until
					l_index_list.after
				loop
					l_atomic := l_index_list.item_for_iteration
					if {lt_string: STRING}l_atomic.string_value then
						create l_attribute_pair.make_from_string (lt_string.twin)
						l_attribute_pair.left_adjust
						l_attribute_pair.right_adjust
						l_attribute_pair.prune_all_leading ('"')
						l_attribute_pair.prune_all_trailing ('"')
						l_attribute_pair.left_adjust
						l_attribute_pair.right_adjust
						if attribute_regex_matcher.matches (l_attribute_pair) then
							if
								{lt_key: STRING}attribute_regex_matcher.captured_substring (1) and then
								{lt_value: STRING}attribute_regex_matcher.captured_substring (2)
							then
								lt_key.left_adjust
								lt_key.right_adjust
								lt_value.left_adjust
								lt_value.right_adjust
								fill_from_key_value (lt_key, lt_value, l_entry_tuple)
							end
						else
								-- Don't recognize the attribute
								-- Put it into others as key, and put in value a `void_string' token.
							l_entry_tuple.others.force ({ES_EIS_TOKENS}.void_string, l_attribute_pair)
						end
					end
					l_index_list.forth
				end
				create Result.make (l_entry_tuple.name, l_entry_tuple.protocol, l_entry_tuple.source, l_entry_tuple.tags, l_entry_tuple.id, l_entry_tuple.others)
			end
		end

	eis_entry_from_conf_note (a_note: HASH_TABLE [STRING, STRING]; l_id: !STRING): ?EIS_ENTRY is
			-- EIS entry from conf note element.
		local
			l_others: !HASH_TABLE [STRING_32, STRING_32]
			l_tags: !ARRAYED_LIST [STRING_32]
			l_entry_tuple: !TUPLE [
							name: STRING_32;
							protocol: STRING_32;
							source: STRING_32;
							tags: ARRAYED_LIST [STRING_32];
							id: STRING;
							others: HASH_TABLE [STRING_32, STRING_32]]
		do
			if a_note /= Void then
				a_note.search ({ES_EIS_TOKENS}.ise_support_string)
				if a_note.found and then a_note.found_item.is_case_insensitive_equal ({ES_EIS_TOKENS}.eis_string) then
					create l_entry_tuple
					l_entry_tuple.id := l_id
					create l_others.make (3)
					create l_tags.make (2)
					l_entry_tuple.others := l_others
					l_entry_tuple.tags := l_tags
					from
						a_note.start
					until
						a_note.after
					loop
						if
							{lt_key: STRING}a_note.key_for_iteration and then
							{lt_value: STRING}a_note.item_for_iteration
						then
							lt_key.left_adjust
							lt_key.right_adjust
							lt_value.left_adjust
							lt_value.right_adjust
							fill_from_key_value (lt_key, lt_value, l_entry_tuple)
						end
						a_note.forth
					end
					create Result.make (l_entry_tuple.name, l_entry_tuple.protocol, l_entry_tuple.source, l_entry_tuple.tags, l_entry_tuple.id, l_entry_tuple.others)
				end
			end
		end

	parse_tags (a_tag_string: !STRING): !ARRAYED_LIST [!STRING_32] is
			-- Parse `a_tag_string' into an array.
			-- tag string should be in the form of "tag1, tag2, tag3"
		do
			if {lt_tag_string: STRING_32}a_tag_string.as_string_32 then
				if {lt_splitted: !ARRAYED_LIST [!STRING_32]}lt_tag_string.split ({ES_EIS_TOKENS}.tag_seperator) then
					lt_splitted.do_all (
							agent (aa_string: !STRING_32)
								do
									aa_string.left_adjust
									aa_string.right_adjust
								end)
					Result := lt_splitted
				else
					create Result.make (0)
				end
			else
				create Result.make (0)
			end
		end

	parse_others (a_others_string: !STRING_32): !HASH_TABLE [STRING_32, STRING_32] is
			-- Parse `a_others_string' into an array.
			-- others string should be in the form of
			-- "other1=value1, other2=value2, other3=value3"
			-- Or ""other1=value1", other2=value2, "other3=value3""
		do
			if {lt_tag_string: STRING_32}a_others_string then
				if {lt_splitted: !ARRAYED_LIST [!STRING_32]}lt_tag_string.split ({ES_EIS_TOKENS}.attribute_seperator) then
					create Result.make (1)
					lt_splitted.do_all (
							agent (aa_string: !STRING_32; a_result: !HASH_TABLE [STRING_32, STRING_32])
								do
									aa_string.left_adjust
									aa_string.right_adjust
									aa_string.prune_all_leading ('"')
									aa_string.prune_all_trailing ('"')
									aa_string.left_adjust
									aa_string.right_adjust
									if attribute_regex_matcher.matches (aa_string) then
										if
											{lt_key: STRING}attribute_regex_matcher.captured_substring (1) and then
											{lt_value: STRING}attribute_regex_matcher.captured_substring (2)
										then
											lt_key.left_adjust
											lt_key.right_adjust
											lt_value.left_adjust
											lt_value.right_adjust
											a_result.force (lt_value.as_string_32, lt_key.as_string_32)
										end
									end
								end (?, Result))
				else
					create Result.make (0)
				end
			else
				create Result.make (0)
			end
		end

feature {NONE} -- Implemetation

	attribute_regex_matcher: !RX_PCRE_MATCHER is
		once
			create Result.make
			Result.compile ("^(\w+)=(.*)$")
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
