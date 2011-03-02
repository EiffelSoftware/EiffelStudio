note
	description: "Summary description for {EV_SIMPLE_PROPERTY_SET}."
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
			set_object_and_function_address
			create item.share_from_pointer (c_create_instance, size)
			all_property_sets.extend (object_id)
		end

	share_with_pointer (a_pointer: POINTER)
			--
		require
			valid: a_pointer /= default_pointer
		do
			set_object_and_function_address
			create item.share_from_pointer (a_pointer, size)
			all_property_sets.extend (object_id)
		end

feature {EV_RIBBON_COLLECTION, EV_SIMPLE_PROPERTY_SET} -- Query

	item: MANAGED_POINTER
			-- Item

feature -- Command

	string: detachable STRING_32
			-- string used when key is label

	item_image: detachable EV_PIXEL_BUFFER
			-- string used when key is image

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

feature {EV_SIMPLE_PROPERTY_SET} -- Implementation

	get_value (a_simple_property_set: POINTER; a_property_key: POINTER; a_property_value: POINTER): NATURAL_32
			--
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
				end
			else
				-- Pass it to correspond {EV_SIMPLE_PROPERTY_SET} object
				if attached find_property_set_for (a_simple_property_set) as l_property_set then
					Result := l_property_set.get_value (a_simple_property_set, a_property_key, a_property_value)
				end
			end
		end

	all_property_sets: ARRAYED_LIST [INTEGER_32]
			-- All property sets in system
		once
			create Result.make (100)
		end

	find_property_set_for (a_pointer: POINTER): detachable EV_SIMPLE_PROPERTY_SET
			--
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
			--
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
			--
		external
			"C inline use %"simple_property_set.h%""
		alias
			"[
			{
				return CreateInstanceSimplePropertySet ();
			}
			]"
		end

	set_object_and_function_address
			-- Set object and function addresses
			-- This set callbacks in C codes, so `execute' and `update_property' can be called in C codes.
		do
			c_set_simple_property_set_object ($Current)
			c_set_get_value_address ($get_value)
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

end
