indexing

	description: "Registry keys value types"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY_KEY_VALUE_TYPE
		
feature -- Access

	Reg_binary: INTEGER is
			-- General binary value
		external
			"C [macro <winnt.h>]"
		alias
			"REG_BINARY"
		end
		
	Reg_dword: INTEGER is
			-- Double word value
		external
			"C [macro <winnt.h>]"
		alias
			"REG_DWORD"
		end
		
	Reg_dword_little_endian: INTEGER is
			-- Synonym of `Reg_dword'
		external
			"C [macro <winnt.h>]"
		alias
			"REG_DWORD_LITTLE_ENDIAN"
		end
		
	Reg_dword_big_endian: INTEGER is
			-- Double word value in big-endian format
		external
			"C [macro <winnt.h>]"
		alias
			"REG_DWORD_BIG_ENDIAN"
		end
		
	Reg_expand_sz: INTEGER is
			-- C-String that contains unexpanded references to environment variables
		external
			"C [macro <winnt.h>]"
		alias
			"REG_EXPAND_SZ"
		end
		
	Reg_sz: INTEGER is
			-- C-String
		external
			"C [macro <winnt.h>]"
		alias
			"REG_SZ"
		end
		
	Reg_link: INTEGER is
			-- Unicode symbolic link
		external
			"C [macro <winnt.h>]"
		alias
			"REG_LINK"
		end
		
	Reg_multi_sz: INTEGER is 
			-- Array of C-strings, terminated by two null characters
		external
			"C [macro <winnt.h>]"
		alias
			"REG_MULTI_SZ"
		end
		
	Reg_none: INTEGER is
			-- No defined value type
		external
			"C [macro <winnt.h>]"
		alias
			"REG_NONE"
		end
		
	Reg_resource_list: INTEGER is
			-- Device-driver resource list
		external
			"C [macro <winnt.h>]"
		alias
			"REG_RESOURCE_LIST"
		end
	 
end -- class WEL_REGISTRY_KEY_VALUE_TYPE

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

