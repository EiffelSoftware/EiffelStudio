indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.NameTable"

external class
	SYSTEM_XML_NAMETABLE

inherit
	SYSTEM_XML_XMLNAMETABLE

create
	make_nametable

feature {NONE} -- Initialization

	frozen make_nametable is
		external
			"IL creator use System.Xml.NameTable"
		end

feature -- Basic Operations

	add_array_char (key: ARRAY [CHARACTER]; start: INTEGER; len: INTEGER): STRING is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.String use System.Xml.NameTable"
		alias
			"Add"
		end

	add (key: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.NameTable"
		alias
			"Add"
		end

	get (value: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.NameTable"
		alias
			"Get"
		end

	get_array_char (key: ARRAY [CHARACTER]; start: INTEGER; len: INTEGER): STRING is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.String use System.Xml.NameTable"
		alias
			"Get"
		end

end -- class SYSTEM_XML_NAMETABLE
