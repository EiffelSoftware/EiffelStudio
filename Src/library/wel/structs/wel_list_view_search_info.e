note
	description: "Information on how to search a list view"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LIST_VIEW_SEARCH_INFO

inherit
	WEL_STRUCTURE
	
	WEL_BIT_OPERATIONS
		undefine
			copy, is_equal
		end

	WEL_LVFI_CONSTANTS
		undefine
			copy, is_equal
		end

	WEL_VK_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_LVFI_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature -- Access

	flags: INTEGER
			-- Flags specifying type of search
			-- See class WEL_LVFI_CONSTANTS for possible value
		do
			Result := cwel_list_view_search_info_flags (item)
		end
	
	target: STRING_32
			-- Search target
			-- Either `target' or `lparam' will be used during search according to `flags'.
		require
			valid_flags: flag_set (flags, Lvfi_string)
		do
			if str_target /= Void then
				Result := str_target.string
			else
				create Result.make_empty
			end
		end
	
	lparam: INTEGER
			-- Search target
			-- Either `target' or `lparam' will be used during search according to `flags'.
		require
			valid_flags: flag_set (flags, Lvfi_param)
		do
			Result := cwel_list_view_search_info_lparam (item)
		end

	starting_position: WEL_POINT
			-- Starting position of search
		require
			valid_flags: flag_set (flags, Lvfi_nearestxy)
		do
			create Result.make_by_pointer (cwel_list_view_search_info_starting_position (item))
			Result.set_unshared
		end
	
	upwards: BOOLEAN
			-- Will search be upwards?
		do
			Result := cwel_list_view_search_info_direction (item) = Vk_up
		end
	
	downwards: BOOLEAN
			-- Will search be downwards?
		do
			Result := cwel_list_view_search_info_direction (item) = Vk_down
		end
	
	right: BOOLEAN
			-- Will search direction be right?
		do
			Result := cwel_list_view_search_info_direction (item) = Vk_right
		end
	
	left: BOOLEAN
			-- Will search direction be left?
		do
			Result := cwel_list_view_search_info_direction (item) = Vk_left
		end	

feature -- Element Change

	add_flag (a_flag: like flags)
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
		
	set_target (a_target: STRING_GENERAL)
			-- Set `target' with `a_target'.
		require
			non_void_target: a_target /= Void
			valid_target: not a_target.is_empty
		do
			add_flag (Lvfi_string)
			create str_target.make (a_target)
			cwel_list_view_search_info_set_target (item, str_target.item)
		ensure
			target_set: target.is_equal (a_target)
		end
		
	set_flags (a_flags: like flags)
			-- Set `flags' with `a_flags'.
		require
			valid_flags: is_valid_list_view_flag (a_flags)
		do
			cwel_list_view_search_info_set_flags (item, flags)
		ensure
			flags_set: flags = a_flags
		end
		
	set_lparam (a_lparam: like lparam)
			-- Set `lparam' with `a_lparam'.
		do
			add_flag (Lvfi_param)
			cwel_list_view_search_info_set_lparam (item, lparam)
		ensure
			lparam_set: lparam = a_lparam
		end
		
	set_starting_position (a_starting_position: like starting_position)
			-- Set `starting_position' with `a_starting_position'.
		require
			non_void_starting_position: a_starting_position /= Void
			valid_starting_position: a_starting_position.exists
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_starting_position (item, starting_position.item)
		end
		
	set_upwards
			-- Set search direction upwards
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_direction (item, Vk_up)
		end
	
	set_downwards
			-- Set search direction downwards
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_direction (item, Vk_down)
		end
	
	set_right
			-- Set search direction right
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_direction (item, Vk_right)
		end
	
	set_left
			-- Set search direction left
		do
			add_flag (Lvfi_nearestxy)
			cwel_list_view_search_info_set_direction (item, Vk_left)
		end

feature -- Measurment

	structure_size: INTEGER
			-- Structure size
		do
			Result := c_structure_size
		end

feature {NONE} -- Externals

	str_target: WEL_STRING
			-- Buffer for `target' field.

	c_structure_size: INTEGER
		external
			"C [macro %"wel.h%"]: EIF_INTEGER"
		alias
			"sizeof (LV_FINDINFO)"
		end

	cwel_list_view_search_info_flags (a_pointer: POINTER): INTEGER
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_INTEGER"
		end

	cwel_list_view_search_info_target (a_pointer: POINTER): POINTER
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_POITNER"
		end

	cwel_list_view_search_info_lparam (a_pointer: POINTER): INTEGER
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_INTEGER"
		end

	cwel_list_view_search_info_starting_position (a_pointer: POINTER): POINTER
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_POINTER"
		end

	cwel_list_view_search_info_direction (a_pointer: POINTER): INTEGER
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*): EIF_INTEGER"
		end

	cwel_list_view_search_info_set_flags (a_pointer: POINTER; a_flags: INTEGER)
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, UINT)"
		end

	cwel_list_view_search_info_set_target (a_pointer, a_target: POINTER)
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, LPCTSTR)"
		end

	cwel_list_view_search_info_set_lparam (a_pointer: POINTER; a_lparam:INTEGER)
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, LPARAM)"
		end

	cwel_list_view_search_info_set_starting_position (a_pointer, a_starting_pos: POINTER)
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, POINT*)"
		end

	cwel_list_view_search_info_set_direction (a_pointer: POINTER; a_direction: INTEGER)
		external
			"C [macro %"wel_list_view_search_info.h%"](LV_FINDINFO*, UINT)"
		end

invariant

	valid_direction: (upwards implies (not downwards and not right and not left)) and
						(downwards implies (not upwards and not right and not left)) and
						(right implies (not upwards and not downwards and not left)) and
						(left implies (not upwards and not downwards and not right)) 

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
