indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "RESIZABLE_BYTE"

deferred external class
	RESIZABLE_BYTE

inherit
	CONTAINER_BYTE
	BOUNDED_BYTE
	FINITE_BYTE
	BOX_BYTE

feature -- Basic Operations

	grow (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use RESIZABLE_BYTE"
		alias
			"grow"
		end

	minimal_increase: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_BYTE"
		alias
			"minimal_increase"
		end

	automatic_grow is
		external
			"IL deferred signature (): System.Void use RESIZABLE_BYTE"
		alias
			"automatic_grow"
		end

	growth_percentage: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_BYTE"
		alias
			"growth_percentage"
		end

	additional_space: INTEGER is
		external
			"IL deferred signature (): System.Int32 use RESIZABLE_BYTE"
		alias
			"additional_space"
		end

end -- class RESIZABLE_BYTE
