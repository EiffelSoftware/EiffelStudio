indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.SignatureHelper"

frozen external class
	SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER

inherit
	ANY
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

create {NONE}

feature -- Basic Operations

	frozen get_property_sig_helper (mod: SYSTEM_REFLECTION_MODULE; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Type[]): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetPropertySigHelper"
		end

	frozen get_field_sig_helper (mod: SYSTEM_REFLECTION_MODULE): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
		external
			"IL static signature (System.Reflection.Module): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetFieldSigHelper"
		end

	frozen get_method_sig_helper_with_conventions (mod: SYSTEM_REFLECTION_MODULE; calling_convention: INTEGER; returnType: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
			-- Valid values for `calling_convention' are a combination of the following values:
			-- Standard = 1
			-- VarArgs = 2
			-- Any = 3
			-- HasThis = 32
			-- ExplicitThis = 64
		require
			valid_calling_conventions: (1 + 2 + 3 + 32 + 64) & calling_convention = 1 + 2 + 3 + 32 + 64
		external
			"IL static signature (System.Reflection.Module, enum System.Reflection.CallingConventions, System.Type): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetMethodSigHelper"
		end

	frozen get_signature: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.Emit.SignatureHelper"
		alias
			"GetSignature"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.SignatureHelper"
		alias
			"Equals"
		end

	frozen get_method_sig_helper (mod: SYSTEM_REFLECTION_MODULE; returnType: SYSTEM_TYPE; parameterTypes: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Type[]): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetMethodSigHelper"
		end

	frozen get_local_var_sig_helper (mod: SYSTEM_REFLECTION_MODULE): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
		external
			"IL static signature (System.Reflection.Module): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetLocalVarSigHelper"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.SignatureHelper"
		alias
			"ToString"
		end

	frozen add_sentinel is
		external
			"IL signature (): System.Void use System.Reflection.Emit.SignatureHelper"
		alias
			"AddSentinel"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.SignatureHelper"
		alias
			"GetHashCode"
		end

	frozen add_argument (clsArgument: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.SignatureHelper"
		alias
			"AddArgument"
		end

end -- class SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER
