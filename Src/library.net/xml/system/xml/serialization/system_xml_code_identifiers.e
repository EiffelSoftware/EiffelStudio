indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.CodeIdentifiers"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_CODE_IDENTIFIERS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.CodeIdentifiers"
		end

feature -- Access

	frozen get_use_camel_casing: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.CodeIdentifiers"
		alias
			"get_UseCamelCasing"
		end

feature -- Element Change

	frozen set_use_camel_casing (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"set_UseCamelCasing"
		end

feature -- Basic Operations

	frozen add_reserved (identifier: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"AddReserved"
		end

	frozen remove_reserved (identifier: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"RemoveReserved"
		end

	frozen add_unique (identifier: SYSTEM_STRING; value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.String, System.Object): System.String use System.Xml.Serialization.CodeIdentifiers"
		alias
			"AddUnique"
		end

	frozen make_right_case (identifier: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.Serialization.CodeIdentifiers"
		alias
			"MakeRightCase"
		end

	frozen is_in_use (identifier: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.Serialization.CodeIdentifiers"
		alias
			"IsInUse"
		end

	frozen to_array (type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.Xml.Serialization.CodeIdentifiers"
		alias
			"ToArray"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"Clear"
		end

	frozen make_unique (identifier: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.Serialization.CodeIdentifiers"
		alias
			"MakeUnique"
		end

	frozen add (identifier: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"Add"
		end

	frozen remove (identifier: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"Remove"
		end

end -- class SYSTEM_XML_CODE_IDENTIFIERS
