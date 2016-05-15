note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_PASTEBOARD_ITEM_DATA_PROVIDER_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Required Methods

	pasteboard__item__provide_data_for_type_ (a_pasteboard: detachable NS_PASTEBOARD; a_item: detachable NS_PASTEBOARD_ITEM; a_type: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_pasteboard__item: POINTER
			a_item__item: POINTER
			a_type__item: POINTER
		do
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			objc_pasteboard__item__provide_data_for_type_ (item, a_pasteboard__item, a_item__item, a_type__item)
		end

feature {NONE} -- Required Methods Externals

	objc_pasteboard__item__provide_data_for_type_ (an_item: POINTER; a_pasteboard: POINTER; a_item: POINTER; a_type: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSPasteboardItemDataProvider>)$an_item pasteboard:$a_pasteboard item:$a_item provideDataForType:$a_type];
			 ]"
		end

feature -- Optional Methods

	pasteboard_finished_with_data_provider_ (a_pasteboard: detachable NS_PASTEBOARD)
			-- Auto generated Objective-C wrapper.
		require
			has_pasteboard_finished_with_data_provider_: has_pasteboard_finished_with_data_provider_
		local
			a_pasteboard__item: POINTER
		do
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			objc_pasteboard_finished_with_data_provider_ (item, a_pasteboard__item)
		end

feature -- Status Report

	has_pasteboard_finished_with_data_provider_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_pasteboard_finished_with_data_provider_ (item)
		end

feature -- Status Report Externals

	objc_has_pasteboard_finished_with_data_provider_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(pasteboardFinishedWithDataProvider:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_pasteboard_finished_with_data_provider_ (an_item: POINTER; a_pasteboard: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSPasteboardItemDataProvider>)$an_item pasteboardFinishedWithDataProvider:$a_pasteboard];
			 ]"
		end

end
