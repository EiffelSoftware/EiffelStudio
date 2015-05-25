note
	description: "Integer values for generic conformance on Eiffel types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_GEN_CONF_LEVEL

feature -- Generic conformance access

	Terminator_type, invalid_dtype: NATURAL_16 = 0xFFFF

	none_type: NATURAL_16 = 0xFFFE
	Like_arg_type: NATURAL_16 = 0xFFFD
	Like_current_type: NATURAL_16 = 0xFFFC
	--not_used: NATURAL_16 = 0xFFFB
	Like_feature_type: NATURAL_16 = 0xFFFA
	Tuple_type: NATURAL_16 = 0xFFF9
	Formal_type: NATURAL_16 = 0xFFF8
	parent_type_separator: NATURAL_16 = 0xFFF7
	--not_used: NATURAL_16 = 0xFFF6
	qualified_feature_type: NATURAL_16 = 0xFFF5
	unused_special_type_1: NATURAL_16 = 0xFFF4
	unused_special_type_2: NATURAL_16 = 0xFFF3
	unused_special_type_3: NATURAL_16 = 0xFFF2
	unused_special_type_4: NATURAL_16 = 0xFFF1
	unused_special_type_5: NATURAL_16 = 0xFFF0

	attached_type: NATURAL_16 = 0xFF01
	detachable_type: NATURAL_16 = 0xFF02
	separate_type: NATURAL_16 = 0xFF04
	variant_type: NATURAL_16 = 0xFF08
	frozen_type: NATURAL_16 = 0xFF20
	poly_type: NATURAL_16 = 0xFF40

	Max_dtype: NATURAL_16 = 0xFF00

	attached_flag: NATURAL_16 = 0x0001
	detachable_flag: NATURAL_16 = 0x0002
	separate_flag: NATURAL_16 = 0x0004
	variant_flag: NATURAL_16 = 0x0008
	frozen_flag: NATURAL_16 = 0x0020
	poly_flag: NATURAL_16 = 0x0040

feature -- TUPLE code

	reference_tuple_code: NATURAL_8 = 0x00
	boolean_tuple_code: NATURAL_8 = 0x01
	character_tuple_code: NATURAL_8 = 0x02
	real_64_tuple_code: NATURAL_8 = 0x03
	real_32_tuple_code: NATURAL_8 = 0x04
	pointer_tuple_code: NATURAL_8 = 0x05
	integer_8_tuple_code: NATURAL_8 = 0x06
	integer_16_tuple_code: NATURAL_8  = 0x07
	integer_32_tuple_code: NATURAL_8 = 0x08
	integer_64_tuple_code: NATURAL_8 = 0x09
	natural_8_tuple_code: NATURAL_8 = 0x0A
	natural_16_tuple_code: NATURAL_8 = 0x0B
	natural_32_tuple_code: NATURAL_8  = 0x0C
	natural_64_tuple_code: NATURAL_8 = 0x0D
	wide_character_tuple_code: NATURAL_8 = 0x0E;
			-- Code used to identify type in TUPLE.

	expanded_tuple_code_extension: NATURAL_8 = 0x10
			-- Code used to identify special type, used in metainformation only: non-basic expanded type

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class SHARED_GEN_CONF_LEVEL
