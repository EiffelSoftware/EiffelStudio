note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_PATH_CELL_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	path_cell__will_display_open_panel_ (a_path_cell: detachable NS_PATH_CELL; a_open_panel: detachable NS_OPEN_PANEL)
			-- Auto generated Objective-C wrapper.
		require
			has_path_cell__will_display_open_panel_: has_path_cell__will_display_open_panel_
		local
			a_path_cell__item: POINTER
			a_open_panel__item: POINTER
		do
			if attached a_path_cell as a_path_cell_attached then
				a_path_cell__item := a_path_cell_attached.item
			end
			if attached a_open_panel as a_open_panel_attached then
				a_open_panel__item := a_open_panel_attached.item
			end
			objc_path_cell__will_display_open_panel_ (item, a_path_cell__item, a_open_panel__item)
		end

	path_cell__will_pop_up_menu_ (a_path_cell: detachable NS_PATH_CELL; a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		require
			has_path_cell__will_pop_up_menu_: has_path_cell__will_pop_up_menu_
		local
			a_path_cell__item: POINTER
			a_menu__item: POINTER
		do
			if attached a_path_cell as a_path_cell_attached then
				a_path_cell__item := a_path_cell_attached.item
			end
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_path_cell__will_pop_up_menu_ (item, a_path_cell__item, a_menu__item)
		end

feature -- Status Report

	has_path_cell__will_display_open_panel_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_path_cell__will_display_open_panel_ (item)
		end

	has_path_cell__will_pop_up_menu_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_path_cell__will_pop_up_menu_ (item)
		end

feature -- Status Report Externals

	objc_has_path_cell__will_display_open_panel_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(pathCell:willDisplayOpenPanel:)];
			 ]"
		end

	objc_has_path_cell__will_pop_up_menu_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(pathCell:willPopUpMenu:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_path_cell__will_display_open_panel_ (an_item: POINTER; a_path_cell: POINTER; a_open_panel: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSPathCellDelegate>)$an_item pathCell:$a_path_cell willDisplayOpenPanel:$a_open_panel];
			 ]"
		end

	objc_path_cell__will_pop_up_menu_ (an_item: POINTER; a_path_cell: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSPathCellDelegate>)$an_item pathCell:$a_path_cell willPopUpMenu:$a_menu];
			 ]"
		end

end
