indexing
	description: "Information about a process."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_INFO

inherit
	WEL_STRUCTURE

creation
	make

feature -- Access

	process_handle: INTEGER is
			-- Handle to process
		do
			Result := cwel_process_info_get_process_handle (item)
		end

	thread_handle: INTEGER is
			-- Handle to thread
		do
			Result := cwel_process_info_get_thread_handle (item)
		end
	
	process_id: INTEGER is
			-- Process identifier
		do
			Result := cwel_process_info_get_process_id (item)
		end
	
	thread_id: INTEGER is
			-- Thread identifier
		do
			Result := cwel_process_info_get_thread_id (item)
		end
	
feature -- Element Settings

	set_process_handle (a_handle: like process_handle) is
			-- Set `process_handle' with `a_handle'.
		require
			valid_handle: a_handle > 0
		do
			cwel_process_info_set_process_handle (item, a_handle)
		ensure
			handle_set: process_handle = a_handle
		end

	set_thread_handle (a_handle: like thread_handle) is
			-- Set `thread_handle' with `a_handle'.
		require
			valid_handle: a_handle > 0
		do
			cwel_process_info_set_thread_handle (item, a_handle)
		ensure
			handle_set: thread_handle = a_handle
		end

	set_process_id (a_id: like process_id) is
			-- Set `process_id' with `a_id'.
		require
			valid_id: a_id > 0
		do
			cwel_process_info_set_process_id (item, a_id)
		ensure
			id_set: process_id = a_id
		end

	set_thread_id (a_id: like thread_id) is
			-- Set `thread_id' with `a_id'.
		require
			valid_id: a_id > 0
		do
			cwel_process_info_set_thread_id (item, a_id)
		ensure
			id_set: thread_id = a_id
		end

feature {NONE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		do
			Result := c_size_of_process_info
		end

feature {NONE} -- Externals

	c_size_of_process_info: INTEGER is
		external
			"C [macro %"wel_process_info.h%"]"
		alias
			"sizeof (PROCESS_INFORMATION)"
		end

	cwel_process_info_get_process_handle (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_process_info.h%"] (PROCESS_INFORMATION*): EIF_INTEGER"
		end

	cwel_process_info_get_thread_handle (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_process_info.h%"] (PROCESS_INFORMATION*): EIF_INTEGER"
		end

	cwel_process_info_get_process_id (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_process_info.h%"] (PROCESS_INFORMATION*): EIF_INTEGER"
		end

	cwel_process_info_get_thread_id (ptr: POINTER): INTEGER is
		external
			"C [macro %"wel_process_info.h%"] (PROCESS_INFORMATION*): EIF_INTEGER"
		end

	cwel_process_info_set_process_handle (ptr: POINTER; a_handle: INTEGER) is
		external
			"C [macro %"wel_process_info.h%"] (PROCESS_INFORMATION*, HANDLE)"
		end

	cwel_process_info_set_thread_handle (ptr: POINTER; a_handle: INTEGER) is
		external
			"C [macro %"wel_process_info.h%"] (PROCESS_INFORMATION*, HANDLE)"
		end

	cwel_process_info_set_process_id (ptr: POINTER; a_id: INTEGER) is
		external
			"C [macro %"wel_process_info.h%"] (PROCESS_INFORMATION*, DWORD)"
		end

	cwel_process_info_set_thread_id (ptr: POINTER; a_id: INTEGER) is
		external
			"C [macro %"wel_process_info.h%"] (PROCESS_INFORMATION*, DWORD)"
		end

end -- class WEL_PROCESS_INFO		


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

