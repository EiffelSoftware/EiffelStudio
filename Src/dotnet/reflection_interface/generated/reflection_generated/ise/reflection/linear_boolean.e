indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LINEAR_BOOLEAN"

deferred external class
	LINEAR_BOOLEAN

inherit
	TRAVERSABLE_BOOLEAN
	CONTAINER_BOOLEAN

feature -- Basic Operations

	finish is
		external
			"IL deferred signature (): System.Void use LINEAR_BOOLEAN"
		alias
			"finish"
		end

	forth is
		external
			"IL deferred signature (): System.Void use LINEAR_BOOLEAN"
		alias
			"forth"
		end

	exhausted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_BOOLEAN"
		alias
			"exhausted"
		end

	index_of (v: BOOLEAN; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Boolean, System.Int32): System.Int32 use LINEAR_BOOLEAN"
		alias
			"index_of"
		end

	after: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_BOOLEAN"
		alias
			"after"
		end

	occurrences (v: BOOLEAN): INTEGER is
		external
			"IL deferred signature (System.Boolean): System.Int32 use LINEAR_BOOLEAN"
		alias
			"occurrences"
		end

	search (v: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use LINEAR_BOOLEAN"
		alias
			"search"
		end

	index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use LINEAR_BOOLEAN"
		alias
			"index"
		end

end -- class LINEAR_BOOLEAN
