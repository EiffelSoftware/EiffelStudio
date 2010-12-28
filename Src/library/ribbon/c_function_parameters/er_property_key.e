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
	ER_PROPERTY_KEY

create
	share_from_pointer

feature {NONE}  -- Initialization

	share_from_pointer (a_property_key: POINTER)
			-- Creation method
		do
			pointer := a_property_key
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

feature {NONE} -- Implementation

	pointer: POINTER
			--

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

end
