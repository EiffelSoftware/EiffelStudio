indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlAnyElementAttributes"

external class
	SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTES

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
	make_xmlanyelementattributes

feature {NONE} -- Initialization

	frozen make_xmlanyelementattributes is
		external
			"IL creator use System.Xml.Serialization.XmlAnyElementAttributes"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE is
		external
			"IL signature (System.Int32): System.Xml.Serialization.XmlAnyElementAttribute use System.Xml.Serialization.XmlAnyElementAttributes"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen put_i_th (index: INTEGER; value: SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE) is
		external
			"IL signature (System.Int32, System.Xml.Serialization.XmlAnyElementAttribute): System.Void use System.Xml.Serialization.XmlAnyElementAttributes"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: ARRAY [SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE]; index: INTEGER) is
		external
			"IL signature (System.Xml.Serialization.XmlAnyElementAttribute[], System.Int32): System.Void use System.Xml.Serialization.XmlAnyElementAttributes"
		alias
			"CopyTo"
		end

	frozen has (attribute: SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Xml.Serialization.XmlAnyElementAttribute): System.Boolean use System.Xml.Serialization.XmlAnyElementAttributes"
		alias
			"Contains"
		end

	frozen index_of (attribute: SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE): INTEGER is
		external
			"IL signature (System.Xml.Serialization.XmlAnyElementAttribute): System.Int32 use System.Xml.Serialization.XmlAnyElementAttributes"
		alias
			"IndexOf"
		end

	frozen extend (attribute: SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE): INTEGER is
		external
			"IL signature (System.Xml.Serialization.XmlAnyElementAttribute): System.Int32 use System.Xml.Serialization.XmlAnyElementAttributes"
		alias
			"Add"
		end

	frozen remove (attribute: SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlAnyElementAttribute): System.Void use System.Xml.Serialization.XmlAnyElementAttributes"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; attribute: SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE) is
		external
			"IL signature (System.Int32, System.Xml.Serialization.XmlAnyElementAttribute): System.Void use System.Xml.Serialization.XmlAnyElementAttributes"
		alias
			"Insert"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTES
