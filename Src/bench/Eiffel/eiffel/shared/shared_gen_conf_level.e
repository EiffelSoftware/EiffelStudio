indexing
	description: "Integer values for generic conformance on Eiffel types"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_GEN_CONF_LEVEL

feature -- Generic conformance access

	Terminator_type: INTEGER is -1
	Character_type: INTEGER is -2
	Boolean_type: INTEGER is -3
	Integer_32_type: INTEGER is -4
	Real_type: INTEGER is -5
	Double_type: INTEGER is -6
	Bit_type: INTEGER is -7
	Pointer_type: INTEGER is -8
	None_type: INTEGER is -9
	Internal_type: INTEGER is -10
	Like_arg_type: INTEGER is -11
	Like_current_type: INTEGER is -12
	Like_pfeature_type: INTEGER is -13
	Like_feature_type: INTEGER is -14
	Tuple_type: INTEGER is -15
	Integer_8_type: INTEGER is -16
	Integer_16_type: INTEGER is -17
	Integer_64_type: INTEGER is -18
	Wide_char_type: INTEGER is -19
	Formal_type: INTEGER is -32
	Expanded_level: INTEGER is -256
	
end -- class SHARED_GEN_CONF_LEVEL
