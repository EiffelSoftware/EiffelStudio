indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "RESIZABLE_CHAR"

deferred external class
	RESIZABLE_CHAR

inherit
	BOUNDED_CHAR
	BOX_CHAR
	CONTAINER_CHAR
	FINITE_CHAR

feature -- Basic Operations

	grow (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use RESIZABLE_CHAR"
		alias
			"grow"
		end

	minimal_increase: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_CHAR"
		alias
			"minimal_increase"
		end

	automatic_grow is
		external
			"IL deferred signature (): System.Void use RESIZABLE_CHAR"
		alias
			"automatic_grow"
		end

	growth_percentage: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_CHAR"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_CHAR"
		alias
			"additional_space"
		end

end -- class RESIZABLE_CHAR
