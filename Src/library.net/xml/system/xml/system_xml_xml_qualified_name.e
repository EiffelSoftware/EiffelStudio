indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlQualifiedName"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_QUALIFIED_NAME

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Xml.XmlQualifiedName"
		end

	frozen make is
		external
			"IL creator use System.Xml.XmlQualifiedName"
		end

	frozen make_1 (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.XmlQualifiedName"
		end

feature -- Access

	frozen empty: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL static_field signature :System.Xml.XmlQualifiedName use System.Xml.XmlQualifiedName"
		alias
			"Empty"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlQualifiedName"
		alias
			"get_IsEmpty"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlQualifiedName"
		alias
			"get_Name"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlQualifiedName"
		alias
			"get_Namespace"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlQualifiedName"
		alias
			"GetHashCode"
		end

	frozen to_string_string (name: SYSTEM_STRING; ns: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Xml.XmlQualifiedName"
		alias
			"ToString"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlQualifiedName"
		alias
			"ToString"
		end

	equals (other: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XmlQualifiedName"
		alias
			"Equals"
		end

feature -- Binary Operators

	frozen infix "#==" (b: SYSTEM_XML_XML_QUALIFIED_NAME): BOOLEAN is
		external
			"IL operator signature (System.Xml.XmlQualifiedName): System.Boolean use System.Xml.XmlQualifiedName"
		alias
			"op_Equality"
		end

	frozen infix "|=" (b: SYSTEM_XML_XML_QUALIFIED_NAME): BOOLEAN is
		external
			"IL operator signature (System.Xml.XmlQualifiedName): System.Boolean use System.Xml.XmlQualifiedName"
		alias
			"op_Inequality"
		end

end -- class SYSTEM_XML_XML_QUALIFIED_NAME
