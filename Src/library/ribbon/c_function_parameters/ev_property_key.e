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
			--
		do
			create Result.share_from_pointer (c_guid_pointer (item))
		end

	pid: NATURAL_32
			--
		do
			Result := c_pid (item)
		end

	pointer: MANAGED_POINTER
			--

	item: POINTER
			--
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
			--
		external
			"C inline use <ribbon.h>"
		alias
			"[
			{
				return sizeof (PROPERTYKEY);
			}
			]"
		end

	c_guid_pointer (a_property_key: POINTER): POINTER
			--
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
			--
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
			--
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
			--
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
			--
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
			--
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
			--
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
			--
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
			--
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
			--
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
			--
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
			--
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
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_GlobalBackgroundColor;
			}
			]"
		end

	c_ui_pkey_globaltextcolor: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_GlobalTextColor;
			}
			]"
		end

	c_ui_pkey_globalhighlightcolor: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_GlobalHighlightColor;
			}
			]"
		end

	c_ui_pkey_item_image: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_ItemImage;
			}
			]"
		end

	c_ui_pkey_representative_string: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_RepresentativeString;
			}
			]"
		end

	c_ui_pkey_tooltip_title: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_TooltipTitle;
			}
			]"
		end

	c_ui_pkey_tooltip_description: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_TooltipDescription;
			}
			]"
		end

	c_ui_pkey_recent_items: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_RecentItems;
			}
			]"
		end

	c_ui_pkey_color: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_Color;
			}
			]"
		end

feature {NONE} -- Font control properties

	c_ui_pkey_font_properties: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties;
			}
			]"
		end

	c_ui_pkey_font_properties_backgroundcolor: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_BackgroundColor;
			}
			]"
		end

	c_ui_pkey_font_properties_backgroundcolor_type: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_BackgroundColorType;
			}
			]"
		end

	c_ui_pkey_font_properties_bold: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_Bold;
			}
			]"
		end

	c_ui_pkey_font_properties_changed_properties: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_ChangedProperties;
			}
			]"
		end

	c_ui_pkey_font_properties_delta_size: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_DeltaSize;
			}
			]"
		end

	c_ui_pkey_font_properties_family: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_Family;
			}
			]"
		end

	c_ui_pkey_font_properties_foregroundcolor: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_ForegroundColor;
			}
			]"
		end

	c_ui_pkey_font_properties_foregroundcolor_type: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_ForegroundColorType;
			}
			]"
		end

	c_ui_pkey_font_properties_italic: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_Italic;
			}
			]"
		end

	c_ui_pkey_font_properties_size: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_Size;
			}
			]"
		end

	c_ui_pkey_font_properties_strikethrough: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_Strikethrough;
			}
			]"
		end

	c_ui_pkey_font_properties_underline: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_Underline;
			}
			]"
		end

	c_ui_pkey_font_properties_vertical_positioning: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_FontProperties_VerticalPositioning;
			}
			]"
		end

	c_ui_pkey_command_id: POINTER
			--
		external
			"C inline use  %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_CommandId;
			}
			]"
		end

	c_ui_pkey_quick_access_toolbar_dock: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_QuickAccessToolbarDock;
			}
			]"
		end

	c_ui_pkey_enabled: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_Enabled;
			}
			]"
		end

	c_ui_pkey_context_available: POINTER
			--
		external
			"C inline use %"UIRibbon.h%""
		alias
			"[
			{
				return &UI_PKEY_ContextAvailable;
			}
			]"
		end

end
