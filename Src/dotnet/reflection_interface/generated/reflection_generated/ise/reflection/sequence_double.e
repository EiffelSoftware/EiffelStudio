indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SEQUENCE_DOUBLE"

deferred external class
	SEQUENCE_DOUBLE

inherit
	BOX_DOUBLE
	BILINEAR_DOUBLE
	ACTIVE_DOUBLE
		rename
			item as item_double,
			occurrences as occurrences_double
		end
	COLLECTION_DOUBLE
	TRAVERSABLE_DOUBLE
	BAG_DOUBLE
		rename
			occurrences as occurrences_double
		end
	FINITE_DOUBLE
	CONTAINER_DOUBLE
	LINEAR_DOUBLE

feature -- Basic Operations

	force (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use SEQUENCE_DOUBLE"
		alias
			"force"
		end

	append (s: SEQUENCE_DOUBLE) is
		external
			"IL deferred signature (SEQUENCE_DOUBLE): System.Void use SEQUENCE_DOUBLE"
		alias
			"append"
		end

end -- class SEQUENCE_DOUBLE
