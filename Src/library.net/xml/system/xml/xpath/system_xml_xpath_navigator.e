indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XPath.XPathNavigator"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XPATH_NAVIGATOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end

feature -- Access

	get_local_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"get_LocalName"
		end

	get_xml_lang: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"get_XmlLang"
		end

	get_value: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"get_Value"
		end

	get_prefix: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"get_Prefix"
		end

	get_has_attributes: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"get_HasAttributes"
		end

	get_is_empty_element: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"get_IsEmptyElement"
		end

	get_base_uri: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"get_BaseURI"
		end

	get_namespace_uri: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"get_NamespaceURI"
		end

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"get_Name"
		end

	get_node_type: SYSTEM_XML_XPATH_NODE_TYPE is
		external
			"IL deferred signature (): System.Xml.XPath.XPathNodeType use System.Xml.XPath.XPathNavigator"
		alias
			"get_NodeType"
		end

	get_name_table: SYSTEM_XML_XML_NAME_TABLE is
		external
			"IL deferred signature (): System.Xml.XmlNameTable use System.Xml.XPath.XPathNavigator"
		alias
			"get_NameTable"
		end

	get_has_children: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"get_HasChildren"
		end

feature -- Basic Operations

	move_to_id (id: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToId"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XPath.XPathNavigator"
		alias
			"GetHashCode"
		end

	select_descendants_string (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING; match_self: BOOLEAN): SYSTEM_XML_XPATH_NODE_ITERATOR is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNavigator"
		alias
			"SelectDescendants"
		end

	move_to_next_namespace_xpath_namespace_scope (namespace_scope: SYSTEM_XML_XPATH_NAMESPACE_SCOPE): BOOLEAN is
		external
			"IL deferred signature (System.Xml.XPath.XPathNamespaceScope): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToNextNamespace"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"ToString"
		end

	compare_position (nav: SYSTEM_XML_XPATH_NAVIGATOR): SYSTEM_XML_XML_NODE_ORDER is
		external
			"IL signature (System.Xml.XPath.XPathNavigator): System.Xml.XmlNodeOrder use System.Xml.XPath.XPathNavigator"
		alias
			"ComparePosition"
		end

	select_ (expr: SYSTEM_XML_XPATH_EXPRESSION): SYSTEM_XML_XPATH_NODE_ITERATOR is
		external
			"IL signature (System.Xml.XPath.XPathExpression): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNavigator"
		alias
			"Select"
		end

	get_namespace (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"GetNamespace"
		end

	move_to_root is
		external
			"IL deferred signature (): System.Void use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToRoot"
		end

	move_to_first: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToFirst"
		end

	frozen move_to_first_namespace: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToFirstNamespace"
		end

	move_to_next_attribute: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToNextAttribute"
		end

	move_to_first_namespace_xpath_namespace_scope (namespace_scope: SYSTEM_XML_XPATH_NAMESPACE_SCOPE): BOOLEAN is
		external
			"IL deferred signature (System.Xml.XPath.XPathNamespaceScope): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToFirstNamespace"
		end

	frozen move_to_next_namespace: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToNextNamespace"
		end

	select_descendants (type: SYSTEM_XML_XPATH_NODE_TYPE; match_self: BOOLEAN): SYSTEM_XML_XPATH_NODE_ITERATOR is
		external
			"IL signature (System.Xml.XPath.XPathNodeType, System.Boolean): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNavigator"
		alias
			"SelectDescendants"
		end

	move_to_parent: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToParent"
		end

	move_to_namespace (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToNamespace"
		end

	evaluate_xpath_expression_xpath_node_iterator (expr: SYSTEM_XML_XPATH_EXPRESSION; context: SYSTEM_XML_XPATH_NODE_ITERATOR): SYSTEM_OBJECT is
		external
			"IL signature (System.Xml.XPath.XPathExpression, System.Xml.XPath.XPathNodeIterator): System.Object use System.Xml.XPath.XPathNavigator"
		alias
			"Evaluate"
		end

	evaluate_string (xpath: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Xml.XPath.XPathNavigator"
		alias
			"Evaluate"
		end

	is_descendant (nav: SYSTEM_XML_XPATH_NAVIGATOR): BOOLEAN is
		external
			"IL signature (System.Xml.XPath.XPathNavigator): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"IsDescendant"
		end

	get_attribute (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String, System.String): System.String use System.Xml.XPath.XPathNavigator"
		alias
			"GetAttribute"
		end

	move_to (other: SYSTEM_XML_XPATH_NAVIGATOR): BOOLEAN is
		external
			"IL deferred signature (System.Xml.XPath.XPathNavigator): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveTo"
		end

	evaluate (expr: SYSTEM_XML_XPATH_EXPRESSION): SYSTEM_OBJECT is
		external
			"IL signature (System.Xml.XPath.XPathExpression): System.Object use System.Xml.XPath.XPathNavigator"
		alias
			"Evaluate"
		end

	move_to_previous: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToPrevious"
		end

	select_children (type: SYSTEM_XML_XPATH_NODE_TYPE): SYSTEM_XML_XPATH_NODE_ITERATOR is
		external
			"IL signature (System.Xml.XPath.XPathNodeType): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNavigator"
		alias
			"SelectChildren"
		end

	matches (expr: SYSTEM_XML_XPATH_EXPRESSION): BOOLEAN is
		external
			"IL signature (System.Xml.XPath.XPathExpression): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"Matches"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"Equals"
		end

	move_to_first_child: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToFirstChild"
		end

	move_to_attribute (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String, System.String): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToAttribute"
		end

	move_to_first_attribute: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToFirstAttribute"
		end

	select__string (xpath: SYSTEM_STRING): SYSTEM_XML_XPATH_NODE_ITERATOR is
		external
			"IL signature (System.String): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNavigator"
		alias
			"Select"
		end

	select_ancestors (type: SYSTEM_XML_XPATH_NODE_TYPE; match_self: BOOLEAN): SYSTEM_XML_XPATH_NODE_ITERATOR is
		external
			"IL signature (System.Xml.XPath.XPathNodeType, System.Boolean): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNavigator"
		alias
			"SelectAncestors"
		end

	select_ancestors_string (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING; match_self: BOOLEAN): SYSTEM_XML_XPATH_NODE_ITERATOR is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNavigator"
		alias
			"SelectAncestors"
		end

	select_children_string (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XPATH_NODE_ITERATOR is
		external
			"IL signature (System.String, System.String): System.Xml.XPath.XPathNodeIterator use System.Xml.XPath.XPathNavigator"
		alias
			"SelectChildren"
		end

	compile (xpath: SYSTEM_STRING): SYSTEM_XML_XPATH_EXPRESSION is
		external
			"IL signature (System.String): System.Xml.XPath.XPathExpression use System.Xml.XPath.XPathNavigator"
		alias
			"Compile"
		end

	clone_: SYSTEM_XML_XPATH_NAVIGATOR is
		external
			"IL deferred signature (): System.Xml.XPath.XPathNavigator use System.Xml.XPath.XPathNavigator"
		alias
			"Clone"
		end

	move_to_next: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"MoveToNext"
		end

	is_same_position (other: SYSTEM_XML_XPATH_NAVIGATOR): BOOLEAN is
		external
			"IL deferred signature (System.Xml.XPath.XPathNavigator): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"IsSamePosition"
		end

	matches_string (xpath: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XPath.XPathNavigator"
		alias
			"Matches"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Xml.XPath.XPathNavigator"
		alias
			"Finalize"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.XPath.XPathNavigator"
		alias
			"System.ICloneable.Clone"
		end

end -- class SYSTEM_XML_XPATH_NAVIGATOR
