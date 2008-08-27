indexing
	description: "A command line switch that accepts a value in the form of an natural."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_NATURAL_SWITCH

inherit
	ARGUMENT_VALUE_SWITCH
		redefine
			make,
			make_hidden,
			create_option,
			create_value_option,
			value_validator
		end

create
	make,
	make_hidden,
	make_with_range,
	make_hidden_with_range

feature {NONE} -- Initialization

	make (a_id: like id; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional) is
			-- Initialize a new value option.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		do
			Precursor {ARGUMENT_VALUE_SWITCH}(a_id, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional)
			min := {NATURAL_64}.min_value
			max := {NATURAL_64}.max_value
		ensure then
			min_set: min = {NATURAL_64}.min_value
			max_set: max = {NATURAL_64}.max_value
		end

	make_hidden (a_id: like id; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional) is
			-- Initialize a new value option.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		do
			Precursor {ARGUMENT_VALUE_SWITCH}(a_id, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional)
		ensure then
			min_set: min = {NATURAL_64}.min_value
			max_set: max = {NATURAL_64}.max_value
		end

	make_with_range (a_id: like id; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional a_min: like min; a_max: like max) is
			-- Initialize a new value option.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_min_less_than_max: a_min < a_max
		do
			make (a_id, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional)
			min := a_min
			max := a_max
		ensure
			id_set: id = a_id
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

	make_hidden_with_range (a_id: like id; a_desc: like description; a_optional: like optional; a_allow_mutliple: like allow_multiple; a_arg_name: like arg_name; a_arg_desc: like arg_description; a_val_optional: like is_value_optional; a_min: like min; a_max: like max) is
			-- Initialize a new value option.
			--
			-- Note: To use long and short names set name `a_id' := "s|long"
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_id_is_valid_id: is_valid_id (a_id)
			a_desc_attached: a_desc /= Void
			not_a_desc_is_empty: not a_desc.is_empty
			a_min_less_than_max: a_min < a_max
		do
			make_with_range (a_id, a_desc, a_optional, a_allow_mutliple, a_arg_name, a_arg_desc, a_val_optional, a_min, a_max)
			is_hidden := True
		ensure
			id_set: id = a_id
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

	min: NATURAL_64
			-- Minimum valid value

	max: NATURAL_64
			-- Maximumn valid value

feature {ARGUMENT_BASE_PARSER} -- Access

	value_validator: !ARGUMENT_NATURAL_RANGE_VALIDATOR
			-- <Precursor>
		do
			create Result.make (min, max)
		end

feature -- Element change

	set_range (a_min: like min; a_max: like max)
			-- Set natural range values.
		require
			a_min_less_than_a_max: a_min < a_max
		do
			min := a_min
			max := a_max
		ensure
			min_set: min = a_min
			max_set: max = a_max
		end

feature {ARGUMENT_BASE_PARSER} -- Factory Functions

	create_option: !ARGUMENT_NATURAL_OPTION
			-- <Precursor>
		do
			create Result.make (Current)
		end

	create_value_option (a_value: !STRING): !ARGUMENT_NATURAL_OPTION
			-- <Precursor>
		do
			create Result.make_with_value (a_value, Current)
		ensure then
			result_value_in_ranged: Result.natural_64_value >= min and then Result.natural_64_value <= max
		end

invariant
	min_less_than_max: min < max

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

end -- class {ARGUMENT_NATURAL_SWITCH}
