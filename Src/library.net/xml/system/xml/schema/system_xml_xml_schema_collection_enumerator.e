indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaCollectionEnumerator"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_XML_XML_SCHEMA_COLLECTION_ENUMERATOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERATOR
		rename
			get_current as system_collections_ienumerator_get_current,
			move_next as system_collections_ienumerator_move_next,
			reset as system_collections_ienumerator_reset
		end

create {NONE}

feature -- Access

	frozen get_current: SYSTEM_XML_XML_SCHEMA is
		external
			"IL signature (): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchemaCollectionEnumerator"
		alias
			"get_Current"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaCollectionEnumerator"
		alias
			"GetHashCode"
		end

	frozen move_next: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaCollectionEnumerator"
		alias
			"MoveNext"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaCollectionEnumerator"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.Schema.XmlSchemaCollectionEnumerator"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_ienumerator_move_next: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaCollectionEnumerator"
		alias
			"System.Collections.IEnumerator.MoveNext"
		end

	frozen system_collections_ienumerator_reset is
		external
			"IL signature (): System.Void use System.Xml.Schema.XmlSchemaCollectionEnumerator"
		alias
			"System.Collections.IEnumerator.Reset"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Xml.Schema.XmlSchemaCollectionEnumerator"
		alias
			"Finalize"
		end

	frozen system_collections_ienumerator_get_current: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Schema.XmlSchemaCollectionEnumerator"
		alias
			"System.Collections.IEnumerator.get_Current"
		end

end -- class SYSTEM_XML_XML_SCHEMA_COLLECTION_ENUMERATOR
