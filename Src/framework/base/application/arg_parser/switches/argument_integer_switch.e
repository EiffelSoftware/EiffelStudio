indexing
	description: "A command line switch that accepts a value in the form of an integer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_INTEGER_SWITCH

inherit
	ARGUMENT_VALUE_SWITCH
		redefine
			make,
			make_hidden,
			value_validator
		end

create
	make,
	make_hidden,
	make_with_range,
	make_hidden_with_range

feature {NONE} -- Initialization

	make (a_name: like name; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional) is
			-- Initialize a new value option.
		do
			Precursor {ARGUMENT_VALUE_SWITCH}(a_name, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional)
			min := {INTEGER_64}.min_value
			max := {INTEGER_64}.max_value
		ensure then
			min_set: min = {INTEGER_64}.min_value
			max_set: max = {INTEGER_64}.max_value
		end

	make_hidden (a_name: like name; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional) is
			-- Initialize a new value option.
		do
			Precursor {ARGUMENT_VALUE_SWITCH}(a_name, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional)
		ensure then
			min_set: min = {INTEGER_64}.min_value
			max_set: max = {INTEGER_64}.max_value
		end

	make_with_range (a_name: like name; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional a_min: like min; a_max: like max) is
			-- Initialize a new value option.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_min_less_than_max: a_min < a_max
		do
			make (a_name, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional)
			min := a_min
			max := a_max
		ensure
			name_set: name = a_name
			description_set: description = a_desc
			optional: optional = a_optional
			arg_name_set: arg_name = a_arg_name
			arg_description_set: arg_description = a_arg_desc
			is_value_optional_set: is_value_optional = a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			min_set: min = a_min
			max_set: max = a_max
			not_is_hidden: not is_hidden
		end

	make_hidden_with_range (a_name: like name; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional; a_min: like min; a_max: like max) is
			-- Initialize a new value option.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_min_less_than_max: a_min < a_max
		do
			make_with_range (a_name, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional, a_min, a_max)
			is_hidden := True
		ensure
			name_set: name = a_name
			description_set: description = a_desc
			optional: optional = a_optional
			arg_name_set: arg_name = a_arg_name
			arg_description_set: arg_description = a_arg_desc
			is_value_optional_set: is_value_optional = a_val_optional
			allow_multiple_set: allow_multiple = a_allow_mutliple
			min_set: min = a_min
			max_set: max = a_max
			is_hidden: is_hidden
		end

feature -- Access

	value_validator: ARGUMENT_INTEGER_RANGE_VALIDATOR
			-- Retrieves an validator used to check current switch value
		do
			create Result.make (min, max)
		end

	min: INTEGER_64
			-- Minimum valid value

	max: INTEGER_64
			-- Maximumn valid value

feature -- Element change

	set_range (a_min: like min; a_max: like max)
			-- Set integer range values.
		require
			a_min_less_than_a_max: a_min < a_max
		do
			min := a_min
			max := a_max
		ensure
			min_set: min = a_min
			max_set: max = a_max
		end

invariant
	min_less_than_max: min < max

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

end -- class {ARGUMENT_INTEGER_SWITCH}
