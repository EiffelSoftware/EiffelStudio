indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LINEAR_INTPTR"

deferred external class
	LINEAR_INTPTR

inherit
	CONTAINER_INTPTR
	TRAVERSABLE_INTPTR

feature -- Basic Operations

	finish is
		external
			"IL deferred signature (): System.Void use LINEAR_INTPTR"
		alias
			"finish"
		end

	forth is
		external
			"IL deferred signature (): System.Void use LINEAR_INTPTR"
		alias
			"forth"
		end

	exhausted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_INTPTR"
		alias
			"exhausted"
		end

	index_of (v: POINTER; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Int32 use LINEAR_INTPTR"
		alias
			"index_of"
		end

	after: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_INTPTR"
		alias
			"after"
		end

	occurrences (v: POINTER): INTEGER is
		external
			"IL deferred signature (System.IntPtr): System.Int32 use LINEAR_INTPTR"
		alias
			"occurrences"
		end

	search (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use LINEAR_INTPTR"
		alias
			"search"
		end

	index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use LINEAR_INTPTR"
		alias
			"index"
		end

end -- class LINEAR_INTPTR
