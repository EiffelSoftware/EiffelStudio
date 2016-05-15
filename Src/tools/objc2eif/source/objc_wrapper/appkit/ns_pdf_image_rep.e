note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PDF_IMAGE_REP

inherit
	NS_IMAGE_REP
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_data_,
	make

feature {NONE} -- Initialization

	make_with_data_ (a_pdf_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_pdf_data__item: POINTER
		do
			if attached a_pdf_data as a_pdf_data_attached then
				a_pdf_data__item := a_pdf_data_attached.item
			end
			make_with_pointer (objc_init_with_data_(allocate_object, a_pdf_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSPDFImageRep Externals

	objc_init_with_data_ (an_item: POINTER; a_pdf_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPDFImageRep *)$an_item initWithData:$a_pdf_data];
			 ]"
		end

	objc_pdf_representation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPDFImageRep *)$an_item PDFRepresentation];
			 ]"
		end

	objc_bounds (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSPDFImageRep *)$an_item bounds];
			 ]"
		end

	objc_set_current_page_ (an_item: POINTER; a_page: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPDFImageRep *)$an_item setCurrentPage:$a_page];
			 ]"
		end

	objc_current_page (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPDFImageRep *)$an_item currentPage];
			 ]"
		end

	objc_page_count (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPDFImageRep *)$an_item pageCount];
			 ]"
		end

feature -- NSPDFImageRep

	pdf_representation: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_pdf_representation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pdf_representation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pdf_representation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bounds: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_bounds (item, Result.item)
		end

	set_current_page_ (a_page: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_current_page_ (item, a_page)
		end

	current_page: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_page (item)
		end

	page_count: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_page_count (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPDFImageRep"
		end

end
