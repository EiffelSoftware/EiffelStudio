note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_OPEN_GL_LAYER

inherit
	CA_LAYER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make,
	make_with_layer_

feature -- CAOpenGLLayer

--	can_draw_in_cgl_context__pixel_format__for_layer_time__display_time_ (a_ctx: UNSUPPORTED_TYPE; a_pf: UNSUPPORTED_TYPE; a_t: REAL_64; a_ts: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ctx__item: POINTER
--			a_pf__item: POINTER
--			a_ts__item: POINTER
--		do
--			if attached a_ctx as a_ctx_attached then
--				a_ctx__item := a_ctx_attached.item
--			end
--			if attached a_pf as a_pf_attached then
--				a_pf__item := a_pf_attached.item
--			end
--			if attached a_ts as a_ts_attached then
--				a_ts__item := a_ts_attached.item
--			end
--			Result := objc_can_draw_in_cgl_context__pixel_format__for_layer_time__display_time_ (item, a_ctx__item, a_pf__item, a_t, a_ts__item)
--		end

--	draw_in_cgl_context__pixel_format__for_layer_time__display_time_ (a_ctx: UNSUPPORTED_TYPE; a_pf: UNSUPPORTED_TYPE; a_t: REAL_64; a_ts: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ctx__item: POINTER
--			a_pf__item: POINTER
--			a_ts__item: POINTER
--		do
--			if attached a_ctx as a_ctx_attached then
--				a_ctx__item := a_ctx_attached.item
--			end
--			if attached a_pf as a_pf_attached then
--				a_pf__item := a_pf_attached.item
--			end
--			if attached a_ts as a_ts_attached then
--				a_ts__item := a_ts_attached.item
--			end
--			objc_draw_in_cgl_context__pixel_format__for_layer_time__display_time_ (item, a_ctx__item, a_pf__item, a_t, a_ts__item)
--		end

--	copy_cgl_pixel_format_for_display_mask_ (a_mask: NATURAL_32): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_copy_cgl_pixel_format_for_display_mask_ (item, a_mask)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like copy_cgl_pixel_format_for_display_mask_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like copy_cgl_pixel_format_for_display_mask_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	release_cgl_pixel_format_ (a_pf: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_pf__item: POINTER
--		do
--			if attached a_pf as a_pf_attached then
--				a_pf__item := a_pf_attached.item
--			end
--			objc_release_cgl_pixel_format_ (item, a_pf__item)
--		end

--	copy_cgl_context_for_pixel_format_ (a_pf: UNSUPPORTED_TYPE): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_pf__item: POINTER
--		do
--			if attached a_pf as a_pf_attached then
--				a_pf__item := a_pf_attached.item
--			end
--			result_pointer := objc_copy_cgl_context_for_pixel_format_ (item, a_pf__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like copy_cgl_context_for_pixel_format_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like copy_cgl_context_for_pixel_format_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	release_cgl_context_ (a_ctx: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ctx__item: POINTER
--		do
--			if attached a_ctx as a_ctx_attached then
--				a_ctx__item := a_ctx_attached.item
--			end
--			objc_release_cgl_context_ (item, a_ctx__item)
--		end

feature {NONE} -- CAOpenGLLayer Externals

--	objc_can_draw_in_cgl_context__pixel_format__for_layer_time__display_time_ (an_item: POINTER; a_ctx: UNSUPPORTED_TYPE; a_pf: UNSUPPORTED_TYPE; a_t: REAL_64; a_ts: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return [(CAOpenGLLayer *)$an_item canDrawInCGLContext: pixelFormat: forLayerTime:$a_t displayTime:];
--			 ]"
--		end

--	objc_draw_in_cgl_context__pixel_format__for_layer_time__display_time_ (an_item: POINTER; a_ctx: UNSUPPORTED_TYPE; a_pf: UNSUPPORTED_TYPE; a_t: REAL_64; a_ts: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(CAOpenGLLayer *)$an_item drawInCGLContext: pixelFormat: forLayerTime:$a_t displayTime:];
--			 ]"
--		end

--	objc_copy_cgl_pixel_format_for_display_mask_ (an_item: POINTER; a_mask: NATURAL_32): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CAOpenGLLayer *)$an_item copyCGLPixelFormatForDisplayMask:$a_mask];
--			 ]"
--		end

--	objc_release_cgl_pixel_format_ (an_item: POINTER; a_pf: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(CAOpenGLLayer *)$an_item releaseCGLPixelFormat:];
--			 ]"
--		end

--	objc_copy_cgl_context_for_pixel_format_ (an_item: POINTER; a_pf: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(CAOpenGLLayer *)$an_item copyCGLContextForPixelFormat:];
--			 ]"
--		end

--	objc_release_cgl_context_ (an_item: POINTER; a_ctx: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <QuartzCore/QuartzCore.h>"
--		alias
--			"[
--				[(CAOpenGLLayer *)$an_item releaseCGLContext:];
--			 ]"
--		end

feature -- Properties

	is_asynchronous: BOOLEAN assign set_asynchronous
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_asynchronous (item)
		end

	set_asynchronous (an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_asynchronous (item, an_arg)
		end

feature {NONE} -- Properties Externals

	objc_is_asynchronous (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				return [(CAOpenGLLayer *)$an_item isAsynchronous];
			 ]"
		end

	objc_set_asynchronous (an_item: POINTER; an_arg: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(CAOpenGLLayer *)$an_item setAsynchronous:$an_arg]
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "CAOpenGLLayer"
		end

end
