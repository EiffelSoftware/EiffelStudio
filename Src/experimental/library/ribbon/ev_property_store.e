note
	description: "[
						Exposes methods for enumerating, getting, and setting property values.
																								]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PROPERTY_STORE

create
	share_with_pointer

feature {NONE} -- Initilization

	share_with_pointer (a_item: POINTER)
			-- Creation method
		require
			valid: a_item /= default_pointer
		do
			create pointer.share_from_pointer (a_item, c_size)
		end

feature -- Query

	pointer: MANAGED_POINTER
			-- C pointer

	count: NATURAL_32
			-- Gets the number of properties attached to the file
		local
			l_h_result: NATURAL_32
		do
			l_h_result := c_get_count (pointer.item, $Result)
			check l_h_result = {WEL_COM_HRESULT}.s_ok end
		end

	value (a_property_key: EV_PROPERTY_KEY): EV_PROPERTY_VARIANT
			-- Gets data for a specific property.
		require
			not_void: a_property_key /= Void
		local
			l_h_result: NATURAL_32
		do
			create Result.make_empty
			l_h_result := c_get_value (pointer.item, a_property_key.item, Result.item)
			check l_h_result = {WEL_COM_HRESULT}.s_ok end
		end

	key_at (a_index: NATURAL_32): EV_PROPERTY_KEY
			-- Gets a property key from an item's array of properties.
		local
			l_h_result: NATURAL_32
		do
			create Result.make_emtpy
			l_h_result := c_get_at (pointer.item, a_index, Result.item)
			check l_h_result = {WEL_COM_HRESULT}.s_ok end
		end

feature -- Command

	commit
			-- Saves a property change.
		local
			l_h_result: NATURAL_32
		do
			l_h_result := c_commit (pointer.item)
			check l_h_result = {WEL_COM_HRESULT}.s_ok end
		end

	set_value (a_key: EV_PROPERTY_KEY; a_value: EV_PROPERTY_VARIANT)
			-- Sets a new property value, or replaces or removes an existing value.
		local
			l_h_result: NATURAL_32
		do
			l_h_result := c_set_value (pointer.item, a_key.item, a_value.item)
			check l_h_result = {WEL_COM_HRESULT}.s_ok end
		end

feature {NONE} -- C externals

	c_size: INTEGER
			-- C size of IPropertyStore
		external
			"C++ inline use <Propsys.h>"
		alias
			"[
			{
				return sizeof (IPropertyStore *);
			}
			]"
		end

	c_commit (a_item: POINTER): NATURAL_32
			-- Saves a property change.
		external
			"C++ inline use <Propsys.h>"
		alias
			"[
			{
				IPropertyStore *l_spPropertyStore = (IPropertyStore *) $a_item;
				return l_spPropertyStore->Commit();
			}
			]"
		end

	c_get_at (a_item: POINTER; a_index: NATURAL_32; a_key: POINTER): NATURAL_32
			-- Gets a property key from an item's array of properties
		external
			"C++ inline use <Propsys.h>"
		alias
			"[
			{
				IPropertyStore *l_spPropertyStore = (IPropertyStore *) $a_item;
				return l_spPropertyStore->GetAt((DWORD)$a_index, (PROPERTYKEY *)$a_key);
			}
			]"
		end

	c_get_count (a_item: POINTER; a_count: TYPED_POINTER [NATURAL_32]): NATURAL_32
			-- Gets the number of properties attached to the file.
		external
			"C++ inline use <Propsys.h>"
		alias
			"[
			{
				IPropertyStore *l_spPropertyStore = (IPropertyStore *) $a_item;
				return l_spPropertyStore ->GetCount((DWORD *)$a_count);
			}
			]"
		end

	c_get_value (a_item: POINTER; a_property_key: POINTER; a_property_variant: POINTER): NATURAL_32
			-- Gets data for a specific property.
		external
			"C++ inline use %"UIRibbon.h%""
		alias
			"[
			{
				PROPERTYKEY *l_property_key = (PROPERTYKEY *)$a_property_key;
				IPropertyStore *l_spPropertyStore = (IPropertyStore *) $a_item;
				return l_spPropertyStore->GetValue(*l_property_key, (PROPVARIANT *)$a_property_variant);
			}
			]"
		end

	c_set_value (a_item: POINTER; a_property_key: POINTER; a_property_variant: POINTER): NATURAL_32
			-- Sets a new property value, or replaces or removes an existing value.
		external
			"C++ inline use <Propsys.h>"
		alias
			"[
			{
				IPropertyStore *l_spPropertyStore = (IPropertyStore *) $a_item;
				return l_spPropertyStore->SetValue((REFPROPERTYKEY)$a_property_key, (REFPROPVARIANT)$a_property_variant);			
			}
			]"
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
