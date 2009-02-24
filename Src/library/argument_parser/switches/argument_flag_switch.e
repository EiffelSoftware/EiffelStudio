note
	description: "A command line switch that accepts a value in the form of single character flags."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_FLAG_SWITCH

inherit
	ARGUMENT_VALUE_SWITCH
		rename
			make as make_value_base,
			make_hidden as make_hidden_value_base
		redefine
			new_option,
			new_value_option,
			value_validator
		end

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make (a_id: like id; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional; a_flags: like flag_descriptions; a_cs_flags: like is_case_sensitive)
			-- Initialize a new flags option.
			-- Note: Flags are single characters. This is passed through `a_flags', which should be paired with a flag description.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_arg_name_attached: a_arg_name /= Void
			not_a_arg_name_is_empty: not a_arg_name.is_empty
			a_arg_desc_attached: a_arg_desc /= Void
			not_a_arg_desc_is_empty: not a_arg_desc.is_empty
			not_a_flags_is_empty: not a_flags.is_empty
			a_flags_contains_attached_items:
				a_flags.linear_representation.for_all (agent (ia_item: STRING): BOOLEAN
					local
						l_item: detachable STRING
					do
						l_item := ia_item
						Result := l_item /= Void and then not l_item.is_empty
					end)
			a_flags_contains_printable_items:
				a_flags.current_keys.for_all (agent (ia_item: CHARACTER): BOOLEAN
					do
						Result := ia_item.is_printable
					end)
		do
			make_value_base (a_id, a_desc, a_optional, a_allow_mutliple, a_arg_name, full_arg_description (a_arg_desc, a_flags), a_val_optional)
			flag_descriptions := a_flags
			is_case_sensitive := a_cs_flags
		ensure
			id_set: id ~ a_id
			description_set: description ~ a_desc
			optional: optional = a_optional
			arg_name_set: arg_name ~ a_arg_name
			is_value_optional_set: is_value_optional = a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			flag_descriptions_set: flag_descriptions ~ a_flags
			is_case_sensitive_flags_set: is_case_sensitive = a_cs_flags
			not_is_hidden: not is_hidden
		end

	make_hidden (a_id: like id; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional; a_flags: like flag_descriptions; a_cs_flags: like is_case_sensitive)
			-- Initialize a new value option.
			-- Note: Flags are single characters. This is passed through `a_flags', which should be paired with a flag description.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_arg_name_attached: a_arg_name /= Void
			not_a_arg_name_is_empty: not a_arg_name.is_empty
			a_arg_desc_attached: a_arg_desc /= Void
			not_a_arg_desc_is_empty: not a_arg_desc.is_empty
			not_a_flags_is_empty: not a_flags.is_empty
			a_flags_contains_attached_items:
				a_flags.linear_representation.for_all (agent (ia_item: STRING): BOOLEAN
					local
						l_item: detachable STRING
					do
						l_item := ia_item
						Result := l_item /= Void and then not l_item.is_empty
					end)
			a_flags_contains_printable_items:
				a_flags.current_keys.for_all (agent (ia_item: CHARACTER): BOOLEAN
					do
						Result := ia_item.is_printable
					end)
		do
			make (a_id, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional, a_flags, a_cs_flags)
			is_hidden := True
		ensure
			id_set: id ~ a_id
			description_set: description ~ a_desc
			optional: optional = a_optional
			arg_name_set: arg_name ~ a_arg_name
			is_value_optional_set: is_value_optional ~ a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			flag_descriptions_set: flag_descriptions ~ a_flags
			is_case_sensitive_flags_set: is_case_sensitive = a_cs_flags
			is_hidden: is_hidden
		end

feature -- Access

	flags: LIST [CHARACTER]
			-- List of flags applicable to switch.
		local
			l_result: like internal_flags
		do
			l_result := internal_flags
			if l_result /= Void then
				Result := l_result
			else
				create {ARRAYED_LIST [CHARACTER]} Result.make_from_array (flag_descriptions.current_keys)
				internal_flags := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ flags
			not_result_is_empty: not Result.is_empty
			result_contains_printable_characters: Result.for_all (
				agent (ia_item: CHARACTER): BOOLEAN do Result := ia_item.is_printable end)
		end

	flag_descriptions: HASH_TABLE [STRING, CHARACTER]
			-- Table of flags matched with a description.

feature {ARGUMENT_BASE_PARSER} -- Access

	value_validator: ARGUMENT_FLAGS_VALIDATOR
			-- <Precursor>
		once
			create Result.make (flags, is_case_sensitive)
		end

feature -- Status report

	is_case_sensitive: BOOLEAN
			-- Indicates if flags are case-sensitive

feature {ARGUMENT_BASE_PARSER} -- Factory Functions

	new_option: ARGUMENT_FLAG_OPTION
			-- <Precursor>
		do
			create Result.make ("", create {ARRAYED_LIST [CHARACTER]}.make (0), is_case_sensitive, Current)
		end

	new_value_option (a_value: STRING): ARGUMENT_FLAG_OPTION
			-- <Precursor>
		local
			l_flags: ARRAYED_LIST [CHARACTER]
			l_count, i: INTEGER
			c: CHARACTER
		do
			create l_flags.make (a_value.count)
			from
				i := 1
				l_count := a_value.count
			until
				i > l_count
			loop
				c := a_value.item (i)
				check c_is_printable: c.is_printable end
				l_flags.extend (c)
				i := i + 1
			end
			create Result.make (a_value, l_flags, is_case_sensitive, Current)
		end

feature {NONE} -- Usage

	full_arg_description (a_desc: STRING; a_flags: HASH_TABLE [STRING, CHARACTER]): STRING
			-- Generates an argument description using specified flags.
			--
			-- `a_desc': The orginal description.
			-- `a_flags': The flags to use to augment the description.
			-- `Result': A command line description string.
		require
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_flags_attached: a_flags /= Void
			not_a_flags_is_empty: not a_flags.is_empty
		local
			l_flag: detachable STRING
			l_list: SORTED_TWO_WAY_LIST [CHARACTER]
			l_keys: ARRAY [CHARACTER]
			c: CHARACTER
		do
			create Result.make (120)
			Result.append (a_desc)
			Result.append_character ('%N')

			l_keys := a_flags.current_keys
			create l_list.make
			l_list.append (create {ARRAYED_LIST [CHARACTER]}.make_from_array (l_keys))
			l_list.sort

			Result.append (once "Use one or more of the following flags:%N")
			from l_list.start until l_list.after loop
				c := l_list.item
				Result.append (once "   ")
				Result.append_character (c)
				Result.append (once ": ")
				l_flag := a_flags [c]
				if l_flag /= Void then
					Result.append_string (l_flag)
				end
				Result.append_character ('%N')
				l_list.forth
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Internal implementation cache

	internal_flags: detachable like flags
			-- Cached version of `flags'
			-- Note: Do not use directly!

invariant
	flag_descriptions_attached: flag_descriptions /= Void
	not_flag_description_is_empty: not flag_descriptions.is_empty
	flag_descriptions_contains_attached_items:
		flag_descriptions.linear_representation.for_all (agent (ia_item: STRING): BOOLEAN
			local
				l_item: detachable STRING
			do
				l_item := ia_item
				Result := l_item /= Void and then not l_item.is_empty
			end)
	flag_descriptions_contains_printable_items:
		flag_descriptions.current_keys.for_all (agent (ia_item: CHARACTER): BOOLEAN
			do
				Result := ia_item.is_printable
			end)
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
