indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TABLE_INTPTR_INT32"

deferred external class
	TABLE_INTPTR_INT32

inherit
	BAG_INTPTR
	CONTAINER_INTPTR
	COLLECTION_INTPTR

feature -- Basic Operations

	item (k: INTEGER): POINTER is
		external
			"IL deferred signature (System.Int32): System.IntPtr use TABLE_INTPTR_INT32"
		alias
			"item"
		end

	infix "@" (k: INTEGER): POINTER is
		external
			"IL deferred signature (System.Int32): System.IntPtr use TABLE_INTPTR_INT32"
		alias
			"infix %"@%""
		end

	valid_key (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_INTPTR_INT32"
		alias
			"valid_key"
		end

	put_int_ptr_int32 (v: POINTER; k: INTEGER) is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Void use TABLE_INTPTR_INT32"
		alias
			"put"
		end

end -- class TABLE_INTPTR_INT32
