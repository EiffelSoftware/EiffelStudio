note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_PATH_CONTROL_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	path_control__should_drag_path_component_cell__with_pasteboard_ (a_path_control: detachable NS_PATH_CONTROL; a_path_component_cell: detachable NS_PATH_COMPONENT_CELL; a_pasteboard: detachable NS_PASTEBOARD): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_path_control__should_drag_path_component_cell__with_pasteboard_: has_path_control__should_drag_path_component_cell__with_pasteboard_
		local
			a_path_control__item: POINTER
			a_path_component_cell__item: POINTER
			a_pasteboard__item: POINTER
		do
			if attached a_path_control as a_path_control_attached then
				a_path_control__item := a_path_control_attached.item
			end
			if attached a_path_component_cell as a_path_component_cell_attached then
				a_path_component_cell__item := a_path_component_cell_attached.item
			end
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			Result := objc_path_control__should_drag_path_component_cell__with_pasteboard_ (item, a_path_control__item, a_path_component_cell__item, a_pasteboard__item)
		end

	path_control__validate_drop_ (a_path_control: detachable NS_PATH_CONTROL; a_info: detachable NS_DRAGGING_INFO_PROTOCOL): NATURAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_path_control__validate_drop_: has_path_control__validate_drop_
		local
			a_path_control__item: POINTER
			a_info__item: POINTER
		do
			if attached a_path_control as a_path_control_attached then
				a_path_control__item := a_path_control_attached.item
			end
			if attached a_info as a_info_attached then
				a_info__item := a_info_attached.item
			end
			Result := objc_path_control__validate_drop_ (item, a_path_control__item, a_info__item)
		end

	path_control__accept_drop_ (a_path_control: detachable NS_PATH_CONTROL; a_info: detachable NS_DRAGGING_INFO_PROTOCOL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_path_control__accept_drop_: has_path_control__accept_drop_
		local
			a_path_control__item: POINTER
			a_info__item: POINTER
		do
			if attached a_path_control as a_path_control_attached then
				a_path_control__item := a_path_control_attached.item
			end
			if attached a_info as a_info_attached then
				a_info__item := a_info_attached.item
			end
			Result := objc_path_control__accept_drop_ (item, a_path_control__item, a_info__item)
		end

	path_control__will_display_open_panel_ (a_path_control: detachable NS_PATH_CONTROL; a_open_panel: detachable NS_OPEN_PANEL)
			-- Auto generated Objective-C wrapper.
		require
			has_path_control__will_display_open_panel_: has_path_control__will_display_open_panel_
		local
			a_path_control__item: POINTER
			a_open_panel__item: POINTER
		do
			if attached a_path_control as a_path_control_attached then
				a_path_control__item := a_path_control_attached.item
			end
			if attached a_open_panel as a_open_panel_attached then
				a_open_panel__item := a_open_panel_attached.item
			end
			objc_path_control__will_display_open_panel_ (item, a_path_control__item, a_open_panel__item)
		end

	path_control__will_pop_up_menu_ (a_path_control: detachable NS_PATH_CONTROL; a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		require
			has_path_control__will_pop_up_menu_: has_path_control__will_pop_up_menu_
		local
			a_path_control__item: POINTER
			a_menu__item: POINTER
		do
			if attached a_path_control as a_path_control_attached then
				a_path_control__item := a_path_control_attached.item
			end
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_path_control__will_pop_up_menu_ (item, a_path_control__item, a_menu__item)
		end

feature -- Status Report

	has_path_control__should_drag_path_component_cell__with_pasteboard_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_path_control__should_drag_path_component_cell__with_pasteboard_ (item)
		end

	has_path_control__validate_drop_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_path_control__validate_drop_ (item)
		end

	has_path_control__accept_drop_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_path_control__accept_drop_ (item)
		end

	has_path_control__will_display_open_panel_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_path_control__will_display_open_panel_ (item)
		end

	has_path_control__will_pop_up_menu_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_path_control__will_pop_up_menu_ (item)
		end

feature -- Status Report Externals

	objc_has_path_control__should_drag_path_component_cell__with_pasteboard_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(pathControl:shouldDragPathComponentCell:withPasteboard:)];
			 ]"
		end

	objc_has_path_control__validate_drop_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(pathControl:validateDrop:)];
			 ]"
		end

	objc_has_path_control__accept_drop_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(pathControl:acceptDrop:)];
			 ]"
		end

	objc_has_path_control__will_display_open_panel_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(pathControl:willDisplayOpenPanel:)];
			 ]"
		end

	objc_has_path_control__will_pop_up_menu_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(pathControl:willPopUpMenu:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_path_control__should_drag_path_component_cell__with_pasteboard_ (an_item: POINTER; a_path_control: POINTER; a_path_component_cell: POINTER; a_pasteboard: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSPathControlDelegate>)$an_item pathControl:$a_path_control shouldDragPathComponentCell:$a_path_component_cell withPasteboard:$a_pasteboard];
			 ]"
		end

	objc_path_control__validate_drop_ (an_item: POINTER; a_path_control: POINTER; a_info: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSPathControlDelegate>)$an_item pathControl:$a_path_control validateDrop:$a_info];
			 ]"
		end

	objc_path_control__accept_drop_ (an_item: POINTER; a_path_control: POINTER; a_info: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSPathControlDelegate>)$an_item pathControl:$a_path_control acceptDrop:$a_info];
			 ]"
		end

	objc_path_control__will_display_open_panel_ (an_item: POINTER; a_path_control: POINTER; a_open_panel: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSPathControlDelegate>)$an_item pathControl:$a_path_control willDisplayOpenPanel:$a_open_panel];
			 ]"
		end

	objc_path_control__will_pop_up_menu_ (an_item: POINTER; a_path_control: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSPathControlDelegate>)$an_item pathControl:$a_path_control willPopUpMenu:$a_menu];
			 ]"
		end

end
