note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_XML_ELEMENT

inherit
	NS_XML_NODE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_name_,
	make_with_name__ur_i_,
	make_with_name__string_value_,
	make_with_kind_,
	make_with_kind__options_,
	make

feature {NONE} -- Initialization

	make_with_name_ (a_name: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			make_with_pointer (objc_init_with_name_(allocate_object, a_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_name__ur_i_ (a_name: detachable NS_STRING; a_uri: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_name__item: POINTER
			a_uri__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_uri as a_uri_attached then
				a_uri__item := a_uri_attached.item
			end
			make_with_pointer (objc_init_with_name__ur_i_(allocate_object, a_name__item, a_uri__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_name__string_value_ (a_name: detachable NS_STRING; a_string: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_name__item: POINTER
			a_string__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			make_with_pointer (objc_init_with_name__string_value_(allocate_object, a_name__item, a_string__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_xml_string__error_ (a_string: detachable NS_STRING; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_string__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_string as a_string_attached then
--				a_string__item := a_string_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_with_xml_string__error_(allocate_object, a_string__item, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSXMLElement Externals

	objc_init_with_name_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item initWithName:$a_name];
			 ]"
		end

	objc_init_with_name__ur_i_ (an_item: POINTER; a_name: POINTER; a_uri: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item initWithName:$a_name URI:$a_uri];
			 ]"
		end

	objc_init_with_name__string_value_ (an_item: POINTER; a_name: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item initWithName:$a_name stringValue:$a_string];
			 ]"
		end

--	objc_init_with_xml_string__error_ (an_item: POINTER; a_string: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLElement *)$an_item initWithXMLString:$a_string error:];
--			 ]"
--		end

	objc_elements_for_name_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item elementsForName:$a_name];
			 ]"
		end

	objc_elements_for_local_name__ur_i_ (an_item: POINTER; a_local_name: POINTER; a_uri: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item elementsForLocalName:$a_local_name URI:$a_uri];
			 ]"
		end

	objc_add_attribute_ (an_item: POINTER; a_attribute: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item addAttribute:$a_attribute];
			 ]"
		end

	objc_remove_attribute_for_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item removeAttributeForName:$a_name];
			 ]"
		end

	objc_set_attributes_ (an_item: POINTER; a_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item setAttributes:$a_attributes];
			 ]"
		end

	objc_set_attributes_as_dictionary_ (an_item: POINTER; a_attributes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item setAttributesAsDictionary:$a_attributes];
			 ]"
		end

	objc_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item attributes];
			 ]"
		end

	objc_attribute_for_name_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item attributeForName:$a_name];
			 ]"
		end

	objc_attribute_for_local_name__ur_i_ (an_item: POINTER; a_local_name: POINTER; a_uri: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item attributeForLocalName:$a_local_name URI:$a_uri];
			 ]"
		end

	objc_add_namespace_ (an_item: POINTER; a_namespace: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item addNamespace:$a_namespace];
			 ]"
		end

	objc_remove_namespace_for_prefix_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item removeNamespaceForPrefix:$a_name];
			 ]"
		end

	objc_set_namespaces_ (an_item: POINTER; a_namespaces: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item setNamespaces:$a_namespaces];
			 ]"
		end

	objc_namespaces (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item namespaces];
			 ]"
		end

	objc_namespace_for_prefix_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item namespaceForPrefix:$a_name];
			 ]"
		end

	objc_resolve_namespace_for_name_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item resolveNamespaceForName:$a_name];
			 ]"
		end

	objc_resolve_prefix_for_namespace_ur_i_ (an_item: POINTER; a_namespace_uri: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLElement *)$an_item resolvePrefixForNamespaceURI:$a_namespace_uri];
			 ]"
		end

	objc_insert_child__at_index_ (an_item: POINTER; a_child: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item insertChild:$a_child atIndex:$a_index];
			 ]"
		end

	objc_insert_children__at_index_ (an_item: POINTER; a_children: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item insertChildren:$a_children atIndex:$a_index];
			 ]"
		end

	objc_remove_child_at_index_ (an_item: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item removeChildAtIndex:$a_index];
			 ]"
		end

	objc_set_children_ (an_item: POINTER; a_children: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item setChildren:$a_children];
			 ]"
		end

	objc_add_child_ (an_item: POINTER; a_child: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item addChild:$a_child];
			 ]"
		end

	objc_replace_child_at_index__with_node_ (an_item: POINTER; a_index: NATURAL_64; a_node: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item replaceChildAtIndex:$a_index withNode:$a_node];
			 ]"
		end

	objc_normalize_adjacent_text_nodes_preserving_cdat_a_ (an_item: POINTER; a_preserve: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLElement *)$an_item normalizeAdjacentTextNodesPreservingCDATA:$a_preserve];
			 ]"
		end

