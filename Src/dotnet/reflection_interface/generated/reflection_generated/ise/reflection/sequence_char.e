indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SEQUENCE_CHAR"

deferred external class
	SEQUENCE_CHAR

inherit
	BOX_CHAR
	CONTAINER_CHAR
	BAG_CHAR
		rename
			occurrences as occurrences_char
		end
	LINEAR_CHAR
	TRAVERSABLE_CHAR
	FINITE_CHAR
	ACTIVE_CHAR
		rename
			item as item_char,
			occurrences as occurrences_char
		end
	BILINEAR_CHAR
	COLLECTION_CHAR

feature -- Basic Operations

	force (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use SEQUENCE_CHAR"
		alias
			"force"
		end

	append (s: SEQUENCE_CHAR) is
		external
			"IL deferred signature (SEQUENCE_CHAR): System.Void use SEQUENCE_CHAR"
		alias
			"append"
		end

end -- class SEQUENCE_CHAR
