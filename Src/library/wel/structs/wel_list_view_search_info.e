indexing
	description: "Information on how to search a list view"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LIST_VIEW_SEARCH_INFO

inherit
	WEL_STRUCTURE
	
	WEL_BIT_OPERATIONS

	WEL_LVFI_CONSTANTS

	WEL_VK_CONSTANTS
		export
			{NONE} all
		end

	WEL_LVFI_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Access

	flags: INTEGER is
			-- Flags specifying type of search
			-- See class WEL_LVFI_CONSTANTS for possible value
		do
			Result := cwel_list_view_search_info_flags (item)
		end
	
	target: STRING is
			-- Search target
			-- Either `target' or `lparam' will be used during search according to `flags'.
		require
			valid_flags: flag_set (flags, Lvfi_string)
		do
			create Result.make (0)
			Result.from_c (cwel_list_view_search_info_target (item))
		end
	
	lparam: INTEGER is
			-- Search target
			-- Either `target' or `lparam' will be used during search according to `flags'.
		require
			valid_flags: flag_set (flags, Lvfi_param)
		do
			Result := cwel_list_view_search_info_lparam (item)
		end

	starting_position: WEL_POINT is
			-- Starting position of search
		require
			valid_flags: flag_set (flags, Lvfi_nearestxy)
		do
			create Result.make_by_pointer (cwel_list_view_search_info_starting_position (item))
			Result.set_unshared
		end
	
	upwards: BOOLEAN is
			-- Will search be upwards?
		do
			Result := cwel_list_view_search_info_direction (item) = Vk_up
		end
	
	downwards: BOOLEAN is
			-- Will search be downwards?
		do
			Result := cwel_list_view_search_info_direction (item) = Vk_down
		end
	
	right: BOOLEAN is
			-- Will search direction be right?
		do
			Result := cwel_list_view_search_info_direction (item) = Vk_right
		end
	
	left: BOOLEAN is
			-- Will search direction be left?
		do
			Result := cwel_list_view_search_info_direction (item) = Vk_left
		end	

feature -- Element Change

	add_flag (a_flag: like flags) is
			-- Add `a_flag' to `flags'.
		require
			valid_flags: is_valid_list_view_flag (a_flag)
		local
			an_integer: INTEGER
		do
			an_integer := set_flag (flags, a_flag)
			cwel_list_view_search_info_set_flags (item, an_integer)
		ensure
			added: flag_set (flags, a_flag)
		end
		
	set_target (a_target: like target) is
			-- Set `target' with `a_target'.
		require
			non_void_target: a_target /= Void
			valid_target: not a_target.is_empty
		do
			add_flag (Lvfi_string)
			cwel_list_view_search_info_set_target (item, (create {WEL_STRING}.make (a_target)).item)
		ensure
			target_set: target.is_equal (a_target)
		end
		
	set_flags (a_flags: like flags) is
			-- Set `flags' with `a_flags'.
		require
			valid_flags: is_valid_list_view_flag (a_flags)
		do
			cwel_list_view_search_info_set_flags (item, flags)
		ensure
			flags_set: flags = a_flags
		end
		
	set_lparam (a_lparam: like lparam) is
			-- Set `lparam' with `a_lparam'.
		do
			add_flag (Lvfi_param)
			cwel_list_view_search_info_set_lparam (item, lparam)
		ensure
			lparam_set: lparam = a_lparam
		end
		
	set_starting_position (a_starting_position: like starting_position) is
			-- Set `starting_position' with `a_starting_position'.
		require
			non_void_starting_position: a_starting_position /= Void
			valid_starting_position: a_starting_position.exists
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_starting_position (item, starting_position.item)
		end
		
	set_upwards is
			-- Set search direction upwards
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_direction (item, Vk_up)
		end
	
	set_downwards is
			-- Set search direction downwards
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_direction (item, Vk_down)
		end
	
	set_right is
			-- Set search direction right
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_direction (item, Vk_right)
		end
	
	set_left is
			-- Set search direction left
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_direction (item, Vk_left)
		end

feature {NONE} -- Measurment

	structure_size: INTEGER is
			-- Structure size
		do
			Result := c_structure_size
		end

feature {NONE} -- Externals

	c_structure_size: INTEGER is
		external
			"C [macro %"wel.h%"]: EIF_INTEGER"
		alias
			"sizeof (LV_FINDINFO)"
		end

	cwel_list_view_search_info_flags (a_pointer: POINTER): INTEGER is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_INTEGER"
		end

	cwel_list_view_search_info_target (a_pointer: POINTER): POINTER is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_POITNER"
		end

	cwel_list_view_search_info_lparam (a_pointer: POINTER): INTEGER is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_INTEGER"
		end

	cwel_list_view_search_info_starting_position (a_pointer: POINTER): POINTER is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_POINTER"
		end

	cwel_list_view_search_info_direction (a_pointer: POINTER): INTEGER is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_INTEGER"
		end

	cwel_list_view_search_info_set_flags (a_pointer: POINTER; a_flags: INTEGER) is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, UINT)"
		end

	cwel_list_view_search_info_set_target (a_pointer, a_target: POINTER) is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, LPCTSTR)"
		end

	cwel_list_view_search_info_set_lparam (a_pointer: POINTER; a_lparam:INTEGER) is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, LPARAM)"
		end

	cwel_list_view_search_info_set_starting_position (a_pointer, a_starting_pos: POINTER) is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, POINT*)"
		end

	cwel_list_view_search_info_set_direction (a_pointer: POINTER; a_direction: INTEGER) is
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, UINT)"
		end

invariant

	valid_direction: (upwards implies (not downwards and not right and not left)) and
						(downwards implies (not upwards and not right and not left)) and
						(right implies (not upwards and not downwards and not left)) and
						(left implies (not upwards and not downwards and not right)) 

end -- class WEL_LIST_VIEW_SEARCH_INFO

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