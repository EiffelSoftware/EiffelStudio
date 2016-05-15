note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ATTRIBUTED_STRING_KIT_ADDITIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSAttributedStringKitAdditions

	font_attributes_in_range_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_range: NS_RANGE): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font_attributes_in_range_ (a_ns_attributed_string.item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_attributes_in_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_attributes_in_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	ruler_attributes_in_range_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_range: NS_RANGE): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ruler_attributes_in_range_ (a_ns_attributed_string.item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ruler_attributes_in_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ruler_attributes_in_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	contains_attachments (a_ns_attributed_string: NS_ATTRIBUTED_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_contains_attachments (a_ns_attributed_string.item)
		end

	line_break_before_index__within_range_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_location: NATURAL_64; a_range: NS_RANGE): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_break_before_index__within_range_ (a_ns_attributed_string.item, a_location, a_range.item)
		end

	line_break_by_hyphenating_before_index__within_range_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_location: NATURAL_64; a_range: NS_RANGE): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_break_by_hyphenating_before_index__within_range_ (a_ns_attributed_string.item, a_location, a_range.item)
		end

	double_click_at_index_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_location: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_double_click_at_index_ (a_ns_attributed_string.item, Result.item, a_location)
		end

	next_word_from_index__forward_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_location: NATURAL_64; a_is_forward: BOOLEAN): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_next_word_from_index__forward_ (a_ns_attributed_string.item, a_location, a_is_forward)
		end

