indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "RESIZABLE_ANY"

deferred external class
	RESIZABLE_ANY

inherit
	BOX_ANY
	CONTAINER_ANY
	BOUNDED_ANY
	FINITE_ANY

feature -- Basic Operations

	grow (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use RESIZABLE_ANY"
		alias
			"grow"
		end

	minimal_increase: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_ANY"
		alias
			"minimal_increase"
		end

	automatic_grow is
		external
			"IL deferred signature (): System.Void use RESIZABLE_ANY"
		alias
			"automatic_grow"
		end

	growth_percentage: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_ANY"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_ANY"
		alias
			"additional_space"
		end

end -- class RESIZABLE_ANY
