indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "RESIZABLE_SINGLE"

deferred external class
	RESIZABLE_SINGLE

inherit
	CONTAINER_SINGLE
	BOX_SINGLE
	BOUNDED_SINGLE
	FINITE_SINGLE

feature -- Basic Operations

	grow (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use RESIZABLE_SINGLE"
		alias
			"grow"
		end

	minimal_increase: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_SINGLE"
		alias
			"minimal_increase"
		end

	automatic_grow is
		external
			"IL deferred signature (): System.Void use RESIZABLE_SINGLE"
		alias
			"automatic_grow"
		end

	growth_percentage: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_SINGLE"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_SINGLE"
		alias
			"additional_space"
		end

end -- class RESIZABLE_SINGLE
