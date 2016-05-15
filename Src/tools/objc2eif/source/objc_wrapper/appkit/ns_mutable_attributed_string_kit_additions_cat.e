note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_ATTRIBUTED_STRING_KIT_ADDITIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSMutableAttributedStringKitAdditions

--	read_from_ur_l__options__document_attributes__error_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_url: detachable NS_URL; a_opts: detachable NS_DICTIONARY; a_dict: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_opts__item: POINTER
--			a_dict__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_opts as a_opts_attached then
--				a_opts__item := a_opts_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_read_from_ur_l__options__document_attributes__error_ (a_ns_mutable_attributed_string.item, a_url__item, a_opts__item, a_dict__item, a_error__item)
--		end

--	read_from_data__options__document_attributes__error_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_data: detachable NS_DATA; a_opts: detachable NS_DICTIONARY; a_dict: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_data__item: POINTER
--			a_opts__item: POINTER
--			a_dict__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_opts as a_opts_attached then
--				a_opts__item := a_opts_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_read_from_data__options__document_attributes__error_ (a_ns_mutable_attributed_string.item, a_data__item, a_opts__item, a_dict__item, a_error__item)
--		end

--	read_from_ur_l__options__document_attributes_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_url: detachable NS_URL; a_options: detachable NS_DICTIONARY; a_dict: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_url__item: POINTER
--			a_options__item: POINTER
--			a_dict__item: POINTER
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
--			Result := objc_read_from_ur_l__options__document_attributes_ (a_ns_mutable_attributed_string.item, a_url__item, a_options__item, a_dict__item)
--		end

--	read_from_data__options__document_attributes_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_data: detachable NS_DATA; a_options: detachable NS_DICTIONARY; a_dict: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
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
--			Result := objc_read_from_data__options__document_attributes_ (a_ns_mutable_attributed_string.item, a_data__item, a_options__item, a_dict__item)
--		end

	superscript_range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_superscript_range_ (a_ns_mutable_attributed_string.item, a_range.item)
		end

	subscript_range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_subscript_range_ (a_ns_mutable_attributed_string.item, a_range.item)
		end

	unscript_range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unscript_range_ (a_ns_mutable_attributed_string.item, a_range.item)
		end

	apply_font_traits__range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_trait_mask: NATURAL_64; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_apply_font_traits__range_ (a_ns_mutable_attributed_string.item, a_trait_mask, a_range.item)
		end

	set_alignment__range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_alignment: NATURAL_64; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alignment__range_ (a_ns_mutable_attributed_string.item, a_alignment, a_range.item)
		end

	set_base_writing_direction__range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_writing_direction: INTEGER_64; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_base_writing_direction__range_ (a_ns_mutable_attributed_string.item, a_writing_direction, a_range.item)
		end

	fix_attributes_in_range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_fix_attributes_in_range_ (a_ns_mutable_attributed_string.item, a_range.item)
		end

	fix_font_attribute_in_range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_fix_font_attribute_in_range_ (a_ns_mutable_attributed_string.item, a_range.item)
		end

	fix_paragraph_style_attribute_in_range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_fix_paragraph_style_attribute_in_range_ (a_ns_mutable_attributed_string.item, a_range.item)
		end

	fix_attachment_attribute_in_range_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_fix_attachment_attribute_in_range_ (a_ns_mutable_attributed_string.item, a_range.item)
		end

feature {NONE} -- NSMutableAttributedStringKitAdditions Externals

--	objc_read_from_ur_l__options__document_attributes__error_ (an_item: POINTER; a_url: POINTER; a_opts: POINTER; a_dict: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSMutableAttributedString *)$an_item readFromURL:$a_url options:$a_opts documentAttributes: error:];
--			 ]"
--		end

--	objc_read_from_data__options__document_attributes__error_ (an_item: POINTER; a_data: POINTER; a_opts: POINTER; a_dict: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSMutableAttributedString *)$an_item readFromData:$a_data options:$a_opts documentAttributes: error:];
--			 ]"
--		end

--	objc_read_from_ur_l__options__document_attributes_ (an_item: POINTER; a_url: POINTER; a_options: POINTER; a_dict: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSMutableAttributedString *)$an_item readFromURL:$a_url options:$a_options documentAttributes:];
--			 ]"
--		end

--	objc_read_from_data__options__document_attributes_ (an_item: POINTER; a_data: POINTER; a_options: POINTER; a_dict: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSMutableAttributedString *)$an_item readFromData:$a_data options:$a_options documentAttributes:];
--			 ]"
--		end

	objc_superscript_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item superscriptRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_subscript_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item subscriptRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_unscript_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item unscriptRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_apply_font_traits__range_ (an_item: POINTER; a_trait_mask: NATURAL_64; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item applyFontTraits:$a_trait_mask range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_set_alignment__range_ (an_item: POINTER; a_alignment: NATURAL_64; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item setAlignment:$a_alignment range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_set_base_writing_direction__range_ (an_item: POINTER; a_writing_direction: INTEGER_64; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item setBaseWritingDirection:$a_writing_direction range:*((NSRange *)$a_range)];
			 ]"
		end

	objc_fix_attributes_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item fixAttributesInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_fix_font_attribute_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item fixFontAttributeInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_fix_paragraph_style_attribute_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item fixParagraphStyleAttributeInRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_fix_attachment_attribute_in_range_ (an_item: POINTER; a_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item fixAttachmentAttributeInRange:*((NSRange *)$a_range)];
			 ]"
		end

end
