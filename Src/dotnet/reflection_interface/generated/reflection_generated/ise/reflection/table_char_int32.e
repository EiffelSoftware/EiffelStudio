indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "TABLE_CHAR_INT32"

deferred external class
	TABLE_CHAR_INT32

inherit
	COLLECTION_CHAR
	BAG_CHAR
	CONTAINER_CHAR

feature -- Basic Operations

	infix "@" (k: INTEGER): CHARACTER is
		external
			"IL deferred signature (System.Int32): System.Char use TABLE_CHAR_INT32"
		alias
			"infix %"@%""
		end

	valid_key (k: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use TABLE_CHAR_INT32"
		alias
			"valid_key"
		end

	item (k: INTEGER): CHARACTER is
		external
			"IL deferred signature (System.Int32): System.Char use TABLE_CHAR_INT32"
		alias
			"item"
		end

	put_char_int32 (v: CHARACTER; k: INTEGER) is
		external
			"IL deferred signature (System.Char, System.Int32): System.Void use TABLE_CHAR_INT32"
		alias
			"put"
		end

end -- class TABLE_CHAR_INT32
