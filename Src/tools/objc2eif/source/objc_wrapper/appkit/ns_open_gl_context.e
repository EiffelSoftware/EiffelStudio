note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPEN_GL_CONTEXT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_format__share_context_,
	make

feature {NONE} -- Initialization

	make_with_format__share_context_ (a_format: detachable NS_OPEN_GL_PIXEL_FORMAT; a_share: detachable NS_OPEN_GL_CONTEXT)
			-- Initialize `Current'.
		local
			a_format__item: POINTER
			a_share__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			if attached a_share as a_share_attached then
				a_share__item := a_share_attached.item
			end
			make_with_pointer (objc_init_with_format__share_context_(allocate_object, a_format__item, a_share__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_cgl_context_obj_ (a_context: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_context__item: POINTER
--		do
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			make_with_pointer (objc_init_with_cgl_context_obj_(allocate_object, a_context__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSOpenGLContext Externals

	objc_init_with_format__share_context_ (an_item: POINTER; a_format: POINTER; a_share: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLContext *)$an_item initWithFormat:$a_format shareContext:$a_share];
			 ]"
		end

--	objc_init_with_cgl_context_obj_ (an_item: POINTER; a_context: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSOpenGLContext *)$an_item initWithCGLContextObj:];
--			 ]"
--		end

	objc_set_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item setView:$a_view];
			 ]"
		end

	objc_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLContext *)$an_item view];
			 ]"
		end

	objc_set_full_screen (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item setFullScreen];
			 ]"
		end

--	objc_set_off_screen__width__height__rowbytes_ (an_item: POINTER; a_baseaddr: UNSUPPORTED_TYPE; a_width: INTEGER_32; a_height: INTEGER_32; a_rowbytes: INTEGER_32)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSOpenGLContext *)$an_item setOffScreen: width:$a_width height:$a_height rowbytes:$a_rowbytes];
--			 ]"
--		end

	objc_clear_drawable (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item clearDrawable];
			 ]"
		end

	objc_update (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item update];
			 ]"
		end

	objc_flush_buffer (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item flushBuffer];
			 ]"
		end

	objc_make_current_context (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item makeCurrentContext];
			 ]"
		end

	objc_copy_attributes_from_context__with_mask_ (an_item: POINTER; a_context: POINTER; a_mask: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item copyAttributesFromContext:$a_context withMask:$a_mask];
			 ]"
		end

--	objc_set_values__for_parameter_ (an_item: POINTER; a_vals: UNSUPPORTED_TYPE; a_param: INTEGER_32)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSOpenGLContext *)$an_item setValues: forParameter:$a_param];
--			 ]"
--		end

--	objc_get_values__for_parameter_ (an_item: POINTER; a_vals: UNSUPPORTED_TYPE; a_param: INTEGER_32)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSOpenGLContext *)$an_item getValues: forParameter:$a_param];
--			 ]"
--		end

	objc_set_current_virtual_screen_ (an_item: POINTER; a_screen: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item setCurrentVirtualScreen:$a_screen];
			 ]"
		end

	objc_current_virtual_screen (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenGLContext *)$an_item currentVirtualScreen];
			 ]"
		end

	objc_create_texture__from_view__internal_format_ (an_item: POINTER; a_target: NATURAL_32; a_view: POINTER; a_format: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item createTexture:$a_target fromView:$a_view internalFormat:$a_format];
			 ]"
		end

--	objc_cgl_context_obj (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSOpenGLContext *)$an_item CGLContextObj];
--			 ]"
--		end

	objc_set_pixel_buffer__cube_map_face__mip_map_level__current_virtual_screen_ (an_item: POINTER; a_pixel_buffer: POINTER; a_face: NATURAL_32; a_level: INTEGER_32; a_screen: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item setPixelBuffer:$a_pixel_buffer cubeMapFace:$a_face mipMapLevel:$a_level currentVirtualScreen:$a_screen];
			 ]"
		end

	objc_pixel_buffer (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLContext *)$an_item pixelBuffer];
			 ]"
		end

	objc_pixel_buffer_cube_map_face (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenGLContext *)$an_item pixelBufferCubeMapFace];
			 ]"
		end

	objc_pixel_buffer_mip_map_level (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenGLContext *)$an_item pixelBufferMipMapLevel];
			 ]"
		end

	objc_set_texture_image_to_pixel_buffer__color_buffer_ (an_item: POINTER; a_pixel_buffer: POINTER; a_source: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLContext *)$an_item setTextureImageToPixelBuffer:$a_pixel_buffer colorBuffer:$a_source];
			 ]"
		end

feature -- NSOpenGLContext

	set_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_view_ (item, a_view__item)
		end

	view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_full_screen
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_full_screen (item)
		end

--	set_off_screen__width__height__rowbytes_ (a_baseaddr: UNSUPPORTED_TYPE; a_width: INTEGER_32; a_height: INTEGER_32; a_rowbytes: INTEGER_32)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_baseaddr__item: POINTER
--		do
--			if attached a_baseaddr as a_baseaddr_attached then
--				a_baseaddr__item := a_baseaddr_attached.item
--			end
--			objc_set_off_screen__width__height__rowbytes_ (item, a_baseaddr__item, a_width, a_height, a_rowbytes)
--		end

	clear_drawable
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_clear_drawable (item)
		end

	update
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update (item)
		end

	flush_buffer
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_flush_buffer (item)
		end

	make_current_context
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_make_current_context (item)
		end

	copy_attributes_from_context__with_mask_ (a_context: detachable NS_OPEN_GL_CONTEXT; a_mask: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_context__item: POINTER
		do
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			objc_copy_attributes_from_context__with_mask_ (item, a_context__item, a_mask)
		end

--	set_values__for_parameter_ (a_vals: UNSUPPORTED_TYPE; a_param: INTEGER_32)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_vals__item: POINTER
--		do
--			if attached a_vals as a_vals_attached then
--				a_vals__item := a_vals_attached.item
--			end
--			objc_set_values__for_parameter_ (item, a_vals__item, a_param)
--		end

--	get_values__for_parameter_ (a_vals: UNSUPPORTED_TYPE; a_param: INTEGER_32)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_vals__item: POINTER
--		do
--			if attached a_vals as a_vals_attached then
--				a_vals__item := a_vals_attached.item
--			end
--			objc_get_values__for_parameter_ (item, a_vals__item, a_param)
--		end

	set_current_virtual_screen_ (a_screen: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_current_virtual_screen_ (item, a_screen)
		end

	current_virtual_screen: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_virtual_screen (item)
		end

	create_texture__from_view__internal_format_ (a_target: NATURAL_32; a_view: detachable NS_VIEW; a_format: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_create_texture__from_view__internal_format_ (item, a_target, a_view__item, a_format)
		end

--	cgl_context_obj: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_cgl_context_obj (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like cgl_context_obj} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like cgl_context_obj} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_pixel_buffer__cube_map_face__mip_map_level__current_virtual_screen_ (a_pixel_buffer: detachable NS_OPEN_GL_PIXEL_BUFFER; a_face: NATURAL_32; a_level: INTEGER_32; a_screen: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		local
			a_pixel_buffer__item: POINTER
		do
			if attached a_pixel_buffer as a_pixel_buffer_attached then
				a_pixel_buffer__item := a_pixel_buffer_attached.item
			end
			objc_set_pixel_buffer__cube_map_face__mip_map_level__current_virtual_screen_ (item, a_pixel_buffer__item, a_face, a_level, a_screen)
		end

	pixel_buffer: detachable NS_OPEN_GL_PIXEL_BUFFER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_pixel_buffer (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pixel_buffer} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pixel_buffer} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	pixel_buffer_cube_map_face: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pixel_buffer_cube_map_face (item)
		end

	pixel_buffer_mip_map_level: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pixel_buffer_mip_map_level (item)
		end

	set_texture_image_to_pixel_buffer__color_buffer_ (a_pixel_buffer: detachable NS_OPEN_GL_PIXEL_BUFFER; a_source: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_pixel_buffer__item: POINTER
		do
			if attached a_pixel_buffer as a_pixel_buffer_attached then
				a_pixel_buffer__item := a_pixel_buffer_attached.item
			end
			objc_set_texture_image_to_pixel_buffer__color_buffer_ (item, a_pixel_buffer__item, a_source)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOpenGLContext"
		end

end
