indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COLLECTION_BOOLEAN"

deferred external class
	COLLECTION_BOOLEAN

inherit
	CONTAINER_BOOLEAN

feature -- Basic Operations

	wipe_out is
		external
			"IL deferred signature (): System.Void use COLLECTION_BOOLEAN"
		alias
			"wipe_out"
		end

	is_inserted (v: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.Boolean): System.Boolean use COLLECTION_BOOLEAN"
		alias
			"is_inserted"
		end

	prune (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use COLLECTION_BOOLEAN"
		alias
			"prune"
		end

	prunable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_BOOLEAN"
		alias
			"prunable"
		end

	prune_all (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use COLLECTION_BOOLEAN"
		alias
			"prune_all"
		end

	put (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use COLLECTION_BOOLEAN"
		alias
			"put"
		end

	extendible: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_BOOLEAN"
		alias
			"extendible"
		end

	extend (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use COLLECTION_BOOLEAN"
		alias
			"extend"
		end

	fill (other: CONTAINER_BOOLEAN) is
		external
			"IL deferred signature (CONTAINER_BOOLEAN): System.Void use COLLECTION_BOOLEAN"
		alias
			"fill"
		end

end -- class COLLECTION_BOOLEAN
