indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TABLE_BOOLEAN_INT32"

deferred external class
	TABLE_BOOLEAN_INT32

inherit
	CONTAINER_BOOLEAN
	BAG_BOOLEAN
	COLLECTION_BOOLEAN

feature -- Basic Operations

	item (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_BOOLEAN_INT32"
		alias
			"item"
		end

	infix "@" (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_BOOLEAN_INT32"
		alias
			"infix %"@%""
		end

	put_boolean_int32 (v: BOOLEAN; k: INTEGER) is
		external
			"IL deferred signature (System.Boolean, System.Int32): System.Void use TABLE_BOOLEAN_INT32"
		alias
			"put"
		end

	valid_key (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_BOOLEAN_INT32"
		alias
			"valid_key"
		end

end -- class TABLE_BOOLEAN_INT32
