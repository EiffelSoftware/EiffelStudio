indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Object"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_OBJECT
	
feature -- Basic Operations

	frozen equals_object_object (obj_a: SYSTEM_OBJECT; obj_b: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Object, System.Object): System.Boolean use System.Object"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Object"
		alias
			"GetHashCode"
		end

	frozen get_type: TYPE is
		external
			"IL signature (): System.Type use System.Object"
		alias
			"GetType"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Object"
		alias
			"ToString"
		end

	frozen reference_equals (obj_a: SYSTEM_OBJECT; obj_b: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Object, System.Object): System.Boolean use System.Object"
		alias
			"ReferenceEquals"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Object"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Object"
		alias
			"Finalize"
		end
		
	memberwise_clone is
		external
			"IL signature (): System.Object use System.Object"
		alias
			"MemberwiseClone"
		end
		
end -- class SYSTEM_OBJECT
