indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LINEAR_DOUBLE"

deferred external class
	LINEAR_DOUBLE

inherit
	CONTAINER_DOUBLE
	TRAVERSABLE_DOUBLE

feature -- Basic Operations

	finish is
		external
			"IL deferred signature (): System.Void use LINEAR_DOUBLE"
		alias
			"finish"
		end

	forth is
		external
			"IL deferred signature (): System.Void use LINEAR_DOUBLE"
		alias
			"forth"
		end

	exhausted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_DOUBLE"
		alias
			"exhausted"
		end

	index_of (v: DOUBLE; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Double, System.Int32): System.Int32 use LINEAR_DOUBLE"
		alias
			"index_of"
		end

	after: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_DOUBLE"
		alias
			"after"
		end

	occurrences (v: DOUBLE): INTEGER is
		external
			"IL deferred signature (System.Double): System.Int32 use LINEAR_DOUBLE"
		alias
			"occurrences"
		end

	search (v: DOUBLE) is
		external
			"IL deferred signature (System.Double): System.Void use LINEAR_DOUBLE"
		alias
			"search"
		end

	index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use LINEAR_DOUBLE"
		alias
			"index"
		end

end -- class LINEAR_DOUBLE
