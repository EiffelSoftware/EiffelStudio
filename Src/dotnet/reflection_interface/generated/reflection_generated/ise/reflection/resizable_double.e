indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "RESIZABLE_DOUBLE"

deferred external class
	RESIZABLE_DOUBLE

inherit
	CONTAINER_DOUBLE
	BOX_DOUBLE
	FINITE_DOUBLE
	BOUNDED_DOUBLE

feature -- Basic Operations

	grow (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use RESIZABLE_DOUBLE"
		alias
			"grow"
		end

	minimal_increase: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_DOUBLE"
		alias
			"minimal_increase"
		end

	automatic_grow is
		external
			"IL deferred signature (): System.Void use RESIZABLE_DOUBLE"
		alias
			"automatic_grow"
		end

	growth_percentage: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_DOUBLE"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_DOUBLE"
		alias
			"additional_space"
		end

end -- class RESIZABLE_DOUBLE
