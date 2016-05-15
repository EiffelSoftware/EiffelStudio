note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPEN_GL_PIXEL_BUFFER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_texture_target__texture_internal_format__texture_max_mip_map_level__pixels_wide__pixels_high_,
	make

feature {NONE} -- Initialization

	make_with_texture_target__texture_internal_format__texture_max_mip_map_level__pixels_wide__pixels_high_ (a_target: NATURAL_32; a_format: NATURAL_32; a_max_level: INTEGER_32; a_pixels_wide: INTEGER_32; a_pixels_high: INTEGER_32)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_texture_target__texture_internal_format__texture_max_mip_map_level__pixels_wide__pixels_high_(allocate_object, a_target, a_format, a_max_level, a_pixels_wide, a_pixels_high))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_cglp_buffer_obj_ (a_pbuffer: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_pbuffer__item: POINTER
--		do
--			if attached a_pbuffer as a_pbuffer_attached then
--				a_pbuffer__item := a_pbuffer_attached.item
--			end
--			make_with_pointer (objc_init_with_cglp_buffer_obj_(allocate_object, a_pbuffer__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSOpenGLPixelBuffer Externals

	objc_init_with_texture_target__texture_internal_format__texture_max_mip_map_level__pixels_wide__pixels_high_ (an_item: POINTER; a_target: NATURAL_32; a_format: NATURAL_32; a_max_level: INTEGER_32; a_pixels_wide: INTEGER_32; a_pixels_high: INTEGER_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLPixelBuffer *)$an_item initWithTextureTarget:$a_target textureInternalFormat:$a_format textureMaxMipMapLevel:$a_max_level pixelsWide:$a_pixels_wide pixelsHigh:$a_pixels_high];
			 ]"
		end

--	objc_init_with_cglp_buffer_obj_ (an_item: POINTER; a_pbuffer: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSOpenGLPixelBuffer *)$an_item initWithCGLPBufferObj:];
--			 ]"
--		end

--	objc_cglp_buffer_obj (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSOpenGLPixelBuffer *)$an_item CGLPBufferObj];
--			 ]"
--		end

	objc_pixels_wide (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenGLPixelBuffer *)$an_item pixelsWide];
			 ]"
		end

	objc_pixels_high (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenGLPixelBuffer *)$an_item pixelsHigh];
			 ]"
		end

	objc_texture_target (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenGLPixelBuffer *)$an_item textureTarget];
			 ]"
		end

	objc_texture_internal_format (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenGLPixelBuffer *)$an_item textureInternalFormat];
			 ]"
		end

	objc_texture_max_mip_map_level (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenGLPixelBuffer *)$an_item textureMaxMipMapLevel];
			 ]"
		end

feature -- NSOpenGLPixelBuffer

--	cglp_buffer_obj: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_cglp_buffer_obj (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like cglp_buffer_obj} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like cglp_buffer_obj} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	pixels_wide: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pixels_wide (item)
		end

	pixels_high: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pixels_high (item)
		end

	texture_target: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_texture_target (item)
		end

	texture_internal_format: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_texture_internal_format (item)
		end

	texture_max_mip_map_level: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_texture_max_mip_map_level (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOpenGLPixelBuffer"
		end

end
