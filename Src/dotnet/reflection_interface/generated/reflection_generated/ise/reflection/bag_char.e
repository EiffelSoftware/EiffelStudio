indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BAG_CHAR"

deferred external class
	BAG_CHAR

inherit
	COLLECTION_CHAR
	CONTAINER_CHAR

feature -- Basic Operations

	occurrences (v: CHARACTER): INTEGER is
		external
			"IL deferred signature (System.Char): System.Int32 use BAG_CHAR"
		alias
			"occurrences"
		end

end -- class BAG_CHAR
