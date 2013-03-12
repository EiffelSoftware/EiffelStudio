note
	description: "[
					Property key parameter used by CCommandHandler Execute and UpdateProperty
					
					
					typedef struct _tagpropertykey
				    {
				    GUID fmtid;
				    DWORD pid;
				    } 	PROPERTYKEY;
																								]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PROPERTY_KEY

create
	make_emtpy,
	share_from_pointer,
	make_boolean,
	make_label,
	make_small_image,
	make_large_image,
	make_small_high_contrast_image,
	make_large_high_contrast_image,
	make_decimal,
	make_items_source,
	make_categories,
	make_selected_item,
	make_global_background_color,
	make_global_text_color,
	make_global_highlight_color,
	make_item_image,
	make_representative_string,
	make_tooltip_title,
	make_tooltip_description,
	make_recent_items,
	make_color,
	make_font_properties,
	make_font_properties_backgroundcolor,
	make_font_properties_backgroundcolor_type,
	make_font_properties_bold,
	make_font_properties_changed_properties,
	make_font_properties_delta_size,
	make_font_properties_family,
	make_font_properties_foregroundcolor,
	make_font_properties_foregroundcolor_type,
	make_font_properties_italic,
	make_font_properties_size,
	make_font_properties_strikethrough,
	make_font_properties_underline,
	make_font_properties_vertical_positioning,
	make_command_id,
	make_quick_access_toolbar_dock,
	make_enabled,
	make_context_avaiable

feature {NONE}  -- Initialization

	make_emtpy
			-- Make a empty property key
		do
			create pointer.make (c_size)
		end

	share_from_pointer (a_property_key: POINTER)
			-- Creation method
		do
			create pointer.share_from_pointer (a_property_key, c_size)
		end

	make_boolean
			-- Make a boolean key
		do
			share_from_pointer (c_ui_pkey_boolean_value)
		end

	make_label
			-- Make a label key
		do
			share_from_pointer (c_ui_pkey_label)
		end

	make_small_image
			-- Make a small image key
		do
			share_from_pointer (c_ui_pkey_small_image)
		end

	make_large_image
			-- Make a large image key
		do
			share_from_pointer (c_ui_pkey_large_image)
		end

	make_small_high_contrast_image
			-- Make a small high contrast image key
		do
			share_from_pointer (c_ui_pkey_small_high_contrast_image)
		end

	make_large_high_contrast_image
			-- Make a large high contrast image key
		do
			share_from_pointer (c_ui_pkey_large_high_contrast_image)
		end

	make_decimal
			-- Make a decimal key
		do
			share_from_pointer (c_ui_pkey_decimal)
		end

	make_items_source
			-- Make a items source key
		do
			share_from_pointer (c_ui_pkey_items_source)
		end

	make_categories
			-- Make a items source key
		do
			share_from_pointer (c_ui_pkey_categories)
		end

	make_selected_item
			-- Make a selected item key
		do
			share_from_pointer (c_ui_pkey_selected_item)
		end

	make_global_background_color
			-- Make a global background color
		do
			share_from_pointer (c_ui_pkey_globalbackgroundcolor)
		end

	make_global_text_color
			-- Make a global text color
		do
			share_from_pointer (c_ui_pkey_globaltextcolor)
		end

	make_global_highlight_color
			-- Make a global hightligh color
		do
			share_from_pointer (c_ui_pkey_globalhighlightcolor)
		end

	make_item_image
			-- Make a item image
		do
			share_from_pointer (c_ui_pkey_item_image)
		end

	make_representative_string
			-- Make a representative string key
		do
			share_from_pointer (c_ui_pkey_representative_string)
		end

	make_tooltip_title
			-- Make a tooltip title key
		do
			share_from_pointer (c_ui_pkey_tooltip_title)
		end

	make_tooltip_description
			-- Make a tooltip description key
		do
			share_from_pointer (c_ui_pkey_tooltip_description)
		end

	make_recent_items
			-- Make a recent items key
		do
			share_from_pointer (c_ui_pkey_recent_items)
		end

	make_color
			-- Make a color key
		do
			share_from_pointer (c_ui_pkey_color)
		end

	make_command_id
			-- Make a command id key
		do
			share_from_pointer (c_ui_pkey_command_id)
		end

	make_quick_access_toolbar_dock
			-- Make a quick access toolbar dock key
		do
			share_from_pointer (c_ui_pkey_quick_access_toolbar_dock)
		end

	make_enabled
			-- Make a enabled key
		do
			share_from_pointer (c_ui_pkey_enabled)
		end

	make_context_avaiable
			-- Make a context aviable key
		do
			share_from_pointer (c_ui_pkey_context_available)
		end

