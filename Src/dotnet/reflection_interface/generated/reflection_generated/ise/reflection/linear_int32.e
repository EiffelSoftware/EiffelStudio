indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LINEAR_INT32"

deferred external class
	LINEAR_INT32

inherit
	TRAVERSABLE_INT32
	CONTAINER_INT32

feature -- Basic Operations

	finish is
		external
			"IL deferred signature (): System.Void use LINEAR_INT32"
		alias
			"finish"
		end

	forth is
		external
			"IL deferred signature (): System.Void use LINEAR_INT32"
		alias
			"forth"
		end

	exhausted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_INT32"
		alias
			"exhausted"
		end

	index_of (v: INTEGER; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Int32 use LINEAR_INT32"
		alias
			"index_of"
		end

	after: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_INT32"
		alias
			"after"
		end

	occurrences (v: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use LINEAR_INT32"
		alias
			"occurrences"
		end

	search (v: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use LINEAR_INT32"
		alias
			"search"
		end

	index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use LINEAR_INT32"
		alias
			"index"
		end

end -- class LINEAR_INT32
