indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BOUNDED_INT32"

deferred external class
	BOUNDED_INT32

inherit
	FINITE_INT32
	BOX_INT32
	CONTAINER_INT32

feature -- Basic Operations

	resizable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BOUNDED_INT32"
		alias
			"resizable"
		end

	capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use BOUNDED_INT32"
		alias
			"capacity"
		end

end -- class BOUNDED_INT32
