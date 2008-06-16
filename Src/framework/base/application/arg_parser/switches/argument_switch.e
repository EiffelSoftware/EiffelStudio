indexing
	description: "A command line switch."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_SWITCH

inherit
	HASHABLE

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make (a_id: like id; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple) is
			-- Initialize a new basic option.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
		local
			l_names: like canonical_name
		do
			l_names := canonical_name (a_id)
			short_name := l_names.short_name
			long_name := l_names.long_name

			id := a_id
			description := a_desc
			optional := a_optional
			allow_multiple := a_allow_mutliple
			lower_case_id := a_id.as_lower
		ensure
			id_set: id = a_id
			description_set: description = a_desc
			optional: optional = a_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			lower_case_id_set: equal (lower_case_id, a_id.as_lower)
			not_is_hidden: not is_hidden
		end

	make_hidden (a_id: like id; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple) is
			-- Initialize a new basic option.
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
		do
			make (a_id, a_desc, a_optional, a_allow_mutliple)
			is_hidden := True
		ensure
			id_set: id = a_id
			description_set: description = a_desc
			optional: optional = a_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			lower_case_id_set: equal (lower_case_id, a_id.as_lower)
			is_hidden: is_hidden
		end

feature -- Access

	id: STRING
			-- Option name id

	name: STRING
			-- Priority option name
		do
			if has_short_name then
				Result := short_name.out
			else
				Result := long_name
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	short_name: CHARACTER
			-- Option short name

	long_name: STRING
			-- Option long name

	description: STRING
			-- Option description

	lower_case_id: STRING
			-- Option name in lower-case

	hash_code: INTEGER
			-- Hash code value
		do
			Result := name.hash_code
		end

feature -- Status Report

	optional: BOOLEAN
			-- Indicates if switch is optional

	allow_multiple: BOOLEAN
			-- Indicated if mutiple occurrences permitted

	is_hidden: BOOLEAN
			-- Indicate if switch should be hidden

	is_special: BOOLEAN
			-- Indicates if switch is to be treated with "special" care

	frozen has_short_name: BOOLEAN
			-- Indicates if a short name has been specified
		do
			Result := short_name /= '%U'
		end

feature {ARGUMENT_BASE_PARSER} -- Status Setting

	set_is_special is
			-- Set switch to be special
		do
			is_special := True
		ensure
			is_special: is_special
		end

feature {ARGUMENT_BASE_PARSER} -- Factory Functions

	create_option: ARGUMENT_OPTION is
			-- Creates a new argument option for switch
		do
			create Result.make (Current)
		ensure
			result_attached: Result /= Void
		end

feature -- Query

	is_valid_id (a_id: STRING): BOOLEAN is
			-- Determines if `a_id' is a valid identifier
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		local
			c: CHARACTER
			l_count, i: INTEGER
		do
			i := a_id.index_of (canocial_name_separator, 1)
			Result := i = 0 or i = 2
			if Result then
				from
					i := 1
					l_count := a_id.count
				until
					i > l_count
				loop
					c := a_id.item (i)
					Result := c.is_printable and not c.is_space
					i := i + 1
				end
			end
		end

feature {NONE} -- Query

	canonical_name (a_id: STRING): TUPLE [long_name: STRING; short_name: CHARACTER] is
			-- Splits canonical name `a_id'
			--
			-- Note: When no short name is found `Result.short_name' will be null
		local
			i: INTEGER
		do
			i := a_id.index_of (canocial_name_separator, 1)
			if i > 0 and i + 1 <= a_id.count then
				Result := [a_id.substring (i + 1, a_id.count), a_id.item (1)]
			else
				Result := [a_id, '%U']
			end
		ensure
			result_attached: Result /= Void
			result_long_name_attached: Result.long_name /= Void
			not_result_long_name_is_empty: not Result.long_name.is_empty
		end

	canocial_name_separator: CHARACTER = '|'
			-- Character used to separate canonical names

invariant
	id_attached: id /= Void
	not_id_is_empty: not id.is_empty
	id_is_valid_id: is_valid_id (id)
	long_name_attached: long_name /= Void
	not_long_name_is_empty: not long_name.is_empty
	description_attached: description /= Void
	not_description_is_empty: not description.is_empty
	lower_case_id_attached: lower_case_id /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class {ARGUMENT_SWITCH}
