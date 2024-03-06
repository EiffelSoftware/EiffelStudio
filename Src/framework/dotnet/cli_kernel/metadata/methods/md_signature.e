note
	description: "Representation of a signature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_SIGNATURE

inherit
	MD_BLOB_DATA

feature -- Settings

	set_byref_type (element_type: INTEGER_8; a_token: INTEGER)
			-- Set type as a byref type in current signature.
		require
			token_valid: (element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_class or
				element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype) implies
				a_token /= 0
		do
			internal_put ({MD_SIGNATURE_CONSTANTS}.Element_type_byref, current_position)
			current_position := current_position + 1
			set_type (element_type, a_token)
		end

	set_type (element_type: INTEGER_8; token: INTEGER)
			-- Set type in current signature.
		require
			token_valid: (element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_class or
				element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_valuetype) implies
				token /= 0
		do
			internal_put (element_type, current_position)
			current_position := current_position + 1
			inspect
				element_type
			when
				{MD_SIGNATURE_CONSTANTS}.Element_type_class,
				{MD_SIGNATURE_CONSTANTS}.Element_type_valuetype
			then
				compress_type_token (token)
			else
			end
		end

	set_generic_parameter_type (element_type: INTEGER_8; a_param_index: INTEGER)
			-- note: `a_param_index` is 0-based.
		require
			expected_data: (element_type = {MD_SIGNATURE_CONSTANTS}.Element_type_mvar) implies
				a_param_index >= 0
		do
			internal_put (element_type, current_position)
			current_position := current_position + 1
			inspect
				element_type
			when
				{MD_SIGNATURE_CONSTANTS}.Element_type_mvar
			then
				compress_data (a_param_index)
			else
			end
		end

feature {NONE} -- Implementation

	compress_data (i: INTEGER)
			-- Compress `i' using Partition II 23.2 specification
			-- and store it at current_position in current.
		require
			valid_i: i <= 0x1FFFFFFF
		do
			compress_unsigned_data (i)
		end

	compress_type_token (i: INTEGER)
			-- Compress token `i' using Partition II 23.2.8 specification
			-- and store it at current_position in current.
		local
			l_header: INTEGER
			l_val: INTEGER
			l_encoding: INTEGER
		do
			l_header := i & 0xFF000000
			l_val := i & 0x00FFFFFF

			if l_header = {MD_TOKEN_TYPES}.Md_type_ref then
					-- TypeRef token
				l_encoding := 1
			elseif l_header = {MD_TOKEN_TYPES}.Md_type_def then
					-- TypeDef token
				l_encoding := 0
			elseif l_header = {MD_TOKEN_TYPES}.Md_type_spec then
					-- TypeSpec token
				l_encoding := 2
			else
				check
					known_type_token_header: False
				end
			end

			l_val := (l_val |<< 2) | l_encoding

			compress_data (l_val)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class MD_SIGNATURE
