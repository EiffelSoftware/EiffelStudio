indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BOUNDED_CHAR"

deferred external class
	BOUNDED_CHAR

inherit
	BOX_CHAR
	CONTAINER_CHAR
	FINITE_CHAR

feature -- Basic Operations

	resizable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BOUNDED_CHAR"
		alias
			"resizable"
		end

	capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use BOUNDED_CHAR"
		alias
			"capacity"
		end

end -- class BOUNDED_CHAR
