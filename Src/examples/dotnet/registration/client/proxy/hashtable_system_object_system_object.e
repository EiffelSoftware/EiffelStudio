indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "HashTable_System_Object_System_Object"
	assembly: "Registrar", "0.0.0.0", "neutral", ""

external class
	HASHTABLE_SYSTEM_OBJECT_SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use HashTable_System_Object_System_Object"
		end

feature -- Access

	frozen a_internal_position: INTEGER is
		external
			"IL field signature :System.Int32 use HashTable_System_Object_System_Object"
		alias
			"_internal_position"
		end

	frozen a_internal_content: ARRAY [ANY] is
		external
			"IL field signature :System.Object[] use HashTable_System_Object_System_Object"
		alias
			"_internal_content"
		end

	frozen a_internal_keys: ARRAY [ANY] is
		external
			"IL field signature :System.Object[] use HashTable_System_Object_System_Object"
		alias
			"_internal_keys"
		end

	frozen a_internal_internal_count: INTEGER is
		external
			"IL field signature :System.Int32 use HashTable_System_Object_System_Object"
		alias
			"_internal_internal_count"
		end

	frozen a_internal_iteration_position: INTEGER is
		external
			"IL field signature :System.Int32 use HashTable_System_Object_System_Object"
		alias
			"_internal_iteration_position"
		end

	frozen a_internal_internal_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use HashTable_System_Object_System_Object"
		alias
			"_internal_internal_object_comparison"
		end

	frozen a_internal_control: INTEGER is
		external
			"IL field signature :System.Int32 use HashTable_System_Object_System_Object"
		alias
			"_internal_control"
		end

	frozen a_internal_deleted_marks: ARRAY [BOOLEAN] is
		external
			"IL field signature :System.Boolean[] use HashTable_System_Object_System_Object"
		alias
			"_internal_deleted_marks"
		end

	frozen a_internal_found_item: ANY is
		external
			"IL field signature :System.Object use HashTable_System_Object_System_Object"
		alias
			"_internal_found_item"
		end

end -- class HASHTABLE_SYSTEM_OBJECT_SYSTEM_OBJECT
