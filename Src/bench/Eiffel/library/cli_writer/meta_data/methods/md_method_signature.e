indexing
	description: "[
		Representation a method signature both for reference
		and definition as we do not consumme varargs.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make is
			-- Initialize current.
		do
			Precursor {MD_SIGNATURE}
			state := Method_type_setting_state
		ensure then
			current_position_set: current_position = 0
			state_set: state = Method_type_setting_state
		end

feature -- Reset

	reset is
			-- Reset current for new signature definition
		do
			current_position := 0
			state := Method_type_setting_state
		ensure
			current_position_set: current_position = 0
			state_set: state = Method_type_setting_state
		end
		
feature -- Settings

	set_method_type (t: INTEGER_8) is
			-- Set type of method.
			-- See MD_SIGNATURE_CONSTANTS for possible values.
		require
			valid_state: state = method_type_setting_state
		do
			internal_put (t, current_position)
			current_position := current_position + 1
			state := Parameter_count_state
		ensure
			state_set: state = Parameter_count_state
		end
		
	set_parameter_count (n: INTEGER) is
			-- Set number of method parameters.
			-- To be compressed.
		require
			valid_state: state = Parameter_count_state
		do
			state := Return_type_state
			compress_data (n)
		ensure
			state_set: state = Return_type_state
		end
	
	set_return_type (element_type: INTEGER_8; token: INTEGER) is
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

	method_type_setting_state: INTEGER is 1
	parameter_count_state: INTEGER is 2
	return_type_state: INTEGER is 3
	parameters_state: INTEGER is 4;
	
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

end -- class MD_METHOD_SIGNATURE
