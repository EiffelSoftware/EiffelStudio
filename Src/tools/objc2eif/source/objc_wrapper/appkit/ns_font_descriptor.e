note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_DESCRIPTOR

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_font_attributes_,
	make

feature -- NSFontDescriptor

	postscript_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_postscript_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like postscript_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like postscript_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	point_size: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_point_size (item)
		end

	matrix: detachable NS_AFFINE_TRANSFORM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_matrix (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like matrix} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like matrix} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	symbolic_traits: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_symbolic_traits (item)
		end

	object_for_key_ (an_attribute: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			an_attribute__item: POINTER
		do
			if attached an_attribute as an_attribute_attached then
				an_attribute__item := an_attribute_attached.item
			end
			result_pointer := objc_object_for_key_ (item, an_attribute__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_attributes: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	matching_font_descriptors_with_mandatory_keys_ (a_mandatory_keys: detachable NS_SET): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_mandatory_keys__item: POINTER
		do
			if attached a_mandatory_keys as a_mandatory_keys_attached then
				a_mandatory_keys__item := a_mandatory_keys_attached.item
			end
			result_pointer := objc_matching_font_descriptors_with_mandatory_keys_ (item, a_mandatory_keys__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like matching_font_descriptors_with_mandatory_keys_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like matching_font_descriptors_with_mandatory_keys_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	matching_font_descriptor_with_mandatory_keys_ (a_mandatory_keys: detachable NS_SET): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_mandatory_keys__item: POINTER
		do
			if attached a_mandatory_keys as a_mandatory_keys_attached then
				a_mandatory_keys__item := a_mandatory_keys_attached.item
			end
			result_pointer := objc_matching_font_descriptor_with_mandatory_keys_ (item, a_mandatory_keys__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like matching_font_descriptor_with_mandatory_keys_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like matching_font_descriptor_with_mandatory_keys_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptor_by_adding_attributes_ (a_attributes: detachable NS_DICTIONARY): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			result_pointer := objc_font_descriptor_by_adding_attributes_ (item, a_attributes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor_by_adding_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor_by_adding_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptor_with_symbolic_traits_ (a_symbolic_traits: NATURAL_32): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font_descriptor_with_symbolic_traits_ (item, a_symbolic_traits)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor_with_symbolic_traits_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor_with_symbolic_traits_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptor_with_size_ (a_new_point_size: REAL_64): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font_descriptor_with_size_ (item, a_new_point_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor_with_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor_with_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptor_with_matrix_ (a_matrix: detachable NS_AFFINE_TRANSFORM): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_matrix__item: POINTER
		do
			if attached a_matrix as a_matrix_attached then
				a_matrix__item := a_matrix_attached.item
			end
			result_pointer := objc_font_descriptor_with_matrix_ (item, a_matrix__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor_with_matrix_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor_with_matrix_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptor_with_face_ (a_new_face: detachable NS_STRING): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_new_face__item: POINTER
		do
			if attached a_new_face as a_new_face_attached then
				a_new_face__item := a_new_face_attached.item
			end
			result_pointer := objc_font_descriptor_with_face_ (item, a_new_face__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor_with_face_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor_with_face_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptor_with_family_ (a_new_family: detachable NS_STRING): detachable NS_FONT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_new_family__item: POINTER
		do
			if attached a_new_family as a_new_family_attached then
				a_new_family__item := a_new_family_attached.item
			end
			result_pointer := objc_font_descriptor_with_family_ (item, a_new_family__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptor_with_family_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptor_with_family_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSFontDescriptor Externals

	objc_postscript_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item postscriptName];
			 ]"
		end

	objc_point_size (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontDescriptor *)$an_item pointSize];
			 ]"
		end

	objc_matrix (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item matrix];
			 ]"
		end

	objc_symbolic_traits (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontDescriptor *)$an_item symbolicTraits];
			 ]"
		end

	objc_object_for_key_ (an_item: POINTER; an_attribute: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item objectForKey:$an_attribute];
			 ]"
		end

	objc_font_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item fontAttributes];
			 ]"
		end

	objc_init_with_font_attributes_ (an_item: POINTER; a_attributes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item initWithFontAttributes:$a_attributes];
			 ]"
		end

	objc_matching_font_descriptors_with_mandatory_keys_ (an_item: POINTER; a_mandatory_keys: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item matchingFontDescriptorsWithMandatoryKeys:$a_mandatory_keys];
			 ]"
		end

	objc_matching_font_descriptor_with_mandatory_keys_ (an_item: POINTER; a_mandatory_keys: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item matchingFontDescriptorWithMandatoryKeys:$a_mandatory_keys];
			 ]"
		end

	objc_font_descriptor_by_adding_attributes_ (an_item: POINTER; a_attributes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item fontDescriptorByAddingAttributes:$a_attributes];
			 ]"
		end

	objc_font_descriptor_with_symbolic_traits_ (an_item: POINTER; a_symbolic_traits: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item fontDescriptorWithSymbolicTraits:$a_symbolic_traits];
			 ]"
		end

	objc_font_descriptor_with_size_ (an_item: POINTER; a_new_point_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item fontDescriptorWithSize:$a_new_point_size];
			 ]"
		end

	objc_font_descriptor_with_matrix_ (an_item: POINTER; a_matrix: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item fontDescriptorWithMatrix:$a_matrix];
			 ]"
		end

	objc_font_descriptor_with_face_ (an_item: POINTER; a_new_face: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item fontDescriptorWithFace:$a_new_face];
			 ]"
		end

	objc_font_descriptor_with_family_ (an_item: POINTER; a_new_family: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontDescriptor *)$an_item fontDescriptorWithFamily:$a_new_family];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_font_attributes_ (a_attributes: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			make_with_pointer (objc_init_with_font_attributes_(allocate_object, a_attributes__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFontDescriptor"
		end

end
