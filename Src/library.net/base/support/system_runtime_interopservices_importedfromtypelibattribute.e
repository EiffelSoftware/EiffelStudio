indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.ImportedFromTypeLibAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_IMPORTEDFROMTYPELIBATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_imported_from_type_lib_attribute

feature {NONE} -- Initialization

	frozen make_imported_from_type_lib_attribute (tlbFile: STRING) is
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
