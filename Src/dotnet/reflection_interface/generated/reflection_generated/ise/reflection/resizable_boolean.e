indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "RESIZABLE_BOOLEAN"

deferred external class
	RESIZABLE_BOOLEAN

inherit
	CONTAINER_BOOLEAN
	BOUNDED_BOOLEAN
	FINITE_BOOLEAN
	BOX_BOOLEAN

feature -- Basic Operations

	grow (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use RESIZABLE_BOOLEAN"
		alias
			"grow"
		end

	minimal_increase: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_BOOLEAN"
		alias
			"minimal_increase"
		end

	automatic_grow is
		external
			"IL deferred signature (): System.Void use RESIZABLE_BOOLEAN"
		alias
			"automatic_grow"
		end

	growth_percentage: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_BOOLEAN"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_BOOLEAN"
		alias
			"additional_space"
		end

end -- class RESIZABLE_BOOLEAN
