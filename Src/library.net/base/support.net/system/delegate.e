indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Delegate"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DELEGATE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
	ISERIALIZABLE

feature -- Access

	frozen get_method: METHOD_INFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Delegate"
		alias
			"get_Method"
		end

	frozen get_target: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Delegate"
		alias
			"get_Target"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Delegate"
		alias
			"ToString"
		end

	frozen dynamic_invoke (args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.Object[]): System.Object use System.Delegate"
		alias
			"DynamicInvoke"
		end

	frozen create_delegate_type_type (type: TYPE; target: TYPE; method: SYSTEM_STRING): DELEGATE is
		external
			"IL static signature (System.Type, System.Type, System.String): System.Delegate use System.Delegate"
		alias
			"CreateDelegate"
		end

	frozen remove (source: DELEGATE; value: DELEGATE): DELEGATE is
		external
			"IL static signature (System.Delegate, System.Delegate): System.Delegate use System.Delegate"
		alias
			"Remove"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Delegate"
		alias
			"Clone"
		end

	frozen create_delegate (type: TYPE; method: METHOD_INFO): DELEGATE is
		external
			"IL static signature (System.Type, System.Reflection.MethodInfo): System.Delegate use System.Delegate"
		alias
			"CreateDelegate"
		end

	get_invocation_list: NATIVE_ARRAY [DELEGATE] is
		external
			"IL signature (): System.Delegate[] use System.Delegate"
		alias
			"GetInvocationList"
		end

	frozen combine_delegate (a: DELEGATE; b: DELEGATE): DELEGATE is
		external
			"IL static signature (System.Delegate, System.Delegate): System.Delegate use System.Delegate"
		alias
			"Combine"
		end

	frozen create_delegate_type_object_string_boolean (type: TYPE; target: SYSTEM_OBJECT; method: SYSTEM_STRING; ignore_case: BOOLEAN): DELEGATE is
		external
			"IL static signature (System.Type, System.Object, System.String, System.Boolean): System.Delegate use System.Delegate"
		alias
			"CreateDelegate"
		end

	frozen combine (delegates: NATIVE_ARRAY [DELEGATE]): DELEGATE is
		external
			"IL static signature (System.Delegate[]): System.Delegate use System.Delegate"
		alias
			"Combine"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Delegate"
		alias
			"Equals"
		end

	frozen create_delegate_type_object_string (type: TYPE; target: SYSTEM_OBJECT; method: SYSTEM_STRING): DELEGATE is
		external
			"IL static signature (System.Type, System.Object, System.String): System.Delegate use System.Delegate"
		alias
			"CreateDelegate"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Delegate"
		alias
			"GetObjectData"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Delegate"
		alias
			"GetHashCode"
		end

feature -- Binary Operators

	frozen infix "#==" (d2: DELEGATE): BOOLEAN is
		external
			"IL operator signature (System.Delegate): System.Boolean use System.Delegate"
		alias
			"op_Equality"
		end

	frozen infix "|=" (d2: DELEGATE): BOOLEAN is
		external
			"IL operator signature (System.Delegate): System.Boolean use System.Delegate"
		alias
			"op_Inequality"
		end

feature {NONE} -- Implementation

	remove_impl (d: DELEGATE): DELEGATE is
		external
			"IL signature (System.Delegate): System.Delegate use System.Delegate"
		alias
			"RemoveImpl"
		end

	combine_impl (d: DELEGATE): DELEGATE is
		external
			"IL signature (System.Delegate): System.Delegate use System.Delegate"
		alias
			"CombineImpl"
		end

	get_method_impl: METHOD_INFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Delegate"
		alias
			"GetMethodImpl"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Delegate"
		alias
			"Finalize"
		end

	dynamic_invoke_impl (args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.Object[]): System.Object use System.Delegate"
		alias
			"DynamicInvokeImpl"
		end

end -- class DELEGATE
