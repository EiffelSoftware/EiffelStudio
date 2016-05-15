note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_XML_NODE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_kind_,
	make_with_kind__options_,
	make

feature {NONE} -- Initialization

	make_with_kind_ (a_kind: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_kind_(allocate_object, a_kind))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_kind__options_ (a_kind: NATURAL_64; a_options: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_kind__options_(allocate_object, a_kind, a_options))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSXMLNode Externals

	objc_init_with_kind_ (an_item: POINTER; a_kind: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item initWithKind:$a_kind];
			 ]"
		end

	objc_init_with_kind__options_ (an_item: POINTER; a_kind: NATURAL_64; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item initWithKind:$a_kind options:$a_options];
			 ]"
		end

	objc_kind (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLNode *)$an_item kind];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLNode *)$an_item setName:$a_name];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item name];
			 ]"
		end

	objc_set_object_value_ (an_item: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLNode *)$an_item setObjectValue:$a_value];
			 ]"
		end

	objc_object_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item objectValue];
			 ]"
		end

	objc_set_string_value_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLNode *)$an_item setStringValue:$a_string];
			 ]"
		end

	objc_set_string_value__resolving_entities_ (an_item: POINTER; a_string: POINTER; a_resolve: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLNode *)$an_item setStringValue:$a_string resolvingEntities:$a_resolve];
			 ]"
		end

	objc_string_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item stringValue];
			 ]"
		end

	objc_index (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLNode *)$an_item index];
			 ]"
		end

	objc_level (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLNode *)$an_item level];
			 ]"
		end

	objc_root_document (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item rootDocument];
			 ]"
		end

	objc_parent (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item parent];
			 ]"
		end

	objc_child_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLNode *)$an_item childCount];
			 ]"
		end

	objc_children (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item children];
			 ]"
		end

	objc_child_at_index_ (an_item: POINTER; a_index: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item childAtIndex:$a_index];
			 ]"
		end

	objc_previous_sibling (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item previousSibling];
			 ]"
		end

	objc_next_sibling (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item nextSibling];
			 ]"
		end

	objc_previous_node (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item previousNode];
			 ]"
		end

	objc_next_node (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item nextNode];
			 ]"
		end

	objc_detach (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLNode *)$an_item detach];
			 ]"
		end

	objc_x_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item XPath];
			 ]"
		end

	objc_local_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item localName];
			 ]"
		end

	objc_prefix_objc (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item prefix];
			 ]"
		end

	objc_set_ur_i_ (an_item: POINTER; a_uri: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLNode *)$an_item setURI:$a_uri];
			 ]"
		end

	objc_uri (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item URI];
			 ]"
		end

	objc_xml_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item XMLString];
			 ]"
		end

	objc_xml_string_with_options_ (an_item: POINTER; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item XMLStringWithOptions:$a_options];
			 ]"
		end

	objc_canonical_xml_string_preserving_comments_ (an_item: POINTER; a_comments: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLNode *)$an_item canonicalXMLStringPreservingComments:$a_comments];
			 ]"
		end

--	objc_nodes_for_x_path__error_ (an_item: POINTER; a_xpath: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLNode *)$an_item nodesForXPath:$a_xpath error:];
--			 ]"
--		end

--	objc_objects_for_x_query__constants__error_ (an_item: POINTER; a_xquery: POINTER; a_constants: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLNode *)$an_item objectsForXQuery:$a_xquery constants:$a_constants error:];
--			 ]"
--		end

--	objc_objects_for_x_query__error_ (an_item: POINTER; a_xquery: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLNode *)$an_item objectsForXQuery:$a_xquery error:];
--			 ]"
--		end

feature -- NSXMLNode

	kind: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_kind (item)
		end

	set_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_name_ (item, a_name__item)
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_object_value_ (a_value: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_set_object_value_ (item, a_value__item)
		end

	object_value: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_string_value_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_string_value_ (item, a_string__item)
		end

	set_string_value__resolving_entities_ (a_string: detachable NS_STRING; a_resolve: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_string_value__resolving_entities_ (item, a_string__item, a_resolve)
		end

	string_value: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string_value (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index (item)
		end

	level: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_level (item)
		end

	root_document: detachable NS_XML_DOCUMENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_root_document (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like root_document} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like root_document} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	parent: detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_parent (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parent} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parent} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	child_count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_child_count (item)
		end

	children: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_children (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like children} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like children} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	child_at_index_ (a_index: NATURAL_64): detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_child_at_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like child_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like child_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	previous_sibling: detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_previous_sibling (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like previous_sibling} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like previous_sibling} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	next_sibling: detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_next_sibling (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_sibling} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_sibling} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	previous_node: detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_previous_node (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like previous_node} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like previous_node} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	next_node: detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_next_node (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_node} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_node} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	detach
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_detach (item)
		end

	x_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_x_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like x_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like x_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	local_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_local_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like local_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like local_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	prefix_objc: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_prefix_objc (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like prefix_objc} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like prefix_objc} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_ur_i_ (a_uri: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_uri__item: POINTER
		do
			if attached a_uri as a_uri_attached then
				a_uri__item := a_uri_attached.item
			end
			objc_set_ur_i_ (item, a_uri__item)
		end

	uri: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_uri (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like uri} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like uri} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	xml_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_xml_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like xml_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like xml_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	xml_string_with_options_ (a_options: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_xml_string_with_options_ (item, a_options)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like xml_string_with_options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like xml_string_with_options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	canonical_xml_string_preserving_comments_ (a_comments: BOOLEAN): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_canonical_xml_string_preserving_comments_ (item, a_comments)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like canonical_xml_string_preserving_comments_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like canonical_xml_string_preserving_comments_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	nodes_for_x_path__error_ (a_xpath: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_xpath__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_xpath as a_xpath_attached then
--				a_xpath__item := a_xpath_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_nodes_for_x_path__error_ (item, a_xpath__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like nodes_for_x_path__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like nodes_for_x_path__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	objects_for_x_query__constants__error_ (a_xquery: detachable NS_STRING; a_constants: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_xquery__item: POINTER
--			a_constants__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_xquery as a_xquery_attached then
--				a_xquery__item := a_xquery_attached.item
--			end
--			if attached a_constants as a_constants_attached then
--				a_constants__item := a_constants_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_objects_for_x_query__constants__error_ (item, a_xquery__item, a_constants__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like objects_for_x_query__constants__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like objects_for_x_query__constants__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	objects_for_x_query__error_ (a_xquery: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_xquery__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_xquery as a_xquery_attached then
--				a_xquery__item := a_xquery_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_objects_for_x_query__error_ (item, a_xquery__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like objects_for_x_query__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like objects_for_x_query__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSXMLNode"
		end

end
