indexing
	description: "Read/Write synchronization object, allows multiple reader threads to have %
		%access to a resource, and only one writer thread."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	READ_WRITE_LOCK

inherit
	DISPOSABLE
		redefine
			default_create
		end
		
create
	default_create

feature -- Initialization

	default_create is
			-- Create read/write lock.
		do
			item := eif_thr_rwl_create
		ensure then
			item_set: is_set
		end

feature -- Access

	is_set: BOOLEAN is
			-- Is read/write lock initialized?
		do
			Result := (item /= default_pointer)
		end

feature -- Status setting

	acquire_read_lock is
			-- Lock current on a read.
		require
			exists: is_set
		do
			eif_thr_rwl_rdlock (item)
		end

	acquire_write_lock is
			-- Lock current on a write.
		require
			exists: is_set
		do
			eif_thr_rwl_wrlock (item)
		end

	release_reader_lock is
			-- Unlock Reader lock.
		require
			exists: is_set
		do
			eif_thr_rwl_unlock (item)
		end

	release_writer_lock is
			-- Unlock Writer lock.
		require
			exists: is_set
		do
			eif_thr_rwl_unlock (item)
		end

	destroy is
			-- Destroy read/write lock.
		require
			exists: is_set
		do
			eif_thr_rwl_destroy (item)
			item := default_pointer
		end

feature {NONE} -- Implementation

	item: POINTER
			-- C reference to the read/write lock.

feature {NONE} -- Removal

	dispose is
			-- Called by the garbage collector when the read/write lock is
			-- collected.
		do
			if is_set then
				destroy
			end
		end

feature {NONE} -- Externals

	eif_thr_rwl_create: POINTER is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_rwl_rdlock (an_item: POINTER) is
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_rwl_unlock (an_item: POINTER) is
		external
			"C | %"eif_threads.h%""
		end

	eif_thr_rwl_wrlock (an_item: POINTER) is
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_rwl_destroy (an_item: POINTER) is
		external
			"C | %"eif_threads.h%""
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




end -- class READ_WRITE_LOCK

