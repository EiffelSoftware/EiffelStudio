indexing
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
			create_option,
			create_value_option,
			value_validator
		end

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make (a_id: !like id; a_desc: !like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: !like arg_name; a_arg_desc: !like arg_description; a_val_optional: like is_value_optional; a_flags: !like flag_descriptions; a_cs_flags: like case_sensitive_flags) is
			-- Initialize a new flags option.
			-- Note: Flags are single characters. This is passed through `a_flags', which should be paired with a flag description.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		require
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			not_a_desc_is_empty: not a_desc.is_empty
			not_a_flags_is_empty: not a_flags.is_empty
		do
			make_value_base (a_id, a_desc, a_optional, a_allow_mutliple, a_arg_name, full_arg_description (a_arg_desc, a_flags), a_val_optional)
			flag_descriptions := a_flags
			case_sensitive_flags := a_cs_flags
		ensure
			id_set: id = a_id
			description_set: description = a_desc
			optional: optional = a_optional
			arg_name_set: arg_name = a_arg_name
			is_value_optional_set: is_value_optional = a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			flag_descriptions_set: flag_descriptions = a_flags
			case_sensitive_flags_set: case_sensitive_flags = a_cs_flags
			not_is_hidden: not is_hidden
		end

	make_hidden (a_id: !like id; a_desc: !like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: !like arg_name; a_arg_desc: !like arg_description; a_val_optional: like is_value_optional; a_flags: !like flag_descriptions; a_cs_flags: like case_sensitive_flags) is
			-- Initialize a new value option.
			-- Note: Flags are single characters. This is passed through `a_flags', which should be paired with a flag description.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		require
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			not_a_desc_is_empty: not a_desc.is_empty
			not_a_flags_is_empty: not a_flags.is_empty
		do
			make (a_id, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional, a_flags, a_cs_flags)
			is_hidden := True
		ensure
			id_set: id = a_id
			description_set: description = a_desc
			optional: optional = a_optional
			arg_name_set: arg_name = a_arg_name
			is_value_optional_set: is_value_optional = a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			flag_descriptions_set: flag_descriptions = a_flags
			case_sensitive_flags_set: case_sensitive_flags = a_cs_flags
			is_hidden: is_hidden
		end

feature -- Access

	flags: !LIST [CHARACTER]
			-- List of flags applicable to switch.
		do
			if {l_flags: like internal_flags} internal_flags then
				Result := l_flags
			else
				create {ARRAYED_LIST [CHARACTER]}Result.make_from_array (flag_descriptions.current_keys)
				internal_flags := Result
			end
		ensure
			result_consistent: Result = flags
			not_result_is_empty: not Result.is_empty
			result_contains_printable_characters: Result.for_all (
				agent (ia_char: CHARACTER): BOOLEAN do Result := ia_char.is_printable end)
		end

	flag_descriptions: !HASH_TABLE [!STRING, CHARACTER]
			-- Table of flags matched with a description.

feature {ARGUMENT_BASE_PARSER} -- Access

	value_validator: !ARGUMENT_FLAGS_VALIDATOR
			-- <Precursor>
		once
			create Result.make (flags, case_sensitive_flags)
		end

feature -- Status report

	case_sensitive_flags: BOOLEAN
			-- Indicates if flags are case-sensitive

feature {ARGUMENT_BASE_PARSER} -- Factory Functions

	create_option: !ARGUMENT_FLAG_OPTION
			-- <Precursor>
		do
			create Result.make ("", create {ARRAYED_LIST [CHARACTER]}.make (0), case_sensitive_flags, Current)
		end

	create_value_option (a_value: !STRING): !ARGUMENT_FLAG_OPTION
			-- <Precursor>
		local
			l_flags: !ARRAYED_LIST [CHARACTER]
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
			create Result.make (a_value, l_flags, case_sensitive_flags, Current)
		end

feature {NONE} -- Usage

	full_arg_description (a_desc: !STRING; a_flags: !HASH_TABLE [!STRING, CHARACTER]): !STRING
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
				Result.append (a_flags [c])
				Result.append_character ('%N')
				l_list.forth
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Internal implementation cache

	internal_flags: ?LIST [CHARACTER]
			-- Cached version of `flags'
			-- Note: Do not use directly!

invariant
	flag_descriptions_attached: flag_descriptions /= Void
	not_flag_description_is_empty: not flag_descriptions.is_empty

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class {ARGUMENT_FLAG_SWITCH}
