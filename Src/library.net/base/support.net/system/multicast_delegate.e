indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.MulticastDelegate"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	MULTICAST_DELEGATE

inherit
	DELEGATE
		redefine
			get_object_data,
			remove_impl,
			combine_impl,
			get_invocation_list,
			dynamic_invoke_impl,
			get_hash_code,
			equals
		end
	ICLONEABLE
	ISERIALIZABLE

feature -- Basic Operations

	frozen get_invocation_list: NATIVE_ARRAY [DELEGATE] is
		external
			"IL signature (): System.Delegate[] use System.MulticastDelegate"
		alias
			"GetInvocationList"
		end

	frozen get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.MulticastDelegate"
		alias
			"GetHashCode"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.MulticastDelegate"
		alias
			"GetObjectData"
		end

	frozen equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.MulticastDelegate"
		alias
			"Equals"
		end

feature -- Binary Operators

	frozen op_inequality_multicast_delegate (d2: MULTICAST_DELEGATE): BOOLEAN is
		external
			"IL operator signature (System.MulticastDelegate): System.Boolean use System.MulticastDelegate"
		alias
			"op_Inequality"
		end

	frozen op_equality_multicast_delegate (d2: MULTICAST_DELEGATE): BOOLEAN is
		external
			"IL operator signature (System.MulticastDelegate): System.Boolean use System.MulticastDelegate"
		alias
			"op_Equality"
		end

feature {NONE} -- Implementation

	frozen remove_impl (value: DELEGATE): DELEGATE is
		external
			"IL signature (System.Delegate): System.Delegate use System.MulticastDelegate"
		alias
			"RemoveImpl"
		end

	frozen combine_impl (follow: DELEGATE): DELEGATE is
		external
			"IL signature (System.Delegate): System.Delegate use System.MulticastDelegate"
		alias
			"CombineImpl"
		end

	frozen dynamic_invoke_impl (args: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.Object[]): System.Object use System.MulticastDelegate"
		alias
			"DynamicInvokeImpl"
		end

end -- class MULTICAST_DELEGATE
