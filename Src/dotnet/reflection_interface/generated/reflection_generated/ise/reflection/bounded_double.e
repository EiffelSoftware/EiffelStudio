indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BOUNDED_DOUBLE"

deferred external class
	BOUNDED_DOUBLE

inherit
	CONTAINER_DOUBLE
	BOX_DOUBLE
	FINITE_DOUBLE

feature -- Basic Operations

	resizable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BOUNDED_DOUBLE"
		alias
			"resizable"
		end

	capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use BOUNDED_DOUBLE"
		alias
			"capacity"
		end

end -- class BOUNDED_DOUBLE
