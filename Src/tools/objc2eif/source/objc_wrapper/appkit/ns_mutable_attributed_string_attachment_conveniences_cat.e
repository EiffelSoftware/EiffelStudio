note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_ATTRIBUTED_STRING_ATTACHMENT_CONVENIENCES_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSMutableAttributedStringAttachmentConveniences

	update_attachments_from_path_ (a_ns_mutable_attributed_string: NS_MUTABLE_ATTRIBUTED_STRING; a_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_update_attachments_from_path_ (a_ns_mutable_attributed_string.item, a_path__item)
		end

feature {NONE} -- NSMutableAttributedStringAttachmentConveniences Externals

	objc_update_attachments_from_path_ (an_item: POINTER; a_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMutableAttributedString *)$an_item updateAttachmentsFromPath:$a_path];
			 ]"
		end

end
