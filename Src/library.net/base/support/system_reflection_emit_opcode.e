indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.OpCode"

frozen expanded external class
	SYSTEM_REFLECTION_EMIT_OPCODE

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	frozen get_flow_control: INTEGER is
		external
			"IL signature (): enum System.Reflection.Emit.FlowControl use System.Reflection.Emit.OpCode"
		alias
			"get_FlowControl"
		ensure
			valid_flow_control: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.OpCode"
		alias
			"get_Size"
		end

	frozen get_value: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Reflection.Emit.OpCode"
		alias
			"get_Value"
		end

	frozen get_stack_behaviour_pop: INTEGER is
		external
			"IL signature (): enum System.Reflection.Emit.StackBehaviour use System.Reflection.Emit.OpCode"
		alias
			"get_StackBehaviourPop"
		ensure
			valid_stack_behaviour: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 13 or Result = 14 or Result = 15 or Result = 16 or Result = 17 or Result = 18 or Result = 19 or Result = 20 or Result = 21 or Result = 22 or Result = 23 or Result = 24 or Result = 25 or Result = 26 or Result = 27
		end

	frozen get_stack_behaviour_push: INTEGER is
		external
			"IL signature (): enum System.Reflection.Emit.StackBehaviour use System.Reflection.Emit.OpCode"
		alias
			"get_StackBehaviourPush"
		ensure
			valid_stack_behaviour: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 13 or Result = 14 or Result = 15 or Result = 16 or Result = 17 or Result = 18 or Result = 19 or Result = 20 or Result = 21 or Result = 22 or Result = 23 or Result = 24 or Result = 25 or Result = 26 or Result = 27
		end

	frozen get_op_code_type: INTEGER is
		external
			"IL signature (): enum System.Reflection.Emit.OpCodeType use System.Reflection.Emit.OpCode"
		alias
			"get_OpCodeType"
		ensure
			valid_op_code_type: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5
		end

	frozen get_operand_type: INTEGER is
		external
			"IL signature (): enum System.Reflection.Emit.OperandType use System.Reflection.Emit.OpCode"
		alias
			"get_OperandType"
		ensure
			valid_operand_type: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 13 or Result = 14 or Result = 15 or Result = 16 or Result = 17 or Result = 18
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.OpCode"
		alias
			"get_Name"
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.OpCode"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.OpCode"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.OpCode"
		alias
			"ToString"
		end

end -- class SYSTEM_REFLECTION_EMIT_OPCODE
