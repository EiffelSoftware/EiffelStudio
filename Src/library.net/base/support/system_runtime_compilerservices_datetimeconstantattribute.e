indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.CompilerServices.DateTimeConstantAttribute"

frozen external class
	SYSTEM_RUNTIME_COMPILERSERVICES_DATETIMECONSTANTATTRIBUTE

inherit
	SYSTEM_RUNTIME_COMPILERSERVICES_CUSTOMCONSTANTATTRIBUTE

create
	make_datetimeconstantattribute

feature {NONE} -- Initialization

	frozen make_datetimeconstantattribute (ticks: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.Runtime.CompilerServices.DateTimeConstantAttribute"
		end

feature -- Access

	get_value: ANY is
		external
			"IL signature (): System.Object use System.Runtime.CompilerServices.DateTimeConstantAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_COMPILERSERVICES_DATETIMECONSTANTATTRIBUTE
