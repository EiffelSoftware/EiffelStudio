indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSchemas"

external class
	SYSTEM_XML_SERIALIZATION_XMLSCHEMAS

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			extend as system_collections_ilist_add,
			has as system_collections_ilist_contains,
			put_i_th as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_COLLECTIONBASE
		redefine
			on_remove,
			on_clear,
			on_insert,
			on_set
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create
	make_xmlschemas

feature {NONE} -- Initialization

	frozen make_xmlschemas is
		external
			"IL creator use System.Xml.Serialization.XmlSchemas"
		end

feature -- Access

	frozen get_item (ns: STRING): SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL signature (System.String): System.Xml.Schema.XmlSchema use System.Xml.Serialization.XmlSchemas"
		alias
			"get_Item"
		end

	frozen get_item_int32 (index: INTEGER): SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL signature (System.Int32): System.Xml.Schema.XmlSchema use System.Xml.Serialization.XmlSchemas"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_XML_SCHEMA_XMLSCHEMA) is
		external
			"IL signature (System.Int32, System.Xml.Schema.XmlSchema): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; schema: SYSTEM_XML_SCHEMA_XMLSCHEMA) is
		external
			"IL signature (System.Int32, System.Xml.Schema.XmlSchema): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"Insert"
		end

	frozen is_data_set (schema: SYSTEM_XML_SCHEMA_XMLSCHEMA): BOOLEAN is
		external
			"IL static signature (System.Xml.Schema.XmlSchema): System.Boolean use System.Xml.Serialization.XmlSchemas"
		alias
			"IsDataSet"
		end

	frozen add_xml_schema (schema: SYSTEM_XML_SCHEMA_XMLSCHEMA): INTEGER is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Int32 use System.Xml.Serialization.XmlSchemas"
		alias
			"Add"
		end

	frozen copy_to (array: ARRAY [SYSTEM_XML_SCHEMA_XMLSCHEMA]; index: INTEGER) is
		external
			"IL signature (System.Xml.Schema.XmlSchema[], System.Int32): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"CopyTo"
		end

	frozen index_of (schema: SYSTEM_XML_SCHEMA_XMLSCHEMA): INTEGER is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Int32 use System.Xml.Serialization.XmlSchemas"
		alias
			"IndexOf"
		end

	frozen remove (schema: SYSTEM_XML_SCHEMA_XMLSCHEMA) is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"Remove"
		end

	frozen contains (schema: SYSTEM_XML_SCHEMA_XMLSCHEMA): BOOLEAN is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Boolean use System.Xml.Serialization.XmlSchemas"
		alias
			"Contains"
		end

	frozen add (schemas: SYSTEM_XML_SERIALIZATION_XMLSCHEMAS) is
		external
			"IL signature (System.Xml.Serialization.XmlSchemas): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"Add"
		end

	frozen find (name: SYSTEM_XML_XMLQUALIFIEDNAME; type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.Type): System.Object use System.Xml.Serialization.XmlSchemas"
		alias
			"Find"
		end

feature {NONE} -- Implementation

	on_remove (index: INTEGER; value: ANY) is
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

	on_set (index: INTEGER; old_value: ANY; new_value: ANY) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"OnSet"
		end

	on_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Xml.Serialization.XmlSchemas"
		alias
			"OnInsert"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLSCHEMAS
