indexing
	description: "Integer values for generic conformance on Eiffel types"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_GEN_CONF_LEVEL

feature -- Generic conformance access

	Terminator_type: INTEGER_16 is 0xFFFF
	None_type: INTEGER_16 is 0xFFFE
	Like_arg_type: INTEGER is 0xFFFD
	Like_current_type: INTEGER is 0xFFFC
	Like_pfeature_type: INTEGER is 0xFFFB
	Like_feature_type: INTEGER is 0xFFFA
	Tuple_type: INTEGER_16 is 0xFFF9
	Formal_type: INTEGER_16 is 0xFFF8
	
feature -- TUPLE code

	reference_tuple_code: INTEGER_8 is 0x00
	boolean_tuple_code: INTEGER_8 is 0x01
	character_tuple_code: INTEGER_8 is 0x02
	double_tuple_code: INTEGER_8 is 0x03
	real_tuple_code: INTEGER_8 is 0x04
	pointer_tuple_code: INTEGER_8 is 0x05
	integer_8_tuple_code: INTEGER_8 is 0x06
	integer_16_tuple_code: INTEGER_8  is 0x07
	integer_32_tuple_code: INTEGER_8 is 0x08
	integer_64_tuple_code: INTEGER_8 is 0x09
	natural_8_tuple_code: INTEGER_8 is 0x0A
	natural_32_tuple_code: INTEGER_8 is 0x0B
	natural_16_tuple_code: INTEGER_8  is 0x0C
	natural_64_tuple_code: INTEGER_8 is 0x0D
	wide_character_tuple_code: INTEGER_8 is 0x0E
			-- Code used to identify type in TUPLE.
	
end -- class SHARED_GEN_CONF_LEVEL
