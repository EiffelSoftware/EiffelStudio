indexing
	description: "Data about opcodes"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_OPCODE

create
	make
	
feature {NONE} -- Initialization

	make (an_opcode_value: INTEGER_16; a_stack_depth_transition: INTEGER; a_format: INTEGER) is
			-- Initialize current opcode with `an_opcode_value'
			-- and `a_format'.
		do
			value := an_opcode_value
			format := a_format
			stack_depth_transition := a_stack_depth_transition
		ensure
			value_set: value = an_opcode_value
			format_set: format = a_format
			stack_depth_transition_set: stack_depth_transition = a_stack_depth_transition
		end
		
feature -- Access

	value: INTEGER_16
			-- Opcode value.
			-- See MD_OPCODES for possible values.
			
	format: INTEGER
			-- Format of arguments.
			-- See MD_OPCODE_FORMATS for possible values.

	stack_depth_transition: INTEGER
			-- Stack depth transition.

end -- class MD_OPCODE
