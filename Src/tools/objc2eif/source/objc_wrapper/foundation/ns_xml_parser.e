note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_XML_PARSER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_contents_of_ur_l_,
	make_with_data_,
	make

feature {NONE} -- Initialization

	make_with_contents_of_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_data_ (a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_data_(allocate_object, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSXMLParser Externals

	objc_init_with_contents_of_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLParser *)$an_item initWithContentsOfURL:$a_url];
			 ]"
		end

	objc_init_with_data_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLParser *)$an_item initWithData:$a_data];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLParser *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLParser *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_set_should_process_namespaces_ (an_item: POINTER; a_should_process_namespaces: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLParser *)$an_item setShouldProcessNamespaces:$a_should_process_namespaces];
			 ]"
		end

	objc_set_should_report_namespace_prefixes_ (an_item: POINTER; a_should_report_namespace_prefixes: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLParser *)$an_item setShouldReportNamespacePrefixes:$a_should_report_namespace_prefixes];
			 ]"
		end

	objc_set_should_resolve_external_entities_ (an_item: POINTER; a_should_resolve_external_entities: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLParser *)$an_item setShouldResolveExternalEntities:$a_should_resolve_external_entities];
			 ]"
		end

	objc_should_process_namespaces (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLParser *)$an_item shouldProcessNamespaces];
			 ]"
		end

	objc_should_report_namespace_prefixes (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLParser *)$an_item shouldReportNamespacePrefixes];
			 ]"
		end

	objc_should_resolve_external_entities (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLParser *)$an_item shouldResolveExternalEntities];
			 ]"
		end

	objc_parse (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLParser *)$an_item parse];
			 ]"
		end

	objc_abort_parsing (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLParser *)$an_item abortParsing];
			 ]"
		end

	objc_parser_error (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLParser *)$an_item parserError];
			 ]"
		end

feature -- NSXMLParser

	delegate: detachable NS_XML_PARSER_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_delegate_ (a_delegate: detachable NS_XML_PARSER_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	set_should_process_namespaces_ (a_should_process_namespaces: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_should_process_namespaces_ (item, a_should_process_namespaces)
		end

	set_should_report_namespace_prefixes_ (a_should_report_namespace_prefixes: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_should_report_namespace_prefixes_ (item, a_should_report_namespace_prefixes)
		end

	set_should_resolve_external_entities_ (a_should_resolve_external_entities: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_should_resolve_external_entities_ (item, a_should_resolve_external_entities)
		end

	should_process_namespaces: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_process_namespaces (item)
		end

	should_report_namespace_prefixes: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_report_namespace_prefixes (item)
		end

	should_resolve_external_entities: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_resolve_external_entities (item)
		end

	parse: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_parse (item)
		end

	abort_parsing
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_abort_parsing (item)
		end

	parser_error: detachable NS_ERROR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_parser_error (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parser_error} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parser_error} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- NSXMLParserLocatorAdditions

	public_id: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_public_id (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like public_id} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like public_id} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	system_id: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_system_id (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like system_id} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like system_id} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	line_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_number (item)
		end

	column_number: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_column_number (item)
		end

feature {NONE} -- NSXMLParserLocatorAdditions Externals

	objc_public_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLParser *)$an_item publicID];
			 ]"
		end

	objc_system_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLParser *)$an_item systemID];
			 ]"
		end

	objc_line_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLParser *)$an_item lineNumber];
			 ]"
		end

	objc_column_number (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLParser *)$an_item columnNumber];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSXMLParser"
		end

end
