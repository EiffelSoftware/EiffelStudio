indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.ILGenerator"

external class
	SYSTEM_REFLECTION_EMIT_ILGENERATOR

create {NONE}

feature -- Basic Operations

	frozen declare_local (localType: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_LOCALBUILDER is
		external
			"IL signature (System.Type): System.Reflection.Emit.LocalBuilder use System.Reflection.Emit.ILGenerator"
		alias
			"DeclareLocal"
		end

	end_scope is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EndScope"
		end

	frozen emit_call (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; methodInfo: SYSTEM_REFLECTION_METHODINFO; optionalParameterTypes: ARRAY [SYSTEM_TYPE]) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.MethodInfo, System.Type[]): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitCall"
		end

	frozen emit_calli (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; calling_convention: INTEGER; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]; optionalParameterTypes: ARRAY [SYSTEM_TYPE]) is
			-- Valid values for `calling_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & calling_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL signature (System.Reflection.Emit.OpCode, enum System.Reflection.CallingConventions, System.Type, System.Type[], System.Type[]): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitCalli"
		end

	define_label: SYSTEM_REFLECTION_EMIT_LABEL is
		external
			"IL signature (): System.Reflection.Emit.Label use System.Reflection.Emit.ILGenerator"
		alias
			"DefineLabel"
		end

	mark_sequence_point (document: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENTWRITER; startLine: INTEGER; startColumn: INTEGER; endLine: INTEGER; endColumn: INTEGER) is
		external
			"IL signature (System.Diagnostics.SymbolStore.ISymbolDocumentWriter, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"MarkSequencePoint"
		end

	emit_include_labels (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; labels: ARRAY [SYSTEM_REFLECTION_EMIT_LABEL]) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.Label[]): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_include_label (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; label: SYSTEM_REFLECTION_EMIT_LABEL) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.Label): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_field_metadata (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; field: SYSTEM_REFLECTION_FIELDINFO) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.FieldInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_int64 (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: INTEGER_64) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Int64): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_string (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; str: STRING) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.String): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_byte (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: INTEGER_8) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Byte): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_method_metadata (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; meth: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.MethodInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_double (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: DOUBLE) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Double): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_int16 (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: INTEGER_16) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Int16): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_type (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; cls: SYSTEM_TYPE) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Type): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_signature (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; signature: SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.SignatureHelper): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit (opcode: SYSTEM_REFLECTION_EMIT_OPCODE) is
		external
			"IL signature (System.Reflection.Emit.OpCode): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_integer (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: INTEGER) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Int32): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_constructor_metadata (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; con: SYSTEM_REFLECTION_CONSTRUCTORINFO) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.ConstructorInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_local_metadata (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; local_: SYSTEM_REFLECTION_EMIT_LOCALBUILDER) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Reflection.Emit.LocalBuilder): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_instruction_and_real (opcode: SYSTEM_REFLECTION_EMIT_OPCODE; arg: REAL) is
		external
			"IL signature (System.Reflection.Emit.OpCode, System.Single): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"Emit"
		end

	emit_write_line_with_field (fld: SYSTEM_REFLECTION_FIELDINFO) is
		external
			"IL signature (System.Reflection.FieldInfo): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitWriteLine"
		end

	emit_write_line_with_local_variable (localBuilder: SYSTEM_REFLECTION_EMIT_LOCALBUILDER) is
		external
			"IL signature (System.Reflection.Emit.LocalBuilder): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitWriteLine"
		end

	emit_write_line (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EmitWriteLine"
		end

	begin_catch_block (exceptionType: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginCatchBlock"
		end

	begin_exception_block: SYSTEM_REFLECTION_EMIT_LABEL is
		external
			"IL signature (): System.Reflection.Emit.Label use System.Reflection.Emit.ILGenerator"
		alias
			"BeginExceptionBlock"
		end

	begin_except_filter_block is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginExceptFilterBlock"
		end

	begin_finally_block is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginFinallyBlock"
		end

	frozen using_namespace (usingNamespace2: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"UsingNamespace"
		end

	throw_exception (excType: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"ThrowException"
		end

	begin_scope is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginScope"
		end

	mark_label (loc: SYSTEM_REFLECTION_EMIT_LABEL) is
		external
			"IL signature (System.Reflection.Emit.Label): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"MarkLabel"
		end

	begin_fault_block is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"BeginFaultBlock"
		end

	end_exception_block is
		external
			"IL signature (): System.Void use System.Reflection.Emit.ILGenerator"
		alias
			"EndExceptionBlock"
		end

end -- class SYSTEM_REFLECTION_EMIT_ILGENERATOR
