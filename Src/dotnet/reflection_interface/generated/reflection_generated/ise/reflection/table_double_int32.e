indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TABLE_DOUBLE_INT32"

deferred external class
	TABLE_DOUBLE_INT32

inherit
	BAG_DOUBLE
	COLLECTION_DOUBLE
	CONTAINER_DOUBLE

feature -- Basic Operations

	item (k: INTEGER): DOUBLE is
		external
			"IL deferred signature (System.Int32): System.Double use TABLE_DOUBLE_INT32"
		alias
			"item"
		end

	put_double_int32 (v: DOUBLE; k: INTEGER) is
		external
			"IL deferred signature (System.Double, System.Int32): System.Void use TABLE_DOUBLE_INT32"
		alias
			"put"
		end

	valid_key (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_DOUBLE_INT32"
		alias
			"valid_key"
		end

	infix "@" (k: INTEGER): DOUBLE is
		external
			"IL deferred signature (System.Int32): System.Double use TABLE_DOUBLE_INT32"
		alias
			"infix %"@%""
		end

end -- class TABLE_DOUBLE_INT32
