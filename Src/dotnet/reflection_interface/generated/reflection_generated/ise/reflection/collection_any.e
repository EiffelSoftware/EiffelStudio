indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COLLECTION_ANY"

deferred external class
	COLLECTION_ANY

inherit
	CONTAINER_ANY

feature -- Basic Operations

	wipe_out is
		external
			"IL deferred signature (): System.Void use COLLECTION_ANY"
		alias
			"wipe_out"
		end

	is_inserted (v: ANY): BOOLEAN is
		external
			"IL deferred signature (ANY): System.Boolean use COLLECTION_ANY"
		alias
			"is_inserted"
		end

	prune (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use COLLECTION_ANY"
		alias
			"prune"
		end

	prunable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_ANY"
		alias
			"prunable"
		end

	prune_all (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use COLLECTION_ANY"
		alias
			"prune_all"
		end

	put (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use COLLECTION_ANY"
		alias
			"put"
		end

	extendible: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_ANY"
		alias
			"extendible"
		end

	extend (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use COLLECTION_ANY"
		alias
			"extend"
		end

	fill (other: CONTAINER_ANY) is
		external
			"IL deferred signature (CONTAINER_ANY): System.Void use COLLECTION_ANY"
		alias
			"fill"
		end

end -- class COLLECTION_ANY
