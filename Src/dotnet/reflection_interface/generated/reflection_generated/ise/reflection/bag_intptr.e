indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BAG_INTPTR"

deferred external class
	BAG_INTPTR

inherit
	CONTAINER_INTPTR
	COLLECTION_INTPTR

feature -- Basic Operations

	occurrences (v: POINTER): INTEGER is
		external
			"IL deferred signature (System.IntPtr): System.Int32 use BAG_INTPTR"
		alias
			"occurrences"
		end

end -- class BAG_INTPTR