feature {NONE} -- Font properties creation methods

	make_font_properties
			-- Make a font properties
		do
			share_from_pointer (c_ui_pkey_font_properties)
		end

	make_font_properties_backgroundcolor
			-- Make a font properties backgroundcolor
		do
			share_from_pointer (c_ui_pkey_font_properties_backgroundcolor)
		end

	make_font_properties_backgroundcolor_type
			-- Make a font properties backgroundcolor tyep
		do
			share_from_pointer (c_ui_pkey_font_properties_backgroundcolor_type)
		end

	make_font_properties_bold
			-- Make a font properties bold
		do
			share_from_pointer (c_ui_pkey_font_properties_bold)
		end

	make_font_properties_changed_properties
			-- Make a font properties changed properties
		do
			share_from_pointer (c_ui_pkey_font_properties_changed_properties)
		end

	make_font_properties_delta_size
			-- Make a font properties delta size
		do
			share_from_pointer (c_ui_pkey_font_properties_delta_size)
		end

	make_font_properties_family
			-- Make a font properties family
		do
			share_from_pointer (c_ui_pkey_font_properties_family)
		end

	make_font_properties_foregroundcolor
			-- Make a font properties foregroundcolor
		do
			share_from_pointer (c_ui_pkey_font_properties_foregroundcolor)
		end

	make_font_properties_foregroundcolor_type
			-- Make a font properties foregroundcolor type
		do
			share_from_pointer (c_ui_pkey_font_properties_foregroundcolor_type)
		end

	make_font_properties_italic
			-- Make a font properties italic
		do
			share_from_pointer (c_ui_pkey_font_properties_italic)
		end

	make_font_properties_size
			-- Make a font properties size
		do
			share_from_pointer (c_ui_pkey_font_properties_size)
		end

	make_font_properties_strikethrough
			-- Make a font properties strikethrough
		do
			share_from_pointer (c_ui_pkey_font_properties_strikethrough)
		end

	make_font_properties_underline
			-- Make a font properties underline
		do
			share_from_pointer (c_ui_pkey_font_properties_underline)
		end

	make_font_properties_vertical_positioning
			-- Make a font properties vertical positioning
		do
			share_from_pointer (c_ui_pkey_font_properties_vertical_positioning)
		end

feature -- Access

	guid: WEL_GUID
			-- A unique GUID for the property.
		do
			create Result.share_from_pointer (c_guid_pointer (item))
		end

	pid: NATURAL_32
			-- A property identifier (PID). This parameter is not used as in SHCOLUMNID. It is recommended that you set this value to PID_FIRST_USABLE.
			-- Any value greater than or equal to 2 is acceptable.
			-- Note  Values of 0 and 1 are reserved and should not be used.
		do
			Result := c_pid (item)
		end

	pointer: MANAGED_POINTER
			-- Managed C pointer item

	item: POINTER
			-- C pointer item
		do
			Result := pointer.item
		end

feature -- Status Report

	exists: BOOLEAN
			-- Does current exists?
		do
			Result := item /= default_pointer
		end

	is_label: BOOLEAN
			-- Is current label key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_label
			Result := l_tmp.guid.is_equal (guid)
		end

	is_small_image: BOOLEAN
			-- Is current small image key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_small_image
			Result := l_tmp.guid.is_equal (guid)
		end

	is_large_image: BOOLEAN
			-- Is current large image key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_large_image
			Result := l_tmp.guid.is_equal (guid)
		end

	is_small_high_contrast_image: BOOLEAN
			-- Is current small high contrast image key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_small_high_contrast_image
			Result := l_tmp.guid.is_equal (guid)
		end

	is_large_high_contrast_image: BOOLEAN
			-- Is current large high contrast image key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_large_high_contrast_image
			Result := l_tmp.guid.is_equal (guid)
		end

	is_decimal: BOOLEAN
			-- Is current decimal value key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_decimal
			Result := l_tmp.guid.is_equal (guid)
		end

	is_items_source: BOOLEAN
			-- Is current items source key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_items_source
			Result := l_tmp.guid.is_equal (guid)
		end

	is_categories: BOOLEAN
			-- Is current categories?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_categories
			Result := l_tmp.guid.is_equal (guid)
		end

	is_selected_item: BOOLEAN
			-- Is current selected item?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_selected_item
			Result := l_tmp.guid.is_equal (guid)
		end

	is_item_image: BOOLEAN
			-- Is current item image?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_item_image
			Result := l_tmp.guid.is_equal (guid)
		end

	is_representative_string: BOOLEAN
			-- Is current representative string?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_representative_string
			Result := l_tmp.guid.is_equal (guid)
		end

	is_tooltip_title: BOOLEAN
			-- Is current tooltip title?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_tooltip_title
			Result := l_tmp.guid.is_equal (guid)
		end

	is_tooltip_description: BOOLEAN
			-- Is current tooltip description?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_tooltip_description
			Result := l_tmp.guid.is_equal (guid)
		end

	is_recent_items: BOOLEAN
			-- Is current recent items key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_recent_items
			Result := l_tmp.guid.is_equal (guid)
		end

	is_color: BOOLEAN
			-- Is current color key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_color
			Result := l_tmp.guid.is_equal (guid)
		end

	is_command_id: BOOLEAN
			-- Is current command id key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_command_id
			Result := l_tmp.guid.is_equal (guid)
		end

	is_quick_access_toolbar_dock: BOOLEAN
			-- Is current quick access toolbar dock key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_quick_access_toolbar_dock
			Result := l_tmp.guid.is_equal (guid)
		end

	is_enabled: BOOLEAN
			-- Is current enabled key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_enabled
			Result := l_tmp.guid.is_equal (guid)
		end

	is_context_available: BOOLEAN
			-- Is current context available key?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_context_avaiable
			Result := l_tmp.guid.is_equal (guid)
		end

feature -- Font properties

	is_font_properties: BOOLEAN
			-- Is current font properties?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_backgroundcolor: BOOLEAN
			-- Is current font properties background color?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_backgroundcolor
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_backgroundcolor_type: BOOLEAN
			-- Is current font properties background color color?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_backgroundcolor_type
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_bold: BOOLEAN
			-- Is current font properties bold?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_bold
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_changed_properties: BOOLEAN
			-- Is current font properties changed properties?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_changed_properties
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_delta_size: BOOLEAN
			-- Is current font properties delta size?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_delta_size
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_family: BOOLEAN
			-- Is current font properties family?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_family
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_foreground_color: BOOLEAN
			-- Is current font properties foregroundcolor?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_foregroundcolor
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_foregroundcolor_type: BOOLEAN
			-- Is current font properties foregroundcolor type?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_foregroundcolor_type
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_italic: BOOLEAN
			-- Is current font properties italic?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_italic
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_size: BOOLEAN
			-- Is current font properties size?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_size
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_strikethrough: BOOLEAN
			-- Is current font properties strikethrough?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_strikethrough
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_underline: BOOLEAN
			-- Is current font properties underline?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_underline
			Result := l_tmp.guid.is_equal (guid)
		end

	is_font_properties_vertical_positioning: BOOLEAN
			-- Is current font properties Vertical Positioning?
		local
			l_tmp: EV_PROPERTY_KEY
		do
			create l_tmp.make_font_properties_vertical_positioning
			Result := l_tmp.guid.is_equal (guid)
		end

feature {NONE} -- Externals

	c_size: INTEGER
			-- Size of PROPERTYKEY
		external
			"C inline use <common.h>"
		alias
			"[
			{
				return sizeof (PROPERTYKEY);
			}
			]"
		end

	c_guid_pointer (a_property_key: POINTER): POINTER
			-- Get GUID from `a_property_key'
		external
			"C inline use %"WTypes.h%""
		alias
			"[
			{
				PROPERTYKEY* l_property_key;
				l_property_key = (PROPERTYKEY *)$a_property_key;
				return (EIF_POINTER)(&(l_property_key -> fmtid));
			}
			]"
		end

	c_pid (a_property_key: POINTER): NATURAL_32
			-- Get pid from `a_property_key'
		external
			"C inline use %"WTypes.h%""
		alias
			"[
			{
				PROPERTYKEY* l_property_key;
				l_property_key = (PROPERTYKEY *)$a_property_key;
				return (EIF_NATURAL_32)(l_property_key -> pid);
			}
			]"
		end

	c_ui_pkey_boolean_value: POINTER
			-- Identifies the UI_PKEY_BooleanValue property.
			-- UI_PKEY_BooleanValue is used by an application to query the toggle-state of a Check Box, Toggle Button,
			-- and the button control of a SplitButtonGallery.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_BooleanValue;
			}
			]"
		end

	c_ui_pkey_label: POINTER
			-- Identifies the UI_PKEY_Label property.
			-- UI_PKEY_Label is used by an application to query the label text of tabs, groups, buttons, gallery items,
			-- and other Ribbon controls.
			-- The property value is a string constrained to any sequence of characters, including white space and line-break characters.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_Label;
			}
			]"
		end

	c_ui_pkey_small_image: POINTER
			-- Identifies the UI_PKEY_SmallImage property.
			-- UI_PKEY_SmallImage is used by an application to query the small image associated with a ribbon control.
			-- The property value is an IUIImage object.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_SmallImage;
			}
			]"
		end

	c_ui_pkey_large_image: POINTER
			-- Identifies the UI_PKEY_LargeImage property.
			-- UI_PKEY_LargeImage is used by an application to query the large image associated with a ribbon control.
			-- The property value is an IUIImage object.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_LargeImage;
			}
			]"
		end

	c_ui_pkey_small_high_contrast_image: POINTER
			-- Identifies the UI_PKEY_SmallHighContrastImage property.
			-- UI_PKEY_SmallHighContrastImage is used by an application to query the small, high contrast image
			-- associated with a ribbon control.
			-- The property value is an IUIImage object.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_SmallHighContrastImage;
			}
			]"
		end

	c_ui_pkey_large_high_contrast_image: POINTER
			-- Identifies the UI_PKEY_LargeHighContrastImage property.
			-- UI_PKEY_LargeHighContrastImage is used by an application to query the large, high contrast image
			-- associated with a ribbon control.
			-- The property value is an IUIImage object.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_LargeHighContrastImage;
			}
			]"
		end

	c_ui_pkey_decimal: POINTER
			-- Identifies the UI_PKEY_DecimalValue property.
			-- UI_PKEY_DecimalValue is used by an application to query the value in the edit field of the Spinner control.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_DecimalValue;
			}
			]"
		end

	c_ui_pkey_items_source: POINTER
			-- Identifies the UI_PKEY_ItemsSource property.
			-- UI_PKEY_ItemsSource is used by an application to query the collection of items in a gallery control, such as the Quick Access Toolbar (QAT).
			-- The property value is an IUICollection object.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_ItemsSource;
			}
			]"
		end

	c_ui_pkey_categories: POINTER
			-- Identifies the UI_PKEY_Categories property.
			-- UI_PKEY_Categories is used by an application to query the categories that are used to group related items in a gallery control.
			-- The property value is an IUICollection object where each item in the collection represents a category.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_Categories;
			}
			]"
		end

	c_ui_pkey_selected_item: POINTER
			-- Identifies the UI_PKEY_SelectedItem property.
			-- UI_PKEY_SelectedItem is used by an application to query the selected item in a gallery control.
			-- The property value is the index of the selected item in a collection.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return (EIF_POINTER) &UI_PKEY_SelectedItem;
			}
			]"
		end

	c_ui_pkey_globalbackgroundcolor: POINTER
			-- Identifies the UI_PKEY_GlobalBackgroundColor property.
			-- UI_PKEY_GlobalBackgroundColor is used by an application to query the global background color for a customized ribbon.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_GlobalBackgroundColor;"
		end

	c_ui_pkey_globaltextcolor: POINTER
			-- Identifies the UI_PKey_GlobalTextColor property.
			-- UI_PKEY_GlobalTextColor is used by an application to query the global text color for a customized ribbon.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_GlobalTextColor;"
		end

	c_ui_pkey_globalhighlightcolor: POINTER
			-- Identifies the UI_PKEY_GlobalHighlightColor property.
			-- UI_PKEY_GlobalHighlightColor is used by an application to query the global highlight color for a customized ribbon.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_GlobalHighlightColor;"
		end

	c_ui_pkey_item_image: POINTER
			-- Identifies the UI_PKEY_ItemImage property.
			-- UI_PKEY_ItemImage is used by an application to query the image associated with an item or command in a gallery control.
			-- The property value is an IUIImage object.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_ItemImage;"
		end

	c_ui_pkey_representative_string: POINTER
			-- Identifies the UI_PKEY_RepresentativeString property.
			-- UI_PKEY_RepresentativeString is used by an application to query the length of the edit field for a Spinner control.
			-- The value of UI_PKEY_RepresentativeString is used by the framework to calculate the width of the Spinner control and is never displayed.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_RepresentativeString;"
		end

	c_ui_pkey_tooltip_title: POINTER
			-- Identifies the UI_PKEY_TooltipTitle property.
			-- UI_PKEY_TooltipTitle is used by an application to query the tooltip of tabs, groups, buttons, gallery items, and other Ribbon controls.
			-- The property value is a string constrained to any sequence of characters, including white space and line-break characters.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_TooltipTitle;"
		end

	c_ui_pkey_tooltip_description: POINTER
			-- Identifies the UI_PKEY_TooltipDescription property.
			-- UI_PKEY_TooltipDescription is used by an application to query the description associated with a UI_PKEY_TooltipTitle.
			-- The property value is a string constrained to any sequence of characters, including white space and line-break characters.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_TooltipDescription;"
		end

	c_ui_pkey_recent_items: POINTER
			-- Identifies the UI_PKEY_RecentItems property.
			-- UI_PKEY_Pinned is used by an application to query the array of items in the most recently used (MRU) items collection of the Application Menu.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_RecentItems;"
		end

	c_ui_pkey_color: POINTER
			-- Identifies the UI_PKEY_Color property.
			-- UI_PKEY_Color is used by an application to query the color value of the DropDownColorPicker control.
			-- The property value is a COLORREF value.
			-- The high-order byte of the COLORREF value is ignored.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_Color;"
		end

