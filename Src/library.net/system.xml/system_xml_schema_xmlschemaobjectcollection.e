indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaObjectCollection"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION

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
	make_xmlschemaobjectcollection,
	make_xmlschemaobjectcollection_1

feature {NONE} -- Initialization

	frozen make_xmlschemaobjectcollection is
		external
			"IL creator use System.Xml.Schema.XmlSchemaObjectCollection"
		end

	frozen make_xmlschemaobjectcollection_1 (parent: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT) is
		external
			"IL creator signature (System.Xml.Schema.XmlSchemaObject) use System.Xml.Schema.XmlSchemaObjectCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT is
		external
			"IL signature (System.Int32): System.Xml.Schema.XmlSchemaObject use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item (index: INTEGER; value: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT) is
		external
			"IL signature (System.Int32, System.Xml.Schema.XmlSchemaObject): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: ARRAY [SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT]; index: INTEGER) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject[], System.Int32): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator_xml_schema_object_enumerator: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTENUMERATOR is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectEnumerator use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"GetEnumerator"
		end

	frozen contains (item: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT): BOOLEAN is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject): System.Boolean use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"Contains"
		end

	frozen index_of (item: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT): INTEGER is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject): System.Int32 use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"IndexOf"
		end

	frozen add (item: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT): INTEGER is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject): System.Int32 use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"Add"
		end

	frozen remove (item: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaObject): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; item: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT) is
		external
			"IL signature (System.Int32, System.Xml.Schema.XmlSchemaObject): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"Insert"
		end

feature {NONE} -- Implementation

	on_remove (index: INTEGER; item: ANY) is
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

	on_set (index: INTEGER; old_value: ANY; new_value: ANY) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"OnSet"
		end

	on_insert (index: INTEGER; item: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Xml.Schema.XmlSchemaObjectCollection"
		alias
			"OnInsert"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION
