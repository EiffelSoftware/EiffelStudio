note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSFont

	font_with_name__size_ (a_font_name: detachable NS_STRING; a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_font_name__item: POINTER
		do
			if attached a_font_name as a_font_name_attached then
				a_font_name__item := a_font_name_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_font_with_name__size_ (l_objc_class.item, a_font_name__item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_with_name__size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_with_name__size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	font_with_name__matrix_ (a_font_name: detachable NS_STRING; a_font_matrix: UNSUPPORTED_TYPE): detachable NS_FONT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_font_name__item: POINTER
--			a_font_matrix__item: POINTER
--		do
--			if attached a_font_name as a_font_name_attached then
--				a_font_name__item := a_font_name_attached.item
--			end
--			if attached a_font_matrix as a_font_matrix_attached then
--				a_font_matrix__item := a_font_matrix_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_font_with_name__matrix_ (l_objc_class.item, a_font_name__item, a_font_matrix__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like font_with_name__matrix_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like font_with_name__matrix_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	font_with_descriptor__size_ (a_font_descriptor: detachable NS_FONT_DESCRIPTOR; a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_font_descriptor__item: POINTER
		do
			if attached a_font_descriptor as a_font_descriptor_attached then
				a_font_descriptor__item := a_font_descriptor_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_font_with_descriptor__size_ (l_objc_class.item, a_font_descriptor__item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_with_descriptor__size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_with_descriptor__size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_with_descriptor__text_transform_ (a_font_descriptor: detachable NS_FONT_DESCRIPTOR; a_text_transform: detachable NS_AFFINE_TRANSFORM): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_font_descriptor__item: POINTER
			a_text_transform__item: POINTER
		do
			if attached a_font_descriptor as a_font_descriptor_attached then
				a_font_descriptor__item := a_font_descriptor_attached.item
			end
			if attached a_text_transform as a_text_transform_attached then
				a_text_transform__item := a_text_transform_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_font_with_descriptor__text_transform_ (l_objc_class.item, a_font_descriptor__item, a_text_transform__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_with_descriptor__text_transform_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_with_descriptor__text_transform_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	user_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_user_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	user_fixed_pitch_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_user_fixed_pitch_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_fixed_pitch_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_fixed_pitch_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_user_font_ (a_font: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_font__item: POINTER
		do
			if attached a_font as a_font_attached then
				a_font__item := a_font_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_user_font_ (l_objc_class.item, a_font__item)
		end

	set_user_fixed_pitch_font_ (a_font: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_font__item: POINTER
		do
			if attached a_font as a_font_attached then
				a_font__item := a_font_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_user_fixed_pitch_font_ (l_objc_class.item, a_font__item)
		end

	system_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_system_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like system_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like system_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bold_system_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_bold_system_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bold_system_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bold_system_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	label_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_label_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like label_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like label_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	title_bar_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_title_bar_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title_bar_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title_bar_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	menu_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_menu_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	menu_bar_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_menu_bar_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu_bar_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu_bar_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	message_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_message_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like message_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like message_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	palette_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_palette_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like palette_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like palette_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	tool_tips_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_tool_tips_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tool_tips_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tool_tips_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	control_content_font_of_size_ (a_font_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_control_content_font_of_size_ (l_objc_class.item, a_font_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like control_content_font_of_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like control_content_font_of_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	system_font_size: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_system_font_size (l_objc_class.item)
		end

	small_system_font_size: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_small_system_font_size (l_objc_class.item)
		end

	label_font_size: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_label_font_size (l_objc_class.item)
		end

	system_font_size_for_control_size_ (a_control_size: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_system_font_size_for_control_size_ (l_objc_class.item, a_control_size)
		end

feature {NONE} -- NSFont Externals

	objc_font_with_name__size_ (a_class_object: POINTER; a_font_name: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object fontWithName:$a_font_name size:$a_font_size];
			 ]"
		end

--	objc_font_with_name__matrix_ (a_class_object: POINTER; a_font_name: POINTER; a_font_matrix: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object fontWithName:$a_font_name matrix:];
--			 ]"
--		end

	objc_font_with_descriptor__size_ (a_class_object: POINTER; a_font_descriptor: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object fontWithDescriptor:$a_font_descriptor size:$a_font_size];
			 ]"
		end

	objc_font_with_descriptor__text_transform_ (a_class_object: POINTER; a_font_descriptor: POINTER; a_text_transform: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object fontWithDescriptor:$a_font_descriptor textTransform:$a_text_transform];
			 ]"
		end

	objc_user_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object userFontOfSize:$a_font_size];
			 ]"
		end

	objc_user_fixed_pitch_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object userFixedPitchFontOfSize:$a_font_size];
			 ]"
		end

	objc_set_user_font_ (a_class_object: POINTER; a_font: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setUserFont:$a_font];
			 ]"
		end

	objc_set_user_fixed_pitch_font_ (a_class_object: POINTER; a_font: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setUserFixedPitchFont:$a_font];
			 ]"
		end

	objc_system_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object systemFontOfSize:$a_font_size];
			 ]"
		end

	objc_bold_system_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object boldSystemFontOfSize:$a_font_size];
			 ]"
		end

	objc_label_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object labelFontOfSize:$a_font_size];
			 ]"
		end

	objc_title_bar_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object titleBarFontOfSize:$a_font_size];
			 ]"
		end

	objc_menu_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object menuFontOfSize:$a_font_size];
			 ]"
		end

	objc_menu_bar_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object menuBarFontOfSize:$a_font_size];
			 ]"
		end

	objc_message_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object messageFontOfSize:$a_font_size];
			 ]"
		end

	objc_palette_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object paletteFontOfSize:$a_font_size];
			 ]"
		end

	objc_tool_tips_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object toolTipsFontOfSize:$a_font_size];
			 ]"
		end

	objc_control_content_font_of_size_ (a_class_object: POINTER; a_font_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object controlContentFontOfSize:$a_font_size];
			 ]"
		end

	objc_system_font_size (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object systemFontSize];
			 ]"
		end

	objc_small_system_font_size (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object smallSystemFontSize];
			 ]"
		end

	objc_label_font_size (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object labelFontSize];
			 ]"
		end

	objc_system_font_size_for_control_size_ (a_class_object: POINTER; a_control_size: NATURAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object systemFontSizeForControlSize:$a_control_size];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFont"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
