indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlNameTable"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_NAME_TABLE

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	add_array_char (array: NATIVE_ARRAY [CHARACTER]; offset: INTEGER; length: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32): System.String use System.Xml.XmlNameTable"
		alias
			"Add"
		end

	add (array: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlNameTable"
		alias
			"Add"
		end

	get (array: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlNameTable"
		alias
			"Get"
		end

	get_array_char (array: NATIVE_ARRAY [CHARACTER]; offset: INTEGER; length: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32): System.String use System.Xml.XmlNameTable"
		alias
			"Get"
		end

end -- class SYSTEM_XML_XML_NAME_TABLE
