indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "LINEAR_CHAR"

deferred external class
	LINEAR_CHAR

inherit
	CONTAINER_CHAR
	TRAVERSABLE_CHAR

feature -- Basic Operations

	finish is
		external
			"IL deferred signature (): System.Void use LINEAR_CHAR"
		alias
			"finish"
		end

	forth is
		external
			"IL deferred signature (): System.Void use LINEAR_CHAR"
		alias
			"forth"
		end

	exhausted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_CHAR"
		alias
			"exhausted"
		end

	index_of (v: CHARACTER; i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Char, System.Int32): System.Int32 use LINEAR_CHAR"
		alias
			"index_of"
		end

	after: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use LINEAR_CHAR"
		alias
			"after"
		end

	occurrences (v: CHARACTER): INTEGER is
		external
			"IL deferred signature (System.Char): System.Int32 use LINEAR_CHAR"
		alias
			"occurrences"
		end

	search (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use LINEAR_CHAR"
		alias
			"search"
		end

	index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use LINEAR_CHAR"
		alias
			"index"
		end

end -- class LINEAR_CHAR
