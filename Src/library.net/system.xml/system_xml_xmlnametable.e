indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlNameTable"

deferred external class
	SYSTEM_XML_XMLNAMETABLE

feature -- Basic Operations

	add_array_char (array: ARRAY [CHARACTER]; offset: INTEGER; length: INTEGER): STRING is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32): System.String use System.Xml.XmlNameTable"
		alias
			"Add"
		end

	add (array: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlNameTable"
		alias
			"Add"
		end

	get (array: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlNameTable"
		alias
			"Get"
		end

	get_array_char (array: ARRAY [CHARACTER]; offset: INTEGER; length: INTEGER): STRING is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32): System.String use System.Xml.XmlNameTable"
		alias
			"Get"
		end

end -- class SYSTEM_XML_XMLNAMETABLE
