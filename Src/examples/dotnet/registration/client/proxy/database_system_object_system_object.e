indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "DataBase_System_Object_System_Object"
	assembly: "Registrar", "0.0.0.0", "neutral", ""

external class
	DATABASE_SYSTEM_OBJECT_SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use DataBase_System_Object_System_Object"
		end

feature -- Access

	frozen a_internal_max_items: INTEGER is
		external
			"IL field signature :System.Int32 use DataBase_System_Object_System_Object"
		alias
			"_internal_max_items"
		end

	frozen a_internal_table: HASHTABLE_SYSTEM_OBJECT_SYSTEM_OBJECT is
		external
			"IL field signature :HashTable_System_Object_System_Object use DataBase_System_Object_System_Object"
		alias
			"_internal_table"
		end

	frozen a_internal_item: ANY is
		external
			"IL field signature :System.Object use DataBase_System_Object_System_Object"
		alias
			"_internal_item"
		end

end -- class DATABASE_SYSTEM_OBJECT_SYSTEM_OBJECT
