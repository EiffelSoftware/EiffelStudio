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
	make_color

feature {NONE}  -- Initialization

	share_from_pointer (a_property_key: POINTER)
			-- Creation method
		do
			item := a_property_key
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

	item: POINTER
			--

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

feature {NONE} -- Externals

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
end
