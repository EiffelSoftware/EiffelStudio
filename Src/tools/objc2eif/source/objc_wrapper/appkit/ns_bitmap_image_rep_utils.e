note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BITMAP_IMAGE_REP_UTILS

inherit
	NS_IMAGE_REP_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSBitmapImageRep

	image_reps_with_data_ (a_data: detachable NS_DATA): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_image_reps_with_data_ (l_objc_class.item, a_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_reps_with_data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_reps_with_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	image_rep_with_data_ (a_data: detachable NS_DATA): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_image_rep_with_data_ (l_objc_class.item, a_data__item)
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

	tiff_representation_of_image_reps_in_array_ (a_array: detachable NS_ARRAY): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_tiff_representation_of_image_reps_in_array_ (l_objc_class.item, a_array__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tiff_representation_of_image_reps_in_array_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tiff_representation_of_image_reps_in_array_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	tiff_representation_of_image_reps_in_array__using_compression__factor_ (a_array: detachable NS_ARRAY; a_comp: NATURAL_64; a_factor: REAL_32): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_array__item: POINTER
		do
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_tiff_representation_of_image_reps_in_array__using_compression__factor_ (l_objc_class.item, a_array__item, a_comp, a_factor)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tiff_representation_of_image_reps_in_array__using_compression__factor_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tiff_representation_of_image_reps_in_array__using_compression__factor_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	get_tiff_compression_types__count_ (a_list: UNSUPPORTED_TYPE; a_num_types: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--			a_list__item: POINTER
--			a_num_types__item: POINTER
--		do
--			if attached a_list as a_list_attached then
--				a_list__item := a_list_attached.item
--			end
--			if attached a_num_types as a_num_types_attached then
--				a_num_types__item := a_num_types_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			objc_get_tiff_compression_types__count_ (l_objc_class.item, a_list__item, a_num_types__item)
--		end

	localized_name_for_tiff_compression_type_ (a_compression: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_localized_name_for_tiff_compression_type_ (l_objc_class.item, a_compression)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_name_for_tiff_compression_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_name_for_tiff_compression_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSBitmapImageRep Externals

	objc_image_reps_with_data_ (a_class_object: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object imageRepsWithData:$a_data];
			 ]"
		end

	objc_image_rep_with_data_ (a_class_object: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object imageRepWithData:$a_data];
			 ]"
		end

	objc_tiff_representation_of_image_reps_in_array_ (a_class_object: POINTER; a_array: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object TIFFRepresentationOfImageRepsInArray:$a_array];
			 ]"
		end

	objc_tiff_representation_of_image_reps_in_array__using_compression__factor_ (a_class_object: POINTER; a_array: POINTER; a_comp: NATURAL_64; a_factor: REAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object TIFFRepresentationOfImageRepsInArray:$a_array usingCompression:$a_comp factor:$a_factor];
			 ]"
		end

--	objc_get_tiff_compression_types__count_ (a_class_object: POINTER; a_list: UNSUPPORTED_TYPE; a_num_types: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(Class)$a_class_object getTIFFCompressionTypes: count:];
--			 ]"
--		end

	objc_localized_name_for_tiff_compression_type_ (a_class_object: POINTER; a_compression: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object localizedNameForTIFFCompressionType:$a_compression];
			 ]"
		end

feature -- NSBitmapImageFileTypeExtensions

	representation_of_image_reps_in_array__using_type__properties_ (a_image_reps: detachable NS_ARRAY; a_storage_type: NATURAL_64; a_properties: detachable NS_DICTIONARY): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_image_reps__item: POINTER
			a_properties__item: POINTER
		do
			if attached a_image_reps as a_image_reps_attached then
				a_image_reps__item := a_image_reps_attached.item
			end
			if attached a_properties as a_properties_attached then
				a_properties__item := a_properties_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_representation_of_image_reps_in_array__using_type__properties_ (l_objc_class.item, a_image_reps__item, a_storage_type, a_properties__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like representation_of_image_reps_in_array__using_type__properties_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like representation_of_image_reps_in_array__using_type__properties_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSBitmapImageFileTypeExtensions Externals

	objc_representation_of_image_reps_in_array__using_type__properties_ (a_class_object: POINTER; a_image_reps: POINTER; a_storage_type: NATURAL_64; a_properties: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object representationOfImageRepsInArray:$a_image_reps usingType:$a_storage_type properties:$a_properties];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBitmapImageRep"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
