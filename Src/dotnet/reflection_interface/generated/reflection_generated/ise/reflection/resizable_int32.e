indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "RESIZABLE_INT32"

deferred external class
	RESIZABLE_INT32

inherit
	CONTAINER_INT32
	FINITE_INT32
	BOX_INT32
	BOUNDED_INT32

feature -- Basic Operations

	grow (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use RESIZABLE_INT32"
		alias
			"grow"
		end

	minimal_increase: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_INT32"
		alias
			"minimal_increase"
		end

	automatic_grow is
		external
			"IL deferred signature (): System.Void use RESIZABLE_INT32"
		alias
			"automatic_grow"
		end

	growth_percentage: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_INT32"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_INT32"
		alias
			"additional_space"
		end

end -- class RESIZABLE_INT32
