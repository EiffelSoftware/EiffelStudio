indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COLLECTION_DOUBLE"

deferred external class
	COLLECTION_DOUBLE

inherit
	CONTAINER_DOUBLE

feature -- Basic Operations

	wipe_out is
		external
			"IL deferred signature (): System.Void use COLLECTION_DOUBLE"
		alias
			"wipe_out"
		end

	is_inserted (v: DOUBLE): BOOLEAN is
		external
			"IL deferred signature (System.Double): System.Boolean use COLLECTION_DOUBLE"
		alias
			"is_inserted"
		end

	prune (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use COLLECTION_DOUBLE"
		alias
			"prune"
		end

	prunable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_DOUBLE"
		alias
			"prunable"
		end

	prune_all (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use COLLECTION_DOUBLE"
		alias
			"prune_all"
		end

	put (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use COLLECTION_DOUBLE"
		alias
			"put"
		end

	extendible: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_DOUBLE"
		alias
			"extendible"
		end

	extend (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use COLLECTION_DOUBLE"
		alias
			"extend"
		end

	fill (other: CONTAINER_DOUBLE) is
		external
			"IL deferred signature (CONTAINER_DOUBLE): System.Void use COLLECTION_DOUBLE"
		alias
			"fill"
		end

end -- class COLLECTION_DOUBLE
