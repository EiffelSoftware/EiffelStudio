indexing
	description: "Objects that contain information about a %
		%dialog template."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DLG_TEMPLATE

inherit
	WEL_STRUCTURE
		redefine
			memory_copy,
			initialize_with_character,
			destroy_item
		end						

create
	make,
	make_with_global_alloc,
	make_by_pointer

feature {NONE} -- Initialization

	make_with_global_alloc is
			-- Allocate `item' with call to `GlobalAlloc' instead of `malloc'
		do
			item := cwin_global_alloc (Gptr, structure_size)
			memory_allocated_with_global_alloc := True
			if item = default_pointer then
					-- Memory allocation problem
				(create {EXCEPTIONS}).raise ("No more memory")
			end
			shared := False
		ensure
			not_shared: not shared
		end

feature -- Access

	style: INTEGER is
			-- Style of dialog.
		do
			if memory_allocated_with_global_alloc then
				Result := cwel_dlgtemplate_get_style (item)
			else
				Result := cwel_dlgtemplate_get_style (cwin_global_lock (item))
				cwin_global_unlock (item)
			end
		end

	dwextendedstyle: INTEGER is
			-- Extended style of dialog.
		do
			if memory_allocated_with_global_alloc then
				Result := cwel_dlgtemplate_get_extended_style (item)
			else
				Result := cwel_dlgtemplate_get_extended_style (cwin_global_lock (item))
				cwin_global_unlock (item)
			end
		end

	cdit: INTEGER is
			-- Number of items in dialog.
		do
			if memory_allocated_with_global_alloc then
				Result := cwel_dlgtemplate_get_cdit (item)
			else
				Result := cwel_dlgtemplate_get_cdit (cwin_global_lock (item))
				cwin_global_unlock (item)
			end
		end

	x: INTEGER is
			-- X coordinate of dialog.
		do
			if memory_allocated_with_global_alloc then
				Result := cwel_dlgtemplate_get_x (item)
			else
				Result := cwel_dlgtemplate_get_x (cwin_global_lock (item))
				cwin_global_unlock (item)
			end
		end

	y: INTEGER is
			-- Y coordinate of dialog.
		do
			if memory_allocated_with_global_alloc then
				Result := cwel_dlgtemplate_get_y (item)
			else
				Result := cwel_dlgtemplate_get_y (cwin_global_lock (item))
				cwin_global_unlock (item)
			end
		end

	cx: INTEGER is
			-- Width of dialog.
		do
			if memory_allocated_with_global_alloc then
				Result := cwel_dlgtemplate_get_cx (item)
			else
				Result := cwel_dlgtemplate_get_cx (cwin_global_lock (item))
				cwin_global_unlock (item)
			end
		end

	cy: INTEGER is
			-- Height of dialog.
		do
			if memory_allocated_with_global_alloc then
				Result := cwel_dlgtemplate_get_cy (item)
			else
				Result := cwel_dlgtemplate_get_cy (cwin_global_lock (item))
				cwin_global_unlock (item)
			end
		end

feature -- Status setting.

	set_style (a_style: INTEGER) is
			-- Assign `a_style' to `style'.
		do
			if memory_allocated_with_global_alloc then
				cwel_dlgtemplate_set_style (item, a_style)
			else
				cwel_dlgtemplate_set_style (cwin_global_lock (item), a_style)
				cwin_global_unlock (item)
			end
		end

	set_dwextendedstyle (a_style: INTEGER) is
			-- Assign `a_style' to `dwextendedstyle'.
		do
			if memory_allocated_with_global_alloc then
				cwel_dlgtemplate_set_dwextendedstyle (item, a_style)
			else
				cwel_dlgtemplate_set_dwextendedstyle (cwin_global_lock (item), a_style)
				cwin_global_unlock (item)
			end
		end

	set_cdit (a_value: INTEGER) is
			-- Assign `a_value' to `cdit'.
		do
			if memory_allocated_with_global_alloc then
				cwel_dlgtemplate_set_cdit (item, a_value)
			else
				cwel_dlgtemplate_set_cdit (cwin_global_lock (item), a_value)
				cwin_global_unlock (item)
			end
		end

	set_x (an_x: INTEGER) is
			-- Assign `an_x' to `x'.
		do
			if memory_allocated_with_global_alloc then
				cwel_dlgtemplate_set_x (item, an_x)
			else
				cwel_dlgtemplate_set_x (cwin_global_lock (item), an_x)
				cwin_global_unlock (item)
			end
		end

	set_y (a_y: INTEGER) is
			-- Assign `a_y' to `y'.
		do
			if memory_allocated_with_global_alloc then
				cwel_dlgtemplate_set_x (item, a_y)
			else
				cwel_dlgtemplate_set_x (cwin_global_lock (item), a_y)
				cwin_global_unlock (item)
			end
		end

	set_cx (a_cx: INTEGER) is
			-- Assign `a_cx' to `x'.
		do
			if memory_allocated_with_global_alloc then
				cwel_dlgtemplate_set_cx (cwin_global_lock (item), a_cx)
			else
				cwel_dlgtemplate_set_cx (item, a_cx)
			end
		end

	set_cy (a_cy: INTEGER) is
			-- Assign `a_cy' to `cy'.
		do
			cwel_dlgtemplate_set_cy (item, a_cy)
		end

