indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BILINEAR_INTPTR"

deferred external class
	BILINEAR_INTPTR

inherit
	LINEAR_INTPTR
	CONTAINER_INTPTR
	TRAVERSABLE_INTPTR

feature -- Basic Operations

	before: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BILINEAR_INTPTR"
		alias
			"before"
		end

	sequential_search (v: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use BILINEAR_INTPTR"
		alias
			"sequential_search"
		end

	back is
		external
			"IL deferred signature (): System.Void use BILINEAR_INTPTR"
		alias
			"back"
		end

end -- class BILINEAR_INTPTR
