indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COLLECTION_SINGLE"

deferred external class
	COLLECTION_SINGLE

inherit
	CONTAINER_SINGLE

feature -- Basic Operations

	wipe_out is
		external
			"IL deferred signature (): System.Void use COLLECTION_SINGLE"
		alias
			"wipe_out"
		end

	is_inserted (v: REAL): BOOLEAN is
		external
			"IL deferred signature (System.Single): System.Boolean use COLLECTION_SINGLE"
		alias
			"is_inserted"
		end

	prune (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use COLLECTION_SINGLE"
		alias
			"prune"
		end

	prunable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_SINGLE"
		alias
			"prunable"
		end

	prune_all (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use COLLECTION_SINGLE"
		alias
			"prune_all"
		end

	put (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use COLLECTION_SINGLE"
		alias
			"put"
		end

	extendible: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_SINGLE"
		alias
			"extendible"
		end

	extend (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use COLLECTION_SINGLE"
		alias
			"extend"
		end

	fill (other: CONTAINER_SINGLE) is
		external
			"IL deferred signature (CONTAINER_SINGLE): System.Void use COLLECTION_SINGLE"
		alias
			"fill"
		end

end -- class COLLECTION_SINGLE
