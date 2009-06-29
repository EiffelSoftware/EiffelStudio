note
	description: "EIS entry to code"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_ENTRY_OUTPUT

inherit
	ES_EIS_SHARED

	CONF_ACCESS

feature -- Operation

	process (a_entry: attached EIS_ENTRY)
			-- Start process `a_entry'
		local
			l_output: STRING_32
			l_comma_needed: BOOLEAN
		do
			if not is_for_conf then
				create l_output.make_from_string ({ES_EIS_TOKENS}.eis_string)
				l_output.append (": ")
				if a_entry.name /= Void then
					l_output.append (quoted_string ({ES_EIS_TOKENS}.name_string + {ES_EIS_TOKENS}.value_assignment + a_entry.name))
					l_comma_needed := True
				end
				if a_entry.protocol /= Void then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_seperator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string ({ES_EIS_TOKENS}.protocol_string + {ES_EIS_TOKENS}.value_assignment + a_entry.protocol))
					l_comma_needed := True
				end
				if a_entry.source /= Void then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_seperator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string ({ES_EIS_TOKENS}.source_string + {ES_EIS_TOKENS}.value_assignment + a_entry.source))
					l_comma_needed := True
				end
				if a_entry.tags /= Void and then not a_entry.tags.is_empty then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_seperator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string ({ES_EIS_TOKENS}.tag_string + {ES_EIS_TOKENS}.value_assignment + tags_as_code (a_entry)))
					l_comma_needed := True
				end

				if a_entry.override then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_seperator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string ({ES_EIS_TOKENS}.override_string + {ES_EIS_TOKENS}.value_assignment + {ES_EIS_TOKENS}.true_string))
					l_comma_needed := True
				end

				if a_entry.others /= Void and then not a_entry.others.is_empty then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_seperator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (others_as_code (a_entry))
				end
			else
				create last_output_conf.make ({ES_EIS_TOKENS}.eis_string.as_lower)
				if a_entry.name /= Void then
					last_output_conf.add_attribute ({ES_EIS_TOKENS}.name_string, a_entry.name)
				end
				if a_entry.protocol /= Void then
					last_output_conf.add_attribute ({ES_EIS_TOKENS}.protocol_string, a_entry.protocol)
				end
				if a_entry.source /= Void then
					last_output_conf.add_attribute ({ES_EIS_TOKENS}.source_string, a_entry.source)
				end
				if a_entry.tags /= Void and then not a_entry.tags.is_empty then
					last_output_conf.add_attribute ({ES_EIS_TOKENS}.tag_string, tags_as_code (a_entry))
				end
				if attached {HASH_TABLE [STRING_32, STRING_32]} a_entry.others as lt_others and then not a_entry.others.is_empty then
					from
						lt_others.start
					until
						lt_others.after
					loop
						if not lt_others.key_for_iteration.is_empty then
								--|FIXME: Bad conversion to STRING_8
							last_output_conf.add_attribute (lt_others.key_for_iteration, lt_others.item_for_iteration)
						end
						lt_others.forth
					end
				end
			end
			last_output_code := l_output
		ensure
			last_output_not_void: (not is_for_conf) implies (last_output_code /= Void)
			last_output_not_void: is_for_conf implies (last_output_conf /= Void)
		end

feature -- Status report

	is_for_conf: BOOLEAN
			-- Is for configure element output?

feature -- Status change

	set_is_for_conf (a_b: BOOLEAN)
			-- Set `is_for_conf' with `a_b'
		do
			is_for_conf := a_b
		ensure
			is_for_conf_set: is_for_conf = a_b
		end

feature -- Access

	last_output_code: detachable STRING_32
			-- Last output of code.

	last_output_conf: CONF_NOTE_ELEMENT
			-- Last output of conf note.

	tags_as_code (a_entry: attached EIS_ENTRY): attached STRING_32
			-- Tags as a string of code.
			-- Unquoted
		local
			l_found: BOOLEAN
		do
			if attached {ARRAYED_LIST [STRING_32]} a_entry.tags as lt_tags then
				create Result.make (10)
				from
					lt_tags.start
				until
					lt_tags.after
				loop
					if not lt_tags.item.is_empty then
						Result.append (lt_tags.item)
						if not lt_tags.islast then
							Result.append_character ({ES_EIS_TOKENS}.tag_seperator)
							Result.append_character ({ES_EIS_TOKENS}.space)
						end
						l_found := True
					end
					lt_tags.forth
				end
			end
			if not l_found then
				create Result.make_empty
			end
		end

	others_as_code (a_entry: attached EIS_ENTRY): attached STRING_32
			-- Others as string of code.
			-- Quoted
		local
			l_attr: STRING_32
			i, l_count: INTEGER
			l_value: STRING_32
			l_found: BOOLEAN
		do
			if attached {HASH_TABLE [STRING_32, STRING_32]} a_entry.others as lt_others then
				create Result.make (10)
				from
					lt_others.start
					l_count := lt_others.count
				until
					lt_others.after
				loop
					i := i + 1
					create l_attr.make_from_string (lt_others.key_for_iteration)
					l_value := lt_others.item_for_iteration
					if not l_value.is_equal ({ES_EIS_TOKENS}.void_string) then
						l_attr.append ({ES_EIS_TOKENS}.value_assignment)
						l_attr.append (l_value)
						l_found := True
					end
					Result.append (quoted_string (l_attr))
					if i < l_count then
						Result.append_character ({ES_EIS_TOKENS}.attribute_seperator)
						Result.append_character ({ES_EIS_TOKENS}.space)
					end
					lt_others.forth
				end
			end
			if not l_found then
			 	create Result.make_empty
			end
		end

feature {NONE} -- Implementation

	quoted_string (a_string: STRING_32): attached STRING_32
			-- Quoted `a_string'
		require
			a_string_not_void: a_string /= Void
		do
			create Result.make_from_string (a_string)
			Result.prepend_character ('%"')
			Result.append_character ('%"')
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