feature -- Basic operations

	memory_copy (source_pointer: POINTER; length: INTEGER) is
			-- Copy `length' bytes from `source_pointer' to `item'.
		do
			if memory_allocated_with_global_alloc then
				check
					source_pointer_exists: source_pointer /= default_pointer
				end
				cwin_global_lock (item).memory_copy (source_pointer, length)
				cwin_global_unlock (item)
			else
				Precursor (source_pointer, length)
			end
		end

	initialize_with_character (a_character: CHARACTER) is
			-- Fill current with `a_character'.
		do
			if memory_allocated_with_global_alloc then
				cwin_global_lock (item).memory_set (a_character.code, structure_size)
				cwin_global_unlock (item)
			else
				Precursor (a_character)
			end
		end

feature {NONE} -- Removal

	destroy_item is
			-- Free `item'
		do
			if memory_allocated_with_global_alloc then
				if item /= default_pointer then
					item := cwin_global_free (item)
				end
				item := default_pointer
			else
				Precursor {WEL_STRUCTURE}
			end
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
				-- An extra 1024 because a dialog template contains things after
				-- end of structure which are used by Windows.
			Result := c_size_of_dlgtemplate + 1024
		end

feature {NONE} -- Implementation

	memory_allocated_with_global_alloc: BOOLEAN
			-- Has the memory been allocated with `GlobalAlloc'?

feature {NONE} -- Externals

	cwin_global_alloc (a_num, a_size: INTEGER): POINTER is
			-- Global Alloc
		external
			"C [macro <windows.h>] (UINT, size_t): EIF_POINTER"
		alias
			"GlobalAlloc"
		end

	cwin_global_free (a_pointer: POINTER): POINTER is
			-- GlobalFree
		external
			"C [macro <windows.h>] (HGLOBAL): EIF_POINTER"
		alias
			"GlobalFree"
		end

	cwin_global_lock (a_pointer: POINTER): POINTER is
			-- GlobalLock
		external
			"C [macro <windows.h>] (HGLOBAL): EIF_POINTER"
		alias
			"GlobalLock"
		end

	cwin_global_unlock (a_pointer: POINTER) is
			-- GlobalLock
		external
			"C [macro <windows.h>] (HGLOBAL)"
		alias
			"(void) GlobalUnlock"
		end

	c_size_of_dlgtemplate: INTEGER is
		external
			"C [macro <windows.h>]"
		alias
			"sizeof (DLGTEMPLATE)"
		end

	cwel_dlgtemplate_get_style (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"style"
		end

	cwel_dlgtemplate_get_extended_style (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"dwExtendedStyle"
		end

	cwel_dlgtemplate_get_cdit (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"cdit"
		end

	cwel_dlgtemplate_get_x (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"x"
		end

	cwel_dlgtemplate_get_y (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"y"
		end

	cwel_dlgtemplate_get_cx (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"cx"
		end

	cwel_dlgtemplate_get_cy (ptr: POINTER): INTEGER is
		external
			"C [struct <windows.h>] (DLGTEMPLATE): EIF_INTEGER"
		alias
			"cy"
		end

	cwel_dlgtemplate_set_style (ptr: POINTER; a_style: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, DWORD)"
		alias
			"style"
		end

	cwel_dlgtemplate_set_dwextendedstyle (ptr: POINTER; a_style: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, DWORD)"
		alias
			"dwExtendedStyle"
		end

	cwel_dlgtemplate_set_cdit (ptr: POINTER; a_cdir: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, WORD)"
		alias
			"dwExtendedStyle"
		end

	cwel_dlgtemplate_set_x (ptr: POINTER; an_x: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, short)"
		alias
			"x"
		end

	cwel_dlgtemplate_set_y (ptr: POINTER; a_y: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, short)"
		alias
			"y"
		end

	cwel_dlgtemplate_set_cy (ptr: POINTER; a_cy: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, short)"
		alias
			"cy"
		end

	cwel_dlgtemplate_set_cx (ptr: POINTER; a_cx: INTEGER) is
		external
			"C [struct <windows.h>] (DLGTEMPLATE, short)"
		alias
			"cx"
		end

	Gmem_fixed: INTEGER is 0
			-- Allocates fixed memory. The return value is a pointer.

	Gmem_moveable: INTEGER is 2
			-- Allocates movable memory. In Win32, memory blocks are
			-- never moved in physical memory, but they can be moved
			-- within the default heap. 
			-- The return value is a handle to the memory object. To
			-- translate the handle into a pointer, use the GlobalLock
			-- function. 

	Gmem_zeroinit: INTEGER is 64
			-- Initializes memory contents to zero.

	Gptr: INTEGER is 64
			-- Defined as (Gmem_fixed | Gmem_zeroinit)

	Ghnd: INTEGER is 66
			-- Defined as (Gmem_moveable | Gmem_zeroinit)

end -- class WEL_DLGTEMPLATE


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

