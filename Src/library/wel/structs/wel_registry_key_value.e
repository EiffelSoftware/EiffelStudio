indexing

	description: "Structure describing a registry key value"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY_KEY_VALUE

inherit
	WEL_REGISTRY_KEY_VALUE_TYPE

creation
	make, make_from_pointer
	
feature -- Initialization

	make is
			-- Create an empty structure
		do
			item := cwin_reg_value_alloc
		ensure
			item_initialized: item /= Default_pointer
		end
		
	make_from_pointer (a_pointer: POINTER) is
			-- Set `item' with `a_pointer'.
		require
			valid_pointer: a_pointer /= Default_pointer
		do
			item := a_pointer
		ensure
			item_set: item = a_pointer
		end

feature -- Access

	type: INTEGER is
			-- Type of value
			-- See class WEL_REGISTRY_KEY_VALUE_TYPE for possible
			-- values.
		do
			Result := cwin_reg_value_get_type (item)
		end
			
	string_value: STRING is
			-- Data of string value
		require
			allocated: item /= default_pointer
			valid_type: type = Reg_sz or type = Reg_expand_sz
		do
			!! Result.make (0)
			Result.from_c (cwin_reg_value_get_data (item))
		end
		
	dword_value: INTEGER is
			-- Data of double word value
		require
			allocated: item /= default_pointer
			valid_type: type = Reg_dword or type = Reg_dword_little_endian
		do
			Result := cwin_reg_value_get_data_dword (item)
		end
		
	value: POINTER is
			-- Pointer on datas of any type
		require
			allocated: item /= default_pointer
		do
			Result := cwin_reg_value_get_data (item)
		end
		
	item: POINTER
			-- Pointer to C structure.

feature -- Element Change

	set_type (t: INTEGER) is
			-- Set type of value with `t'.
			-- See class WEL_REGISTRY_KEY_VALUE_TYPE for possible
			-- values for `t'.
		require
			allocated: item /= default_pointer
			valid_type: t = Reg_binary or t = Reg_dword or t = Reg_dword_little_endian
							or t = Reg_expand_sz or t = Reg_sz
		do
			cwin_reg_value_set_type (item, t)
		end
		
	set_string_value (data: STRING) is
			-- Set data of key value with `data'.
			-- Value type must be set first.
		require
			allocated: item /= default_pointer
			valid_type: type = Reg_sz or type = Reg_expand_sz
		local
			a: ANY
		do
			a := data.to_c
			cwin_reg_value_set_data (item, $a)
			cwin_reg_value_set_data_length (item, data.count)
		end
		
	set_dword_value (data: INTEGER) is
			-- Set data of key value with `data'.
			-- Value type must be set first.
		require
			allocated: item /= default_pointer
			valid_type: type = Reg_dword or type = Reg_dword_little_endian
		do
			cwin_reg_value_set_data_dword (item, data)
		end

	set_value (pointer_to_data: POINTER; length: INTEGER) is
			-- Set data of key value to datas pointed by `pointer_to_data'
			-- with `length' bytes.
		require
			allocated: item /= default_pointer
		do
			cwin_reg_value_set_data (item, pointer_to_data)
			cwin_reg_value_set_data_length (item, length)
		end
		
	destroy is
			-- Free C structure
		require
			allocated: item /= default_pointer
		do
			cwin_reg_value_destroy (item)
		end
		
feature {NONE} -- Externals

	cwin_reg_value_alloc: POINTER is
		external
			"C [macro <wel_reg_value.h>]"
		end
	
	cwin_reg_value_get_type (ptr: POINTER): INTEGER is
		external
			"C [macro <wel_reg_value.h>]"
		end
		
	cwin_reg_value_get_data (ptr: POINTER): POINTER is
		external
			"C [macro <wel_reg_value.h>]"
		end
		
	cwin_reg_value_get_data_dword (ptr: POINTER): INTEGER is
		external
			"C [macro <wel_reg_value.h>]"
		end

	cwin_reg_value_set_type (ptr: POINTER; t: INTEGER) is
		external
			"C [macro <wel_reg_value.h>]"
		end

	cwin_reg_value_set_data_dword (ptr: POINTER; data: INTEGER) is
		external
			"C [macro <wel_reg_value.h>]"
		end

	cwin_reg_value_set_data (ptr, data_ptr: POINTER) is
		external
			"C [macro <wel_reg_value.h>]"
		end

	cwin_reg_value_set_data_length (ptr: POINTER; length: INTEGER) is
		external
			"C [macro <wel_reg_value.h>]"
		end
		
	cwin_reg_value_destroy (ptr: POINTER) is
		external
			"C [macro <wel_reg_value.h>]"
		end
		
invariant
	
	valid_item: item /= Default_pointer

end -- class WEL_REGISTRY_KEY_VALUE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

