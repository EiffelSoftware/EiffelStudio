indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlElementAttributes"

external class
	SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTES

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			insert as ilist_insert,
			index_of as ilist_index_of,
			remove as ilist_remove,
			extend as ilist_extend,
			has as ilist_has,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_COLLECTIONBASE
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end

create
	make_xmlelementattributes

feature {NONE} -- Initialization

	frozen make_xmlelementattributes is
		external
			"IL creator use System.Xml.Serialization.XmlElementAttributes"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE is
		external
			"IL signature (System.Int32): System.Xml.Serialization.XmlElementAttribute use System.Xml.Serialization.XmlElementAttributes"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen put_i_th (index: INTEGER; value: SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE) is
		external
			"IL signature (System.Int32, System.Xml.Serialization.XmlElementAttribute): System.Void use System.Xml.Serialization.XmlElementAttributes"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: ARRAY [SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE]; index: INTEGER) is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute[], System.Int32): System.Void use System.Xml.Serialization.XmlElementAttributes"
		alias
			"CopyTo"
		end

	frozen has (attribute: SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute): System.Boolean use System.Xml.Serialization.XmlElementAttributes"
		alias
			"Contains"
		end

	frozen index_of (attribute: SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE): INTEGER is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute): System.Int32 use System.Xml.Serialization.XmlElementAttributes"
		alias
			"IndexOf"
		end

	frozen extend (attribute: SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE): INTEGER is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute): System.Int32 use System.Xml.Serialization.XmlElementAttributes"
		alias
			"Add"
		end

	frozen remove (attribute: SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlElementAttribute): System.Void use System.Xml.Serialization.XmlElementAttributes"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; attribute: SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE) is
		external
			"IL signature (System.Int32, System.Xml.Serialization.XmlElementAttribute): System.Void use System.Xml.Serialization.XmlElementAttributes"
		alias
			"Insert"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTES
