indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.ILGenerator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ILGENERATOR

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	define_label: LABEL is
		external
			"IL signature (): System.Reflection.Emit.Label use System.Reflection.Emit.ILGenerator"
		alias
			"DefineLabel"
		end

	emit (opcode: OP_CODE) is
		external
			"IL signature (System.Reflection.Emit.OpCode): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_write_line (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitWriteLine"
		end

	emit_op_code_type (opcode: OP_CODE; cls: TYPE) is
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

	frozen emit_call (opcode: OP_CODE; method_info: METHOD_INFO; optional_parameter_types: NATIVE_ARRAY [TYPE]) is
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

	emit_op_code_method_info (opcode: OP_CODE; meth: METHOD_INFO) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	throw_exception (exc_type: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"ThrowException"
		end

	frozen declare_local (local_type: TYPE): LOCAL_BUILDER is
		external
			"IL signature (System.Type): System.Reflection.Emit.LocalBuilder use System.Reflection.Emit.ILGenerator"
		alias
			"DeclareLocal"
		end

	emit_op_code_single (opcode: OP_CODE; arg: REAL) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Single): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	begin_exception_block: LABEL is
		external
			"IL signature (): System.Reflection.Emit.Label use System.Reflection.Emit.ILGenerator"
		alias
			"BeginExceptionBlock"
		end

	frozen using_namespace (using_namespace2: SYSTEM_STRING) is
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

	emit_op_code_array_label (opcode: OP_CODE; labels: NATIVE_ARRAY [LABEL]) is
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

	mark_label (loc: LABEL) is
		external
			"IL signature (System.Reflection.Emit.Label): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"MarkLabel"
		end

	emit_op_code_int32 (opcode: OP_CODE; arg: INTEGER) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Int32): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	frozen emit_calli_op_code_calling_conventions (opcode: OP_CODE; calling_convention: CALLING_CONVENTIONS; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]; optional_parameter_types: NATIVE_ARRAY [TYPE]) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.CallingConventions, System.Type, System.Type[], System.Type[]): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitCalli"
		end

	emit_op_code_int64 (opcode: OP_CODE; arg: INTEGER_64) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Int64): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_string (opcode: OP_CODE; str: SYSTEM_STRING) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.String): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	mark_sequence_point (document: ISYMBOL_DOCUMENT_WRITER; start_line: INTEGER; start_column: INTEGER; end_line: INTEGER; end_column: INTEGER) is
		external
			"IL signature (System.Diagnostics.SymbolStore.ISymbolDocumentWriter, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"MarkSequencePoint"
		end

	emit_op_code_byte (opcode: OP_CODE; arg: INTEGER_8) is
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

	emit_op_code_double (opcode: OP_CODE; arg: DOUBLE) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Double): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_write_line_field_info (fld: FIELD_INFO) is
		external
			"IL signature (System.Reflection.FieldInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitWriteLine"
		end

	emit_write_line_local_builder (local_builder: LOCAL_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.LocalBuilder): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitWriteLine"
		end

	emit_op_code_constructor_info (opcode: OP_CODE; con: CONSTRUCTOR_INFO) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.ConstructorInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_signature_helper (opcode: OP_CODE; signature: SIGNATURE_HELPER) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.SignatureHelper): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	begin_catch_block (exception_type: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginCatchBlock"
		end

	frozen emit_calli (opcode: OP_CODE; unmanaged_call_conv: CALLING_CONVENTION; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Runtime.InteropServices.CallingConvention, System.Type, System.Type[]): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitCalli"
		end

	emit_op_code_local_builder (opcode: OP_CODE; local_: LOCAL_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.LocalBuilder): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_int16 (opcode: OP_CODE; arg: INTEGER_16) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Int16): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_field_info (opcode: OP_CODE; field: FIELD_INFO) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.FieldInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_op_code_label (opcode: OP_CODE; label: LABEL) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.Label): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

end -- class ILGENERATOR
