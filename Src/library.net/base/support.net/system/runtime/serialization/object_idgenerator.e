indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.ObjectIDGenerator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	OBJECT_IDGENERATOR

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.ObjectIDGenerator"
		end

feature -- Basic Operations

	has_id (obj: SYSTEM_OBJECT; first_time: BOOLEAN): INTEGER_64 is
		external
			"IL signature (System.Object, System.Boolean&): System.Int64 use System.Runtime.Serialization.ObjectIDGenerator"
		alias
			"HasId"
		end

	get_id (obj: SYSTEM_OBJECT; first_time: BOOLEAN): INTEGER_64 is
		external
			"IL signature (System.Object, System.Boolean&): System.Int64 use System.Runtime.Serialization.ObjectIDGenerator"
		alias
			"GetId"
		end

end -- class OBJECT_IDGENERATOR
