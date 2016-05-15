note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_ATTACHMENT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_file_wrapper_,
	make

feature {NONE} -- Initialization

	make_with_file_wrapper_ (a_file_wrapper: detachable NS_FILE_WRAPPER)
			-- Initialize `Current'.
		local
			a_file_wrapper__item: POINTER
		do
			if attached a_file_wrapper as a_file_wrapper_attached then
				a_file_wrapper__item := a_file_wrapper_attached.item
			end
			make_with_pointer (objc_init_with_file_wrapper_(allocate_object, a_file_wrapper__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTextAttachment Externals

	objc_init_with_file_wrapper_ (an_item: POINTER; a_file_wrapper: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextAttachment *)$an_item initWithFileWrapper:$a_file_wrapper];
			 ]"
		end

	objc_set_file_wrapper_ (an_item: POINTER; a_file_wrapper: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextAttachment *)$an_item setFileWrapper:$a_file_wrapper];
			 ]"
		end

	objc_file_wrapper (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextAttachment *)$an_item fileWrapper];
			 ]"
		end

	objc_attachment_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextAttachment *)$an_item attachmentCell];
			 ]"
		end

	objc_set_attachment_cell_ (an_item: POINTER; a_cell: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextAttachment *)$an_item setAttachmentCell:$a_cell];
			 ]"
		end

feature -- NSTextAttachment

	set_file_wrapper_ (a_file_wrapper: detachable NS_FILE_WRAPPER)
			-- Auto generated Objective-C wrapper.
		local
			a_file_wrapper__item: POINTER
		do
			if attached a_file_wrapper as a_file_wrapper_attached then
				a_file_wrapper__item := a_file_wrapper_attached.item
			end
			objc_set_file_wrapper_ (item, a_file_wrapper__item)
		end

	file_wrapper: detachable NS_FILE_WRAPPER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_file_wrapper (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like file_wrapper} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like file_wrapper} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attachment_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attachment_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attachment_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attachment_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attachment_cell_ (a_cell: detachable NS_TEXT_ATTACHMENT_CELL_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_set_attachment_cell_ (item, a_cell__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextAttachment"
		end

end
