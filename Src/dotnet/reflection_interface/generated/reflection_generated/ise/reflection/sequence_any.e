indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SEQUENCE_ANY"

deferred external class
	SEQUENCE_ANY

inherit
	CONTAINER_ANY
	FINITE_ANY
	BOX_ANY
	BAG_ANY
		rename
			occurrences as occurrences_any
		end
	TRAVERSABLE_ANY
	ACTIVE_ANY
		rename
			item as item_any,
			occurrences as occurrences_any
		end
	COLLECTION_ANY
	LINEAR_ANY
	BILINEAR_ANY

feature -- Basic Operations

	force (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use SEQUENCE_ANY"
		alias
			"force"
		end

	append (s: SEQUENCE_ANY) is
		external
			"IL deferred signature (SEQUENCE_ANY): System.Void use SEQUENCE_ANY"
		alias
			"append"
		end

end -- class SEQUENCE_ANY
