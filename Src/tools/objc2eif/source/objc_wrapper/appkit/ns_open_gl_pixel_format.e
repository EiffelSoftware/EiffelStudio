note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OPEN_GL_PIXEL_FORMAT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_data_,
	make

feature {NONE} -- Initialization

--	make_with_attributes_ (a_attribs: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_attribs__item: POINTER
--		do
--			if attached a_attribs as a_attribs_attached then
--				a_attribs__item := a_attribs_attached.item
--			end
--			make_with_pointer (objc_init_with_attributes_(allocate_object, a_attribs__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

	make_with_data_ (a_attribs: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_attribs__item: POINTER
		do
			if attached a_attribs as a_attribs_attached then
				a_attribs__item := a_attribs_attached.item
			end
			make_with_pointer (objc_init_with_data_(allocate_object, a_attribs__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_cgl_pixel_format_obj_ (a_format: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_format__item: POINTER
--		do
--			if attached a_format as a_format_attached then
--				a_format__item := a_format_attached.item
--			end
--			make_with_pointer (objc_init_with_cgl_pixel_format_obj_(allocate_object, a_format__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSOpenGLPixelFormat Externals

--	objc_init_with_attributes_ (an_item: POINTER; a_attribs: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSOpenGLPixelFormat *)$an_item initWithAttributes:];
--			 ]"
--		end

	objc_init_with_data_ (an_item: POINTER; a_attribs: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLPixelFormat *)$an_item initWithData:$a_attribs];
			 ]"
		end

--	objc_init_with_cgl_pixel_format_obj_ (an_item: POINTER; a_format: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSOpenGLPixelFormat *)$an_item initWithCGLPixelFormatObj:];
--			 ]"
--		end

	objc_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOpenGLPixelFormat *)$an_item attributes];
			 ]"
		end

	objc_set_attributes_ (an_item: POINTER; a_attribs: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSOpenGLPixelFormat *)$an_item setAttributes:$a_attribs];
			 ]"
		end

--	objc_get_values__for_attribute__for_virtual_screen_ (an_item: POINTER; a_vals: UNSUPPORTED_TYPE; a_attrib: NATURAL_32; a_screen: INTEGER_32)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSOpenGLPixelFormat *)$an_item getValues: forAttribute:$a_attrib forVirtualScreen:$a_screen];
--			 ]"
--		end

	objc_number_of_virtual_screens (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSOpenGLPixelFormat *)$an_item numberOfVirtualScreens];
			 ]"
		end

--	objc_cgl_pixel_format_obj (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSOpenGLPixelFormat *)$an_item CGLPixelFormatObj];
--			 ]"
--		end

feature -- NSOpenGLPixelFormat

	attributes: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attributes_ (a_attribs: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_attribs__item: POINTER
		do
			if attached a_attribs as a_attribs_attached then
				a_attribs__item := a_attribs_attached.item
			end
			objc_set_attributes_ (item, a_attribs__item)
		end

--	get_values__for_attribute__for_virtual_screen_ (a_vals: UNSUPPORTED_TYPE; a_attrib: NATURAL_32; a_screen: INTEGER_32)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_vals__item: POINTER
--		do
--			if attached a_vals as a_vals_attached then
--				a_vals__item := a_vals_attached.item
--			end
--			objc_get_values__for_attribute__for_virtual_screen_ (item, a_vals__item, a_attrib, a_screen)
--		end

	number_of_virtual_screens: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_virtual_screens (item)
		end

--	cgl_pixel_format_obj: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_cgl_pixel_format_obj (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like cgl_pixel_format_obj} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like cgl_pixel_format_obj} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOpenGLPixelFormat"
		end

end