feature {NONE} -- Font control properties

	c_ui_pkey_font_properties: POINTER
			-- Identifies the UI_PKEY_FontProperties property.
			-- UI_PKEY_FontProperties is a property store used by an application to query all font properties.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties;"
		end

	c_ui_pkey_font_properties_backgroundcolor: POINTER
			-- Identifies the UI_PKEY_FontProperties_BackgroundColor property.
			-- UI_PKEY_FontProperties_BackgroundColor is used by an application, in conjunction with UI_PKEY_FontProperties_BackgroundColorType,
			-- to query Text highlight color gallery settings.
			-- The default value is 0x00000000.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_BackgroundColor;"
		end

	c_ui_pkey_font_properties_backgroundcolor_type: POINTER
			-- Identifies the UI_PKEY_FontProperties_BackgroundColorType property.
			-- UI_PKEY_FontProperties_BackgroundColorType is used by an application, in conjunction with UI_PKEY_FontProperties_BackgroundColor, to query Text highlight color gallery settings.
			-- The property value is from the UI_SWATCHCOLORTYPE enumeration.
			-- The default value is UI_SWATCHCOLORTYPE_RGB.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_BackgroundColorType;"
		end

	c_ui_pkey_font_properties_bold: POINTER
			-- Identifies the UI_PKEY_FontProperties_Bold property.
			-- UI_PKEY_FontProperties_Bold is used by an application to query the state of the Bold button.
			-- The property value is from the UI_FONTPROPERTIES enumeration.
			-- The default value is UI_FONTPROPERTIES_NOTSET.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_Bold;"
		end

	c_ui_pkey_font_properties_changed_properties: POINTER
			-- Identifies the UI_PKEY_FontProperties_ChangedProperties property.
			-- UI_PKEY_FontProperties_ChangedProperties is used by an application to query only changed properties from UI_PKEY_FontProperties.
			-- Calling the IUISimplePropertySet::GetValue method on this IUISimplePropertySet object returns an IPropertyStore.
			-- UI_PKEY_FontProperties_ChangedProperties is passed as the last parameter of the IUICommandHandler::Execute call to the Ribbon host application.
			-- This property key is read-only.			
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_ChangedProperties;"
		end

	c_ui_pkey_font_properties_delta_size: POINTER
			-- Identifies the UI_PKEY_FontProperties_DeltaSize property.
			-- UI_PKEY_FontProperties_DeltaSize is used by an application in cases where it is not possible for the application to specify
			-- a value for Font size, such as when a run of heterogeneously sized text is selected. The Font size control is set to blank and
			-- UI_PKEY_FontProperties_DeltaSize is used to capture user interaction with the Font grow and Font shrink buttons.
			-- UI_PKEY_FontProperties_DeltaSize is included in UI_PKEY_FontProperties_ChangedProperties.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_DeltaSize;"
		end

	c_ui_pkey_font_properties_family: POINTER
			-- Identifies the UI_PKEY_FontProperties_Family property.
			-- UI_PKEY_FontProperties_Family is used by an application to query the value of the Font family drop-down gallery.
			-- The value of UI_PKEY_FontProperties_Family matches a Windows GDI Font Families name retrieved with the EnumFontFamilies
			-- function or EnumFontFamiliesEx function.
			-- The default value is an empty string.
			-- If an empty string is supplied for the value for UI_PKEY_FontProperties_Family, then the font selection is cleared.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_Family;"
		end

	c_ui_pkey_font_properties_foregroundcolor: POINTER
			-- Identifies the UI_PKEY_FontProperties_ForegroundColor property.
			-- UI_PKEY_FontProperties_ForegroundColor is used by an application, in conjunction with UI_PKEY_FontProperties_ForegroundColorType,
			-- to query Text color gallery settings.
			-- The default value is 0x00000000.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_ForegroundColor;"
		end

	c_ui_pkey_font_properties_foregroundcolor_type: POINTER
			-- Identifies the UI_PKEY_FontProperties_ForegroundColorType property.
			-- UI_PKEY_FontProperties_ForegroundColorType is used by an application, in conjunction with UI_PKEY_FontProperties_ForegroundColor,
			-- to query Text color gallery settings.
			-- The property value is from the UI_SWATCHCOLORTYPE enumeration.
			-- The default value is UI_SWATCHCOLORTYPE_RGB.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_ForegroundColorType;"
		end

	c_ui_pkey_font_properties_italic: POINTER
			-- Identifies the UI_PKEY_FontProperties_Italic property.
			-- UI_PKEY_FontProperties_Italic is used by an application to query the state of the Italic button.
			-- The property value is from the UI_FONTPROPERTIES enumeration.
			-- The default value is UI_FONTPROPERTIES_NOTSET.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_Italic;"
		end

	c_ui_pkey_font_properties_size: POINTER
			-- Identifies the UI_PKEY_FontProperties_Size property.
			-- UI_PKEY_FontProperties_Size is used by an application to query the value of the Font size control.
			-- Valid values for this property range from 1 to 9999, inclusive. If a user tries to enter an invalid value,
			-- the entry is rejected and the Font size control reverts to the last valid value.
			-- If an application attempts to set font size programmatically to a value outside the valid range, the Ribbon
			-- framework invalidates all font properties and sets the font controls (Font size and Font face) to blank or to
			-- their default state, where appropriate.
			-- The default value is 0.
			-- A value of 0 specifies that no single point size is selected (either no text, or a run of heterogeneously sized
			-- text, is selected).
			-- A user cannot set the Font size control to 0.
			-- Other than 0, valid values for UI_PKEY_FontProperties_Size range between MinimumFontSize and MaximumFontSize as
			-- declared in the Font Control markup.			
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_Size;"
		end

	c_ui_pkey_font_properties_strikethrough: POINTER
			-- Identifies the UI_PKEY_FontProperties_Strikethrough property.
			-- UI_PKEY_FontProperties_Strikethrough is used by an application to query the state of the Strikethrough button.
			-- The property value is from the UI_FONTPROPERTIES enumeration.
			-- The default value is UI_FONTPROPERTIES_NOTSET.			
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_Strikethrough;"
		end

	c_ui_pkey_font_properties_underline: POINTER
			-- Identifies the UI_PKEY_FontProperties_Underline property.
			-- UI_PKEY_FontProperties_Underline is used by an application to query the state of the Underline button.
			-- The property value is from the UI_FONTUNDERLINE enumeration.
			-- The default value is UI_FONTUNDERLINE_NOTSET.			
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_Underline;"
		end

	c_ui_pkey_font_properties_vertical_positioning: POINTER
			-- Identifies the UI_PKEY_FontProperties_VerticalPositioning property.
			-- UI_PKEY_FontProperties_VerticalPositioning is used by an application to query the value of the Superscript and
			-- Subscript controls.
			-- The property value is from the UI_FONTVERTICALPOSITION enumeration.
			-- The default value is UI_FONTVERTICALPOSITION_NOTSET.			
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_FontProperties_VerticalPositioning;"
		end

	c_ui_pkey_command_id: POINTER
			-- Identifies the UI_PKEY_CommandId property.
			-- UI_PKEY_CommandId is used by an application to query the IDs of the commands in a gallery control.
			-- The property value is the ID of a Command.
		external
			"C inline use  %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_CommandId;"
		end

	c_ui_pkey_quick_access_toolbar_dock: POINTER
			-- Identifies the UI_PKEY_QuickAccessToolbarDock property.
			-- UI_PKEY_QuickAccessToolbarDock is used by an application to query the dock-state of the Quick Access Toolbar (QAT).
			-- The property value is from the UI_CONTROLDOCK enumeration.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_QuickAccessToolbarDock;"
		end

	c_ui_pkey_enabled: POINTER
			-- Identifies the UI_PKEY_Enabled property.
			-- UI_PKEY_Enabled is used by an application to query whether a control is enabled and able to respond to user interaction.
			-- The value is not automatically set to 0 when the application mode is changed and the visibility of a Command is toggled off.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_Enabled;"
		end

	c_ui_pkey_context_available: POINTER
			-- Identifies the UI_PKEY_ContextAvailable property.
			-- UI_PKEY_ContextAvailable is used by an application to query the availability of a Tab Group control based on the current application context.
		external
			"C inline use %"UIRibbon.h%""
		alias
			"return (EIF_POINTER) &UI_PKEY_ContextAvailable;"
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
