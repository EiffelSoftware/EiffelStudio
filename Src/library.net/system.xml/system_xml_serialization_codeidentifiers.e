indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.CodeIdentifiers"

external class
	SYSTEM_XML_SERIALIZATION_CODEIDENTIFIERS

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

	frozen add_reserved (identifier: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"AddReserved"
		end

	frozen remove_reserved (identifier: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"RemoveReserved"
		end

	frozen add_unique (identifier: STRING; value: ANY): STRING is
		external
			"IL signature (System.String, System.Object): System.String use System.Xml.Serialization.CodeIdentifiers"
		alias
			"AddUnique"
		end

	frozen make_right_case (identifier: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.Serialization.CodeIdentifiers"
		alias
			"MakeRightCase"
		end

	frozen is_in_use (identifier: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.Serialization.CodeIdentifiers"
		alias
			"IsInUse"
		end

	frozen to_array (type: SYSTEM_TYPE): ANY is
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

	frozen make_unique (identifier: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.Serialization.CodeIdentifiers"
		alias
			"MakeUnique"
		end

	frozen add (identifier: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"Add"
		end

	frozen remove (identifier: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.CodeIdentifiers"
		alias
			"Remove"
		end

end -- class SYSTEM_XML_SERIALIZATION_CODEIDENTIFIERS
