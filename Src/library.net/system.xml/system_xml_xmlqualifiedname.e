indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlQualifiedName"

external class
	SYSTEM_XML_XMLQUALIFIEDNAME

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (name: STRING; ns: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Xml.XmlQualifiedName"
		end

	frozen make is
		external
			"IL creator use System.Xml.XmlQualifiedName"
		end

	frozen make_1 (name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.XmlQualifiedName"
		end

feature -- Access

	frozen empty: SYSTEM_XML_XMLQUALIFIEDNAME is
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

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlQualifiedName"
		alias
			"get_Name"
		end

	frozen get_namespace: STRING is
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

	equals_object (other: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XmlQualifiedName"
		alias
			"Equals"
		end

	frozen to_string_string (name: STRING; ns: STRING): STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Xml.XmlQualifiedName"
		alias
			"ToString"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlQualifiedName"
		alias
			"ToString"
		end

feature -- Binary Operators

	frozen infix "#==" (b: SYSTEM_XML_XMLQUALIFIEDNAME): BOOLEAN is
		external
			"IL operator  signature (System.Xml.XmlQualifiedName): System.Boolean use System.Xml.XmlQualifiedName"
		alias
			"op_Equality"
		end

	frozen infix "|=" (b: SYSTEM_XML_XMLQUALIFIEDNAME): BOOLEAN is
		external
			"IL operator  signature (System.Xml.XmlQualifiedName): System.Boolean use System.Xml.XmlQualifiedName"
		alias
			"op_Inequality"
		end

end -- class SYSTEM_XML_XMLQUALIFIEDNAME
