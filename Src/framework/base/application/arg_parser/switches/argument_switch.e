indexing
	description: "A command line switch."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_SWITCH

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make (a_name: like name; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple) is
			-- Initialize a new basic option.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
		do
			name := a_name
			description := a_desc
			optional := a_optional
			allow_multiple := a_allow_mutliple
			lower_case_name := name.as_lower
		ensure
			name_set: name = a_name
			description_set: description = a_desc
			optional: optional = a_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			not_hidden: not hidden
		end

	make_hidden (a_name: like name; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple) is
			-- Initialize a new basic option.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
		do
			make (a_name, a_desc, a_optional, a_allow_mutliple)
			hidden := True
		ensure
			name_set: name = a_name
			description_set: description = a_desc
			optional: optional = a_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			hidden: hidden
		end

feature -- Access

	name: STRING
			-- Option name

	description: STRING
			-- Option description

	lower_case_name: STRING
			-- Option name in lower-case

	hidden: BOOLEAN
			-- Indicate if switch should be hidden

feature -- Status Report

	optional: BOOLEAN
			-- Indicates if switch is optional

	allow_multiple: BOOLEAN
			-- Indicated if mutiple occurances permitted

feature {ARGUMENT_BASE_PARSER} -- Factory Functions

	create_option: ARGUMENT_OPTION is
			-- Creates a new argument option for switch
		do
			create Result.make (name)
		ensure
			result_attached: Result /= Void
		end

invariant
	name_attached: name /= Void
	not_name_is_empty: not name.is_empty
	description_attached: description /= Void
	not_description_is_empty: not description.is_empty
	lower_case_name_attached: lower_case_name /= Void
	lower_case_name_is_name_in_lower: name.as_lower.is_equal (lower_case_name)

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
