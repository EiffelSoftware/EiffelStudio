note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSMenu

	pop_up_context_menu__with_event__for_view_ (a_menu: detachable NS_MENU; a_event: detachable NS_EVENT; a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_menu__item: POINTER
			a_event__item: POINTER
			a_view__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_pop_up_context_menu__with_event__for_view_ (l_objc_class.item, a_menu__item, a_event__item, a_view__item)
		end

	pop_up_context_menu__with_event__for_view__with_font_ (a_menu: detachable NS_MENU; a_event: detachable NS_EVENT; a_view: detachable NS_VIEW; a_font: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_menu__item: POINTER
			a_event__item: POINTER
			a_view__item: POINTER
			a_font__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_font as a_font_attached then
				a_font__item := a_font_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_pop_up_context_menu__with_event__for_view__with_font_ (l_objc_class.item, a_menu__item, a_event__item, a_view__item, a_font__item)
		end

	set_menu_bar_visible_ (a_visible: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_menu_bar_visible_ (l_objc_class.item, a_visible)
		end

	menu_bar_visible: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_menu_bar_visible (l_objc_class.item)
		end

--	menu_zone: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_menu_zone (l_objc_class.item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like menu_zone} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like menu_zone} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSMenu Externals

	objc_pop_up_context_menu__with_event__for_view_ (a_class_object: POINTER; a_menu: POINTER; a_event: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object popUpContextMenu:$a_menu withEvent:$a_event forView:$a_view];
			 ]"
		end

	objc_pop_up_context_menu__with_event__for_view__with_font_ (a_class_object: POINTER; a_menu: POINTER; a_event: POINTER; a_view: POINTER; a_font: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object popUpContextMenu:$a_menu withEvent:$a_event forView:$a_view withFont:$a_font];
			 ]"
		end

	objc_set_menu_bar_visible_ (a_class_object: POINTER; a_visible: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setMenuBarVisible:$a_visible];
			 ]"
		end

	objc_menu_bar_visible (a_class_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object menuBarVisible];
			 ]"
		end

	objc_menu_zone (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object menuZone];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMenu"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
