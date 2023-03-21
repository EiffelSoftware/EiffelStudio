note
	description: "Representation a property signature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class MD_PROPERTY_SIGNATURE

inherit
	MD_SIGNATURE
		rename
			set_type as set_element_type
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
			-- Initialize current.
		do
			Precursor {MD_SIGNATURE}
			state := property_type_state
		ensure then
			current_position_set: current_position = 0
			state_set: state = property_type_state
		end

feature -- Reset

	reset
			-- Reset current for new signature definition.
		do
			current_position := 0
			state := property_type_state
		ensure
			current_position_set: current_position = 0
			state_set: state = property_type_state
		end

feature -- Settings

	set_property_type (t: INTEGER_8)
			-- Set type of property.
		require
			valid_state: state = property_type_state
			valid_type:
				t = {MD_SIGNATURE_CONSTANTS}.property_sig or else
				t = {MD_SIGNATURE_CONSTANTS}.property_sig | {MD_SIGNATURE_CONSTANTS}.has_current
		do
			internal_put (t, current_position)
			current_position := current_position + 1
			state := parameter_count_state
		ensure
			state_set: state = parameter_count_state
		end

	set_parameter_count (n: INTEGER)
			-- Set number of method parameters to `n'.
			-- To be compressed.
		require
			valid_state: state = parameter_count_state
			non_negative_n: n >= 0
		do
			state := type_state
			compress_data (n)
		ensure
			state_set: state = type_state
		end

	set_type (element_type: INTEGER_8; token: INTEGER)
			-- Set return type of method.
		require
			valid_state: state = type_state
			token_valid: (element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_class or
				element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype) implies
				token /= 0
		do
			set_element_type (element_type, token)
			state := parameter_state
		ensure
			state_set: state = parameter_state
		end

feature -- State

	state: INTEGER
			-- Current state of signature settings.

	property_type_state: INTEGER = 1
	parameter_count_state: INTEGER = 2
	type_state: INTEGER = 3
	parameter_state: INTEGER = 4;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
