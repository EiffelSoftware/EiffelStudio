indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BOUNDED_SINGLE"

deferred external class
	BOUNDED_SINGLE

inherit
	CONTAINER_SINGLE
	BOX_SINGLE
	FINITE_SINGLE

feature -- Basic Operations

	resizable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BOUNDED_SINGLE"
		alias
			"resizable"
		end

	capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use BOUNDED_SINGLE"
		alias
			"capacity"
		end

end -- class BOUNDED_SINGLE
