note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPEN_GL_VIEW

inherit
	NS_VIEW
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame__pixel_format_,
	make_with_frame_,
	make

feature {NONE} -- Initialization

	make_with_frame__pixel_format_ (a_frame_rect: NS_RECT; a_format: detachable NS_OPEN_GL_PIXEL_FORMAT)
			-- Initialize `Current'.
		local
			a_format__item: POINTER
		do
			if attached a_format as a_format_attached then
				a_format__item := a_format_attached.item
			end
			make_with_pointer (objc_init_with_frame__pixel_format_(allocate_object, a_frame_rect.item, a_format__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSOpenGLView Externals

	objc_init_with_frame__pixel_format_ (an_item: POINTER; a_frame_rect: POINTER; a_format: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLView *)$an_item initWithFrame:*((NSRect *)$a_frame_rect) pixelFormat:$a_format];
			 ]"
		end

	objc_set_open_gl_context_ (an_item: POINTER; a_context: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLView *)$an_item setOpenGLContext:$a_context];
			 ]"
		end

	objc_open_gl_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLView *)$an_item openGLContext];
			 ]"
		end

	objc_clear_gl_context (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLView *)$an_item clearGLContext];
			 ]"
		end

	objc_update (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLView *)$an_item update];
			 ]"
		end

	objc_reshape (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLView *)$an_item reshape];
			 ]"
		end

	objc_set_pixel_format_ (an_item: POINTER; a_pixel_format: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLView *)$an_item setPixelFormat:$a_pixel_format];
			 ]"
		end

	objc_pixel_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLView *)$an_item pixelFormat];
			 ]"
		end

	objc_prepare_open_gl (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLView *)$an_item prepareOpenGL];
			 ]"
		end

feature -- NSOpenGLView

	set_open_gl_context_ (a_context: detachable NS_OPEN_GL_CONTEXT)
			-- Auto generated Objective-C wrapper.
		local
			a_context__item: POINTER
		do
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			objc_set_open_gl_context_ (item, a_context__item)
		end

	open_gl_context: detachable NS_OPEN_GL_CONTEXT
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

	clear_gl_context
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_clear_gl_context (item)
		end

	update
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update (item)
		end

	reshape
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reshape (item)
		end

	set_pixel_format_ (a_pixel_format: detachable NS_OPEN_GL_PIXEL_FORMAT)
			-- Auto generated Objective-C wrapper.
		local
			a_pixel_format__item: POINTER
		do
			if attached a_pixel_format as a_pixel_format_attached then
				a_pixel_format__item := a_pixel_format_attached.item
			end
			objc_set_pixel_format_ (item, a_pixel_format__item)
		end

	pixel_format: detachable NS_OPEN_GL_PIXEL_FORMAT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_pixel_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like pixel_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like pixel_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	prepare_open_gl
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_prepare_open_gl (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOpenGLView"
		end

end
