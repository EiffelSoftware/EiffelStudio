note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_XML_PARSER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	parser_did_start_document_ (a_parser: detachable NS_XML_PARSER)
			-- Auto generated Objective-C wrapper.
		require
			has_parser_did_start_document_: has_parser_did_start_document_
		local
			a_parser__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			objc_parser_did_start_document_ (item, a_parser__item)
		end

	parser_did_end_document_ (a_parser: detachable NS_XML_PARSER)
			-- Auto generated Objective-C wrapper.
		require
			has_parser_did_end_document_: has_parser_did_end_document_
		local
			a_parser__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			objc_parser_did_end_document_ (item, a_parser__item)
		end

	parser__found_notation_declaration_with_name__public_i_d__system_i_d_ (a_parser: detachable NS_XML_PARSER; a_name: detachable NS_STRING; a_public_id: detachable NS_STRING; a_system_id: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_notation_declaration_with_name__public_i_d__system_i_d_: has_parser__found_notation_declaration_with_name__public_i_d__system_i_d_
		local
			a_parser__item: POINTER
			a_name__item: POINTER
			a_public_id__item: POINTER
			a_system_id__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_public_id as a_public_id_attached then
				a_public_id__item := a_public_id_attached.item
			end
			if attached a_system_id as a_system_id_attached then
				a_system_id__item := a_system_id_attached.item
			end
			objc_parser__found_notation_declaration_with_name__public_i_d__system_i_d_ (item, a_parser__item, a_name__item, a_public_id__item, a_system_id__item)
		end

	parser__found_unparsed_entity_declaration_with_name__public_i_d__system_i_d__notation_name_ (a_parser: detachable NS_XML_PARSER; a_name: detachable NS_STRING; a_public_id: detachable NS_STRING; a_system_id: detachable NS_STRING; a_notation_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_unparsed_entity_declaration_with_name__public_i_d__system_i_d__notation_name_: has_parser__found_unparsed_entity_declaration_with_name__public_i_d__system_i_d__notation_name_
		local
			a_parser__item: POINTER
			a_name__item: POINTER
			a_public_id__item: POINTER
			a_system_id__item: POINTER
			a_notation_name__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_public_id as a_public_id_attached then
				a_public_id__item := a_public_id_attached.item
			end
			if attached a_system_id as a_system_id_attached then
				a_system_id__item := a_system_id_attached.item
			end
			if attached a_notation_name as a_notation_name_attached then
				a_notation_name__item := a_notation_name_attached.item
			end
			objc_parser__found_unparsed_entity_declaration_with_name__public_i_d__system_i_d__notation_name_ (item, a_parser__item, a_name__item, a_public_id__item, a_system_id__item, a_notation_name__item)
		end

	parser__found_attribute_declaration_with_name__for_element__type__default_value_ (a_parser: detachable NS_XML_PARSER; a_attribute_name: detachable NS_STRING; a_element_name: detachable NS_STRING; a_type: detachable NS_STRING; a_default_value: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_attribute_declaration_with_name__for_element__type__default_value_: has_parser__found_attribute_declaration_with_name__for_element__type__default_value_
		local
			a_parser__item: POINTER
			a_attribute_name__item: POINTER
			a_element_name__item: POINTER
			a_type__item: POINTER
			a_default_value__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_attribute_name as a_attribute_name_attached then
				a_attribute_name__item := a_attribute_name_attached.item
			end
			if attached a_element_name as a_element_name_attached then
				a_element_name__item := a_element_name_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			if attached a_default_value as a_default_value_attached then
				a_default_value__item := a_default_value_attached.item
			end
			objc_parser__found_attribute_declaration_with_name__for_element__type__default_value_ (item, a_parser__item, a_attribute_name__item, a_element_name__item, a_type__item, a_default_value__item)
		end

	parser__found_element_declaration_with_name__model_ (a_parser: detachable NS_XML_PARSER; a_element_name: detachable NS_STRING; a_model: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_element_declaration_with_name__model_: has_parser__found_element_declaration_with_name__model_
		local
			a_parser__item: POINTER
			a_element_name__item: POINTER
			a_model__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_element_name as a_element_name_attached then
				a_element_name__item := a_element_name_attached.item
			end
			if attached a_model as a_model_attached then
				a_model__item := a_model_attached.item
			end
			objc_parser__found_element_declaration_with_name__model_ (item, a_parser__item, a_element_name__item, a_model__item)
		end

	parser__found_internal_entity_declaration_with_name__value_ (a_parser: detachable NS_XML_PARSER; a_name: detachable NS_STRING; a_value: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_internal_entity_declaration_with_name__value_: has_parser__found_internal_entity_declaration_with_name__value_
		local
			a_parser__item: POINTER
			a_name__item: POINTER
			a_value__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_parser__found_internal_entity_declaration_with_name__value_ (item, a_parser__item, a_name__item, a_value__item)
		end

	parser__found_external_entity_declaration_with_name__public_i_d__system_i_d_ (a_parser: detachable NS_XML_PARSER; a_name: detachable NS_STRING; a_public_id: detachable NS_STRING; a_system_id: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_external_entity_declaration_with_name__public_i_d__system_i_d_: has_parser__found_external_entity_declaration_with_name__public_i_d__system_i_d_
		local
			a_parser__item: POINTER
			a_name__item: POINTER
			a_public_id__item: POINTER
			a_system_id__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_public_id as a_public_id_attached then
				a_public_id__item := a_public_id_attached.item
			end
			if attached a_system_id as a_system_id_attached then
				a_system_id__item := a_system_id_attached.item
			end
			objc_parser__found_external_entity_declaration_with_name__public_i_d__system_i_d_ (item, a_parser__item, a_name__item, a_public_id__item, a_system_id__item)
		end

	parser__did_start_element__namespace_ur_i__qualified_name__attributes_ (a_parser: detachable NS_XML_PARSER; a_element_name: detachable NS_STRING; a_namespace_uri: detachable NS_STRING; a_q_name: detachable NS_STRING; a_attribute_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__did_start_element__namespace_ur_i__qualified_name__attributes_: has_parser__did_start_element__namespace_ur_i__qualified_name__attributes_
		local
			a_parser__item: POINTER
			a_element_name__item: POINTER
			a_namespace_uri__item: POINTER
			a_q_name__item: POINTER
			a_attribute_dict__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_element_name as a_element_name_attached then
				a_element_name__item := a_element_name_attached.item
			end
			if attached a_namespace_uri as a_namespace_uri_attached then
				a_namespace_uri__item := a_namespace_uri_attached.item
			end
			if attached a_q_name as a_q_name_attached then
				a_q_name__item := a_q_name_attached.item
			end
			if attached a_attribute_dict as a_attribute_dict_attached then
				a_attribute_dict__item := a_attribute_dict_attached.item
			end
			objc_parser__did_start_element__namespace_ur_i__qualified_name__attributes_ (item, a_parser__item, a_element_name__item, a_namespace_uri__item, a_q_name__item, a_attribute_dict__item)
		end

	parser__did_end_element__namespace_ur_i__qualified_name_ (a_parser: detachable NS_XML_PARSER; a_element_name: detachable NS_STRING; a_namespace_uri: detachable NS_STRING; a_q_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__did_end_element__namespace_ur_i__qualified_name_: has_parser__did_end_element__namespace_ur_i__qualified_name_
		local
			a_parser__item: POINTER
			a_element_name__item: POINTER
			a_namespace_uri__item: POINTER
			a_q_name__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_element_name as a_element_name_attached then
				a_element_name__item := a_element_name_attached.item
			end
			if attached a_namespace_uri as a_namespace_uri_attached then
				a_namespace_uri__item := a_namespace_uri_attached.item
			end
			if attached a_q_name as a_q_name_attached then
				a_q_name__item := a_q_name_attached.item
			end
			objc_parser__did_end_element__namespace_ur_i__qualified_name_ (item, a_parser__item, a_element_name__item, a_namespace_uri__item, a_q_name__item)
		end

	parser__did_start_mapping_prefix__to_ur_i_ (a_parser: detachable NS_XML_PARSER; a_prefix: detachable NS_STRING; a_namespace_uri: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__did_start_mapping_prefix__to_ur_i_: has_parser__did_start_mapping_prefix__to_ur_i_
		local
			a_parser__item: POINTER
			a_prefix__item: POINTER
			a_namespace_uri__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_prefix as a_prefix_attached then
				a_prefix__item := a_prefix_attached.item
			end
			if attached a_namespace_uri as a_namespace_uri_attached then
				a_namespace_uri__item := a_namespace_uri_attached.item
			end
			objc_parser__did_start_mapping_prefix__to_ur_i_ (item, a_parser__item, a_prefix__item, a_namespace_uri__item)
		end

	parser__did_end_mapping_prefix_ (a_parser: detachable NS_XML_PARSER; a_prefix: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__did_end_mapping_prefix_: has_parser__did_end_mapping_prefix_
		local
			a_parser__item: POINTER
			a_prefix__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_prefix as a_prefix_attached then
				a_prefix__item := a_prefix_attached.item
			end
			objc_parser__did_end_mapping_prefix_ (item, a_parser__item, a_prefix__item)
		end

	parser__found_characters_ (a_parser: detachable NS_XML_PARSER; a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_characters_: has_parser__found_characters_
		local
			a_parser__item: POINTER
			a_string__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_parser__found_characters_ (item, a_parser__item, a_string__item)
		end

	parser__found_ignorable_whitespace_ (a_parser: detachable NS_XML_PARSER; a_whitespace_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_ignorable_whitespace_: has_parser__found_ignorable_whitespace_
		local
			a_parser__item: POINTER
			a_whitespace_string__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_whitespace_string as a_whitespace_string_attached then
				a_whitespace_string__item := a_whitespace_string_attached.item
			end
			objc_parser__found_ignorable_whitespace_ (item, a_parser__item, a_whitespace_string__item)
		end

	parser__found_processing_instruction_with_target__data_ (a_parser: detachable NS_XML_PARSER; a_target: detachable NS_STRING; a_data: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_processing_instruction_with_target__data_: has_parser__found_processing_instruction_with_target__data_
		local
			a_parser__item: POINTER
			a_target__item: POINTER
			a_data__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			objc_parser__found_processing_instruction_with_target__data_ (item, a_parser__item, a_target__item, a_data__item)
		end

	parser__found_comment_ (a_parser: detachable NS_XML_PARSER; a_comment: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_comment_: has_parser__found_comment_
		local
			a_parser__item: POINTER
			a_comment__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_comment as a_comment_attached then
				a_comment__item := a_comment_attached.item
			end
			objc_parser__found_comment_ (item, a_parser__item, a_comment__item)
		end

	parser__found_cdat_a_ (a_parser: detachable NS_XML_PARSER; a_cdata_block: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__found_cdat_a_: has_parser__found_cdat_a_
		local
			a_parser__item: POINTER
			a_cdata_block__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_cdata_block as a_cdata_block_attached then
				a_cdata_block__item := a_cdata_block_attached.item
			end
			objc_parser__found_cdat_a_ (item, a_parser__item, a_cdata_block__item)
		end

	parser__resolve_external_entity_name__system_i_d_ (a_parser: detachable NS_XML_PARSER; a_name: detachable NS_STRING; a_system_id: detachable NS_STRING): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		require
			has_parser__resolve_external_entity_name__system_i_d_: has_parser__resolve_external_entity_name__system_i_d_
		local
			result_pointer: POINTER
			a_parser__item: POINTER
			a_name__item: POINTER
			a_system_id__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_system_id as a_system_id_attached then
				a_system_id__item := a_system_id_attached.item
			end
			result_pointer := objc_parser__resolve_external_entity_name__system_i_d_ (item, a_parser__item, a_name__item, a_system_id__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parser__resolve_external_entity_name__system_i_d_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parser__resolve_external_entity_name__system_i_d_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	parser__parse_error_occurred_ (a_parser: detachable NS_XML_PARSER; a_parse_error: detachable NS_ERROR)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__parse_error_occurred_: has_parser__parse_error_occurred_
		local
			a_parser__item: POINTER
			a_parse_error__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_parse_error as a_parse_error_attached then
				a_parse_error__item := a_parse_error_attached.item
			end
			objc_parser__parse_error_occurred_ (item, a_parser__item, a_parse_error__item)
		end

	parser__validation_error_occurred_ (a_parser: detachable NS_XML_PARSER; a_validation_error: detachable NS_ERROR)
			-- Auto generated Objective-C wrapper.
		require
			has_parser__validation_error_occurred_: has_parser__validation_error_occurred_
		local
			a_parser__item: POINTER
			a_validation_error__item: POINTER
		do
			if attached a_parser as a_parser_attached then
				a_parser__item := a_parser_attached.item
			end
			if attached a_validation_error as a_validation_error_attached then
				a_validation_error__item := a_validation_error_attached.item
			end
			objc_parser__validation_error_occurred_ (item, a_parser__item, a_validation_error__item)
		end

feature -- Status Report

	has_parser_did_start_document_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser_did_start_document_ (item)
		end

	has_parser_did_end_document_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser_did_end_document_ (item)
		end

	has_parser__found_notation_declaration_with_name__public_i_d__system_i_d_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_notation_declaration_with_name__public_i_d__system_i_d_ (item)
		end

	has_parser__found_unparsed_entity_declaration_with_name__public_i_d__system_i_d__notation_name_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_unparsed_entity_declaration_with_name__public_i_d__system_i_d__notation_name_ (item)
		end

	has_parser__found_attribute_declaration_with_name__for_element__type__default_value_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_attribute_declaration_with_name__for_element__type__default_value_ (item)
		end

	has_parser__found_element_declaration_with_name__model_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_element_declaration_with_name__model_ (item)
		end

	has_parser__found_internal_entity_declaration_with_name__value_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_internal_entity_declaration_with_name__value_ (item)
		end

	has_parser__found_external_entity_declaration_with_name__public_i_d__system_i_d_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_external_entity_declaration_with_name__public_i_d__system_i_d_ (item)
		end

	has_parser__did_start_element__namespace_ur_i__qualified_name__attributes_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__did_start_element__namespace_ur_i__qualified_name__attributes_ (item)
		end

	has_parser__did_end_element__namespace_ur_i__qualified_name_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__did_end_element__namespace_ur_i__qualified_name_ (item)
		end

	has_parser__did_start_mapping_prefix__to_ur_i_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__did_start_mapping_prefix__to_ur_i_ (item)
		end

	has_parser__did_end_mapping_prefix_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__did_end_mapping_prefix_ (item)
		end

	has_parser__found_characters_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_characters_ (item)
		end

	has_parser__found_ignorable_whitespace_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_ignorable_whitespace_ (item)
		end

	has_parser__found_processing_instruction_with_target__data_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_processing_instruction_with_target__data_ (item)
		end

	has_parser__found_comment_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_comment_ (item)
		end

	has_parser__found_cdat_a_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__found_cdat_a_ (item)
		end

	has_parser__resolve_external_entity_name__system_i_d_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__resolve_external_entity_name__system_i_d_ (item)
		end

	has_parser__parse_error_occurred_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__parse_error_occurred_ (item)
		end

	has_parser__validation_error_occurred_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_parser__validation_error_occurred_ (item)
		end

feature -- Status Report Externals

	objc_has_parser_did_start_document_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parserDidStartDocument:)];
			 ]"
		end

	objc_has_parser_did_end_document_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parserDidEndDocument:)];
			 ]"
		end

	objc_has_parser__found_notation_declaration_with_name__public_i_d__system_i_d_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundNotationDeclarationWithName:publicID:systemID:)];
			 ]"
		end

	objc_has_parser__found_unparsed_entity_declaration_with_name__public_i_d__system_i_d__notation_name_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundUnparsedEntityDeclarationWithName:publicID:systemID:notationName:)];
			 ]"
		end

	objc_has_parser__found_attribute_declaration_with_name__for_element__type__default_value_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundAttributeDeclarationWithName:forElement:type:defaultValue:)];
			 ]"
		end

	objc_has_parser__found_element_declaration_with_name__model_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundElementDeclarationWithName:model:)];
			 ]"
		end

	objc_has_parser__found_internal_entity_declaration_with_name__value_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundInternalEntityDeclarationWithName:value:)];
			 ]"
		end

	objc_has_parser__found_external_entity_declaration_with_name__public_i_d__system_i_d_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundExternalEntityDeclarationWithName:publicID:systemID:)];
			 ]"
		end

	objc_has_parser__did_start_element__namespace_ur_i__qualified_name__attributes_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:didStartElement:namespaceURI:qualifiedName:attributes:)];
			 ]"
		end

	objc_has_parser__did_end_element__namespace_ur_i__qualified_name_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:didEndElement:namespaceURI:qualifiedName:)];
			 ]"
		end

	objc_has_parser__did_start_mapping_prefix__to_ur_i_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:didStartMappingPrefix:toURI:)];
			 ]"
		end

	objc_has_parser__did_end_mapping_prefix_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:didEndMappingPrefix:)];
			 ]"
		end

	objc_has_parser__found_characters_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundCharacters:)];
			 ]"
		end

	objc_has_parser__found_ignorable_whitespace_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundIgnorableWhitespace:)];
			 ]"
		end

	objc_has_parser__found_processing_instruction_with_target__data_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundProcessingInstructionWithTarget:data:)];
			 ]"
		end

	objc_has_parser__found_comment_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundComment:)];
			 ]"
		end

	objc_has_parser__found_cdat_a_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:foundCDATA:)];
			 ]"
		end

	objc_has_parser__resolve_external_entity_name__system_i_d_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:resolveExternalEntityName:systemID:)];
			 ]"
		end

	objc_has_parser__parse_error_occurred_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:parseErrorOccurred:)];
			 ]"
		end

	objc_has_parser__validation_error_occurred_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(parser:validationErrorOccurred:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_parser_did_start_document_ (an_item: POINTER; a_parser: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parserDidStartDocument:$a_parser];
			 ]"
		end

	objc_parser_did_end_document_ (an_item: POINTER; a_parser: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parserDidEndDocument:$a_parser];
			 ]"
		end

	objc_parser__found_notation_declaration_with_name__public_i_d__system_i_d_ (an_item: POINTER; a_parser: POINTER; a_name: POINTER; a_public_id: POINTER; a_system_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundNotationDeclarationWithName:$a_name publicID:$a_public_id systemID:$a_system_id];
			 ]"
		end

	objc_parser__found_unparsed_entity_declaration_with_name__public_i_d__system_i_d__notation_name_ (an_item: POINTER; a_parser: POINTER; a_name: POINTER; a_public_id: POINTER; a_system_id: POINTER; a_notation_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundUnparsedEntityDeclarationWithName:$a_name publicID:$a_public_id systemID:$a_system_id notationName:$a_notation_name];
			 ]"
		end

	objc_parser__found_attribute_declaration_with_name__for_element__type__default_value_ (an_item: POINTER; a_parser: POINTER; a_attribute_name: POINTER; a_element_name: POINTER; a_type: POINTER; a_default_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundAttributeDeclarationWithName:$a_attribute_name forElement:$a_element_name type:$a_type defaultValue:$a_default_value];
			 ]"
		end

	objc_parser__found_element_declaration_with_name__model_ (an_item: POINTER; a_parser: POINTER; a_element_name: POINTER; a_model: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundElementDeclarationWithName:$a_element_name model:$a_model];
			 ]"
		end

	objc_parser__found_internal_entity_declaration_with_name__value_ (an_item: POINTER; a_parser: POINTER; a_name: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundInternalEntityDeclarationWithName:$a_name value:$a_value];
			 ]"
		end

	objc_parser__found_external_entity_declaration_with_name__public_i_d__system_i_d_ (an_item: POINTER; a_parser: POINTER; a_name: POINTER; a_public_id: POINTER; a_system_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundExternalEntityDeclarationWithName:$a_name publicID:$a_public_id systemID:$a_system_id];
			 ]"
		end

	objc_parser__did_start_element__namespace_ur_i__qualified_name__attributes_ (an_item: POINTER; a_parser: POINTER; a_element_name: POINTER; a_namespace_uri: POINTER; a_q_name: POINTER; a_attribute_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser didStartElement:$a_element_name namespaceURI:$a_namespace_uri qualifiedName:$a_q_name attributes:$a_attribute_dict];
			 ]"
		end

	objc_parser__did_end_element__namespace_ur_i__qualified_name_ (an_item: POINTER; a_parser: POINTER; a_element_name: POINTER; a_namespace_uri: POINTER; a_q_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser didEndElement:$a_element_name namespaceURI:$a_namespace_uri qualifiedName:$a_q_name];
			 ]"
		end

	objc_parser__did_start_mapping_prefix__to_ur_i_ (an_item: POINTER; a_parser: POINTER; a_prefix: POINTER; a_namespace_uri: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser didStartMappingPrefix:$a_prefix toURI:$a_namespace_uri];
			 ]"
		end

	objc_parser__did_end_mapping_prefix_ (an_item: POINTER; a_parser: POINTER; a_prefix: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser didEndMappingPrefix:$a_prefix];
			 ]"
		end

	objc_parser__found_characters_ (an_item: POINTER; a_parser: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundCharacters:$a_string];
			 ]"
		end

	objc_parser__found_ignorable_whitespace_ (an_item: POINTER; a_parser: POINTER; a_whitespace_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundIgnorableWhitespace:$a_whitespace_string];
			 ]"
		end

	objc_parser__found_processing_instruction_with_target__data_ (an_item: POINTER; a_parser: POINTER; a_target: POINTER; a_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundProcessingInstructionWithTarget:$a_target data:$a_data];
			 ]"
		end

	objc_parser__found_comment_ (an_item: POINTER; a_parser: POINTER; a_comment: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundComment:$a_comment];
			 ]"
		end

	objc_parser__found_cdat_a_ (an_item: POINTER; a_parser: POINTER; a_cdata_block: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser foundCDATA:$a_cdata_block];
			 ]"
		end

	objc_parser__resolve_external_entity_name__system_i_d_ (an_item: POINTER; a_parser: POINTER; a_name: POINTER; a_system_id: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSXMLParserDelegate>)$an_item parser:$a_parser resolveExternalEntityName:$a_name systemID:$a_system_id];
			 ]"
		end

	objc_parser__parse_error_occurred_ (an_item: POINTER; a_parser: POINTER; a_parse_error: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser parseErrorOccurred:$a_parse_error];
			 ]"
		end

	objc_parser__validation_error_occurred_ (an_item: POINTER; a_parser: POINTER; a_validation_error: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSXMLParserDelegate>)$an_item parser:$a_parser validationErrorOccurred:$a_validation_error];
			 ]"
		end

end