--	url_at_index__effective_range_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_location: NATURAL_64; a_effective_range: UNSUPPORTED_TYPE): detachable NS_URL
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_effective_range__item: POINTER
--		do
--			if attached a_effective_range as a_effective_range_attached then
--				a_effective_range__item := a_effective_range_attached.item
--			end
--			result_pointer := objc_url_at_index__effective_range_ (a_ns_attributed_string.item, a_location, a_effective_range__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like url_at_index__effective_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like url_at_index__effective_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	range_of_text_block__at_index_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_block: detachable NS_TEXT_BLOCK; a_location: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_block__item: POINTER
		do
			if attached a_block as a_block_attached then
				a_block__item := a_block_attached.item
			end
			create Result.make
			objc_range_of_text_block__at_index_ (a_ns_attributed_string.item, Result.item, a_block__item, a_location)
		end

	range_of_text_table__at_index_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_table: detachable NS_TEXT_TABLE; a_location: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_table__item: POINTER
		do
			if attached a_table as a_table_attached then
				a_table__item := a_table_attached.item
			end
			create Result.make
			objc_range_of_text_table__at_index_ (a_ns_attributed_string.item, Result.item, a_table__item, a_location)
		end

	range_of_text_list__at_index_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_list: detachable NS_TEXT_LIST; a_location: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_list__item: POINTER
		do
			if attached a_list as a_list_attached then
				a_list__item := a_list_attached.item
			end
			create Result.make
			objc_range_of_text_list__at_index_ (a_ns_attributed_string.item, Result.item, a_list__item, a_location)
		end

	item_number_in_text_list__at_index_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_list: detachable NS_TEXT_LIST; a_location: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_list__item: POINTER
		do
			if attached a_list as a_list_attached then
				a_list__item := a_list_attached.item
			end
			Result := objc_item_number_in_text_list__at_index_ (a_ns_attributed_string.item, a_list__item, a_location)
		end

--	init_with_ur_l__options__document_attributes__error_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_url: detachable NS_URL; a_options: detachable NS_DICTIONARY; a_dict: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_url__item: POINTER
--			a_options__item: POINTER
--			a_dict__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_init_with_ur_l__options__document_attributes__error_ (a_ns_attributed_string.item, a_url__item, a_options__item, a_dict__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_ur_l__options__document_attributes__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_ur_l__options__document_attributes__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_data__options__document_attributes__error_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_data: detachable NS_DATA; a_options: detachable NS_DICTIONARY; a_dict: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_data__item: POINTER
--			a_options__item: POINTER
--			a_dict__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_init_with_data__options__document_attributes__error_ (a_ns_attributed_string.item, a_data__item, a_options__item, a_dict__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_data__options__document_attributes__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_data__options__document_attributes__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_path__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_path: detachable NS_STRING; a_dict: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_path__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			result_pointer := objc_init_with_path__document_attributes_ (a_ns_attributed_string.item, a_path__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_path__document_attributes_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_path__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_ur_l__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_url: detachable NS_URL; a_dict: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_url__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			result_pointer := objc_init_with_ur_l__document_attributes_ (a_ns_attributed_string.item, a_url__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_ur_l__document_attributes_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_ur_l__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_rt_f__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_data: detachable NS_DATA; a_dict: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_data__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			result_pointer := objc_init_with_rt_f__document_attributes_ (a_ns_attributed_string.item, a_data__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_rt_f__document_attributes_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_rt_f__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_rtf_d__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_data: detachable NS_DATA; a_dict: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_data__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			result_pointer := objc_init_with_rtf_d__document_attributes_ (a_ns_attributed_string.item, a_data__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_rtf_d__document_attributes_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_rtf_d__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_htm_l__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_data: detachable NS_DATA; a_dict: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_data__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			result_pointer := objc_init_with_htm_l__document_attributes_ (a_ns_attributed_string.item, a_data__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_htm_l__document_attributes_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_htm_l__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_htm_l__base_ur_l__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_data: detachable NS_DATA; a_base: detachable NS_URL; a_dict: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_data__item: POINTER
--			a_base__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_base as a_base_attached then
--				a_base__item := a_base_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			result_pointer := objc_init_with_htm_l__base_ur_l__document_attributes_ (a_ns_attributed_string.item, a_data__item, a_base__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_htm_l__base_ur_l__document_attributes_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_htm_l__base_ur_l__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_doc_format__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_data: detachable NS_DATA; a_dict: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_data__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			result_pointer := objc_init_with_doc_format__document_attributes_ (a_ns_attributed_string.item, a_data__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_doc_format__document_attributes_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_doc_format__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_htm_l__options__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_data: detachable NS_DATA; a_options: detachable NS_DICTIONARY; a_dict: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_data__item: POINTER
--			a_options__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			result_pointer := objc_init_with_htm_l__options__document_attributes_ (a_ns_attributed_string.item, a_data__item, a_options__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_htm_l__options__document_attributes_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_htm_l__options__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	init_with_rtfd_file_wrapper__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_wrapper: detachable NS_FILE_WRAPPER; a_dict: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_wrapper__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_wrapper as a_wrapper_attached then
--				a_wrapper__item := a_wrapper_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			result_pointer := objc_init_with_rtfd_file_wrapper__document_attributes_ (a_ns_attributed_string.item, a_wrapper__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like init_with_rtfd_file_wrapper__document_attributes_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like init_with_rtfd_file_wrapper__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	data_from_range__document_attributes__error_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_range: NS_RANGE; a_dict: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): detachable NS_DATA
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_dict__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_data_from_range__document_attributes__error_ (a_ns_attributed_string.item, a_range.item, a_dict__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like data_from_range__document_attributes__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like data_from_range__document_attributes__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	file_wrapper_from_range__document_attributes__error_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_range: NS_RANGE; a_dict: detachable NS_DICTIONARY; a_error: UNSUPPORTED_TYPE): detachable NS_FILE_WRAPPER
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_dict__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			result_pointer := objc_file_wrapper_from_range__document_attributes__error_ (a_ns_attributed_string.item, a_range.item, a_dict__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like file_wrapper_from_range__document_attributes__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like file_wrapper_from_range__document_attributes__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	rtf_from_range__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_range: NS_RANGE; a_dict: detachable NS_DICTIONARY): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_dict__item: POINTER
		do
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			result_pointer := objc_rtf_from_range__document_attributes_ (a_ns_attributed_string.item, a_range.item, a_dict__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rtf_from_range__document_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rtf_from_range__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	rtfd_from_range__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_range: NS_RANGE; a_dict: detachable NS_DICTIONARY): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_dict__item: POINTER
		do
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			result_pointer := objc_rtfd_from_range__document_attributes_ (a_ns_attributed_string.item, a_range.item, a_dict__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rtfd_from_range__document_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rtfd_from_range__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	rtfd_file_wrapper_from_range__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_range: NS_RANGE; a_dict: detachable NS_DICTIONARY): detachable NS_FILE_WRAPPER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_dict__item: POINTER
		do
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			result_pointer := objc_rtfd_file_wrapper_from_range__document_attributes_ (a_ns_attributed_string.item, a_range.item, a_dict__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rtfd_file_wrapper_from_range__document_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rtfd_file_wrapper_from_range__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	doc_format_from_range__document_attributes_ (a_ns_attributed_string: NS_ATTRIBUTED_STRING; a_range: NS_RANGE; a_dict: detachable NS_DICTIONARY): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_dict__item: POINTER
		do
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			result_pointer := objc_doc_format_from_range__document_attributes_ (a_ns_attributed_string.item, a_range.item, a_dict__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like doc_format_from_range__document_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like doc_format_from_range__document_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSAttributedStringKitAdditions Externals

	objc_font_attributes_in_range_ (an_item: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item fontAttributesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_ruler_attributes_in_range_ (an_item: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item rulerAttributesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_contains_attachments (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAttributedString *)$an_item containsAttachments];
			 ]"
		end

	objc_line_break_before_index__within_range_ (an_item: POINTER; a_location: NATURAL_64; a_range: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAttributedString *)$an_item lineBreakBeforeIndex:$a_location withinRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_line_break_by_hyphenating_before_index__within_range_ (an_item: POINTER; a_location: NATURAL_64; a_range: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAttributedString *)$an_item lineBreakByHyphenatingBeforeIndex:$a_location withinRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_double_click_at_index_ (an_item: POINTER; result_pointer: POINTER; a_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSAttributedString *)$an_item doubleClickAtIndex:$a_location];
			 ]"
		end

	objc_next_word_from_index__forward_ (an_item: POINTER; a_location: NATURAL_64; a_is_forward: BOOLEAN): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAttributedString *)$an_item nextWordFromIndex:$a_location forward:$a_is_forward];
			 ]"
		end

--	objc_url_at_index__effective_range_ (an_item: POINTER; a_location: NATURAL_64; a_effective_range: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item URLAtIndex:$a_location effectiveRange:];
--			 ]"
--		end

	objc_range_of_text_block__at_index_ (an_item: POINTER; result_pointer: POINTER; a_block: POINTER; a_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSAttributedString *)$an_item rangeOfTextBlock:$a_block atIndex:$a_location];
			 ]"
		end

	objc_range_of_text_table__at_index_ (an_item: POINTER; result_pointer: POINTER; a_table: POINTER; a_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSAttributedString *)$an_item rangeOfTextTable:$a_table atIndex:$a_location];
			 ]"
		end

	objc_range_of_text_list__at_index_ (an_item: POINTER; result_pointer: POINTER; a_list: POINTER; a_location: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSAttributedString *)$an_item rangeOfTextList:$a_list atIndex:$a_location];
			 ]"
		end

	objc_item_number_in_text_list__at_index_ (an_item: POINTER; a_list: POINTER; a_location: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAttributedString *)$an_item itemNumberInTextList:$a_list atIndex:$a_location];
			 ]"
		end

