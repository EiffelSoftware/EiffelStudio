indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.NameTable"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_NAME_TABLE

inherit
	SYSTEM_XML_XML_NAME_TABLE

create
	make_system_xml_name_table

feature {NONE} -- Initialization

	frozen make_system_xml_name_table is
		external
			"IL creator use System.Xml.NameTable"
		end

feature -- Basic Operations

	add_array_char (key: NATIVE_ARRAY [CHARACTER]; start: INTEGER; len: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.String use System.Xml.NameTable"
		alias
			"Add"
		end

	add (key: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.NameTable"
		alias
			"Add"
		end

	get (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.NameTable"
		alias
			"Get"
		end

	get_array_char (key: NATIVE_ARRAY [CHARACTER]; start: INTEGER; len: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.String use System.Xml.NameTable"
		alias
			"Get"
		end

end -- class SYSTEM_XML_NAME_TABLE
