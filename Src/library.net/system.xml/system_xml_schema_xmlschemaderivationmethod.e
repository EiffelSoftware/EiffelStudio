indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaDerivationMethod"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen substitution: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaDerivationMethod"
		alias
			"1"
		end

	frozen restriction: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaDerivationMethod"
		alias
			"4"
		end

	frozen union: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaDerivationMethod"
		alias
			"16"
		end

	frozen list: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaDerivationMethod"
		alias
			"8"
		end

	frozen empty: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaDerivationMethod"
		alias
			"0"
		end

	frozen none: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaDerivationMethod"
		alias
			"256"
		end

	frozen extension: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaDerivationMethod"
		alias
			"2"
		end

	frozen All_: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaDerivationMethod"
		alias
			"255"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD
