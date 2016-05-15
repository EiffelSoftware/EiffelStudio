note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_DESCRIPTOR_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSFontDescriptor

	font_descriptor_with_font_attributes_ (a_attributes: detachable NS_DICTIONARY): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_font_descriptor_with_font_attributes_ (l_objc_class.item, a_attributes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor_with_font_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor_with_font_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptor_with_name__size_ (a_font_name: detachable NS_STRING; a_size: REAL_64): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_font_name__item: POINTER
		do
			if attached a_font_name as a_font_name_attached then
				a_font_name__item := a_font_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_font_descriptor_with_name__size_ (l_objc_class.item, a_font_name__item, a_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor_with_name__size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor_with_name__size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptor_with_name__matrix_ (a_font_name: detachable NS_STRING; a_matrix: detachable NS_AFFINE_TRANSFORM): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_font_name__item: POINTER
			a_matrix__item: POINTER
		do
			if attached a_font_name as a_font_name_attached then
				a_font_name__item := a_font_name_attached.item
			end
			if attached a_matrix as a_matrix_attached then
				a_matrix__item := a_matrix_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_font_descriptor_with_name__matrix_ (l_objc_class.item, a_font_name__item, a_matrix__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor_with_name__matrix_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor_with_name__matrix_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSFontDescriptor Externals

	objc_font_descriptor_with_font_attributes_ (a_class_object: POINTER; a_attributes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object fontDescriptorWithFontAttributes:$a_attributes];
			 ]"
		end

	objc_font_descriptor_with_name__size_ (a_class_object: POINTER; a_font_name: POINTER; a_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object fontDescriptorWithName:$a_font_name size:$a_size];
			 ]"
		end

	objc_font_descriptor_with_name__matrix_ (a_class_object: POINTER; a_font_name: POINTER; a_matrix: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object fontDescriptorWithName:$a_font_name matrix:$a_matrix];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFontDescriptor"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
