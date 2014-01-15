note
	description: "[
					IUISimplePropertySet is a read-only interface that defines a method for
					retrieving the value identified by a property key. This interface is
					implemented by the Windows Ribbon framework and is also implemented by 
					the host application for each item in the IUICollection object of an 
					item gallery.
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SIMPLE_PROPERTY_SET

inherit
	IDENTIFIED

create
	make,
	share_with_pointer

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			share_with_pointer (c_create_instance)
		end

	share_with_pointer (a_pointer: POINTER)
			-- Create current with shared pointer
		require
			valid: a_pointer /= default_pointer
		do
			create item.share_from_pointer (a_pointer, size)
			set_object_and_function_address
			all_property_sets.extend (object_id)
		end

feature -- Query

	value (a_property_key: EV_PROPERTY_KEY): EV_PROPERTY_VARIANT
			-- Retrieves the value identified by a property key.
		local
			l_result: NATURAL_32
		do
			create Result.make_empty
			l_result := c_get_value (item.item, a_property_key.item, Result.item)
			check l_result = {WEL_COM_HRESULT}.s_ok end
		end

feature {EV_RIBBON_COLLECTION, EV_SIMPLE_PROPERTY_SET, EV_RIBBON_SAFE_ARRAY} -- Query

	item: MANAGED_POINTER
			-- Item

feature -- Command

	string: detachable STRING_32
			-- string used when key is label

	item_image: detachable EV_PIXEL_BUFFER
			-- image used when key is image

	command_id: NATURAL_32
			-- command id used when key is command id

	set_string (a_string: like string)
			-- Set `string' with `a_string'
		do
			string := a_string
		ensure
			set: a_string = string
		end

	set_item_image (a_image: like item_image)
			-- Set `image' with `a_image'
		do
			item_image := a_image
		ensure
			set: a_image = item_image
		end

	set_command_id (a_command_id: like command_id)
			-- Set `command_id' with `a_command_id'
		do
			command_id := a_command_id
		ensure
			set: a_command_id = command_id
		end

feature {EV_SIMPLE_PROPERTY_SET} -- Implementation

	get_value_for_c (a_simple_property_set: POINTER; a_property_key: POINTER; a_property_value: POINTER): NATURAL_32
			-- Get value function used as C callback
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
		do
			if a_simple_property_set = item.item then
				create l_key.share_from_pointer (a_property_key)
				if l_key.is_label then
					if attached string as l_string then
						create l_value.share_from_pointer (a_property_value)
						l_value.set_string_value (l_string)
					end
				elseif l_key.is_item_image then
					if attached item_image as l_image then
						create l_value.share_from_pointer (a_property_value)
						l_value.set_image (l_image)
					end
				elseif l_key.is_command_id then
					if command_id /= 0 then
						create l_value.share_from_pointer (a_property_value)
						l_value.set_uint32 (command_id)
					end
				end
			else
				-- Pass it to correspond {EV_SIMPLE_PROPERTY_SET} object
				if attached find_property_set_for (a_simple_property_set) as l_property_set then
					Result := l_property_set.get_value_for_c (a_simple_property_set, a_property_key, a_property_value)
				end
			end
		end

	all_property_sets: ARRAYED_LIST [INTEGER_32]
			-- All property sets in system
		once
			create Result.make (100)
		end

	find_property_set_for (a_pointer: POINTER): detachable EV_SIMPLE_PROPERTY_SET
			-- Find `a_pointer' in all property sets
		require
			valid: a_pointer /= default_pointer
		do
			from
				all_property_sets.start
			until
				all_property_sets.after or Result /= Void
			loop
				if attached {EV_SIMPLE_PROPERTY_SET} id_object (all_property_sets.item) as l_property_set then
					if l_property_set.item.item = a_pointer then
						Result := l_property_set
					else
						all_property_sets.forth
					end
				else
					all_property_sets.remove
				end

			end
		end

feature {NONE} -- Externals

	size: INTEGER
			-- C size of IUISimplePropertySet
		external
			"C inline use %"simple_property_set.h%""
		alias
			"[
			{
				return sizeof (IUISimplePropertySet);
			}
			]"
		end

	c_create_instance: POINTER
			-- Create an instanse of simple property set
		external
			"C inline use %"simple_property_set.h%""
		alias
			"[
			{
				return CreateInstanceSimplePropertySet ();
			}
			]"
		end

	c_get_value (a_item: POINTER; a_property_key: POINTER; a_property_value: POINTER): NATURAL_32
			-- Retrieves the value identified by a property key.
		external
			"C++ inline use %"simple_property_set.h%""
		alias
			"[
			{
				IUISimplePropertySet *l_set = (IUISimplePropertySet *)$a_item;
				return l_set->GetValue((REFPROPERTYKEY)$a_property_key,
										(PROPVARIANT *)$a_property_value);
			}
			]"
		end

	set_object_and_function_address
			-- Set object and function addresses
			-- This set callbacks in C codes, so `execute' and `update_property' can be called in C codes.
		do
			c_set_simple_property_set_object ($Current)
			c_set_get_value_address ($get_value_for_c)
		end

	c_set_simple_property_set_object (a_object: POINTER)
			-- Set Current object address.
		external
			"C signature (EIF_REFERENCE) use %"simple_property_set.h%""
		end

	c_set_get_value_address (a_address: POINTER)
			-- Set execute function address
		external
			"C use %"simple_property_set.h%""
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
