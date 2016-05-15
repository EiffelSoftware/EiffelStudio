note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CI_IMAGE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_data_,
	make_with_data__options_,
	make_with_contents_of_ur_l_,
	make_with_contents_of_ur_l__options_,
	make_with_color_,
	make

feature {NONE} -- Initialization

--	make_with_cg_image_ (a_image: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_image__item: POINTER
--		do
--			if attached a_image as a_image_attached then
--				a_image__item := a_image_attached.item
--			end
--			make_with_pointer (objc_init_with_cg_image_(allocate_object, a_image__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_cg_image__options_ (a_image: UNSUPPORTED_TYPE; a_d: detachable NS_DICTIONARY)
--			-- Initialize `Current'.
--		local
--			a_image__item: POINTER
--			a_d__item: POINTER
--		do
--			if attached a_image as a_image_attached then
--				a_image__item := a_image_attached.item
--			end
--			if attached a_d as a_d_attached then
--				a_d__item := a_d_attached.item
--			end
--			make_with_pointer (objc_init_with_cg_image__options_(allocate_object, a_image__item, a_d__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_cg_layer_ (a_layer: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_layer__item: POINTER
--		do
--			if attached a_layer as a_layer_attached then
--				a_layer__item := a_layer_attached.item
--			end
--			make_with_pointer (objc_init_with_cg_layer_(allocate_object, a_layer__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_cg_layer__options_ (a_layer: UNSUPPORTED_TYPE; a_d: detachable NS_DICTIONARY)
--			-- Initialize `Current'.
--		local
--			a_layer__item: POINTER
--			a_d__item: POINTER
--		do
--			if attached a_layer as a_layer_attached then
--				a_layer__item := a_layer_attached.item
--			end
--			if attached a_d as a_d_attached then
--				a_d__item := a_d_attached.item
--			end
--			make_with_pointer (objc_init_with_cg_layer__options_(allocate_object, a_layer__item, a_d__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_data_ (a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_data_(allocate_object, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_data__options_ (a_data: detachable NS_DATA; a_d: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
			a_d__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			if attached a_d as a_d_attached then
				a_d__item := a_d_attached.item
			end
			make_with_pointer (objc_init_with_data__options_(allocate_object, a_data__item, a_d__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_bitmap_data__bytes_per_row__size__format__color_space_ (a_d: detachable NS_DATA; a_bpr: NATURAL_64; a_size: CG_SIZE; a_f: INTEGER_32; a_c: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_d__item: POINTER
--			a_c__item: POINTER
--		do
--			if attached a_d as a_d_attached then
--				a_d__item := a_d_attached.item
--			end
--			if attached a_c as a_c_attached then
--				a_c__item := a_c_attached.item
--			end
--			make_with_pointer (objc_init_with_bitmap_data__bytes_per_row__size__format__color_space_(allocate_object, a_d__item, a_bpr, a_size.item, a_f, a_c__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_texture__size__flipped__color_space_ (a_name: NATURAL_32; a_size: CG_SIZE; a_flag: BOOLEAN; a_cs: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_cs__item: POINTER
--		do
--			if attached a_cs as a_cs_attached then
--				a_cs__item := a_cs_attached.item
--			end
--			make_with_pointer (objc_init_with_texture__size__flipped__color_space_(allocate_object, a_name, a_size.item, a_flag, a_cs__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_contents_of_ur_l_ (a_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_ur_l_(allocate_object, a_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_contents_of_ur_l__options_ (a_url: detachable NS_URL; a_d: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
			a_d__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			if attached a_d as a_d_attached then
				a_d__item := a_d_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_ur_l__options_(allocate_object, a_url__item, a_d__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_io_surface_ (a_surface: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_surface__item: POINTER
--		do
--			if attached a_surface as a_surface_attached then
--				a_surface__item := a_surface_attached.item
--			end
--			make_with_pointer (objc_init_with_io_surface_(allocate_object, a_surface__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_io_surface__options_ (a_surface: UNSUPPORTED_TYPE; a_d: detachable NS_DICTIONARY)
--			-- Initialize `Current'.
--		local
--			a_surface__item: POINTER
--			a_d__item: POINTER
--		do
--			if attached a_surface as a_surface_attached then
--				a_surface__item := a_surface_attached.item
--			end
--			if attached a_d as a_d_attached then
--				a_d__item := a_d_attached.item
--			end
--			make_with_pointer (objc_init_with_io_surface__options_(allocate_object, a_surface__item, a_d__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_cv_image_buffer_ (a_image_buffer: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_image_buffer__item: POINTER
--		do
--			if attached a_image_buffer as a_image_buffer_attached then
--				a_image_buffer__item := a_image_buffer_attached.item
--			end
--			make_with_pointer (objc_init_with_cv_image_buffer_(allocate_object, a_image_buffer__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_cv_image_buffer__options_ (a_image_buffer: UNSUPPORTED_TYPE; a_dict: detachable NS_DICTIONARY)
--			-- Initialize `Current'.
--		local
--			a_image_buffer__item: POINTER
--			a_dict__item: POINTER
--		do
--			if attached a_image_buffer as a_image_buffer_attached then
--				a_image_buffer__item := a_image_buffer_attached.item
--			end
--			if attached a_dict as a_dict_attached then
--				a_dict__item := a_dict_attached.item
--			end
--			make_with_pointer (objc_init_with_cv_image_buffer__options_(allocate_object, a_image_buffer__item, a_dict__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_color_ (a_color: detachable CI_COLOR)
			-- Initialize `Current'.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			make_with_pointer (objc_init_with_color_(allocate_object, a_color__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- CIImage Externals

--	objc_init_with_cg_image_ (an_item: POINTER; a_image: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithCGImage:];
--			 ]"
--		end

--	objc_init_with_cg_image__options_ (an_item: POINTER; a_image: UNSUPPORTED_TYPE; a_d: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithCGImage: options:$a_d];
--			 ]"
--		end

--	objc_init_with_cg_layer_ (an_item: POINTER; a_layer: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithCGLayer:];
--			 ]"
--		end

--	objc_init_with_cg_layer__options_ (an_item: POINTER; a_layer: UNSUPPORTED_TYPE; a_d: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithCGLayer: options:$a_d];
--			 ]"
--		end

	objc_init_with_data_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIImage *)$an_item initWithData:$a_data];
			 ]"
		end

	objc_init_with_data__options_ (an_item: POINTER; a_data: POINTER; a_d: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIImage *)$an_item initWithData:$a_data options:$a_d];
			 ]"
		end

--	objc_init_with_bitmap_data__bytes_per_row__size__format__color_space_ (an_item: POINTER; a_d: POINTER; a_bpr: NATURAL_64; a_size: POINTER; a_f: INTEGER_32; a_c: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithBitmapData:$a_d bytesPerRow:$a_bpr size:*((CGSize *)$a_size) format:$a_f colorSpace:];
--			 ]"
--		end

--	objc_init_with_texture__size__flipped__color_space_ (an_item: POINTER; a_name: NATURAL_32; a_size: POINTER; a_flag: BOOLEAN; a_cs: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithTexture:$a_name size:*((CGSize *)$a_size) flipped:$a_flag colorSpace:];
--			 ]"
--		end

	objc_init_with_contents_of_ur_l_ (an_item: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIImage *)$an_item initWithContentsOfURL:$a_url];
			 ]"
		end

	objc_init_with_contents_of_ur_l__options_ (an_item: POINTER; a_url: POINTER; a_d: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIImage *)$an_item initWithContentsOfURL:$a_url options:$a_d];
			 ]"
		end

--	objc_init_with_io_surface_ (an_item: POINTER; a_surface: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithIOSurface:];
--			 ]"
--		end

--	objc_init_with_io_surface__options_ (an_item: POINTER; a_surface: UNSUPPORTED_TYPE; a_d: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithIOSurface: options:$a_d];
--			 ]"
--		end

--	objc_init_with_cv_image_buffer_ (an_item: POINTER; a_image_buffer: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithCVImageBuffer:];
--			 ]"
--		end

--	objc_init_with_cv_image_buffer__options_ (an_item: POINTER; a_image_buffer: UNSUPPORTED_TYPE; a_dict: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item initWithCVImageBuffer: options:$a_dict];
--			 ]"
--		end

	objc_init_with_color_ (an_item: POINTER; a_color: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIImage *)$an_item initWithColor:$a_color];
			 ]"
		end

	objc_image_by_applying_transform_ (an_item: POINTER; a_matrix: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIImage *)$an_item imageByApplyingTransform:*((CGAffineTransform *)$a_matrix)];
			 ]"
		end

	objc_image_by_cropping_to_rect_ (an_item: POINTER; a_r: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIImage *)$an_item imageByCroppingToRect:*((CGRect *)$a_r)];
			 ]"
		end

	objc_extent (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				*(CGRect *)$result_pointer = [(CIImage *)$an_item extent];
			 ]"
		end

--	objc_definition (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item definition];
--			 ]"
--		end

	objc_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return (EIF_POINTER)[(CIImage *)$an_item url];
			 ]"
		end

--	objc_color_space (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CIImage *)$an_item colorSpace];
--			 ]"
--		end

feature -- CIImage

	image_by_applying_transform_ (a_matrix: CG_AFFINE_TRANSFORM): detachable CI_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_image_by_applying_transform_ (item, a_matrix.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_by_applying_transform_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_by_applying_transform_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	image_by_cropping_to_rect_ (a_r: CG_RECT): detachable CI_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_image_by_cropping_to_rect_ (item, a_r.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_by_cropping_to_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_by_cropping_to_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	extent: CG_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_extent (item, Result.item)
		end

--	definition: detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_definition (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like definition} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like definition} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	color_space: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_color_space (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like color_space} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like color_space} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "CIImage"
		end

end
