note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GRAPHICS_CONTEXT_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSGraphicsContext

	graphics_context_with_attributes_ (a_attributes: detachable NS_DICTIONARY): detachable NS_GRAPHICS_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_graphics_context_with_attributes_ (l_objc_class.item, a_attributes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like graphics_context_with_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like graphics_context_with_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	graphics_context_with_window_ (a_window: detachable NS_WINDOW): detachable NS_GRAPHICS_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_graphics_context_with_window_ (l_objc_class.item, a_window__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like graphics_context_with_window_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like graphics_context_with_window_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	graphics_context_with_bitmap_image_rep_ (a_bitmap_rep: detachable NS_BITMAP_IMAGE_REP): detachable NS_GRAPHICS_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_bitmap_rep__item: POINTER
		do
			if attached a_bitmap_rep as a_bitmap_rep_attached then
				a_bitmap_rep__item := a_bitmap_rep_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_graphics_context_with_bitmap_image_rep_ (l_objc_class.item, a_bitmap_rep__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like graphics_context_with_bitmap_image_rep_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like graphics_context_with_bitmap_image_rep_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	graphics_context_with_graphics_port__flipped_ (a_graphics_port: UNSUPPORTED_TYPE; a_initial_flipped_state: BOOLEAN): detachable NS_GRAPHICS_CONTEXT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_graphics_port__item: POINTER
--		do
--			if attached a_graphics_port as a_graphics_port_attached then
--				a_graphics_port__item := a_graphics_port_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_graphics_context_with_graphics_port__flipped_ (l_objc_class.item, a_graphics_port__item, a_initial_flipped_state)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like graphics_context_with_graphics_port__flipped_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like graphics_context_with_graphics_port__flipped_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	current_context: detachable NS_GRAPHICS_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_current_context (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_current_context_ (a_context: detachable NS_GRAPHICS_CONTEXT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_context__item: POINTER
		do
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_current_context_ (l_objc_class.item, a_context__item)
		end

	current_context_drawing_to_screen: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_current_context_drawing_to_screen (l_objc_class.item)
		end

	save_graphics_state
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_save_graphics_state (l_objc_class.item)
		end

	restore_graphics_state
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_restore_graphics_state (l_objc_class.item)
		end

	set_graphics_state_ (a_g_state: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_graphics_state_ (l_objc_class.item, a_g_state)
		end

feature {NONE} -- NSGraphicsContext Externals

	objc_graphics_context_with_attributes_ (a_class_object: POINTER; a_attributes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object graphicsContextWithAttributes:$a_attributes];
			 ]"
		end

	objc_graphics_context_with_window_ (a_class_object: POINTER; a_window: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object graphicsContextWithWindow:$a_window];
			 ]"
		end

	objc_graphics_context_with_bitmap_image_rep_ (a_class_object: POINTER; a_bitmap_rep: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object graphicsContextWithBitmapImageRep:$a_bitmap_rep];
			 ]"
		end

--	objc_graphics_context_with_graphics_port__flipped_ (a_class_object: POINTER; a_graphics_port: UNSUPPORTED_TYPE; a_initial_flipped_state: BOOLEAN): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object graphicsContextWithGraphicsPort: flipped:$a_initial_flipped_state];
--			 ]"
--		end

	objc_current_context (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object currentContext];
			 ]"
		end

	objc_set_current_context_ (a_class_object: POINTER; a_context: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setCurrentContext:$a_context];
			 ]"
		end

	objc_current_context_drawing_to_screen (a_class_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object currentContextDrawingToScreen];
			 ]"
		end

	objc_save_graphics_state (a_class_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object saveGraphicsState];
			 ]"
		end

	objc_restore_graphics_state (a_class_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object restoreGraphicsState];
			 ]"
		end

	objc_set_graphics_state_ (a_class_object: POINTER; a_g_state: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setGraphicsState:$a_g_state];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSGraphicsContext"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
