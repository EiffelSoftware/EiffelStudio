indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlAttributeCollection"

external class
	SYSTEM_XML_XMLATTRIBUTECOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_count as system_collections_icollection_get_count,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			copy_to as system_collections_icollection_copy_to
		end
	SYSTEM_XML_XMLNAMEDNODEMAP
		redefine
			set_named_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	get_item_of_string (name: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String): System.Xml.XmlAttribute use System.Xml.XmlAttributeCollection"
		alias
			"get_ItemOf"
		end

	get_item_of_string_string (local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlAttributeCollection"
		alias
			"get_ItemOf"
		end

	get_item_of (i: INTEGER): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.Int32): System.Xml.XmlAttribute use System.Xml.XmlAttributeCollection"
		alias
			"get_ItemOf"
		end

feature -- Basic Operations

	set_named_item (node: SYSTEM_XML_XMLNODE): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlAttributeCollection"
		alias
			"SetNamedItem"
		end

	insert_after (new_node: SYSTEM_XML_XMLATTRIBUTE; ref_node: SYSTEM_XML_XMLATTRIBUTE): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.Xml.XmlAttribute, System.Xml.XmlAttribute): System.Xml.XmlAttribute use System.Xml.XmlAttributeCollection"
		alias
			"InsertAfter"
		end

	frozen copy_to (array: ARRAY [SYSTEM_XML_XMLATTRIBUTE]; index: INTEGER) is
		external
			"IL signature (System.Xml.XmlAttribute[], System.Int32): System.Void use System.Xml.XmlAttributeCollection"
		alias
			"CopyTo"
		end

	remove (node: SYSTEM_XML_XMLATTRIBUTE): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.Xml.XmlAttribute): System.Xml.XmlAttribute use System.Xml.XmlAttributeCollection"
		alias
			"Remove"
		end

	remove_all is
		external
			"IL signature (): System.Void use System.Xml.XmlAttributeCollection"
		alias
			"RemoveAll"
		end

	append (node: SYSTEM_XML_XMLATTRIBUTE): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.Xml.XmlAttribute): System.Xml.XmlAttribute use System.Xml.XmlAttributeCollection"
		alias
			"Append"
		end

	prepend (node: SYSTEM_XML_XMLATTRIBUTE): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.Xml.XmlAttribute): System.Xml.XmlAttribute use System.Xml.XmlAttributeCollection"
		alias
			"Prepend"
		end

	insert_before (new_node: SYSTEM_XML_XMLATTRIBUTE; ref_node: SYSTEM_XML_XMLATTRIBUTE): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.Xml.XmlAttribute, System.Xml.XmlAttribute): System.Xml.XmlAttribute use System.Xml.XmlAttributeCollection"
		alias
			"InsertBefore"
		end

	remove_at (i: INTEGER): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.Int32): System.Xml.XmlAttribute use System.Xml.XmlAttributeCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Xml.XmlAttributeCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlAttributeCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlAttributeCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Xml.XmlAttributeCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_XML_XMLATTRIBUTECOLLECTION
