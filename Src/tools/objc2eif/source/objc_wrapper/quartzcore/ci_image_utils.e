note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CI_IMAGE_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- CIImage

--	image_with_cg_image_ (a_image: UNSUPPORTED_TYPE): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_image__item: POINTER
--		do
--			if attached a_image as a_image_attached then
--				a_image__item := a_image_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_cg_image_ (l_objc_class.item, a_image__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_cg_image_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_cg_image_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	image_with_cg_image__options_ (a_image: UNSUPPORTED_TYPE; a_d: detachable NS_DICTIONARY): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_image__item: POINTER
--			a_d__item: POINTER
--		do
--			if attached a_image as a_image_attached then
--				a_image__item := a_image_attached.item
--			end
--			if attached a_d as a_d_attached then
--				a_d__item := a_d_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_cg_image__options_ (l_objc_class.item, a_image__item, a_d__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_cg_image__options_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_cg_image__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	image_with_cg_layer_ (a_layer: UNSUPPORTED_TYPE): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_layer__item: POINTER
--		do
--			if attached a_layer as a_layer_attached then
--				a_layer__item := a_layer_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_cg_layer_ (l_objc_class.item, a_layer__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_cg_layer_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_cg_layer_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	image_with_cg_layer__options_ (a_layer: UNSUPPORTED_TYPE; a_d: detachable NS_DICTIONARY): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_layer__item: POINTER
--			a_d__item: POINTER
--		do
--			if attached a_layer as a_layer_attached then
--				a_layer__item := a_layer_attached.item
--			end
--			if attached a_d as a_d_attached then
--				a_d__item := a_d_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_cg_layer__options_ (l_objc_class.item, a_layer__item, a_d__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_cg_layer__options_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_cg_layer__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	image_with_bitmap_data__bytes_per_row__size__format__color_space_ (a_d: detachable NS_DATA; a_bpr: NATURAL_64; a_size: CG_SIZE; a_f: INTEGER_32; a_cs: UNSUPPORTED_TYPE): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_d__item: POINTER
--			a_cs__item: POINTER
--		do
--			if attached a_d as a_d_attached then
--				a_d__item := a_d_attached.item
--			end
--			if attached a_cs as a_cs_attached then
--				a_cs__item := a_cs_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_bitmap_data__bytes_per_row__size__format__color_space_ (l_objc_class.item, a_d__item, a_bpr, a_size.item, a_f, a_cs__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_bitmap_data__bytes_per_row__size__format__color_space_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_bitmap_data__bytes_per_row__size__format__color_space_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	image_with_texture__size__flipped__color_space_ (a_name: NATURAL_32; a_size: CG_SIZE; a_flag: BOOLEAN; a_cs: UNSUPPORTED_TYPE): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_cs__item: POINTER
--		do
--			if attached a_cs as a_cs_attached then
--				a_cs__item := a_cs_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_texture__size__flipped__color_space_ (l_objc_class.item, a_name, a_size.item, a_flag, a_cs__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_texture__size__flipped__color_space_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_texture__size__flipped__color_space_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	image_with_contents_of_ur_l_ (a_url: detachable NS_URL): detachable CI_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_image_with_contents_of_ur_l_ (l_objc_class.item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_with_contents_of_ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_with_contents_of_ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	image_with_contents_of_ur_l__options_ (a_url: detachable NS_URL; a_d: detachable NS_DICTIONARY): detachable CI_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_url__item: POINTER
			a_d__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			if attached a_d as a_d_attached then
				a_d__item := a_d_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_image_with_contents_of_ur_l__options_ (l_objc_class.item, a_url__item, a_d__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_with_contents_of_ur_l__options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_with_contents_of_ur_l__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	image_with_data_ (a_data: detachable NS_DATA): detachable CI_IMAGE
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
			result_pointer := objc_image_with_data_ (l_objc_class.item, a_data__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_with_data_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_with_data_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	image_with_data__options_ (a_data: detachable NS_DATA; a_d: detachable NS_DICTIONARY): detachable CI_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_data__item: POINTER
			a_d__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_d as a_d_attached then
				a_d__item := a_d_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_image_with_data__options_ (l_objc_class.item, a_data__item, a_d__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_with_data__options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_with_data__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	image_with_cv_image_buffer_ (a_image_buffer: UNSUPPORTED_TYPE): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_image_buffer__item: POINTER
--		do
--			if attached a_image_buffer as a_image_buffer_attached then
--				a_image_buffer__item := a_image_buffer_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_cv_image_buffer_ (l_objc_class.item, a_image_buffer__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_cv_image_buffer_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_cv_image_buffer_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	image_with_cv_image_buffer__options_ (a_image_buffer: UNSUPPORTED_TYPE; a_dict: detachable NS_DICTIONARY): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_image_buffer__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_image_buffer as a_image_buffer_attached then
--				a_image_buffer__item := a_image_buffer_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_cv_image_buffer__options_ (l_objc_class.item, a_image_buffer__item, a_dict__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_cv_image_buffer__options_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_cv_image_buffer__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	image_with_io_surface_ (a_surface: UNSUPPORTED_TYPE): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_surface__item: POINTER
--		do
--			if attached a_surface as a_surface_attached then
--				a_surface__item := a_surface_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_io_surface_ (l_objc_class.item, a_surface__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_io_surface_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_io_surface_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	image_with_io_surface__options_ (a_surface: UNSUPPORTED_TYPE; a_d: detachable NS_DICTIONARY): detachable CI_IMAGE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_surface__item: POINTER
--			a_d__item: POINTER
--		do
--			if attached a_surface as a_surface_attached then
--				a_surface__item := a_surface_attached.item
--			end
--			if attached a_d as a_d_attached then
--				a_d__item := a_d_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_image_with_io_surface__options_ (l_objc_class.item, a_surface__item, a_d__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like image_with_io_surface__options_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like image_with_io_surface__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	image_with_color_ (a_color: detachable CI_COLOR): detachable CI_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_image_with_color_ (l_objc_class.item, a_color__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_with_color_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_with_color_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	empty_image: detachable CI_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_empty_image (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like empty_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like empty_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- CIImage Externals

--	objc_image_with_cg_image_ (a_class_object: POINTER; a_image: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithCGImage:];
--			 ]"
--		end

--	objc_image_with_cg_image__options_ (a_class_object: POINTER; a_image: UNSUPPORTED_TYPE; a_d: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithCGImage: options:$a_d];
--			 ]"
--		end

--	objc_image_with_cg_layer_ (a_class_object: POINTER; a_layer: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithCGLayer:];
--			 ]"
--		end

--	objc_image_with_cg_layer__options_ (a_class_object: POINTER; a_layer: UNSUPPORTED_TYPE; a_d: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithCGLayer: options:$a_d];
--			 ]"
--		end

--	objc_image_with_bitmap_data__bytes_per_row__size__format__color_space_ (a_class_object: POINTER; a_d: POINTER; a_bpr: NATURAL_64; a_size: POINTER; a_f: INTEGER_32; a_cs: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithBitmapData:$a_d bytesPerRow:$a_bpr size:*((CGSize *)$a_size) format:$a_f colorSpace:];
--			 ]"
--		end

--	objc_image_with_texture__size__flipped__color_space_ (a_class_object: POINTER; a_name: NATURAL_32; a_size: POINTER; a_flag: BOOLEAN; a_cs: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithTexture:$a_name size:*((CGSize *)$a_size) flipped:$a_flag colorSpace:];
--			 ]"
--		end

	objc_image_with_contents_of_ur_l_ (a_class_object: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object imageWithContentsOfURL:$a_url];
			 ]"
		end

	objc_image_with_contents_of_ur_l__options_ (a_class_object: POINTER; a_url: POINTER; a_d: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object imageWithContentsOfURL:$a_url options:$a_d];
			 ]"
		end

	objc_image_with_data_ (a_class_object: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object imageWithData:$a_data];
			 ]"
		end

	objc_image_with_data__options_ (a_class_object: POINTER; a_data: POINTER; a_d: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object imageWithData:$a_data options:$a_d];
			 ]"
		end

--	objc_image_with_cv_image_buffer_ (a_class_object: POINTER; a_image_buffer: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithCVImageBuffer:];
--			 ]"
--		end

--	objc_image_with_cv_image_buffer__options_ (a_class_object: POINTER; a_image_buffer: UNSUPPORTED_TYPE; a_dict: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithCVImageBuffer: options:$a_dict];
--			 ]"
--		end

--	objc_image_with_io_surface_ (a_class_object: POINTER; a_surface: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithIOSurface:];
--			 ]"
--		end

--	objc_image_with_io_surface__options_ (a_class_object: POINTER; a_surface: UNSUPPORTED_TYPE; a_d: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object imageWithIOSurface: options:$a_d];
--			 ]"
--		end

	objc_image_with_color_ (a_class_object: POINTER; a_color: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object imageWithColor:$a_color];
			 ]"
		end

	objc_empty_image (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object emptyImage];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "CIImage"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