--	objc_init_with_ur_l__options__document_attributes__error_ (an_item: POINTER; a_url: POINTER; a_options: POINTER; a_dict: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithURL:$a_url options:$a_options documentAttributes: error:];
--			 ]"
--		end

--	objc_init_with_data__options__document_attributes__error_ (an_item: POINTER; a_data: POINTER; a_options: POINTER; a_dict: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithData:$a_data options:$a_options documentAttributes: error:];
--			 ]"
--		end

--	objc_init_with_path__document_attributes_ (an_item: POINTER; a_path: POINTER; a_dict: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithPath:$a_path documentAttributes:];
--			 ]"
--		end

--	objc_init_with_ur_l__document_attributes_ (an_item: POINTER; a_url: POINTER; a_dict: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithURL:$a_url documentAttributes:];
--			 ]"
--		end

--	objc_init_with_rt_f__document_attributes_ (an_item: POINTER; a_data: POINTER; a_dict: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithRTF:$a_data documentAttributes:];
--			 ]"
--		end

--	objc_init_with_rtf_d__document_attributes_ (an_item: POINTER; a_data: POINTER; a_dict: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithRTFD:$a_data documentAttributes:];
--			 ]"
--		end

--	objc_init_with_htm_l__document_attributes_ (an_item: POINTER; a_data: POINTER; a_dict: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithHTML:$a_data documentAttributes:];
--			 ]"
--		end

--	objc_init_with_htm_l__base_ur_l__document_attributes_ (an_item: POINTER; a_data: POINTER; a_base: POINTER; a_dict: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithHTML:$a_data baseURL:$a_base documentAttributes:];
--			 ]"
--		end

--	objc_init_with_doc_format__document_attributes_ (an_item: POINTER; a_data: POINTER; a_dict: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithDocFormat:$a_data documentAttributes:];
--			 ]"
--		end

--	objc_init_with_htm_l__options__document_attributes_ (an_item: POINTER; a_data: POINTER; a_options: POINTER; a_dict: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithHTML:$a_data options:$a_options documentAttributes:];
--			 ]"
--		end

--	objc_init_with_rtfd_file_wrapper__document_attributes_ (an_item: POINTER; a_wrapper: POINTER; a_dict: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item initWithRTFDFileWrapper:$a_wrapper documentAttributes:];
--			 ]"
--		end

--	objc_data_from_range__document_attributes__error_ (an_item: POINTER; a_range: POINTER; a_dict: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item dataFromRange:*((NSRange *)$a_range) documentAttributes:$a_dict error:];
--			 ]"
--		end

--	objc_file_wrapper_from_range__document_attributes__error_ (an_item: POINTER; a_range: POINTER; a_dict: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAttributedString *)$an_item fileWrapperFromRange:*((NSRange *)$a_range) documentAttributes:$a_dict error:];
--			 ]"
--		end

	objc_rtf_from_range__document_attributes_ (an_item: POINTER; a_range: POINTER; a_dict: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item RTFFromRange:*((NSRange *)$a_range) documentAttributes:$a_dict];
			 ]"
		end

	objc_rtfd_from_range__document_attributes_ (an_item: POINTER; a_range: POINTER; a_dict: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item RTFDFromRange:*((NSRange *)$a_range) documentAttributes:$a_dict];
			 ]"
		end

	objc_rtfd_file_wrapper_from_range__document_attributes_ (an_item: POINTER; a_range: POINTER; a_dict: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item RTFDFileWrapperFromRange:*((NSRange *)$a_range) documentAttributes:$a_dict];
			 ]"
		end

	objc_doc_format_from_range__document_attributes_ (an_item: POINTER; a_range: POINTER; a_dict: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAttributedString *)$an_item docFormatFromRange:*((NSRange *)$a_range) documentAttributes:$a_dict];
			 ]"
		end

end
