indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Object"

external class
	ANY

create
	default_create

feature {NONE} -- Initialization

	frozen default_create is
		external
			"IL creator use System.Object"
		end

feature -- Basic Operations

	frozen equals_object_object (obj_a: ANY; obj_b: ANY): BOOLEAN is
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

	frozen get_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Object"
		alias
			"GetType"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Object"
		alias
			"ToString"
		end

	frozen reference_equal (obj_a: ANY; obj_b: ANY): BOOLEAN is
		external
			"IL static signature (System.Object, System.Object): System.Boolean use System.Object"
		alias
			"ReferenceEquals"
		end

	Void: NONE

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Object"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen memberwise_clone: ANY is
		external
			"IL signature (): System.Object use System.Object"
		alias
			"MemberwiseClone"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Object"
		alias
			"Finalize"
		end

end -- class ANY
