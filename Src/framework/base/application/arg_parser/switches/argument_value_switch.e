indexing
	description: "A command line switch that accepts a value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_VALUE_SWITCH

inherit
	ARGUMENT_SWITCH
		rename
			make as make_base,
			make_hidden as make_hidden_base
		end

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make (a_name: like name; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional) is
			-- Initialize a new value option.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
		do
			make_base (a_name, a_desc, a_optional, a_allow_mutliple)
			arg_name := a_arg_name
			arg_description := a_arg_desc
			is_value_optional := a_val_optional
		ensure
			name_set: name = a_name
			description_set: description = a_desc
			optional: optional = a_optional
			arg_name_set: arg_name = a_arg_name
			arg_description_set: arg_description = a_arg_desc
			is_value_optional_set: is_value_optional = a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			not_hidden: not hidden
		end

	make_hidden (a_name: like name; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional) is
			-- Initialize a new value option.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
		do
			make (a_name, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional)
			hidden := True
		ensure
			name_set: name = a_name
			description_set: description = a_desc
			optional: optional = a_optional
			arg_name_set: arg_name = a_arg_name
			arg_description_set: arg_description = a_arg_desc
			is_value_optional_set: is_value_optional = a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			hidden: hidden
		end

feature -- Access

	arg_name: STRING
			-- Value argument name

	arg_description: STRING
			-- Value argument description

	value_validator: ARGUMENT_SWITCH_VALUE_VALIDATOR is
			-- Retrieves an validator used to check current switch value
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Status Report

	is_value_optional: BOOLEAN
			-- Indicates if a option value is optional

feature {ARGUMENT_LITE_PARSER} -- Factory Functions

	create_value_option (a_value: STRING): ARGUMENT_OPTION is
			-- Creates a new argument option given a value `a_value', for current switch
		require
			a_value_attached: a_value /= Void
			not_a_value_is_empty: not a_value.is_empty
		do
			create Result.make_with_value (name, a_value)
		ensure
			result_attached: Result /= Void
		end

invariant
	arg_name_attached: arg_name /= Void
	not_arg_name_is_empty: not arg_name.is_empty
	arg_description_attached: arg_description /= Void
	not_arg_description_is_empty: not arg_description.is_empty

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

end -- class {ARGUMENT_VALUE_SWITCH}
