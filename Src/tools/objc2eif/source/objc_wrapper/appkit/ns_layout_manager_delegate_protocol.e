note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_LAYOUT_MANAGER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	layout_manager_did_invalidate_layout_ (a_sender: detachable NS_LAYOUT_MANAGER)
			-- Auto generated Objective-C wrapper.
		require
			has_layout_manager_did_invalidate_layout_: has_layout_manager_did_invalidate_layout_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_layout_manager_did_invalidate_layout_ (item, a_sender__item)
		end

	layout_manager__did_complete_layout_for_text_container__at_end_ (a_layout_manager: detachable NS_LAYOUT_MANAGER; a_text_container: detachable NS_TEXT_CONTAINER; a_layout_finished_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		require
			has_layout_manager__did_complete_layout_for_text_container__at_end_: has_layout_manager__did_complete_layout_for_text_container__at_end_
		local
			a_layout_manager__item: POINTER
			a_text_container__item: POINTER
		do
			if attached a_layout_manager as a_layout_manager_attached then
				a_layout_manager__item := a_layout_manager_attached.item
			end
			if attached a_text_container as a_text_container_attached then
				a_text_container__item := a_text_container_attached.item
			end
			objc_layout_manager__did_complete_layout_for_text_container__at_end_ (item, a_layout_manager__item, a_text_container__item, a_layout_finished_flag)
		end

--	layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_ (a_layout_manager: detachable NS_LAYOUT_MANAGER; a_attrs: detachable NS_DICTIONARY; a_to_screen: BOOLEAN; a_char_index: NATURAL_64; a_effective_char_range: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		require
--			has_layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_: has_layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_
--		local
--			result_pointer: POINTER
--			a_layout_manager__item: POINTER
--			a_attrs__item: POINTER
--			a_effective_char_range__item: POINTER
--		do
--			if attached a_layout_manager as a_layout_manager_attached then
--				a_layout_manager__item := a_layout_manager_attached.item
--			end
--			if attached a_attrs as a_attrs_attached then
--				a_attrs__item := a_attrs_attached.item
--			end
--			if attached a_effective_char_range as a_effective_char_range_attached then
--				a_effective_char_range__item := a_effective_char_range_attached.item
--			end
--			result_pointer := objc_layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_ (item, a_layout_manager__item, a_attrs__item, a_to_screen, a_char_index, a_effective_char_range__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature -- Status Report

	has_layout_manager_did_invalidate_layout_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_layout_manager_did_invalidate_layout_ (item)
		end

	has_layout_manager__did_complete_layout_for_text_container__at_end_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_layout_manager__did_complete_layout_for_text_container__at_end_ (item)
		end

--	has_layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_ (item)
--		end

feature -- Status Report Externals

	objc_has_layout_manager_did_invalidate_layout_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(layoutManagerDidInvalidateLayout:)];
			 ]"
		end

	objc_has_layout_manager__did_complete_layout_for_text_container__at_end_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(layoutManager:didCompleteLayoutForTextContainer:atEnd:)];
			 ]"
		end

--	objc_has_layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(layoutManager:shouldUseTemporaryAttributes:forDrawingToScreen:atCharacterIndex:effectiveRange:)];
--			 ]"
--		end

feature {NONE} -- Optional Methods Externals

	objc_layout_manager_did_invalidate_layout_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSLayoutManagerDelegate>)$an_item layoutManagerDidInvalidateLayout:$a_sender];
			 ]"
		end

	objc_layout_manager__did_complete_layout_for_text_container__at_end_ (an_item: POINTER; a_layout_manager: POINTER; a_text_container: POINTER; a_layout_finished_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSLayoutManagerDelegate>)$an_item layoutManager:$a_layout_manager didCompleteLayoutForTextContainer:$a_text_container atEnd:$a_layout_finished_flag];
			 ]"
		end

--	objc_layout_manager__should_use_temporary_attributes__for_drawing_to_screen__at_character_index__effective_range_ (an_item: POINTER; a_layout_manager: POINTER; a_attrs: POINTER; a_to_screen: BOOLEAN; a_char_index: NATURAL_64; a_effective_char_range: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSLayoutManagerDelegate>)$an_item layoutManager:$a_layout_manager shouldUseTemporaryAttributes:$a_attrs forDrawingToScreen:$a_to_screen atCharacterIndex:$a_char_index effectiveRange:];
--			 ]"
--		end

end
