indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TABLE_BYTE_INT32"

deferred external class
	TABLE_BYTE_INT32

inherit
	CONTAINER_BYTE
	COLLECTION_BYTE
	BAG_BYTE

feature -- Basic Operations

	infix "@" (k: INTEGER): INTEGER_8 is
		external
			"IL deferred signature (System.Int32): System.Byte use TABLE_BYTE_INT32"
		alias
			"infix %"@%""
		end

	valid_key (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_BYTE_INT32"
		alias
			"valid_key"
		end

	put_byte_int32 (v: INTEGER_8; k: INTEGER) is
		external
			"IL deferred signature (System.Byte, System.Int32): System.Void use TABLE_BYTE_INT32"
		alias
			"put"
		end

	item (k: INTEGER): INTEGER_8 is
		external
			"IL deferred signature (System.Int32): System.Byte use TABLE_BYTE_INT32"
		alias
			"item"
		end

end -- class TABLE_BYTE_INT32
