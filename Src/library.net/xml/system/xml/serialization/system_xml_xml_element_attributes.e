indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlElementAttributes"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ELEMENT_ATTRIBUTES

inherit
	COLLECTION_BASE
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
	make_system_xml_xml_element_attributes

feature {NONE} -- Initialization

	frozen make_system_xml_xml_element_attributes is
		external
			"IL creator use System.Xml.Serialization.XmlElementAttributes"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_XML_XML_ELEMENT_ATTRIBUTE is
		external
			"IL signature (System.Int32): System.Xml.Serialization.XmlElementAttribute use System.Xml.Serialization.XmlElementAttributes"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_XML_XML_ELEMENT_ATTRIBUTE) is
		external
			"IL signature (System.Int32, System.Xml.Serialization.XmlElementAttribute): System.Void use System.Xml.Serialization.XmlElementAttributes"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_XML_XML_ELEMENT_ATTRIBUTE]; index: INTEGER) is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute[], System.Int32): System.Void use System.Xml.Serialization.XmlElementAttributes"
		alias
			"CopyTo"
		end

	frozen contains (attribute: SYSTEM_XML_XML_ELEMENT_ATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute): System.Boolean use System.Xml.Serialization.XmlElementAttributes"
		alias
			"Contains"
		end

	frozen index_of (attribute: SYSTEM_XML_XML_ELEMENT_ATTRIBUTE): INTEGER is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute): System.Int32 use System.Xml.Serialization.XmlElementAttributes"
		alias
			"IndexOf"
		end

	frozen add (attribute: SYSTEM_XML_XML_ELEMENT_ATTRIBUTE): INTEGER is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute): System.Int32 use System.Xml.Serialization.XmlElementAttributes"
		alias
			"Add"
		end

	frozen remove (attribute: SYSTEM_XML_XML_ELEMENT_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute): System.Void use System.Xml.Serialization.XmlElementAttributes"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; attribute: SYSTEM_XML_XML_ELEMENT_ATTRIBUTE) is
		external
			"IL signature (System.Int32, System.Xml.Serialization.XmlElementAttribute): System.Void use System.Xml.Serialization.XmlElementAttributes"
		alias
			"Insert"
		end

end -- class SYSTEM_XML_XML_ELEMENT_ATTRIBUTES
