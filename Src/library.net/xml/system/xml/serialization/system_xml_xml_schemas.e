indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSchemas"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMAS

inherit
	COLLECTION_BASE
		redefine
			on_remove,
			on_clear,
			on_insert,
			on_set
		end
	ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			add as system_collections_ilist_add,
			contains as system_collections_ilist_contains,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create
	make_system_xml_xml_schemas

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schemas is
		external
			"IL creator use System.Xml.Serialization.XmlSchemas"
		end

feature -- Access

	frozen get_item (ns: SYSTEM_STRING): SYSTEM_XML_XML_SCHEMA is
		external
			"IL signature (System.String): System.Xml.Schema.XmlSchema use System.Xml.Serialization.XmlSchemas"
		alias
			"get_Item"
		end

	frozen get_item_int32 (index: INTEGER): SYSTEM_XML_XML_SCHEMA is
		external
			"IL signature (System.Int32): System.Xml.Schema.XmlSchema use System.Xml.Serialization.XmlSchemas"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_XML_XML_SCHEMA) is
		external
			"IL signature (System.Int32, System.Xml.Schema.XmlSchema): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; schema: SYSTEM_XML_XML_SCHEMA) is
		external
			"IL signature (System.Int32, System.Xml.Schema.XmlSchema): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"Insert"
		end

	frozen is_data_set (schema: SYSTEM_XML_XML_SCHEMA): BOOLEAN is
		external
			"IL static signature (System.Xml.Schema.XmlSchema): System.Boolean use System.Xml.Serialization.XmlSchemas"
		alias
			"IsDataSet"
		end

	frozen add_xml_schema (schema: SYSTEM_XML_XML_SCHEMA): INTEGER is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Int32 use System.Xml.Serialization.XmlSchemas"
		alias
			"Add"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_XML_XML_SCHEMA]; index: INTEGER) is
		external
			"IL signature (System.Xml.Schema.XmlSchema[], System.Int32): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"CopyTo"
		end

	frozen index_of (schema: SYSTEM_XML_XML_SCHEMA): INTEGER is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Int32 use System.Xml.Serialization.XmlSchemas"
		alias
			"IndexOf"
		end

	frozen remove (schema: SYSTEM_XML_XML_SCHEMA) is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"Remove"
		end

	frozen contains (schema: SYSTEM_XML_XML_SCHEMA): BOOLEAN is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Boolean use System.Xml.Serialization.XmlSchemas"
		alias
			"Contains"
		end

	frozen add (schemas: SYSTEM_XML_XML_SCHEMAS) is
		external
			"IL signature (System.Xml.Serialization.XmlSchemas): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"Add"
		end

	frozen find (name: SYSTEM_XML_XML_QUALIFIED_NAME; type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.Type): System.Object use System.Xml.Serialization.XmlSchemas"
		alias
			"Find"
		end

feature {NONE} -- Implementation

	on_remove (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"OnRemove"
		end

	on_clear is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"OnClear"
		end

	on_set (index: INTEGER; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"OnSet"
		end

	on_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"OnInsert"
		end

end -- class SYSTEM_XML_XML_SCHEMAS
