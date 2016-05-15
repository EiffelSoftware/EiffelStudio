note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PDF_IMAGE_REP_UTILS

inherit
	NS_IMAGE_REP_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSPDFImageRep

	image_rep_with_data_ (a_pdf_data: detachable NS_DATA): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_pdf_data__item: POINTER
		do
			if attached a_pdf_data as a_pdf_data_attached then
				a_pdf_data__item := a_pdf_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_image_rep_with_data_ (l_objc_class.item, a_pdf_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_rep_with_data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_rep_with_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPDFImageRep Externals

	objc_image_rep_with_data_ (a_class_object: POINTER; a_pdf_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object imageRepWithData:$a_pdf_data];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPDFImageRep"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
