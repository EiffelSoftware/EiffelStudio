indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Delegate"

deferred external class
	SYSTEM_DELEGATE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

feature -- Access

	frozen get_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Delegate"
		alias
			"get_Method"
		end

	frozen get_target: ANY is
		external
			"IL signature (): System.Object use System.Delegate"
		alias
			"get_Target"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Delegate"
		alias
			"ToString"
		end

	frozen dynamic_invoke (args: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Object[]): System.Object use System.Delegate"
		alias
			"DynamicInvoke"
		end

	frozen create_delegate_type_type (type: SYSTEM_TYPE; target: SYSTEM_TYPE; method: STRING): SYSTEM_DELEGATE is
		external
			"IL static signature (System.Type, System.Type, System.String): System.Delegate use System.Delegate"
		alias
			"CreateDelegate"
		end

	frozen remove (source: SYSTEM_DELEGATE; value: SYSTEM_DELEGATE): SYSTEM_DELEGATE is
		external
			"IL static signature (System.Delegate, System.Delegate): System.Delegate use System.Delegate"
		alias
			"Remove"
		end

	frozen create_delegate_type_object (type: SYSTEM_TYPE; target: ANY; method: STRING): SYSTEM_DELEGATE is
		external
			"IL static signature (System.Type, System.Object, System.String): System.Delegate use System.Delegate"
		alias
			"CreateDelegate"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Delegate"
		alias
			"Clone"
		end

	get_invocation_list: ARRAY [SYSTEM_DELEGATE] is
		external
			"IL signature (): System.Delegate[] use System.Delegate"
		alias
			"GetInvocationList"
		end

	frozen combine_delegate (a: SYSTEM_DELEGATE; b: SYSTEM_DELEGATE): SYSTEM_DELEGATE is
		external
			"IL static signature (System.Delegate, System.Delegate): System.Delegate use System.Delegate"
		alias
			"Combine"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Delegate"
		alias
			"Equals"
		end

	frozen combine (delegates: ARRAY [SYSTEM_DELEGATE]): SYSTEM_DELEGATE is
		external
			"IL static signature (System.Delegate[]): System.Delegate use System.Delegate"
		alias
			"Combine"
		end

	frozen create_delegate (type: SYSTEM_TYPE; method: SYSTEM_REFLECTION_METHODINFO): SYSTEM_DELEGATE is
		external
			"IL static signature (System.Type, System.Reflection.MethodInfo): System.Delegate use System.Delegate"
		alias
			"CreateDelegate"
		end

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
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

	frozen infix "#==" (d2: SYSTEM_DELEGATE): BOOLEAN is
		external
			"IL operator signature (System.Delegate): System.Boolean use System.Delegate"
		alias
			"op_Equality"
		end

	frozen infix "|=" (d2: SYSTEM_DELEGATE): BOOLEAN is
		external
			"IL operator signature (System.Delegate): System.Boolean use System.Delegate"
		alias
			"op_Inequality"
		end

feature {NONE} -- Implementation

	remove_impl (d: SYSTEM_DELEGATE): SYSTEM_DELEGATE is
		external
			"IL signature (System.Delegate): System.Delegate use System.Delegate"
		alias
			"RemoveImpl"
		end

	combine_impl (d: SYSTEM_DELEGATE): SYSTEM_DELEGATE is
		external
			"IL signature (System.Delegate): System.Delegate use System.Delegate"
		alias
			"CombineImpl"
		end

	get_method_impl: SYSTEM_REFLECTION_METHODINFO is
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

	dynamic_invoke_impl (args: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Object[]): System.Object use System.Delegate"
		alias
			"DynamicInvokeImpl"
		end

end -- class SYSTEM_DELEGATE
