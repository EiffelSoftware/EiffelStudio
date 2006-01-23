indexing
	description: "Abstract notions of a COM data structure."
	legal: "See notice at end of class."
	note: "If allocated by Client, may be deallocated by Server, and the opposite."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_STRUCTURE

inherit
	WEL_STRUCTURE
		export
			{NONE} set_item
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
				(create {EXCEPTIONS}).raise ("No more memory")
			end
			initialize 
			shared := False
		end

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		require
			valid_pointer: a_pointer /= default_pointer
		deferred
		end

feature -- Basic Operations

	set_value (source: like Current) is
			-- Set Current to 'source'.
		require
			non_void: source /= Void
			valid_source: source.item /= default_pointer
		do
			memory_copy (source.item, structure_size)
		end

feature {NONE} -- Removal

	destroy_item is
			-- Free `item'
		do
			if exists then
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


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ECOM_STRUCTURE

