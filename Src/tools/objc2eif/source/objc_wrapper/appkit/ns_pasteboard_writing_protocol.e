note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_PASTEBOARD_WRITING_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Required Methods

	writable_types_for_pasteboard_ (a_pasteboard: detachable NS_PASTEBOARD): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_pasteboard__item: POINTER
		do
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			result_pointer := objc_writable_types_for_pasteboard_ (item, a_pasteboard__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like writable_types_for_pasteboard_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like writable_types_for_pasteboard_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pasteboard_property_list_for_type_ (a_type: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_type__item: POINTER
		do
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			result_pointer := objc_pasteboard_property_list_for_type_ (item, a_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pasteboard_property_list_for_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pasteboard_property_list_for_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Required Methods Externals

	objc_writable_types_for_pasteboard_ (an_item: POINTER; a_pasteboard: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSPasteboardWriting>)$an_item writableTypesForPasteboard:$a_pasteboard];
			 ]"
		end

	objc_pasteboard_property_list_for_type_ (an_item: POINTER; a_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSPasteboardWriting>)$an_item pasteboardPropertyListForType:$a_type];
			 ]"
		end

feature -- Optional Methods

	writing_options_for_type__pasteboard_ (a_type: detachable NS_STRING; a_pasteboard: detachable NS_PASTEBOARD): NATURAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_writing_options_for_type__pasteboard_: has_writing_options_for_type__pasteboard_
		local
			a_type__item: POINTER
			a_pasteboard__item: POINTER
		do
			if attached a_type as a_type_attached then
				a_type__item := a_type_attached.item
			end
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			Result := objc_writing_options_for_type__pasteboard_ (item, a_type__item, a_pasteboard__item)
		end

feature -- Status Report

	has_writing_options_for_type__pasteboard_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_writing_options_for_type__pasteboard_ (item)
		end

feature -- Status Report Externals

	objc_has_writing_options_for_type__pasteboard_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(writingOptionsForType:pasteboard:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_writing_options_for_type__pasteboard_ (an_item: POINTER; a_type: POINTER; a_pasteboard: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSPasteboardWriting>)$an_item writingOptionsForType:$a_type pasteboard:$a_pasteboard];
			 ]"
		end

end
