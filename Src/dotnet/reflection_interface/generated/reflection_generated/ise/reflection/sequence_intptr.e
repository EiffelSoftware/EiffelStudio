indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SEQUENCE_INTPTR"

deferred external class
	SEQUENCE_INTPTR

inherit
	TRAVERSABLE_INTPTR
	ACTIVE_INTPTR
		rename
			item as item_int_ptr,
			occurrences as occurrences_int_ptr
		end
	BILINEAR_INTPTR
	COLLECTION_INTPTR
	BOX_INTPTR
	BAG_INTPTR
		rename
			occurrences as occurrences_int_ptr
		end
	CONTAINER_INTPTR
	LINEAR_INTPTR
	FINITE_INTPTR

feature -- Basic Operations

	force (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use SEQUENCE_INTPTR"
		alias
			"force"
		end

	append (s: SEQUENCE_INTPTR) is
		external
			"IL deferred signature (SEQUENCE_INTPTR): System.Void use SEQUENCE_INTPTR"
		alias
			"append"
		end

end -- class SEQUENCE_INTPTR
