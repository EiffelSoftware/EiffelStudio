note
	description: "[
			Representation a method signature both for reference
			and definition as we do not consumme varargs.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_SIGNATURE

inherit
	MD_SIGNATURE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize current.
		do
			Precursor {MD_SIGNATURE}
			state := Method_type_setting_state
		ensure then
			current_position_set: current_position = 0
			state_set: state = Method_type_setting_state
		end

feature -- Reset

	reset
			-- Reset current for new signature definition
		do
			current_position := 0
			state := Method_type_setting_state
		ensure
			current_position_set: current_position = 0
			state_set: state = Method_type_setting_state
		end

feature -- Access

	method_type: INTEGER_8
			-- Type of method

	parameter_count: INTEGER
			-- Number of parameters

feature -- Settings

	set_method_type (t: like method_type)
			-- Set type of method.
			-- See MD_SIGNATURE_CONSTANTS for possible values.
		require
			valid_state: state = method_type_setting_state
		do
			internal_put (t, current_position)
			current_position := current_position + 1
			state := Parameter_count_state
			method_type := t
		ensure
			state_set: state = Parameter_count_state
			method_type_set: method_type = t
		end

	set_parameter_count (n: like parameter_count)
			-- Set number of method parameters.
			-- To be compressed.
		require
			valid_state: state = Parameter_count_state
		do
			state := Return_type_state
			parameter_count := n
			compress_data (n)
		ensure
			state_set: state = Return_type_state
			parameter_count_set: parameter_count = n
		end

	set_return_type (element_type: INTEGER_8; token: INTEGER)
			-- Set return type of method.
		require
			valid_state: state = Return_type_state
			token_valid: (element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_class or
					element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype) implies
				token /= 0
		do
			set_type (element_type, token)
			state := Parameters_state
		ensure
			state_set: state = Parameters_state
		end

feature -- State

	state: INTEGER
			-- Current state of signature settings.

	method_type_setting_state: INTEGER = 1
	parameter_count_state: INTEGER = 2
	return_type_state: INTEGER = 3
	parameters_state: INTEGER = 4;

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class MD_METHOD_SIGNATURE
