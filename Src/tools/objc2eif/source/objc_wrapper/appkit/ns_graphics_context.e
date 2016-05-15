note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GRAPHICS_CONTEXT

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSGraphicsContext

	attributes: detachable NS_DICTIONARY
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

	is_drawing_to_screen: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_drawing_to_screen (item)
		end

	flush_graphics
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_flush_graphics (item)
		end

--	graphics_port: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_graphics_port (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like graphics_port} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like graphics_port} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	is_flipped: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_flipped (item)
		end

feature {NONE} -- NSGraphicsContext Externals

	objc_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSGraphicsContext *)$an_item attributes];
			 ]"
		end

	objc_is_drawing_to_screen (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSGraphicsContext *)$an_item isDrawingToScreen];
			 ]"
		end

	objc_flush_graphics (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGraphicsContext *)$an_item flushGraphics];
			 ]"
		end

--	objc_graphics_port (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSGraphicsContext *)$an_item graphicsPort];
--			 ]"
--		end

	objc_is_flipped (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSGraphicsContext *)$an_item isFlipped];
			 ]"
		end

feature -- NSGraphicsContext_RenderingOptions

	set_should_antialias_ (a_antialias: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_should_antialias_ (item, a_antialias)
		end

	should_antialias: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_antialias (item)
		end

	set_image_interpolation_ (a_interpolation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_image_interpolation_ (item, a_interpolation)
		end

	image_interpolation: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_image_interpolation (item)
		end

	set_pattern_phase_ (a_phase: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_pattern_phase_ (item, a_phase.item)
		end

	pattern_phase: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_pattern_phase (item, Result.item)
		end

	set_compositing_operation_ (a_operation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_compositing_operation_ (item, a_operation)
		end

	compositing_operation: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_compositing_operation (item)
		end

	color_rendering_intent: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_color_rendering_intent (item)
		end

	set_color_rendering_intent_ (a_rendering_intent: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_color_rendering_intent_ (item, a_rendering_intent)
		end

feature {NONE} -- NSGraphicsContext_RenderingOptions Externals

	objc_set_should_antialias_ (an_item: POINTER; a_antialias: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGraphicsContext *)$an_item setShouldAntialias:$a_antialias];
			 ]"
		end

	objc_should_antialias (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSGraphicsContext *)$an_item shouldAntialias];
			 ]"
		end

	objc_set_image_interpolation_ (an_item: POINTER; a_interpolation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGraphicsContext *)$an_item setImageInterpolation:$a_interpolation];
			 ]"
		end

	objc_image_interpolation (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSGraphicsContext *)$an_item imageInterpolation];
			 ]"
		end

	objc_set_pattern_phase_ (an_item: POINTER; a_phase: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGraphicsContext *)$an_item setPatternPhase:*((NSPoint *)$a_phase)];
			 ]"
		end

	objc_pattern_phase (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSGraphicsContext *)$an_item patternPhase];
			 ]"
		end

	objc_set_compositing_operation_ (an_item: POINTER; a_operation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGraphicsContext *)$an_item setCompositingOperation:$a_operation];
			 ]"
		end

	objc_compositing_operation (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSGraphicsContext *)$an_item compositingOperation];
			 ]"
		end

	objc_color_rendering_intent (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSGraphicsContext *)$an_item colorRenderingIntent];
			 ]"
		end

	objc_set_color_rendering_intent_ (an_item: POINTER; a_rendering_intent: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSGraphicsContext *)$an_item setColorRenderingIntent:$a_rendering_intent];
			 ]"
		end

feature -- NSQuartzCoreAdditions

--	ci_context: detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_ci_context (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like ci_context} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like ci_context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSQuartzCoreAdditions Externals

--	objc_ci_context (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSGraphicsContext *)$an_item CIContext];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSGraphicsContext"
		end

end
