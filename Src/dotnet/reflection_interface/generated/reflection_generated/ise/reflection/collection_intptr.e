indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COLLECTION_INTPTR"

deferred external class
	COLLECTION_INTPTR

inherit
	CONTAINER_INTPTR

feature -- Basic Operations

	wipe_out is
		external
			"IL deferred signature (): System.Void use COLLECTION_INTPTR"
		alias
			"wipe_out"
		end

	is_inserted (v: POINTER): BOOLEAN is
		external
			"IL deferred signature (System.IntPtr): System.Boolean use COLLECTION_INTPTR"
		alias
			"is_inserted"
		end

	prune (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use COLLECTION_INTPTR"
		alias
			"prune"
		end

	prunable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_INTPTR"
		alias
			"prunable"
		end

	prune_all (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use COLLECTION_INTPTR"
		alias
			"prune_all"
		end

	put (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use COLLECTION_INTPTR"
		alias
			"put"
		end

	extendible: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_INTPTR"
		alias
			"extendible"
		end

	extend (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use COLLECTION_INTPTR"
		alias
			"extend"
		end

	fill (other: CONTAINER_INTPTR) is
		external
			"IL deferred signature (CONTAINER_INTPTR): System.Void use COLLECTION_INTPTR"
		alias
			"fill"
		end

end -- class COLLECTION_INTPTR
