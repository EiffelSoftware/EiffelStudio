indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.OpCode"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	OP_CODE

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	frozen get_stack_behaviour_push: STACK_BEHAVIOUR is
		external
			"IL signature (): System.Reflection.Emit.StackBehaviour use System.Reflection.Emit.OpCode"
		alias
			"get_StackBehaviourPush"
		end

	frozen get_value: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Reflection.Emit.OpCode"
		alias
			"get_Value"
		end

	frozen get_operand_type: OPERAND_TYPE is
		external
			"IL signature (): System.Reflection.Emit.OperandType use System.Reflection.Emit.OpCode"
		alias
			"get_OperandType"
		end

	frozen get_flow_control: FLOW_CONTROL is
		external
			"IL signature (): System.Reflection.Emit.FlowControl use System.Reflection.Emit.OpCode"
		alias
			"get_FlowControl"
		end

	frozen get_op_code_type: OP_CODE_TYPE is
		external
			"IL signature (): System.Reflection.Emit.OpCodeType use System.Reflection.Emit.OpCode"
		alias
			"get_OpCodeType"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.OpCode"
		alias
			"get_Size"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.OpCode"
		alias
			"get_Name"
		end

	frozen get_stack_behaviour_pop: STACK_BEHAVIOUR is
		external
			"IL signature (): System.Reflection.Emit.StackBehaviour use System.Reflection.Emit.OpCode"
		alias
			"get_StackBehaviourPop"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.OpCode"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.OpCode"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.OpCode"
		alias
			"Equals"
		end

end -- class OP_CODE
