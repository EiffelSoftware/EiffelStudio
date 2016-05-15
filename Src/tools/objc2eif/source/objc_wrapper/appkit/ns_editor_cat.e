note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EDITOR_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSEditor

	discard_editing (a_ns_object: NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_discard_editing (a_ns_object.item)
		end

	commit_editing (a_ns_object: NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_commit_editing (a_ns_object.item)
		end

--	commit_editing_with_delegate__did_commit_selector__context_info_ (a_ns_object: NS_OBJECT; a_delegate: detachable NS_OBJECT; a_did_commit_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_delegate__item: POINTER
--			a_did_commit_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_commit_selector as a_did_commit_selector_attached then
--				a_did_commit_selector__item := a_did_commit_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_commit_editing_with_delegate__did_commit_selector__context_info_ (a_ns_object.item, a_delegate__item, a_did_commit_selector__item, a_context_info__item)
--		end

feature {NONE} -- NSEditor Externals

	objc_discard_editing (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item discardEditing];
			 ]"
		end

	objc_commit_editing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item commitEditing];
			 ]"
		end

--	objc_commit_editing_with_delegate__did_commit_selector__context_info_ (an_item: POINTER; a_delegate: POINTER; a_did_commit_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSObject *)$an_item commitEditingWithDelegate:$a_delegate didCommitSelector:$a_did_commit_selector contextInfo:];
--			 ]"
--		end

end
