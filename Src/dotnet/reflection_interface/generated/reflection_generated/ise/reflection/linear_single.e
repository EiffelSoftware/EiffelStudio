indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LINEAR_SINGLE"

deferred external class
	LINEAR_SINGLE

inherit
	CONTAINER_SINGLE
	TRAVERSABLE_SINGLE

feature -- Basic Operations

	finish is
		external
			"IL deferred signature (): System.Void use LINEAR_SINGLE"
		alias
			"finish"
		end

	forth is
		external
			"IL deferred signature (): System.Void use LINEAR_SINGLE"
		alias
			"forth"
		end

	exhausted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_SINGLE"
		alias
			"exhausted"
		end

	index_of (v: REAL; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Single, System.Int32): System.Int32 use LINEAR_SINGLE"
		alias
			"index_of"
		end

	after: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_SINGLE"
		alias
			"after"
		end

	occurrences (v: REAL): INTEGER is
		external
			"IL deferred signature (System.Single): System.Int32 use LINEAR_SINGLE"
		alias
			"occurrences"
		end

	search (v: REAL) is
		external
			"IL deferred signature (System.Single): System.Void use LINEAR_SINGLE"
		alias
			"search"
		end

	index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use LINEAR_SINGLE"
		alias
			"index"
		end

end -- class LINEAR_SINGLE
