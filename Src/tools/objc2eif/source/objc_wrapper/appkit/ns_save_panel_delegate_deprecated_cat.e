note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SAVE_PANEL_DELEGATE_DEPRECATED_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSSavePanelDelegateDeprecated

	panel__is_valid_filename_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_OBJECT; a_filename: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			Result := objc_panel__is_valid_filename_ (a_ns_object.item, a_sender__item, a_filename__item)
		end

	panel__directory_did_change_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_OBJECT; a_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
			a_path__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_panel__directory_did_change_ (a_ns_object.item, a_sender__item, a_path__item)
		end

	panel__compare_filename__with__case_sensitive_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_OBJECT; a_name1: detachable NS_STRING; a_name2: detachable NS_STRING; a_case_sensitive: BOOLEAN): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
			a_name1__item: POINTER
			a_name2__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_name1 as a_name1_attached then
				a_name1__item := a_name1_attached.item
			end
			if attached a_name2 as a_name2_attached then
				a_name2__item := a_name2_attached.item
			end
			Result := objc_panel__compare_filename__with__case_sensitive_ (a_ns_object.item, a_sender__item, a_name1__item, a_name2__item, a_case_sensitive)
		end

	panel__should_show_filename_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_OBJECT; a_filename: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			Result := objc_panel__should_show_filename_ (a_ns_object.item, a_sender__item, a_filename__item)
		end

feature {NONE} -- NSSavePanelDelegateDeprecated Externals

	objc_panel__is_valid_filename_ (an_item: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item panel:$a_sender isValidFilename:$a_filename];
			 ]"
		end

	objc_panel__directory_did_change_ (an_item: POINTER; a_sender: POINTER; a_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item panel:$a_sender directoryDidChange:$a_path];
			 ]"
		end

	objc_panel__compare_filename__with__case_sensitive_ (an_item: POINTER; a_sender: POINTER; a_name1: POINTER; a_name2: POINTER; a_case_sensitive: BOOLEAN): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item panel:$a_sender compareFilename:$a_name1 with:$a_name2 caseSensitive:$a_case_sensitive];
			 ]"
		end

	objc_panel__should_show_filename_ (an_item: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item panel:$a_sender shouldShowFilename:$a_filename];
			 ]"
		end

end
