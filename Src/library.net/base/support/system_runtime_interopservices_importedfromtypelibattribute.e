indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ImportedFromTypeLibAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_IMPORTEDFROMTYPELIBATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_importedfromtypelibattribute

feature {NONE} -- Initialization

	frozen make_importedfromtypelibattribute (tlb_file: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ImportedFromTypeLibAttribute"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.ImportedFromTypeLibAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_IMPORTEDFROMTYPELIBATTRIBUTE
