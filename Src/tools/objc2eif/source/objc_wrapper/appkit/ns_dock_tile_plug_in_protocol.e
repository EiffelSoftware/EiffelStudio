note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_DOCK_TILE_PLUG_IN_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Required Methods

	set_dock_tile_ (a_dock_tile: detachable NS_DOCK_TILE)
			-- Auto generated Objective-C wrapper.
		local
			a_dock_tile__item: POINTER
		do
			if attached a_dock_tile as a_dock_tile_attached then
				a_dock_tile__item := a_dock_tile_attached.item
			end
			objc_set_dock_tile_ (item, a_dock_tile__item)
		end

feature {NONE} -- Required Methods Externals

	objc_set_dock_tile_ (an_item: POINTER; a_dock_tile: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSDockTilePlugIn>)$an_item setDockTile:$a_dock_tile];
			 ]"
		end

feature -- Optional Methods

	dock_menu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		require
			has_dock_menu: has_dock_menu
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dock_menu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dock_menu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dock_menu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- Status Report

	has_dock_menu: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_dock_menu (item)
		end

feature -- Status Report Externals

	objc_has_dock_menu (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(dockMenu)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_dock_menu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSDockTilePlugIn>)$an_item dockMenu];
			 ]"
		end

end
