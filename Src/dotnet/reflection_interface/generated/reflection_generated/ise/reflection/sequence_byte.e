indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SEQUENCE_BYTE"

deferred external class
	SEQUENCE_BYTE

inherit
	LINEAR_BYTE
	BAG_BYTE
		rename
			occurrences as occurrences_byte
		end
	CONTAINER_BYTE
	BILINEAR_BYTE
	TRAVERSABLE_BYTE
	ACTIVE_BYTE
		rename
			item as item_byte,
			occurrences as occurrences_byte
		end
	FINITE_BYTE
	COLLECTION_BYTE
	BOX_BYTE

feature -- Basic Operations

	force (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use SEQUENCE_BYTE"
		alias
			"force"
		end

	append (s: SEQUENCE_BYTE) is
		external
			"IL deferred signature (SEQUENCE_BYTE): System.Void use SEQUENCE_BYTE"
		alias
			"append"
		end

end -- class SEQUENCE_BYTE
