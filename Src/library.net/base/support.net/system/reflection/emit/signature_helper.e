indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.SignatureHelper"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SIGNATURE_HELPER

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.SignatureHelper"
		alias
			"ToString"
		end

	frozen get_local_var_sig_helper (mod: MODULE): SIGNATURE_HELPER is
		external
			"IL static signature (System.Reflection.Module): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetLocalVarSigHelper"
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

	frozen get_method_sig_helper_module_type (mod: MODULE; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]): SIGNATURE_HELPER is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Type[]): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetMethodSigHelper"
		end

	frozen get_property_sig_helper (mod: MODULE; return_type: TYPE; parameter_types: NATIVE_ARRAY [TYPE]): SIGNATURE_HELPER is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Type[]): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetPropertySigHelper"
		end

	frozen get_signature: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Reflection.Emit.SignatureHelper"
		alias
			"GetSignature"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.SignatureHelper"
		alias
			"Equals"
		end

	frozen add_argument (cls_argument: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Reflection.Emit.SignatureHelper"
		alias
			"AddArgument"
		end

	frozen get_method_sig_helper_module_calling_convention (mod: MODULE; unmanaged_call_conv: CALLING_CONVENTION; return_type: TYPE): SIGNATURE_HELPER is
		external
			"IL static signature (System.Reflection.Module, System.Runtime.InteropServices.CallingConvention, System.Type): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetMethodSigHelper"
		end

	frozen get_method_sig_helper (mod: MODULE; calling_convention: CALLING_CONVENTIONS; return_type: TYPE): SIGNATURE_HELPER is
		external
			"IL static signature (System.Reflection.Module, System.Reflection.CallingConventions, System.Type): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetMethodSigHelper"
		end

	frozen get_field_sig_helper (mod: MODULE): SIGNATURE_HELPER is
		external
			"IL static signature (System.Reflection.Module): System.Reflection.Emit.SignatureHelper use System.Reflection.Emit.SignatureHelper"
		alias
			"GetFieldSigHelper"
		end

end -- class SIGNATURE_HELPER
