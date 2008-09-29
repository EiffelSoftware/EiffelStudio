indexing
	description: "Integer values for generic conformance on Eiffel types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_GEN_CONF_LEVEL

feature -- Generic conformance access

	Terminator_type, invalid_dtype: NATURAL_16 is 0xFFFF
	None_type: NATURAL_16 is 0xFFFE
	Like_arg_type: NATURAL_16 is 0xFFFD
	Like_current_type: NATURAL_16 is 0xFFFC
	Like_pfeature_type: NATURAL_16 is 0xFFFB
	Like_feature_type: NATURAL_16 is 0xFFFA
	Tuple_type: NATURAL_16 is 0xFFF9
	Formal_type: NATURAL_16 is 0xFFF8

	annotation_type_mask: NATURAL_16 is 0xFF1F
	attached_type: NATURAL_16 is 0xFF11
	frozen_type: NATURAL_16 is 0xFF12

	Max_dtype: NATURAL_16 is 0xFF00

feature -- TUPLE code

	reference_tuple_code: NATURAL_8 is 0x00
	boolean_tuple_code: NATURAL_8 is 0x01
	character_tuple_code: NATURAL_8 is 0x02
	real_64_tuple_code: NATURAL_8 is 0x03
	real_32_tuple_code: NATURAL_8 is 0x04
	pointer_tuple_code: NATURAL_8 is 0x05
	integer_8_tuple_code: NATURAL_8 is 0x06
	integer_16_tuple_code: NATURAL_8  is 0x07
	integer_32_tuple_code: NATURAL_8 is 0x08
	integer_64_tuple_code: NATURAL_8 is 0x09
	natural_8_tuple_code: NATURAL_8 is 0x0A
	natural_16_tuple_code: NATURAL_8 is 0x0B
	natural_32_tuple_code: NATURAL_8  is 0x0C
	natural_64_tuple_code: NATURAL_8 is 0x0D
	wide_character_tuple_code: NATURAL_8 is 0x0E;
			-- Code used to identify type in TUPLE.

	expanded_tuple_code_extension: NATURAL_8 is 0x10
			-- Code used to identify special type, used in metainformation only: non-basic expanded type

	bit_tuple_code_extension: NATURAL_8 is 0x20;
			-- Code used to identify special type, used in metainformation only: bit type

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end -- class SHARED_GEN_CONF_LEVEL
