indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COLLECTION_INT32"

deferred external class
	COLLECTION_INT32

inherit
	CONTAINER_INT32

feature -- Basic Operations

	wipe_out is
		external
			"IL deferred signature (): System.Void use COLLECTION_INT32"
		alias
			"wipe_out"
		end

	is_inserted (v: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use COLLECTION_INT32"
		alias
			"is_inserted"
		end

	prune (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use COLLECTION_INT32"
		alias
			"prune"
		end

	prunable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_INT32"
		alias
			"prunable"
		end

	prune_all (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use COLLECTION_INT32"
		alias
			"prune_all"
		end

	put (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use COLLECTION_INT32"
		alias
			"put"
		end

	extendible: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_INT32"
		alias
			"extendible"
		end

	extend (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use COLLECTION_INT32"
		alias
			"extend"
		end

	fill (other: CONTAINER_INT32) is
		external
			"IL deferred signature (CONTAINER_INT32): System.Void use COLLECTION_INT32"
		alias
			"fill"
		end

end -- class COLLECTION_INT32
