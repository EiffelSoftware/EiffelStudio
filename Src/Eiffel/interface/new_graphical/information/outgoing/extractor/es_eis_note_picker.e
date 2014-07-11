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

	CONF_ACCESS

	SHARED_LOCALE

	INTERNAL_COMPILER_STRING_EXPORTER

	SHARED_ENCODING_CONVERTER

feature {NONE} -- Implementation

	fill_from_key_value (a_key: READABLE_STRING_GENERAL;
						a_value: STRING_32;
						a_eis_tuple: TUPLE [
											name: STRING_32;
											protocol: STRING_32;
											source: STRING_32;
											tags: ARRAYED_LIST [STRING_32];
											id: STRING;
											parameters: STRING_TABLE [STRING_32];
											override: BOOLEAN])
			-- Fill `a_eis_tuple' from `a_key' and `a_value'.
			-- There is still problem of the attached type for tuples.
		require
			a_key_not_void: a_key /= Void
			a_key_valid: not a_key.is_empty and then not a_key.item (1).is_space and then not a_key.item (a_key.count).is_space
			a_value_not_void: a_value /= Void
			a_value_valid: (not a_value.is_empty) implies not a_value.item (1).is_space and then not a_value.item (a_value.count).is_space
			a_eis_tuple_not_void: a_eis_tuple /= Void
			tags_not_void: a_eis_tuple.tags /= Void
			parameters_not_void: a_eis_tuple.parameters /= Void
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
			elseif a_key.is_case_insensitive_equal ({ES_EIS_TOKENS}.override_string) then
				if a_value.is_case_insensitive_equal ({ES_EIS_TOKENS}.true_string) then
					a_eis_tuple.override := True
				end
			else
					-- parameters
				a_eis_tuple.parameters.force (a_value, a_key)
			end
		end

	eis_entry_from_index (a_index: INDEX_AS; a_eis_id: detachable STRING): detachable EIS_ENTRY
			-- EIS entry from `a_clause'
		require
			a_index_not_void: a_index /= Void
		local
			l_index_list: EIFFEL_LIST [ATOMIC_AS]
			l_atomic: ATOMIC_AS
			l_attribute_pair: STRING
			l_parameters: STRING_TABLE [STRING_32]
			l_tags: ARRAYED_LIST [STRING_32]

			l_entry_tuple: TUPLE [
							name: STRING_32;
							protocol: STRING_32;
							source: STRING_32;
							tags: ARRAYED_LIST [STRING_32];
							id: STRING;
							parameters: STRING_TABLE [STRING_32];
							override: BOOLEAN]
			l_key, l_value, l_default: STRING_32
			l_source_pos, l_source_len: INTEGER
			l_count, l_removed_chars: INTEGER
		do
			last_source_ast := Void
			if a_index.tag /= Void and then a_index.tag.name_8.is_case_insensitive_equal ({ES_EIS_TOKENS}.eis_string) then
				l_index_list := a_index.index_list
				create l_parameters.make (3)
				create l_tags.make (2)
				l_entry_tuple := [l_default, l_default, l_default, l_tags, a_eis_id, l_parameters, False]
				from
					l_index_list.start
				until
					l_index_list.after
				loop
					l_atomic := l_index_list.item_for_iteration
						-- Parse UTF-8 string
					if attached {STRING_AS} l_atomic as lt_str_as and then attached lt_str_as.value as lt_string then
						create l_attribute_pair.make_from_string (lt_string)
						l_count := l_attribute_pair.count
						string_general_left_adjust (l_attribute_pair)
						l_removed_chars := l_count -  l_attribute_pair.count
						string_general_right_adjust (l_attribute_pair)

						l_count := l_attribute_pair.count
						l_attribute_pair.prune_all_leading ('"')
						l_removed_chars := l_removed_chars + l_count -  l_attribute_pair.count
						l_attribute_pair.prune_all_trailing ('"')

						l_count := l_attribute_pair.count
						string_general_left_adjust (l_attribute_pair)
						l_removed_chars := l_removed_chars + l_count -  l_attribute_pair.count
						string_general_right_adjust (l_attribute_pair)

						if attribute_regex_matcher.matches (l_attribute_pair) then
							if
								attached attribute_regex_matcher.captured_substring (1) as lt_key and then
								attached attribute_regex_matcher.captured_substring (2) as lt_value
							then
								l_key := encoding_converter.utf8_to_utf32 (lt_key)
								l_value := encoding_converter.utf8_to_utf32 (lt_value)
								l_removed_chars := l_removed_chars + l_key.count
								l_key.left_adjust
								l_key.right_adjust

								l_count := l_value.count
								l_value.left_adjust
								l_removed_chars := l_removed_chars + l_count - l_value.count
								l_value.right_adjust
								fill_from_key_value (l_key, l_value, l_entry_tuple)
								if l_key.is_case_insensitive_equal ({ES_EIS_TOKENS}.source_string) then
									l_removed_chars := l_removed_chars + 1 -- '"'
									l_removed_chars := l_removed_chars + 1 -- '='
										-- Character positions.
									l_source_pos := lt_str_as.character_start_position + l_removed_chars
									l_source_len := lt_str_as.character_end_position - l_source_pos -- -1 + 1 '"'
									last_source_ast := l_atomic
								end
							end
						else
								-- Don't recognize the attribute
								-- Put it into parameters as key, and put in value a `void_string' token.
							l_entry_tuple.parameters.force ({ES_EIS_TOKENS}.void_string, l_attribute_pair)
						end
					end
					l_index_list.forth
				end
					-- Set them to Void if empty.
				if l_entry_tuple.tags /= Void and then l_entry_tuple.tags.is_empty then
					l_entry_tuple.tags := Void
				end
				if l_entry_tuple.parameters /= Void and then l_entry_tuple.parameters.is_empty then
					l_entry_tuple.parameters := Void
				end
				create Result.make (l_entry_tuple.name, l_entry_tuple.protocol, l_entry_tuple.source, l_entry_tuple.tags, l_entry_tuple.id, l_entry_tuple.parameters)
				Result.set_override (l_entry_tuple.override)
				Result.set_source_pos ([l_source_pos, l_source_len])
			end
		end

	eis_entry_from_conf_note (a_note: CONF_NOTE_ELEMENT; l_id: STRING): detachable EIS_ENTRY
			-- EIS entry from conf note element.
		require
			l_id_not_void: l_id /= Void
		local
			l_attributes: like {CONF_NOTE_ELEMENT}.attributes
			l_parameters: STRING_TABLE [STRING_32]
			l_tags: ARRAYED_LIST [STRING_32]
			l_entry_tuple: TUPLE [
							name: STRING_32;
							protocol: STRING_32;
							source: STRING_32;
							tags: ARRAYED_LIST [STRING_32];
							id: STRING;
							parameters: STRING_TABLE [STRING_32];
							override: BOOLEAN]
			l_key, l_value: STRING_32
		do
			if a_note /= Void then
				l_attributes := a_note.attributes
				if
					a_note.element_name.is_case_insensitive_equal ({ES_EIS_TOKENS}.eis_string) and then
					not l_attributes.has ({ES_EIS_TOKENS}.auto_string)
				then
					create l_entry_tuple
					l_entry_tuple.id := l_id
					create l_parameters.make (3)
					create l_tags.make (2)
					l_entry_tuple.parameters := l_parameters
					l_entry_tuple.tags := l_tags
					from
						l_attributes.start
					until
						l_attributes.after
					loop
						if
							attached l_attributes.key_for_iteration as lt_key and then
							attached l_attributes.item_for_iteration as lt_value
						then
							create l_key.make_from_string_general (lt_key)
							create l_value.make_from_string_general (lt_value)
							l_key.left_adjust
							l_key.right_adjust
							l_value.left_adjust
							l_value.right_adjust
							fill_from_key_value (l_key, l_value, l_entry_tuple)
						end
						l_attributes.forth
					end
						-- Set them to Void if empty.
					if l_entry_tuple.tags /= Void and then l_entry_tuple.tags.is_empty then
						l_entry_tuple.tags := Void
					end
					if l_entry_tuple.parameters /= Void and then l_entry_tuple.parameters.is_empty then
						l_entry_tuple.parameters := Void
					end
					create Result.make (l_entry_tuple.name, l_entry_tuple.protocol, l_entry_tuple.source, l_entry_tuple.tags, l_entry_tuple.id, l_entry_tuple.parameters)
				end
			end
		end

	parse_tags (a_tag_string: STRING_32): ARRAYED_LIST [STRING_32]
			-- Parse `a_tag_string' into an array.
			-- tag string should be in the form of "tag1, tag2, tag3"
		require
			a_tag_string_not_void: a_tag_string /= Void
		local
			l_list: LIST [STRING_32]
			l_str: STRING_32
		do
			l_list := a_tag_string.split ({ES_EIS_TOKENS}.tag_separator)
			create Result.make (l_list.count)
			across
				l_list as l_c
			loop
				l_str := l_c.item
				l_str.left_adjust
				l_str.right_adjust
				Result.extend (l_str)
			end
			if Result.count = 1 and then Result.i_th (1).count = 0 then
				Result.wipe_out
			end
		ensure
			Result_not_void: Result /= Void
			tags_valid: across Result as l_c all not l_c.item.is_empty implies not l_c.item.item (1).is_space and then not l_c.item.item (l_c.item.count).is_space end
		end

	parse_parameters (a_parameters_string: STRING_32): STRING_TABLE [STRING_32]
			-- Parse `a_parameters_string' into an array.
			-- parameters string should be in the form of
			-- "parameter1=value1, parameter2=value2, parameter3=value3"
			-- Or ""parameter1=value1", parameter2=value2, "parameter3=value3""
		require
			a_parameters_string_not_void: a_parameters_string /= Void
		local
			l_list: LIST [STRING_32]
			l_str, l_key, l_value: STRING_32
		do
			l_list := a_parameters_string.split ({ES_EIS_TOKENS}.attribute_separator)
			create Result.make (1)
			across
				l_list as l_c
			loop
				l_str := l_c.item
				l_str.left_adjust
				l_str.right_adjust
				l_str.prune_all_leading ('"')
				l_str.prune_all_trailing ('"')
				l_str.left_adjust
				l_str.right_adjust
				if attribute_regex_matcher.matches (encoding_converter.utf32_to_utf8 (l_str)) then
					if
						attached attribute_regex_matcher.captured_substring (1) as lt_key and then
						attached attribute_regex_matcher.captured_substring (2) as lt_value
					then
						l_key := encoding_converter.utf8_to_utf32 (lt_key)
						l_value := encoding_converter.utf8_to_utf32 (lt_value)
						l_key.left_adjust
						l_key.right_adjust
						l_value.left_adjust
						l_value.right_adjust
						Result.force (l_value, l_key)
					end
				end
			end
		ensure
			Result_not_void: Result /= Void
			parameters_valid: across Result as l_c all
				(not l_c.key.is_empty implies not l_c.key.item (1).is_space and then not l_c.key.item (l_c.key.count).is_space) and then
				(not l_c.item.is_empty implies not l_c.item.item (1).is_space and then not l_c.item.item (l_c.item.count).is_space) end
		end

	auto_entry (a_target: CONF_TARGET): detachable TUPLE [enabled: BOOLEAN; src: STRING_32]
			-- Auto entry in `a_target'.
			-- Void if not found.
		require
			a_target_not_void: a_target /= Void
		local
			l_note, l_notes: detachable CONF_NOTE_ELEMENT
			l_attributes: like {CONF_NOTE_ELEMENT}.attributes
			l_src: STRING_32
			l_enabled: BOOLEAN
		do
			l_notes := a_target.note_node
			if l_notes /= Void then
				from
					l_notes.start
				until
					l_notes.after or Result /= Void
				loop
					l_note := l_notes.item_for_iteration
					check l_note /= Void end
					if l_note.element_name.is_case_insensitive_equal ({ES_EIS_TOKENS}.eis_string) then
						l_attributes := l_note.attributes
						l_attributes.search ({ES_EIS_TOKENS}.auto_string)
						if l_attributes.found then
							l_enabled := l_attributes.found_item.is_case_insensitive_equal ({ES_EIS_TOKENS}.true_string)
							l_attributes.search ({ES_EIS_TOKENS}.source_string)
							if l_attributes.found then
								create l_src.make_from_string_general (l_attributes.found_item)
								l_src.left_adjust
								l_src.right_adjust
							else
								create l_src.make_empty
							end
							Result := [l_enabled, l_src]
						end
					end
					l_notes.forth
				end
			end
		end

	new_auto_entry_note (enabled: BOOLEAN; src: STRING_32): CONF_NOTE_ELEMENT
			-- Note for EIS auto setting.
		require
			src_not_void: src /= Void
		do
			create Result.make ({ES_EIS_TOKENS}.eis_string)
			if enabled then
				Result.add_attribute ({ES_EIS_TOKENS}.auto_string, {ES_EIS_TOKENS}.true_string)
			else
				Result.add_attribute ({ES_EIS_TOKENS}.auto_string, {ES_EIS_TOKENS}.false_string)
			end
			Result.add_attribute ({ES_EIS_TOKENS}.source_string, src)
		end

feature {NONE} -- Implemetation

	last_source_ast: detachable AST_EIFFEL
			-- Last found source ast by `eis_entry_from_index'.

	attribute_regex_matcher: RX_PCRE_MATCHER
		once
			create Result.make
			Result.compile ("^(\w+)=(.*)$")
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
