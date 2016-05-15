note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_USER_INTERFACE_ITEM_SEARCHING_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Required Methods

--	search_for_items_with_search_string__result_limit__matched_item_handler_ (a_search_string: detachable NS_STRING; a_result_limit: INTEGER_64; a_handle_matched_items: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_search_string__item: POINTER
--		do
--			if attached a_search_string as a_search_string_attached then
--				a_search_string__item := a_search_string_attached.item
--			end
--			objc_search_for_items_with_search_string__result_limit__matched_item_handler_ (item, a_search_string__item, a_result_limit, )
--		end

	localized_titles_for_item_ (a_item: detachable NS_OBJECT): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			result_pointer := objc_localized_titles_for_item_ (item, a_item__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_titles_for_item_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_titles_for_item_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Required Methods Externals

--	objc_search_for_items_with_search_string__result_limit__matched_item_handler_ (an_item: POINTER; a_search_string: POINTER; a_result_limit: INTEGER_64; a_handle_matched_items: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(id <NSUserInterfaceItemSearching>)$an_item searchForItemsWithSearchString:$a_search_string resultLimit:$a_result_limit matchedItemHandler:];
--			 ]"
--		end

	objc_localized_titles_for_item_ (an_item: POINTER; a_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSUserInterfaceItemSearching>)$an_item localizedTitlesForItem:$a_item];
			 ]"
		end

feature -- Optional Methods

	perform_action_for_item_ (a_item: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_perform_action_for_item_: has_perform_action_for_item_
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_perform_action_for_item_ (item, a_item__item)
		end

	show_all_help_topics_for_search_string_ (a_search_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_show_all_help_topics_for_search_string_: has_show_all_help_topics_for_search_string_
		local
			a_search_string__item: POINTER
		do
			if attached a_search_string as a_search_string_attached then
				a_search_string__item := a_search_string_attached.item
			end
			objc_show_all_help_topics_for_search_string_ (item, a_search_string__item)
		end

feature -- Status Report

	has_perform_action_for_item_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_perform_action_for_item_ (item)
		end

	has_show_all_help_topics_for_search_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_show_all_help_topics_for_search_string_ (item)
		end

feature -- Status Report Externals

	objc_has_perform_action_for_item_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(performActionForItem:)];
			 ]"
		end

	objc_has_show_all_help_topics_for_search_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(showAllHelpTopicsForSearchString:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_perform_action_for_item_ (an_item: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSUserInterfaceItemSearching>)$an_item performActionForItem:$a_item];
			 ]"
		end

	objc_show_all_help_topics_for_search_string_ (an_item: POINTER; a_search_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSUserInterfaceItemSearching>)$an_item showAllHelpTopicsForSearchString:$a_search_string];
			 ]"
		end

end