feature -- NSXMLElement

	elements_for_name_ (a_name: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			result_pointer := objc_elements_for_name_ (item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like elements_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like elements_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	elements_for_local_name__ur_i_ (a_local_name: detachable NS_STRING; a_uri: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_local_name__item: POINTER
			a_uri__item: POINTER
		do
			if attached a_local_name as a_local_name_attached then
				a_local_name__item := a_local_name_attached.item
			end
			if attached a_uri as a_uri_attached then
				a_uri__item := a_uri_attached.item
			end
			result_pointer := objc_elements_for_local_name__ur_i_ (item, a_local_name__item, a_uri__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like elements_for_local_name__ur_i_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like elements_for_local_name__ur_i_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_attribute_ (a_attribute: detachable NS_XML_NODE)
			-- Auto generated Objective-C wrapper.
		local
			a_attribute__item: POINTER
		do
			if attached a_attribute as a_attribute_attached then
				a_attribute__item := a_attribute_attached.item
			end
			objc_add_attribute_ (item, a_attribute__item)
		end

	remove_attribute_for_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_remove_attribute_for_name_ (item, a_name__item)
		end

	set_attributes_ (a_attributes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			objc_set_attributes_ (item, a_attributes__item)
		end

	set_attributes_as_dictionary_ (a_attributes: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			objc_set_attributes_as_dictionary_ (item, a_attributes__item)
		end

	attributes: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attribute_for_name_ (a_name: detachable NS_STRING): detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			result_pointer := objc_attribute_for_name_ (item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attribute_for_local_name__ur_i_ (a_local_name: detachable NS_STRING; a_uri: detachable NS_STRING): detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_local_name__item: POINTER
			a_uri__item: POINTER
		do
			if attached a_local_name as a_local_name_attached then
				a_local_name__item := a_local_name_attached.item
			end
			if attached a_uri as a_uri_attached then
				a_uri__item := a_uri_attached.item
			end
			result_pointer := objc_attribute_for_local_name__ur_i_ (item, a_local_name__item, a_uri__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_for_local_name__ur_i_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_for_local_name__ur_i_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_namespace_ (a_namespace: detachable NS_XML_NODE)
			-- Auto generated Objective-C wrapper.
		local
			a_namespace__item: POINTER
		do
			if attached a_namespace as a_namespace_attached then
				a_namespace__item := a_namespace_attached.item
			end
			objc_add_namespace_ (item, a_namespace__item)
		end

	remove_namespace_for_prefix_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_remove_namespace_for_prefix_ (item, a_name__item)
		end

	set_namespaces_ (a_namespaces: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_namespaces__item: POINTER
		do
			if attached a_namespaces as a_namespaces_attached then
				a_namespaces__item := a_namespaces_attached.item
			end
			objc_set_namespaces_ (item, a_namespaces__item)
		end

	namespaces: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_namespaces (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like namespaces} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like namespaces} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	namespace_for_prefix_ (a_name: detachable NS_STRING): detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			result_pointer := objc_namespace_for_prefix_ (item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like namespace_for_prefix_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like namespace_for_prefix_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	resolve_namespace_for_name_ (a_name: detachable NS_STRING): detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			result_pointer := objc_resolve_namespace_for_name_ (item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like resolve_namespace_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like resolve_namespace_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	resolve_prefix_for_namespace_ur_i_ (a_namespace_uri: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_namespace_uri__item: POINTER
		do
			if attached a_namespace_uri as a_namespace_uri_attached then
				a_namespace_uri__item := a_namespace_uri_attached.item
			end
			result_pointer := objc_resolve_prefix_for_namespace_ur_i_ (item, a_namespace_uri__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like resolve_prefix_for_namespace_ur_i_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like resolve_prefix_for_namespace_ur_i_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	insert_child__at_index_ (a_child: detachable NS_XML_NODE; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_child__item: POINTER
		do
			if attached a_child as a_child_attached then
				a_child__item := a_child_attached.item
			end
			objc_insert_child__at_index_ (item, a_child__item, a_index)
		end

	insert_children__at_index_ (a_children: detachable NS_ARRAY; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_children__item: POINTER
		do
			if attached a_children as a_children_attached then
				a_children__item := a_children_attached.item
			end
			objc_insert_children__at_index_ (item, a_children__item, a_index)
		end

	remove_child_at_index_ (a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_child_at_index_ (item, a_index)
		end

	set_children_ (a_children: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_children__item: POINTER
		do
			if attached a_children as a_children_attached then
				a_children__item := a_children_attached.item
			end
			objc_set_children_ (item, a_children__item)
		end

	add_child_ (a_child: detachable NS_XML_NODE)
			-- Auto generated Objective-C wrapper.
		local
			a_child__item: POINTER
		do
			if attached a_child as a_child_attached then
				a_child__item := a_child_attached.item
			end
			objc_add_child_ (item, a_child__item)
		end

	replace_child_at_index__with_node_ (a_index: NATURAL_64; a_node: detachable NS_XML_NODE)
			-- Auto generated Objective-C wrapper.
		local
			a_node__item: POINTER
		do
			if attached a_node as a_node_attached then
				a_node__item := a_node_attached.item
			end
			objc_replace_child_at_index__with_node_ (item, a_index, a_node__item)
		end

	normalize_adjacent_text_nodes_preserving_cdat_a_ (a_preserve: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_normalize_adjacent_text_nodes_preserving_cdat_a_ (item, a_preserve)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSXMLElement"
		end

end
