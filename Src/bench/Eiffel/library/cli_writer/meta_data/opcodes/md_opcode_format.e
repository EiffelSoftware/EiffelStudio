indexing
	description: "How opcodes are formatted?"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_OPCODE_FORMAT

feature -- Access

	no_arg: INTEGER is 1
	variable_arg: INTEGER is 2
	i_arg: INTEGER is 3
	r_arg: INTEGER is 4
	i8_arg: INTEGER is 5
	short_variable_arg: INTEGER is 6
	short_i_arg: INTEGER is 7
	short_r_arg: INTEGER is 8
	method_arg: INTEGER is 9
	field_arg: INTEGER is 10
	type_arg: INTEGER is 11
	signature_arg: INTEGER is 12
	string_arg: INTEGER is 13
	token_arg: INTEGER is 14
	branch_target_arg: INTEGER is 15
	switch_arg: INTEGER is 16
	short_branch_target_arg: INTEGER is 17
	
end -- class MD_OPCODE_USAGE
