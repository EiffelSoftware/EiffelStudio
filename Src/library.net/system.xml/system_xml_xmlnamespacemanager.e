indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlNamespaceManager"

external class
	SYSTEM_XML_XMLNAMESPACEMANAGER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make (name_table: SYSTEM_XML_XMLNAMETABLE) is
		external
			"IL creator signature (System.Xml.XmlNameTable) use System.Xml.XmlNamespaceManager"
		end

feature -- Access

	get_default_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNamespaceManager"
		alias
			"get_DefaultNamespace"
		end

	frozen get_name_table: SYSTEM_XML_XMLNAMETABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlNamespaceManager"
		alias
			"get_NameTable"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNamespaceManager"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XmlNamespaceManager"
		alias
			"Equals"
		end

	push_scope is
		external
			"IL signature (): System.Void use System.Xml.XmlNamespaceManager"
		alias
			"PushScope"
		end

	pop_scope: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNamespaceManager"
		alias
			"PopScope"
		end

	remove_namespace (prefix_: STRING; uri: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlNamespaceManager"
		alias
			"RemoveNamespace"
		end

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Xml.XmlNamespaceManager"
		alias
			"GetEnumerator"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlNamespaceManager"
		alias
			"GetHashCode"
		end

	has_namespace (prefix_: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlNamespaceManager"
		alias
			"HasNamespace"
		end

	add_namespace (prefix_: STRING; uri: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlNamespaceManager"
		alias
			"AddNamespace"
		end

	lookup_namespace (prefix_: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNamespaceManager"
		alias
			"LookupNamespace"
		end

	lookup_prefix (uri: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNamespaceManager"
		alias
			"LookupPrefix"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Xml.XmlNamespaceManager"
		alias
			"Finalize"
		end

end -- class SYSTEM_XML_XMLNAMESPACEMANAGER
