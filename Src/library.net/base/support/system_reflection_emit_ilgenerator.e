indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.ILGenerator"

external class
	SYSTEM_REFLECTION_EMIT_ILGENERATOR

create {NONE}

feature -- Basic Operations

	define_label: SYSTEM_REFLECTION_EMIT_LABEL is
		external
			"IL signature (): System.Reflection.Emit.Label use System.Reflection.Emit.ILGenerator"
		alias
			"DefineLabel"
		end

	emit (opcode: SYSTEM_REFLECTION_EMIT_OPCODE) is
		external
			"IL signature (System.Reflection.Emit.OpCode): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_write_line (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitWriteLine"
		end

	emit_op_code_type (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; cls: SYSTEM_TYPE) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Type): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	begin_except_filter_block is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginExceptFilterBlock"
		end

	frozen emit_call (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; method_info: SYSTEM_REFLECTION_METHODINFO; optional_parameter_types: ARRAY [SYSTEM_TYPE]) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.MethodInfo, System.Type[]): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitCall"
		end

	begin_scope is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginScope"
		end

	emit_op_code_method_info (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; meth: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	throw_exception (exc_type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"ThrowException"
		end

	frozen declare_local (local_type: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_LOCALBUILDER is
		external
			"IL signature (System.Type): System.Reflection.Emit.LocalBuilder use System.Reflection.Emit.ILGenerator"
		alias
			"DeclareLocal"
		end

	emit_op_code_single (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: REAL) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Single): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	begin_exception_block: SYSTEM_REFLECTION_EMIT_LABEL is
		external
			"IL signature (): System.Reflection.Emit.Label use System.Reflection.Emit.ILGenerator"
		alias
			"BeginExceptionBlock"
		end

	frozen using_namespace (using_namespace2: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"UsingNamespace"
		end

	begin_fault_block is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginFaultBlock"
		end

	end_scope is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EndScope"
		end

	emit_op_code_array_label (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; labels: ARRAY [SYSTEM_REFLECTION_EMIT_LABEL]) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.Label[]): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	end_exception_block is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EndExceptionBlock"
		end

	mark_label (loc: SYSTEM_REFLECTION_EMIT_LABEL) is
		external
			"IL signature (System.Reflection.Emit.Label): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"MarkLabel"
		end

	emit_op_code_int32 (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: INTEGER) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Int32): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_int64 (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: INTEGER_64) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Int64): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_string (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; str: STRING) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.String): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	mark_sequence_point (document: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENTWRITER; start_line: INTEGER; start_column: INTEGER; end_line: INTEGER; end_column: INTEGER) is
		external
			"IL signature (System.Diagnostics.SymbolStore.ISymbolDocumentWriter, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"MarkSequencePoint"
		end

	emit_op_code_byte (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: INTEGER_8) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Byte): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	begin_finally_block is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginFinallyBlock"
		end

	emit_op_code_double (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: DOUBLE) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Double): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_write_line_field_info (fld: SYSTEM_REFLECTION_FIELDINFO) is
		external
			"IL signature (System.Reflection.FieldInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitWriteLine"
		end

	emit_write_line_local_builder (local_builder: SYSTEM_REFLECTION_EMIT_LOCALBUILDER) is
		external
			"IL signature (System.Reflection.Emit.LocalBuilder): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitWriteLine"
		end

	emit_op_code_constructor_info (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; con: SYSTEM_REFLECTION_CONSTRUCTORINFO) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.ConstructorInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_signature_helper (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; signature: SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.SignatureHelper): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	begin_catch_block (exception_type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginCatchBlock"
		end

	emit_op_code_int16 (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: INTEGER_16) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Int16): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_local_builder (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; local_: SYSTEM_REFLECTION_EMIT_LOCALBUILDER) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.LocalBuilder): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	frozen emit_calli (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]; optional_parameter_types: ARRAY [SYSTEM_TYPE]) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.CallingConventions, System.Type, System.Type[], System.Type[]): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitCalli"
		end

	emit_op_code_field_info (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; field: SYSTEM_REFLECTION_FIELDINFO) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.FieldInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_label (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; label: SYSTEM_REFLECTION_EMIT_LABEL) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.Label): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

end -- class SYSTEM_REFLECTION_EMIT_ILGENERATOR
