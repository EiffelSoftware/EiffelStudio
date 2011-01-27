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
	make_label

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
end
