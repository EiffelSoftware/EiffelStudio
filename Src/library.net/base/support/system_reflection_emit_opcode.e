indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.OpCode"

frozen expanded external class
	SYSTEM_REFLECTION_EMIT_OPCODE

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	frozen get_stack_behaviour_push: SYSTEM_REFLECTION_EMIT_STACKBEHAVIOUR is
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

	frozen get_operand_type: SYSTEM_REFLECTION_EMIT_OPERANDTYPE is
		external
			"IL signature (): System.Reflection.Emit.OperandType use System.Reflection.Emit.OpCode"
		alias
			"get_OperandType"
		end

	frozen get_flow_control: SYSTEM_REFLECTION_EMIT_FLOWCONTROL is
		external
			"IL signature (): System.Reflection.Emit.FlowControl use System.Reflection.Emit.OpCode"
		alias
			"get_FlowControl"
		end

	frozen get_op_code_type: SYSTEM_REFLECTION_EMIT_OPCODETYPE is
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

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.OpCode"
		alias
			"get_Name"
		end

	frozen get_stack_behaviour_pop: SYSTEM_REFLECTION_EMIT_STACKBEHAVIOUR is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.OpCode"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.OpCode"
		alias
			"ToString"
		end

end -- class SYSTEM_REFLECTION_EMIT_OPCODE
