note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_XML_DOCUMENT

inherit
	NS_XML_NODE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_root_element_,
	make_with_kind_,
	make_with_kind__options_,
	make

feature {NONE} -- Initialization

--	make_with_xml_string__options__error_ (a_string: detachable NS_STRING; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE)
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
--			make_with_pointer (objc_init_with_xml_string__options__error_(allocate_object, a_string__item, a_mask, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_contents_of_ur_l__options__error_ (a_url: detachable NS_URL; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_with_contents_of_ur_l__options__error_(allocate_object, a_url__item, a_mask, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_data__options__error_ (a_data: detachable NS_DATA; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_data__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_with_data__options__error_(allocate_object, a_data__item, a_mask, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_root_element_ (a_element: detachable NS_XML_ELEMENT)
			-- Initialize `Current'.
		local
			a_element__item: POINTER
		do
			if attached a_element as a_element_attached then
				a_element__item := a_element_attached.item
			end
			make_with_pointer (objc_init_with_root_element_(allocate_object, a_element__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSXMLDocument Externals

--	objc_init_with_xml_string__options__error_ (an_item: POINTER; a_string: POINTER; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLDocument *)$an_item initWithXMLString:$a_string options:$a_mask error:];
--			 ]"
--		end

--	objc_init_with_contents_of_ur_l__options__error_ (an_item: POINTER; a_url: POINTER; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLDocument *)$an_item initWithContentsOfURL:$a_url options:$a_mask error:];
--			 ]"
--		end

--	objc_init_with_data__options__error_ (an_item: POINTER; a_data: POINTER; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLDocument *)$an_item initWithData:$a_data options:$a_mask error:];
--			 ]"
--		end

	objc_init_with_root_element_ (an_item: POINTER; a_element: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDocument *)$an_item initWithRootElement:$a_element];
			 ]"
		end

	objc_set_character_encoding_ (an_item: POINTER; a_encoding: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item setCharacterEncoding:$a_encoding];
			 ]"
		end

	objc_character_encoding (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDocument *)$an_item characterEncoding];
			 ]"
		end

	objc_set_version_ (an_item: POINTER; a_version: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item setVersion:$a_version];
			 ]"
		end

	objc_version (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDocument *)$an_item version];
			 ]"
		end

	objc_set_standalone_ (an_item: POINTER; a_standalone: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item setStandalone:$a_standalone];
			 ]"
		end

	objc_is_standalone (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLDocument *)$an_item isStandalone];
			 ]"
		end

	objc_set_document_content_kind_ (an_item: POINTER; a_kind: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item setDocumentContentKind:$a_kind];
			 ]"
		end

	objc_document_content_kind (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLDocument *)$an_item documentContentKind];
			 ]"
		end

	objc_set_mime_type_ (an_item: POINTER; a_mime_type: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item setMIMEType:$a_mime_type];
			 ]"
		end

	objc_mime_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDocument *)$an_item MIMEType];
			 ]"
		end

	objc_set_dt_d_ (an_item: POINTER; a_document_type_declaration: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item setDTD:$a_document_type_declaration];
			 ]"
		end

	objc_dtd (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDocument *)$an_item DTD];
			 ]"
		end

	objc_set_root_element_ (an_item: POINTER; a_root: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item setRootElement:$a_root];
			 ]"
		end

	objc_root_element (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDocument *)$an_item rootElement];
			 ]"
		end

	objc_insert_child__at_index_ (an_item: POINTER; a_child: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item insertChild:$a_child atIndex:$a_index];
			 ]"
		end

	objc_insert_children__at_index_ (an_item: POINTER; a_children: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item insertChildren:$a_children atIndex:$a_index];
			 ]"
		end

	objc_remove_child_at_index_ (an_item: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item removeChildAtIndex:$a_index];
			 ]"
		end

	objc_set_children_ (an_item: POINTER; a_children: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item setChildren:$a_children];
			 ]"
		end

	objc_add_child_ (an_item: POINTER; a_child: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item addChild:$a_child];
			 ]"
		end

	objc_replace_child_at_index__with_node_ (an_item: POINTER; a_index: NATURAL_64; a_node: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDocument *)$an_item replaceChildAtIndex:$a_index withNode:$a_node];
			 ]"
		end

	objc_xml_data (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDocument *)$an_item XMLData];
			 ]"
		end

	objc_xml_data_with_options_ (an_item: POINTER; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDocument *)$an_item XMLDataWithOptions:$a_options];
			 ]"
		end

--	objc_object_by_applying_xsl_t__arguments__error_ (an_item: POINTER; a_xslt: POINTER; a_arguments: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLDocument *)$an_item objectByApplyingXSLT:$a_xslt arguments:$a_arguments error:];
--			 ]"
--		end

--	objc_object_by_applying_xslt_string__arguments__error_ (an_item: POINTER; a_xslt: POINTER; a_arguments: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLDocument *)$an_item objectByApplyingXSLTString:$a_xslt arguments:$a_arguments error:];
--			 ]"
--		end

--	objc_object_by_applying_xslt_at_ur_l__arguments__error_ (an_item: POINTER; a_xslt_url: POINTER; a_argument: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLDocument *)$an_item objectByApplyingXSLTAtURL:$a_xslt_url arguments:$a_argument error:];
--			 ]"
--		end

--	objc_validate_and_return_error_ (an_item: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSXMLDocument *)$an_item validateAndReturnError:];
--			 ]"
--		end

feature -- NSXMLDocument

	set_character_encoding_ (a_encoding: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_encoding__item: POINTER
		do
			if attached a_encoding as a_encoding_attached then
				a_encoding__item := a_encoding_attached.item
			end
			objc_set_character_encoding_ (item, a_encoding__item)
		end

	character_encoding: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_character_encoding (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like character_encoding} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like character_encoding} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_version_ (a_version: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_version__item: POINTER
		do
			if attached a_version as a_version_attached then
				a_version__item := a_version_attached.item
			end
			objc_set_version_ (item, a_version__item)
		end

	version: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_version (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like version} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like version} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_standalone_ (a_standalone: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_standalone_ (item, a_standalone)
		end

	is_standalone: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_standalone (item)
		end

	set_document_content_kind_ (a_kind: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_document_content_kind_ (item, a_kind)
		end

	document_content_kind: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_document_content_kind (item)
		end

	set_mime_type_ (a_mime_type: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_mime_type__item: POINTER
		do
			if attached a_mime_type as a_mime_type_attached then
				a_mime_type__item := a_mime_type_attached.item
			end
			objc_set_mime_type_ (item, a_mime_type__item)
		end

	mime_type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mime_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mime_type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mime_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_dt_d_ (a_document_type_declaration: detachable NS_XMLDTD)
			-- Auto generated Objective-C wrapper.
		local
			a_document_type_declaration__item: POINTER
		do
			if attached a_document_type_declaration as a_document_type_declaration_attached then
				a_document_type_declaration__item := a_document_type_declaration_attached.item
			end
			objc_set_dt_d_ (item, a_document_type_declaration__item)
		end

	dtd: detachable NS_XMLDTD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dtd (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dtd} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dtd} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_root_element_ (a_root: detachable NS_XML_NODE)
			-- Auto generated Objective-C wrapper.
		local
			a_root__item: POINTER
		do
			if attached a_root as a_root_attached then
				a_root__item := a_root_attached.item
			end
			objc_set_root_element_ (item, a_root__item)
		end

	root_element: detachable NS_XML_ELEMENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_root_element (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like root_element} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like root_element} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	xml_data: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_xml_data (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like xml_data} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like xml_data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	xml_data_with_options_ (a_options: NATURAL_64): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_xml_data_with_options_ (item, a_options)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like xml_data_with_options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like xml_data_with_options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	object_by_applying_xsl_t__arguments__error_ (a_xslt: detachable NS_DATA; a_arguments: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_xslt__item: POINTER
--			a_arguments__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_xslt as a_xslt_attached then
--				a_xslt__item := a_xslt_attached.item
--			end
--			if attached a_arguments as a_arguments_attached then
--				a_arguments__item := a_arguments_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_object_by_applying_xsl_t__arguments__error_ (item, a_xslt__item, a_arguments__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like object_by_applying_xsl_t__arguments__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like object_by_applying_xsl_t__arguments__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	object_by_applying_xslt_string__arguments__error_ (a_xslt: detachable NS_STRING; a_arguments: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_xslt__item: POINTER
--			a_arguments__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_xslt as a_xslt_attached then
--				a_xslt__item := a_xslt_attached.item
--			end
--			if attached a_arguments as a_arguments_attached then
--				a_arguments__item := a_arguments_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_object_by_applying_xslt_string__arguments__error_ (item, a_xslt__item, a_arguments__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like object_by_applying_xslt_string__arguments__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like object_by_applying_xslt_string__arguments__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	object_by_applying_xslt_at_ur_l__arguments__error_ (a_xslt_url: detachable NS_URL; a_argument: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_xslt_url__item: POINTER
--			a_argument__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_xslt_url as a_xslt_url_attached then
--				a_xslt_url__item := a_xslt_url_attached.item
--			end
--			if attached a_argument as a_argument_attached then
--				a_argument__item := a_argument_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_object_by_applying_xslt_at_ur_l__arguments__error_ (item, a_xslt_url__item, a_argument__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like object_by_applying_xslt_at_ur_l__arguments__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like object_by_applying_xslt_at_ur_l__arguments__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	validate_and_return_error_ (a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_validate_and_return_error_ (item, a_error__item)
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSXMLDocument"
		end

end
