note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_PANEL_VALIDATION_ADDITIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSFontPanelValidationAdditions

	valid_modes_for_font_panel_ (a_ns_object: NS_OBJECT; a_font_panel: detachable NS_FONT_PANEL): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_font_panel__item: POINTER
		do
			if attached a_font_panel as a_font_panel_attached then
				a_font_panel__item := a_font_panel_attached.item
			end
			Result := objc_valid_modes_for_font_panel_ (a_ns_object.item, a_font_panel__item)
		end

feature {NONE} -- NSFontPanelValidationAdditions Externals

	objc_valid_modes_for_font_panel_ (an_item: POINTER; a_font_panel: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item validModesForFontPanel:$a_font_panel];
			 ]"
		end

end
