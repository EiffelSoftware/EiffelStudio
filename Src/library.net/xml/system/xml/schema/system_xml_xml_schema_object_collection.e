indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaObjectCollection"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION

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
	make_system_xml_xml_schema_object_collection,
	make_system_xml_xml_schema_object_collection_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_object_collection is
		external
			"IL creator use System.Xml.Schema.XmlSchemaObjectCollection"
		end

	frozen make_system_xml_xml_schema_object_collection_1 (parent: SYSTEM_XML_XML_SCHEMA_OBJECT) is
		external
			"IL creator signature (System.Xml.Schema.XmlSchemaObject) use System.Xml.Schema.XmlSchemaObjectCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_XML_XML_SCHEMA_OBJECT is
		external
			"IL signature (System.Int32): System.Xml.Schema.XmlSchemaObject use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item (index: INTEGER; value: SYSTEM_XML_XML_SCHEMA_OBJECT) is
		external
			"IL signature (System.Int32, System.Xml.Schema.XmlSchemaObject): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_XML_XML_SCHEMA_OBJECT]; index: INTEGER) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject[], System.Int32): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator_xml_schema_object_enumerator: SYSTEM_XML_XML_SCHEMA_OBJECT_ENUMERATOR is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectEnumerator use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"GetEnumerator"
		end

	frozen contains (item: SYSTEM_XML_XML_SCHEMA_OBJECT): BOOLEAN is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject): System.Boolean use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"Contains"
		end

	frozen index_of (item: SYSTEM_XML_XML_SCHEMA_OBJECT): INTEGER is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject): System.Int32 use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"IndexOf"
		end

	frozen add (item: SYSTEM_XML_XML_SCHEMA_OBJECT): INTEGER is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject): System.Int32 use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"Add"
		end

	frozen remove (item: SYSTEM_XML_XML_SCHEMA_OBJECT) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; item: SYSTEM_XML_XML_SCHEMA_OBJECT) is
		external
			"IL signature (System.Int32, System.Xml.Schema.XmlSchemaObject): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"Insert"
		end

feature {NONE} -- Implementation

	on_remove (index: INTEGER; item: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"OnRemove"
		end

	on_clear is
		external
			"IL signature (): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"OnClear"
		end

	on_set (index: INTEGER; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"OnSet"
		end

	on_insert (index: INTEGER; item: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"OnInsert"
		end

end -- class SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION
