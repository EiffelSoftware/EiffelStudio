indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "BOUNDED_BYTE"

deferred external class
	BOUNDED_BYTE

inherit
	CONTAINER_BYTE
	FINITE_BYTE
	BOX_BYTE

feature -- Basic Operations

	resizable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use BOUNDED_BYTE"
		alias
			"resizable"
		end

	capacity: INTEGER is
		external
			"IL deferred signature (): System.Int32 use BOUNDED_BYTE"
		alias
			"capacity"
		end

end -- class BOUNDED_BYTE
