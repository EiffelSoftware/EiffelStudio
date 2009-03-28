note
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

	fill_from_key_value (a_key: attached STRING;
						a_value: attached STRING;
						a_eis_tuple: attached TUPLE [
											name: STRING_32;
											protocol: STRING_32;
											source: STRING_32;
											tags: ARRAY [STRING_32];
											id: STRING;
											others: HASH_TABLE [STRING_32, STRING_32]])
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
				a_eis_tuple.others.force (a_value, a_key)
			end
		end

	eis_entry_from_index (a_index: attached INDEX_AS; a_eis_id: detachable STRING): detachable EIS_ENTRY
			-- EIS entry from `a_clause'
		local
			l_index_list: EIFFEL_LIST [ATOMIC_AS]
			l_atomic: ATOMIC_AS
			l_attribute_pair: attached STRING
			l_others: attached HASH_TABLE [STRING_32, STRING_32]
			l_tags: attached ARRAYED_LIST [STRING_32]

			l_entry_tuple: attached TUPLE [
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
					if attached {STRING} l_atomic.string_value as lt_string then
						create l_attribute_pair.make_from_string (lt_string.twin)
						l_attribute_pair.left_adjust
						l_attribute_pair.right_adjust
						l_attribute_pair.prune_all_leading ('"')
						l_attribute_pair.prune_all_trailing ('"')
						l_attribute_pair.left_adjust
						l_attribute_pair.right_adjust
						if attribute_regex_matcher.matches (l_attribute_pair) then
							if
								attached {STRING} attribute_regex_matcher.captured_substring (1) as lt_key and then
								attached {STRING} attribute_regex_matcher.captured_substring (2) as lt_value
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
					-- Set them to Void if empty.
				if l_entry_tuple.tags /= Void and then l_entry_tuple.tags.is_empty then
					l_entry_tuple.tags := Void
				end
				if l_entry_tuple.others /= Void and then l_entry_tuple.others.is_empty then
					l_entry_tuple.others := Void
				end
				create Result.make (l_entry_tuple.name, l_entry_tuple.protocol, l_entry_tuple.source, l_entry_tuple.tags, l_entry_tuple.id, l_entry_tuple.others)
			end
		end

	eis_entry_from_conf_note (a_note: CONF_NOTE_ELEMENT; l_id: attached STRING): detachable EIS_ENTRY
			-- EIS entry from conf note element.
		local
			l_attributes: HASH_TABLE [STRING, STRING]
			l_others: attached HASH_TABLE [STRING_32, STRING_32]
			l_tags: attached ARRAYED_LIST [STRING_32]
			l_entry_tuple: attached TUPLE [
							name: STRING_32;
							protocol: STRING_32;
							source: STRING_32;
							tags: ARRAYED_LIST [STRING_32];
							id: STRING;
							others: HASH_TABLE [STRING_32, STRING_32]]
		do
			if a_note /= Void then
				if a_note.element_name.is_case_insensitive_equal ({ES_EIS_TOKENS}.eis_string) then
					create l_entry_tuple
					l_entry_tuple.id := l_id
					create l_others.make (3)
					create l_tags.make (2)
					l_entry_tuple.others := l_others
					l_entry_tuple.tags := l_tags
					l_attributes := a_note.attributes
					from
						l_attributes.start
					until
						l_attributes.after
					loop
						if
							attached {STRING} l_attributes.key_for_iteration as lt_key and then
							attached {STRING} l_attributes.item_for_iteration as lt_value
						then
							lt_key.left_adjust
							lt_key.right_adjust
							lt_value.left_adjust
							lt_value.right_adjust
							fill_from_key_value (lt_key, lt_value, l_entry_tuple)
						end
						l_attributes.forth
					end
						-- Set them to Void if empty.
					if l_entry_tuple.tags /= Void and then l_entry_tuple.tags.is_empty then
						l_entry_tuple.tags := Void
					end
					if l_entry_tuple.others /= Void and then l_entry_tuple.others.is_empty then
						l_entry_tuple.others := Void
					end
					create Result.make (l_entry_tuple.name, l_entry_tuple.protocol, l_entry_tuple.source, l_entry_tuple.tags, l_entry_tuple.id, l_entry_tuple.others)
				end
			end
		end

	parse_tags (a_tag_string: attached STRING): attached ARRAYED_LIST [STRING_32]
			-- Parse `a_tag_string' into an array.
			-- tag string should be in the form of "tag1, tag2, tag3"
		do
			if attached {STRING_32} a_tag_string.as_string_32 as lt_tag_string then
				if attached {ARRAYED_LIST [STRING_32]} lt_tag_string.split ({ES_EIS_TOKENS}.tag_seperator) as lt_splitted then
					lt_splitted.do_all (
							agent (aa_string: STRING_32)
								do
									check aa_string_not_void: aa_string /= Void end
									aa_string.left_adjust
									aa_string.right_adjust
								end)
					Result := lt_splitted
						-- Empty string is not needed.
					if Result.count = 1 and then Result.i_th (1).count = 0 then
						Result.wipe_out
					end
				else
					create Result.make (0)
				end
			else
				create Result.make (0)
			end
		end

	parse_others (a_others_string: attached STRING_32): attached HASH_TABLE [STRING_32, STRING_32]
			-- Parse `a_others_string' into an array.
			-- others string should be in the form of
			-- "other1=value1, other2=value2, other3=value3"
			-- Or ""other1=value1", other2=value2, "other3=value3""
		do
			if attached {STRING_32} a_others_string as lt_tag_string then
				if attached {ARRAYED_LIST [STRING_32]} lt_tag_string.split ({ES_EIS_TOKENS}.attribute_seperator) as lt_splitted then
					create Result.make (1)
					lt_splitted.do_all (
							agent (aa_string: attached STRING_32; a_result: attached HASH_TABLE [STRING_32, STRING_32])
								do
									aa_string.left_adjust
									aa_string.right_adjust
									aa_string.prune_all_leading ('"')
									aa_string.prune_all_trailing ('"')
									aa_string.left_adjust
									aa_string.right_adjust
									if attribute_regex_matcher.matches (aa_string) then
										if
											attached {STRING} attribute_regex_matcher.captured_substring (1) as lt_key and then
											attached {STRING} attribute_regex_matcher.captured_substring (2) as lt_value
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

	attribute_regex_matcher: attached RX_PCRE_MATCHER
		once
			create Result.make
			Result.compile ("^(\w+)=(.*)$")
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
