indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BILINEAR_CHAR"

deferred external class
	BILINEAR_CHAR

inherit
	CONTAINER_CHAR
	LINEAR_CHAR
	TRAVERSABLE_CHAR

feature -- Basic Operations

	before: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BILINEAR_CHAR"
		alias
			"before"
		end

	sequential_search (v: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use BILINEAR_CHAR"
		alias
			"sequential_search"
		end

	back is
		external
			"IL deferred signature (): System.Void use BILINEAR_CHAR"
		alias
			"back"
		end

end -- class BILINEAR_CHAR
