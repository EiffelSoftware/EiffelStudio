indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SEQUENCE_BOOLEAN"

deferred external class
	SEQUENCE_BOOLEAN

inherit
	BAG_BOOLEAN
		rename
			occurrences as occurrences_boolean
		end
	COLLECTION_BOOLEAN
	LINEAR_BOOLEAN
	TRAVERSABLE_BOOLEAN
	FINITE_BOOLEAN
	CONTAINER_BOOLEAN
	BILINEAR_BOOLEAN
	ACTIVE_BOOLEAN
		rename
			item as item_boolean,
			occurrences as occurrences_boolean
		end
	BOX_BOOLEAN

feature -- Basic Operations

	force (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use SEQUENCE_BOOLEAN"
		alias
			"force"
		end

	append (s: SEQUENCE_BOOLEAN) is
		external
			"IL deferred signature (SEQUENCE_BOOLEAN): System.Void use SEQUENCE_BOOLEAN"
		alias
			"append"
		end

end -- class SEQUENCE_BOOLEAN
