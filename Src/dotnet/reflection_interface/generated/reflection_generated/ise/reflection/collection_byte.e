indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "COLLECTION_BYTE"

deferred external class
	COLLECTION_BYTE

inherit
	CONTAINER_BYTE

feature -- Basic Operations

	wipe_out is
		external
			"IL deferred signature (): System.Void use COLLECTION_BYTE"
		alias
			"wipe_out"
		end

	is_inserted (v: INTEGER_8): BOOLEAN is
		external
			"IL deferred signature (System.Byte): System.Boolean use COLLECTION_BYTE"
		alias
			"is_inserted"
		end

	prune (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use COLLECTION_BYTE"
		alias
			"prune"
		end

	prunable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_BYTE"
		alias
			"prunable"
		end

	prune_all (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use COLLECTION_BYTE"
		alias
			"prune_all"
		end

	put (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use COLLECTION_BYTE"
		alias
			"put"
		end

	extendible: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use COLLECTION_BYTE"
		alias
			"extendible"
		end

	extend (v: INTEGER_8) is
		external
			"IL deferred signature (System.Byte): System.Void use COLLECTION_BYTE"
		alias
			"extend"
		end

	fill (other: CONTAINER_BYTE) is
		external
			"IL deferred signature (CONTAINER_BYTE): System.Void use COLLECTION_BYTE"
		alias
			"fill"
		end

end -- class COLLECTION_BYTE
