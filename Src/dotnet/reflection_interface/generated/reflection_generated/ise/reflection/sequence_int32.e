indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SEQUENCE_INT32"

deferred external class
	SEQUENCE_INT32

inherit
	CONTAINER_INT32
	BAG_INT32
		rename
			occurrences as occurrences_int32
		end
	ACTIVE_INT32
		rename
			item as item_int32,
			occurrences as occurrences_int32
		end
	BOX_INT32
	FINITE_INT32
	BILINEAR_INT32
	TRAVERSABLE_INT32
	LINEAR_INT32
	COLLECTION_INT32

feature -- Basic Operations

	force (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use SEQUENCE_INT32"
		alias
			"force"
		end

	append (s: SEQUENCE_INT32) is
		external
			"IL deferred signature (SEQUENCE_INT32): System.Void use SEQUENCE_INT32"
		alias
			"append"
		end

end -- class SEQUENCE_INT32
