indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TABLE_INT32_INT32"

deferred external class
	TABLE_INT32_INT32

inherit
	BAG_INT32
	CONTAINER_INT32
	COLLECTION_INT32

feature -- Basic Operations

	infix "@" (k: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use TABLE_INT32_INT32"
		alias
			"infix %"@%""
		end

	valid_key (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_INT32_INT32"
		alias
			"valid_key"
		end

	put_int32_int32 (v: INTEGER; k: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Void use TABLE_INT32_INT32"
		alias
			"put"
		end

	item (k: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use TABLE_INT32_INT32"
		alias
			"item"
		end

end -- class TABLE_INT32_INT32
