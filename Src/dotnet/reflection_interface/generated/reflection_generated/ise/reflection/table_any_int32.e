indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TABLE_ANY_INT32"

deferred external class
	TABLE_ANY_INT32

inherit
	BAG_ANY
	COLLECTION_ANY
	CONTAINER_ANY

feature -- Basic Operations

	item (k: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): ANY use TABLE_ANY_INT32"
		alias
			"item"
		end

	infix "@" (k: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): ANY use TABLE_ANY_INT32"
		alias
			"infix %"@%""
		end

	put_any_int32 (v: ANY; k: INTEGER) is
		external
			"IL deferred signature (ANY, System.Int32): System.Void use TABLE_ANY_INT32"
		alias
			"put"
		end

	valid_key (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_ANY_INT32"
		alias
			"valid_key"
		end

end -- class TABLE_ANY_INT32
