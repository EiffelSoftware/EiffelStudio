indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LINEAR_ANY"

deferred external class
	LINEAR_ANY

inherit
	CONTAINER_ANY
	TRAVERSABLE_ANY

feature -- Basic Operations

	finish is
		external
			"IL deferred signature (): System.Void use LINEAR_ANY"
		alias
			"finish"
		end

	forth is
		external
			"IL deferred signature (): System.Void use LINEAR_ANY"
		alias
			"forth"
		end

	exhausted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_ANY"
		alias
			"exhausted"
		end

	index_of (v: ANY; i: INTEGER): INTEGER is
		external
			"IL deferred signature (ANY, System.Int32): System.Int32 use LINEAR_ANY"
		alias
			"index_of"
		end

	after: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_ANY"
		alias
			"after"
		end

	occurrences (v: ANY): INTEGER is
		external
			"IL deferred signature (ANY): System.Int32 use LINEAR_ANY"
		alias
			"occurrences"
		end

	search (v: ANY) is
		external
			"IL deferred signature (ANY): System.Void use LINEAR_ANY"
		alias
			"search"
		end

	index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use LINEAR_ANY"
		alias
			"index"
		end

end -- class LINEAR_ANY
