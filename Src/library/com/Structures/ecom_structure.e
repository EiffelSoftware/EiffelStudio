indexing
	description: "Abstract notions of a COM data structure."
	note: "If allocated by Client, may be deallocated by Server, and the opposite."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_STRUCTURE

inherit
	WEL_STRUCTURE
		redefine
			make, 
			destroy_item
		end

feature {NONE} -- Initialization

	make is
			-- Allocate `item'
		do
			item := co_task_mem_alloc (structure_size)
			if item = default_pointer then
				-- Memory allocation problem
				c_enomem
			end
			shared := False
		end


feature {NONE} -- Removal

	destroy_item is
			-- Free `item'
		do
			if item /= default_pointer then
				co_task_mem_free (item)
				item := default_pointer
			end
		end


feature {NONE} -- Externals

	co_task_mem_alloc (a_size: INTEGER): POINTER is
			-- Allocates a block of task memory 
		external
			"C [macro <objbase.h >] (size_t):EIF_POINTER"
		alias
			"CoTaskMemAlloc"
		end

	co_task_mem_free (ptr: POINTER) is
			-- Frees a block of task memory  
		external
			"C [macro <objbase.h >] (void*)"
		alias
			"CoTaskMemFree"
		end

	co_task_mem_realloc (ptr: POINTER; a_size: INTEGER): POINTER is
			-- Changes the size of a previously allocated block of task memory. 
  
		external
			"C [macro <objbase.h >] (void*, size_t):EIF_POINTER"
		alias
			"CoTaskMemRealloc"
		end


end -- class ECOM_STRUCTURE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

