indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.ObjectIDGenerator"

external class
	SYSTEM_RUNTIME_SERIALIZATION_OBJECTIDGENERATOR

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.ObjectIDGenerator"
		end

feature -- Basic Operations

	has_id (obj: ANY; first_time: BOOLEAN): INTEGER_64 is
		external
			"IL signature (System.Object, System.Boolean&): System.Int64 use System.Runtime.Serialization.ObjectIDGenerator"
		alias
			"HasId"
		end

	get_id (obj: ANY; first_time: BOOLEAN): INTEGER_64 is
		external
			"IL signature (System.Object, System.Boolean&): System.Int64 use System.Runtime.Serialization.ObjectIDGenerator"
		alias
			"GetId"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_OBJECTIDGENERATOR
