note
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
	default_create,
	make

feature -- Initialization

	default_create
			-- Create read/write lock.
		obsolete
			"Use make instead"
		require else
			thread_capable: {PLATFORM}.is_thread_capable
		do
			item := eif_thr_rwl_create
		ensure then
			item_set: is_set
		end

	make
			-- Create read/write lock.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			item := eif_thr_rwl_create
		ensure
			item_set: is_set
		end

feature -- Access

	is_set: BOOLEAN
			-- Is read/write lock initialized?
		do
			Result := (item /= default_pointer)
		end

feature -- Status setting

	acquire_read_lock
			-- Lock current on a read.
		require
			exists: is_set
		do
			eif_thr_rwl_rdlock (item)
		end

	acquire_write_lock
			-- Lock current on a write.
		require
			exists: is_set
		do
			eif_thr_rwl_wrlock (item)
		end

	release_read_lock
			-- Unlock Reader lock.
		require
			exists: is_set
		do
			eif_thr_rwl_unlock (item)
		end

	release_write_lock
			-- Unlock Writer lock.
		require
			exists: is_set
		do
			eif_thr_rwl_unlock (item)
		end

	destroy
			-- Destroy read/write lock.
		require
			exists: is_set
		do
			eif_thr_rwl_destroy (item)
			item := default_pointer
		end

feature -- Obsolete

	release_reader_lock, release_writer_lock
			-- Unlock Reader or Writer lock.
		obsolete
			"Use `release_read_lock' or `release_write_lock'."
		require
			exists: is_set
		do
			eif_thr_rwl_unlock (item)
		end

feature {NONE} -- Implementation

	item: POINTER
			-- C reference to the read/write lock.

feature {NONE} -- Removal

	dispose
			-- Called by the garbage collector when the read/write lock is
			-- collected.
		do
			if is_set then
				destroy
			end
		end

feature {NONE} -- Externals

	eif_thr_rwl_create: POINTER
		external
			"C use %"eif_threads.h%""
		end

	eif_thr_rwl_rdlock (an_item: POINTER)
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_rwl_unlock (an_item: POINTER)
		external
			"C use %"eif_threads.h%""
		end

	eif_thr_rwl_wrlock (an_item: POINTER)
		external
			"C blocking use %"eif_threads.h%""
		end

	eif_thr_rwl_destroy (an_item: POINTER)
		external
			"C use %"eif_threads.h%""
		end

invariant
	is_thread_capable: {PLATFORM}.is_thread_capable

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

