indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TABLE_SINGLE_INT32"

deferred external class
	TABLE_SINGLE_INT32

inherit
	CONTAINER_SINGLE
	COLLECTION_SINGLE
	BAG_SINGLE

feature -- Basic Operations

	infix "@" (k: INTEGER): REAL is
		external
			"IL deferred signature (System.Int32): System.Single use TABLE_SINGLE_INT32"
		alias
			"infix %"@%""
		end

	put_single_int32 (v: REAL; k: INTEGER) is
		external
			"IL deferred signature (System.Single, System.Int32): System.Void use TABLE_SINGLE_INT32"
		alias
			"put"
		end

	valid_key (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_SINGLE_INT32"
		alias
			"valid_key"
		end

	item (k: INTEGER): REAL is
		external
			"IL deferred signature (System.Int32): System.Single use TABLE_SINGLE_INT32"
		alias
			"item"
		end

end -- class TABLE_SINGLE_INT32
