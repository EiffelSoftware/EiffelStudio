indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.MulticastDelegate"

deferred external class
	SYSTEM_MULTICASTDELEGATE

inherit
	SYSTEM_DELEGATE
		redefine
			remove_impl,
			combine_impl,
			get_invocation_list,
			dynamic_invoke_impl,
			get_hash_code,
			is_equal
		end
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

feature -- Basic Operations

	get_invocation_list: ARRAY [SYSTEM_DELEGATE] is
		external
			"IL signature (): System.Delegate[] use System.MulticastDelegate"
		alias
			"GetInvocationList"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.MulticastDelegate"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.MulticastDelegate"
		alias
			"Equals"
		end

feature -- Binary Operators

	frozen op_inequality_multicast_delegate (d2: SYSTEM_MULTICASTDELEGATE): BOOLEAN is
		external
			"IL operator signature (System.MulticastDelegate): System.Boolean use System.MulticastDelegate"
		alias
			"op_Inequality"
		end

	frozen op_equality_multicast_delegate (d2: SYSTEM_MULTICASTDELEGATE): BOOLEAN is
		external
			"IL operator signature (System.MulticastDelegate): System.Boolean use System.MulticastDelegate"
		alias
			"op_Equality"
		end

feature {NONE} -- Implementation

	remove_impl (value: SYSTEM_DELEGATE): SYSTEM_DELEGATE is
		external
			"IL signature (System.Delegate): System.Delegate use System.MulticastDelegate"
		alias
			"RemoveImpl"
		end

	combine_impl (follow: SYSTEM_DELEGATE): SYSTEM_DELEGATE is
		external
			"IL signature (System.Delegate): System.Delegate use System.MulticastDelegate"
		alias
			"CombineImpl"
		end

	dynamic_invoke_impl (args: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Object[]): System.Object use System.MulticastDelegate"
		alias
			"DynamicInvokeImpl"
		end

end -- class SYSTEM_MULTICASTDELEGATE
