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
	make_large_high_contrast_image

feature {NONE}  -- Initialization

	share_from_pointer (a_property_key: POINTER)
			-- Creation method
		do
			pointer := a_property_key
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

feature -- Query

	guid: WEL_GUID
			--
		do
			create Result.share_from_pointer (c_guid_pointer (pointer))
		end

	pid: NATURAL_32
			--
		do
			Result := c_pid (pointer)
		end

	pointer: POINTER
			--

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
				return &UI_PKEY_BooleanValue;
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
				return &UI_PKEY_Label;
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
				return &UI_PKEY_SmallImage;
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
				return &UI_PKEY_LargeImage;
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
				return &UI_PKEY_SmallHighContrastImage;
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
				return &UI_PKEY_LargeHighContrastImage;
			}
			]"
		end
end
