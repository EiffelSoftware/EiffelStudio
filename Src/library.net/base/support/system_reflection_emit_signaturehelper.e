indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.SignatureHelper"
		alias
			"ToString"
		end

	frozen get_local_var_sig_helper (mod: SYSTEM_REFLECTION_MODULE): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
		external
			"IL static signature (System.Reflection.Module): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetLocalVarSigHelper"
		end

	frozen get_signature: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.Emit.SignatureHelper"
		alias
			"GetSignature"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.SignatureHelper"
		alias
			"GetHashCode"
		end

	frozen add_sentinel is
		external
			"IL signature (): System.Void use System.Reflection.Emit.SignatureHelper"
		alias
			"AddSentinel"
		end

	frozen get_method_sig_helper_module_calling_conventions (mod: SYSTEM_REFLECTION_MODULE; calling_convention: SYSTEM_REFLECTION_CALLINGCONVENTIONS; return_type: SYSTEM_TYPE): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
		external
			"IL static signature (System.Reflection.Module, System.Reflection.CallingConventions, System.Type): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetMethodSigHelper"
		end

	frozen get_property_sig_helper (mod: SYSTEM_REFLECTION_MODULE; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Type[]): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetPropertySigHelper"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.SignatureHelper"
		alias
			"Equals"
		end

	frozen add_argument (cls_argument: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.SignatureHelper"
		alias
			"AddArgument"
		end

	frozen get_method_sig_helper (mod: SYSTEM_REFLECTION_MODULE; return_type: SYSTEM_TYPE; parameter_types: ARRAY [SYSTEM_TYPE]): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Type[]): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetMethodSigHelper"
		end

	frozen get_field_sig_helper (mod: SYSTEM_REFLECTION_MODULE): SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER is
		external
			"IL static signature (System.Reflection.Module): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetFieldSigHelper"
		end

end -- class SYSTEM_REFLECTION_EMIT_SIGNATUREHELPER
