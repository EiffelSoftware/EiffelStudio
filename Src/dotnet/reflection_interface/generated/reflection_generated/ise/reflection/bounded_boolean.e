indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BOUNDED_BOOLEAN"

deferred external class
	BOUNDED_BOOLEAN

inherit
	CONTAINER_BOOLEAN
	FINITE_BOOLEAN
	BOX_BOOLEAN

feature -- Basic Operations

	resizable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BOUNDED_BOOLEAN"
		alias
			"resizable"
		end

	capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use BOUNDED_BOOLEAN"
		alias
			"capacity"
		end

end -- class BOUNDED_BOOLEAN
