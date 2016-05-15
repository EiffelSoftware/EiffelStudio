note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_XML_NODE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSXMLNode

	document: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_document (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like document} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like document} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	document_with_root_element_ (a_element: detachable NS_XML_ELEMENT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_element__item: POINTER
		do
			if attached a_element as a_element_attached then
				a_element__item := a_element_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_document_with_root_element_ (l_objc_class.item, a_element__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like document_with_root_element_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like document_with_root_element_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	element_with_name_ (a_name: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_element_with_name_ (l_objc_class.item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like element_with_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like element_with_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	element_with_name__ur_i_ (a_name: detachable NS_STRING; a_uri: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_uri__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_uri as a_uri_attached then
				a_uri__item := a_uri_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_element_with_name__ur_i_ (l_objc_class.item, a_name__item, a_uri__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like element_with_name__ur_i_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like element_with_name__ur_i_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	element_with_name__string_value_ (a_name: detachable NS_STRING; a_string: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_string__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_element_with_name__string_value_ (l_objc_class.item, a_name__item, a_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like element_with_name__string_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like element_with_name__string_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	element_with_name__children__attributes_ (a_name: detachable NS_STRING; a_children: detachable NS_ARRAY; a_attributes: detachable NS_ARRAY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_children__item: POINTER
			a_attributes__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_children as a_children_attached then
				a_children__item := a_children_attached.item
			end
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_element_with_name__children__attributes_ (l_objc_class.item, a_name__item, a_children__item, a_attributes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like element_with_name__children__attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like element_with_name__children__attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attribute_with_name__string_value_ (a_name: detachable NS_STRING; a_string_value: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_string_value__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_string_value as a_string_value_attached then
				a_string_value__item := a_string_value_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_attribute_with_name__string_value_ (l_objc_class.item, a_name__item, a_string_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_with_name__string_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_with_name__string_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attribute_with_name__ur_i__string_value_ (a_name: detachable NS_STRING; a_uri: detachable NS_STRING; a_string_value: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_uri__item: POINTER
			a_string_value__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_uri as a_uri_attached then
				a_uri__item := a_uri_attached.item
			end
			if attached a_string_value as a_string_value_attached then
				a_string_value__item := a_string_value_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_attribute_with_name__ur_i__string_value_ (l_objc_class.item, a_name__item, a_uri__item, a_string_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_with_name__ur_i__string_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_with_name__ur_i__string_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	namespace_with_name__string_value_ (a_name: detachable NS_STRING; a_string_value: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_string_value__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_string_value as a_string_value_attached then
				a_string_value__item := a_string_value_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_namespace_with_name__string_value_ (l_objc_class.item, a_name__item, a_string_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like namespace_with_name__string_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like namespace_with_name__string_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	processing_instruction_with_name__string_value_ (a_name: detachable NS_STRING; a_string_value: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_string_value__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_string_value as a_string_value_attached then
				a_string_value__item := a_string_value_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_processing_instruction_with_name__string_value_ (l_objc_class.item, a_name__item, a_string_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like processing_instruction_with_name__string_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like processing_instruction_with_name__string_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	comment_with_string_value_ (a_string_value: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_string_value__item: POINTER
		do
			if attached a_string_value as a_string_value_attached then
				a_string_value__item := a_string_value_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_comment_with_string_value_ (l_objc_class.item, a_string_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like comment_with_string_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like comment_with_string_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_with_string_value_ (a_string_value: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_string_value__item: POINTER
		do
			if attached a_string_value as a_string_value_attached then
				a_string_value__item := a_string_value_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_text_with_string_value_ (l_objc_class.item, a_string_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_with_string_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_with_string_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dtd_node_with_xml_string_ (a_string: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_dtd_node_with_xml_string_ (l_objc_class.item, a_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dtd_node_with_xml_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dtd_node_with_xml_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	local_name_for_name_ (a_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_local_name_for_name_ (l_objc_class.item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like local_name_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like local_name_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	prefix_for_name_ (a_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_prefix_for_name_ (l_objc_class.item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like prefix_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like prefix_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	predefined_namespace_for_prefix_ (a_name: detachable NS_STRING): detachable NS_XML_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_predefined_namespace_for_prefix_ (l_objc_class.item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predefined_namespace_for_prefix_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predefined_namespace_for_prefix_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSXMLNode Externals

	objc_document (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object document];
			 ]"
		end

	objc_document_with_root_element_ (a_class_object: POINTER; a_element: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object documentWithRootElement:$a_element];
			 ]"
		end

	objc_element_with_name_ (a_class_object: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object elementWithName:$a_name];
			 ]"
		end

	objc_element_with_name__ur_i_ (a_class_object: POINTER; a_name: POINTER; a_uri: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object elementWithName:$a_name URI:$a_uri];
			 ]"
		end

	objc_element_with_name__string_value_ (a_class_object: POINTER; a_name: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object elementWithName:$a_name stringValue:$a_string];
			 ]"
		end

	objc_element_with_name__children__attributes_ (a_class_object: POINTER; a_name: POINTER; a_children: POINTER; a_attributes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object elementWithName:$a_name children:$a_children attributes:$a_attributes];
			 ]"
		end

	objc_attribute_with_name__string_value_ (a_class_object: POINTER; a_name: POINTER; a_string_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object attributeWithName:$a_name stringValue:$a_string_value];
			 ]"
		end

	objc_attribute_with_name__ur_i__string_value_ (a_class_object: POINTER; a_name: POINTER; a_uri: POINTER; a_string_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object attributeWithName:$a_name URI:$a_uri stringValue:$a_string_value];
			 ]"
		end

	objc_namespace_with_name__string_value_ (a_class_object: POINTER; a_name: POINTER; a_string_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object namespaceWithName:$a_name stringValue:$a_string_value];
			 ]"
		end

	objc_processing_instruction_with_name__string_value_ (a_class_object: POINTER; a_name: POINTER; a_string_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object processingInstructionWithName:$a_name stringValue:$a_string_value];
			 ]"
		end

	objc_comment_with_string_value_ (a_class_object: POINTER; a_string_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object commentWithStringValue:$a_string_value];
			 ]"
		end

	objc_text_with_string_value_ (a_class_object: POINTER; a_string_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object textWithStringValue:$a_string_value];
			 ]"
		end

	objc_dtd_node_with_xml_string_ (a_class_object: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object DTDNodeWithXMLString:$a_string];
			 ]"
		end

	objc_local_name_for_name_ (a_class_object: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object localNameForName:$a_name];
			 ]"
		end

	objc_prefix_for_name_ (a_class_object: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object prefixForName:$a_name];
			 ]"
		end

	objc_predefined_namespace_for_prefix_ (a_class_object: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object predefinedNamespaceForPrefix:$a_name];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSXMLNode"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
