note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPEN_GL_LAYER

inherit
	CA_OPEN_GL_LAYER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make,
	make_with_layer_

feature -- NSOpenGLLayer

	open_gl_pixel_format_for_display_mask_ (a_mask: NATURAL_32): detachable NS_OPEN_GL_PIXEL_FORMAT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_open_gl_pixel_format_for_display_mask_ (item, a_mask)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like open_gl_pixel_format_for_display_mask_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like open_gl_pixel_format_for_display_mask_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	open_gl_context_for_pixel_format_ (a_pixel_format: detachable NS_OPEN_GL_PIXEL_FORMAT): detachable NS_OPEN_GL_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_pixel_format__item: POINTER
		do
			if attached a_pixel_format as a_pixel_format_attached then
				a_pixel_format__item := a_pixel_format_attached.item
			end
			result_pointer := objc_open_gl_context_for_pixel_format_ (item, a_pixel_format__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like open_gl_context_for_pixel_format_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like open_gl_context_for_pixel_format_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	can_draw_in_open_gl_context__pixel_format__for_layer_time__display_time_ (a_context: detachable NS_OPEN_GL_CONTEXT; a_pixel_format: detachable NS_OPEN_GL_PIXEL_FORMAT; a_t: REAL_64; a_ts: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_context__item: POINTER
--			a_pixel_format__item: POINTER
--			a_ts__item: POINTER
--		do
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			if attached a_pixel_format as a_pixel_format_attached then
--				a_pixel_format__item := a_pixel_format_attached.item
--			end
--			if attached a_ts as a_ts_attached then
--				a_ts__item := a_ts_attached.item
--			end
--			Result := objc_can_draw_in_open_gl_context__pixel_format__for_layer_time__display_time_ (item, a_context__item, a_pixel_format__item, a_t, a_ts__item)
--		end

--	draw_in_open_gl_context__pixel_format__for_layer_time__display_time_ (a_context: detachable NS_OPEN_GL_CONTEXT; a_pixel_format: detachable NS_OPEN_GL_PIXEL_FORMAT; a_t: REAL_64; a_ts: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_context__item: POINTER
--			a_pixel_format__item: POINTER
--			a_ts__item: POINTER
--		do
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			if attached a_pixel_format as a_pixel_format_attached then
--				a_pixel_format__item := a_pixel_format_attached.item
--			end
--			if attached a_ts as a_ts_attached then
--				a_ts__item := a_ts_attached.item
--			end
--			objc_draw_in_open_gl_context__pixel_format__for_layer_time__display_time_ (item, a_context__item, a_pixel_format__item, a_t, a_ts__item)
--		end

feature {NONE} -- NSOpenGLLayer Externals

	objc_open_gl_pixel_format_for_display_mask_ (an_item: POINTER; a_mask: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLLayer *)$an_item openGLPixelFormatForDisplayMask:$a_mask];
			 ]"
		end

	objc_open_gl_context_for_pixel_format_ (an_item: POINTER; a_pixel_format: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLLayer *)$an_item openGLContextForPixelFormat:$a_pixel_format];
			 ]"
		end

--	objc_can_draw_in_open_gl_context__pixel_format__for_layer_time__display_time_ (an_item: POINTER; a_context: POINTER; a_pixel_format: POINTER; a_t: REAL_64; a_ts: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSOpenGLLayer *)$an_item canDrawInOpenGLContext:$a_context pixelFormat:$a_pixel_format forLayerTime:$a_t displayTime:];
--			 ]"
--		end

--	objc_draw_in_open_gl_context__pixel_format__for_layer_time__display_time_ (an_item: POINTER; a_context: POINTER; a_pixel_format: POINTER; a_t: REAL_64; a_ts: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSOpenGLLayer *)$an_item drawInOpenGLContext:$a_context pixelFormat:$a_pixel_format forLayerTime:$a_t displayTime:];
--			 ]"
--		end

feature -- Properties

	view: detachable NS_VIEW assign set_view
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

	set_view (an_arg: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_view (item, an_arg__item)
		end

	open_gl_pixel_format: detachable NS_OPEN_GL_PIXEL_FORMAT assign set_open_gl_pixel_format
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_open_gl_pixel_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like open_gl_pixel_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like open_gl_pixel_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_open_gl_pixel_format (an_arg: detachable NS_OPEN_GL_PIXEL_FORMAT)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_open_gl_pixel_format (item, an_arg__item)
		end

	open_gl_context: detachable NS_OPEN_GL_CONTEXT assign set_open_gl_context
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_open_gl_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like open_gl_context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like open_gl_context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_open_gl_context (an_arg: detachable NS_OPEN_GL_CONTEXT)
			-- Auto generated Objective-C wrapper.
		local
			an_arg__item: POINTER
		do
			if attached an_arg as an_arg_attached then
				an_arg__item := an_arg_attached.item
			end
			objc_set_open_gl_context (item, an_arg__item)
		end

feature {NONE} -- Properties Externals

	objc_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLLayer *)$an_item view];
			 ]"
		end

	objc_set_view (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLLayer *)$an_item setView:$an_arg]
			 ]"
		end

	objc_open_gl_pixel_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLLayer *)$an_item openGLPixelFormat];
			 ]"
		end

	objc_set_open_gl_pixel_format (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLLayer *)$an_item setOpenGLPixelFormat:$an_arg]
			 ]"
		end

	objc_open_gl_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLLayer *)$an_item openGLContext];
			 ]"
		end

	objc_set_open_gl_context (an_item: POINTER; an_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLLayer *)$an_item setOpenGLContext:$an_arg]
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOpenGLLayer"
		end

end
