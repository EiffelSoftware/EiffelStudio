indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BOUNDED_ANY"

deferred external class
	BOUNDED_ANY

inherit
	BOX_ANY
	CONTAINER_ANY
	FINITE_ANY

feature -- Basic Operations

	resizable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BOUNDED_ANY"
		alias
			"resizable"
		end

	capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use BOUNDED_ANY"
		alias
			"capacity"
		end

end -- class BOUNDED_ANY
