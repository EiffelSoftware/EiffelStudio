indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaCollection"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_XML_XML_SCHEMA_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
		rename
			get_count as system_collections_icollection_get_count,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			copy_to as system_collections_icollection_copy_to,
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Schema.XmlSchemaCollection"
		end

	frozen make_1 (nametable: SYSTEM_XML_XML_NAME_TABLE) is
		external
			"IL creator signature (System.Xml.XmlNameTable) use System.Xml.Schema.XmlSchemaCollection"
		end

feature -- Access

	frozen get_item (ns: SYSTEM_STRING): SYSTEM_XML_XML_SCHEMA is
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

	frozen get_name_table: SYSTEM_XML_XML_NAME_TABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.Schema.XmlSchemaCollection"
		alias
			"get_NameTable"
		end

feature -- Element Change

	frozen remove_validation_event_handler (value: SYSTEM_XML_VALIDATION_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.Schema.ValidationEventHandler): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"remove_ValidationEventHandler"
		end

	frozen add_validation_event_handler (value: SYSTEM_XML_VALIDATION_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.Schema.ValidationEventHandler): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"add_ValidationEventHandler"
		end

feature -- Basic Operations

	frozen add_xml_schema_collection (schema: SYSTEM_XML_XML_SCHEMA_COLLECTION) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaCollection): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Add"
		end

	frozen add_string_xml_reader (ns: SYSTEM_STRING; reader: SYSTEM_XML_XML_READER): SYSTEM_XML_XML_SCHEMA is
		external
			"IL signature (System.String, System.Xml.XmlReader): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Add"
		end

	frozen add (schema: SYSTEM_XML_XML_SCHEMA): SYSTEM_XML_XML_SCHEMA is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Add"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_XML_XML_SCHEMA]; index: INTEGER) is
		external
			"IL signature (System.Xml.Schema.XmlSchema[], System.Int32): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"CopyTo"
		end

	frozen contains_xml_schema (schema: SYSTEM_XML_XML_SCHEMA): BOOLEAN is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Boolean use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Contains"
		end

	frozen contains (ns: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Contains"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaCollection"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.Schema.XmlSchemaCollection"
		alias
			"Equals"
		end

	frozen get_enumerator: SYSTEM_XML_XML_SCHEMA_COLLECTION_ENUMERATOR is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaCollectionEnumerator use System.Xml.Schema.XmlSchemaCollection"
		alias
			"GetEnumerator"
		end

	frozen add_string_string (ns: SYSTEM_STRING; uri: SYSTEM_STRING): SYSTEM_XML_XML_SCHEMA is
		external
			"IL signature (System.String, System.String): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchemaCollection"
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

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Xml.Schema.XmlSchemaCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Xml.Schema.XmlSchemaCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
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

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Schema.XmlSchemaCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_XML_XML_SCHEMA_COLLECTION
