indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ComVisibleAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_COMVISIBLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_comvisibleattribute

feature {NONE} -- Initialization

	frozen make_comvisibleattribute (visibility: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Runtime.InteropServices.ComVisibleAttribute"
		end

feature -- Access

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.InteropServices.ComVisibleAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_COMVISIBLEATTRIBUTE
