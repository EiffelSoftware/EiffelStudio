indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SEQUENCE_SINGLE"

deferred external class
	SEQUENCE_SINGLE

inherit
	BOX_SINGLE
	CONTAINER_SINGLE
	TRAVERSABLE_SINGLE
	LINEAR_SINGLE
	ACTIVE_SINGLE
		rename
			item as item_single,
			occurrences as occurrences_single
		end
	BILINEAR_SINGLE
	FINITE_SINGLE
	BAG_SINGLE
		rename
			occurrences as occurrences_single
		end
	COLLECTION_SINGLE

feature -- Basic Operations

	force (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use SEQUENCE_SINGLE"
		alias
			"force"
		end

	append (s: SEQUENCE_SINGLE) is
		external
			"IL deferred signature (SEQUENCE_SINGLE): System.Void use SEQUENCE_SINGLE"
		alias
			"append"
		end

end -- class SEQUENCE_SINGLE
