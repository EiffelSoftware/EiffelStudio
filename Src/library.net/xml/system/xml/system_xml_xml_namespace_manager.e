indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlNamespaceManager"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_NAMESPACE_MANAGER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make (name_table: SYSTEM_XML_XML_NAME_TABLE) is
		external
			"IL creator signature (System.Xml.XmlNameTable) use System.Xml.XmlNamespaceManager"
		end

feature -- Access

	get_default_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNamespaceManager"
		alias
			"get_DefaultNamespace"
		end

	frozen get_name_table: SYSTEM_XML_XML_NAME_TABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlNamespaceManager"
		alias
			"get_NameTable"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNamespaceManager"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

	remove_namespace (prefix_: SYSTEM_STRING; uri: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlNamespaceManager"
		alias
			"RemoveNamespace"
		end

	get_enumerator: IENUMERATOR is
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

	has_namespace (prefix_: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlNamespaceManager"
		alias
			"HasNamespace"
		end

	add_namespace (prefix_: SYSTEM_STRING; uri: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlNamespaceManager"
		alias
			"AddNamespace"
		end

	lookup_namespace (prefix_: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNamespaceManager"
		alias
			"LookupNamespace"
		end

	lookup_prefix (uri: SYSTEM_STRING): SYSTEM_STRING is
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

end -- class SYSTEM_XML_XML_NAMESPACE_MANAGER
