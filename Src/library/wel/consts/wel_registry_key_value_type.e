indexing
	description: "Registry keys value types"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_REGISTRY_KEY_VALUE_TYPE
		
feature -- Access

	Reg_binary: INTEGER is 3
			-- General binary value
			--
			-- Declared in Windows as REG_BINARY

	Reg_dword: INTEGER is 4
			-- Double word value
			--
			-- Declared in Windows as REG_DWORD

	Reg_dword_little_endian: INTEGER is 4
			-- Synonym of `Reg_dword'
			--
			-- Declared in Windows as REG_DWORD_LITTLE_ENDIAN

	Reg_dword_big_endian: INTEGER is 5
			-- Double word value in big-endian format
			--
			-- Declared in Windows as REG_DWORD_BIG_ENDIAN

	Reg_expand_sz: INTEGER is 2
			-- C-String that contains unexpanded references to environment
			-- variables
			--
			-- Declared in Windows as REG_EXPAND_SZ

	Reg_sz: INTEGER is 1
			-- C-String
			--
			-- Declared in Windows as REG_SZ

	Reg_link: INTEGER is 6
			-- Unicode symbolic link
			--
			-- Declared in Windows as REG_LINK

	Reg_multi_sz: INTEGER is 7
			-- Array of C-strings, terminated by two null characters
			--
			-- Declared in Windows as REG_MULTI_SZ

	Reg_none: INTEGER is 0
			-- No defined value type
			--
			-- Declared in Windows as REG_NONE

	Reg_resource_list: INTEGER is 8
			-- Device-driver resource list
			--
			-- Declared in Windows as REG_RESOURCE_LIST

end -- class WEL_REGISTRY_KEY_VALUE_TYPE


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

