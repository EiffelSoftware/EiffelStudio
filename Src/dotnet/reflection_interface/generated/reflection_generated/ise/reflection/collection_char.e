indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COLLECTION_CHAR"

deferred external class
	COLLECTION_CHAR

inherit
	CONTAINER_CHAR

feature -- Basic Operations

	wipe_out is
		external
			"IL deferred signature (): System.Void use COLLECTION_CHAR"
		alias
			"wipe_out"
		end

	is_inserted (v: CHARACTER): BOOLEAN is
		external
			"IL deferred signature (System.Char): System.Boolean use COLLECTION_CHAR"
		alias
			"is_inserted"
		end

	prune (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use COLLECTION_CHAR"
		alias
			"prune"
		end

	prunable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_CHAR"
		alias
			"prunable"
		end

	prune_all (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use COLLECTION_CHAR"
		alias
			"prune_all"
		end

	put (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use COLLECTION_CHAR"
		alias
			"put"
		end

	extendible: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_CHAR"
		alias
			"extendible"
		end

	extend (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use COLLECTION_CHAR"
		alias
			"extend"
		end

	fill (other: CONTAINER_CHAR) is
		external
			"IL deferred signature (CONTAINER_CHAR): System.Void use COLLECTION_CHAR"
		alias
			"fill"
		end

end -- class COLLECTION_CHAR
