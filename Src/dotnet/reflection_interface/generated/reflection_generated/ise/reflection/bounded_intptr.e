indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BOUNDED_INTPTR"

deferred external class
	BOUNDED_INTPTR

inherit
	FINITE_INTPTR
	BOX_INTPTR
	CONTAINER_INTPTR

feature -- Basic Operations

	resizable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BOUNDED_INTPTR"
		alias
			"resizable"
		end

	capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use BOUNDED_INTPTR"
		alias
			"capacity"
		end

end -- class BOUNDED_INTPTR
