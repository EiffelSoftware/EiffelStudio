indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaCollection"

frozen external class
	SYSTEM_XML_SCHEMA_XMLSCHEMACOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_count as icollection_get_count,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			copy_to as icollection_copy_to,
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Schema.XmlSchemaCollection"
		end

	frozen make_1 (nametable: SYSTEM_XML_XMLNAMETABLE) is
		external
			"IL creator signature (System.Xml.XmlNameTable) use System.Xml.Schema.XmlSchemaCollection"
		end

feature -- Access

	frozen get_item (ns: STRING): SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL signature (System.String): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchemaCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaCollection"
		alias
			"get_Count"
		end

	frozen get_name_table: SYSTEM_XML_XMLNAMETABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.Schema.XmlSchemaCollection"
		alias
			"get_NameTable"
		end

feature -- Element Change

	frozen remove_validation_event_handler (value: SYSTEM_XML_SCHEMA_VALIDATIONEVENTHANDLER) is
		external
			"IL signature (System.Xml.Schema.ValidationEventHandler): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"remove_ValidationEventHandler"
		end

	frozen add_validation_event_handler (value: SYSTEM_XML_SCHEMA_VALIDATIONEVENTHANDLER) is
		external
			"IL signature (System.Xml.Schema.ValidationEventHandler): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"add_ValidationEventHandler"
		end

feature -- Basic Operations

	frozen add_xml_schema_collection (schema: SYSTEM_XML_SCHEMA_XMLSCHEMACOLLECTION) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaCollection): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Add"
		end

	frozen add_string_xml_reader (ns: STRING; reader: SYSTEM_XML_XMLREADER) is
		external
			"IL signature (System.String, System.Xml.XmlReader): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Add"
		end

	frozen extend (schema: SYSTEM_XML_SCHEMA_XMLSCHEMA) is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Add"
		end

	frozen get_enumerator: SYSTEM_XML_SCHEMA_XMLSCHEMACOLLECTIONENUMERATOR is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaCollectionEnumerator use System.Xml.Schema.XmlSchemaCollection"
		alias
			"GetEnumerator"
		end

	frozen copy_to (array: ARRAY [SYSTEM_XML_SCHEMA_XMLSCHEMA]; index: INTEGER) is
		external
			"IL signature (System.Xml.Schema.XmlSchema[], System.Int32): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"CopyTo"
		end

	frozen contains_xml_schema (schema: SYSTEM_XML_SCHEMA_XMLSCHEMA): BOOLEAN is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Boolean use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Contains"
		end

	frozen remove (ns: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Remove"
		end

	frozen has (ns: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Contains"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaCollection"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Equals"
		end

	frozen remove_xml_schema (schema: SYSTEM_XML_SCHEMA_XMLSCHEMA) is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Remove"
		end

	frozen add_string_string (ns: STRING; uri: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Xml.Schema.XmlSchemaCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Finalize"
		end

	frozen icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Xml.Schema.XmlSchemaCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMACOLLECTION
