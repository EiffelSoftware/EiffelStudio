indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "RESIZABLE_INTPTR"

deferred external class
	RESIZABLE_INTPTR

inherit
	FINITE_INTPTR
	BOX_INTPTR
	BOUNDED_INTPTR
	CONTAINER_INTPTR

feature -- Basic Operations

	grow (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use RESIZABLE_INTPTR"
		alias
			"grow"
		end

	minimal_increase: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_INTPTR"
		alias
			"minimal_increase"
		end

	automatic_grow is
		external
			"IL deferred signature (): System.Void use RESIZABLE_INTPTR"
		alias
			"automatic_grow"
		end

	growth_percentage: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_INTPTR"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_INTPTR"
		alias
			"additional_space"
		end

end -- class RESIZABLE_INTPTR
