note
	description: "Wrapper of FILETIME structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FILE_TIME

inherit
	WEL_STRUCTURE
		export
			{NONE} set_item
		redefine
			is_equal
		end

create
	make,
	make_by_pointer,
	make_by_current_time,
	make_by_file_access_time,
	make_by_file_modification_time,
	make_by_file_creation_time

feature {NONE} -- Initialization

	make_by_current_time
			-- Create FILETIME structure and initialize it
			-- to current universal time.
		do
			make
			cwel_get_system_time_as_file_time (item)
		ensure
			exists: exists
		end

	make_by_file_access_time (a_file: FILE)
			-- Create FILETIME structure and initialize
			-- it to universal access time of file `a_file'
		require
			non_void_file: a_file /= Void
		do
			make
			file_times (a_file, Void, Current, Void)
		ensure
			exists: exists
		end

	make_by_file_creation_time (a_file: FILE)
			-- Create FILETIME structure and initialize
			-- it to universal creation time of file `a_file'
		require
			non_void_file: a_file /= Void
		do
			make
			file_times (a_file, Current, Void, Void)
		ensure
			exists: exists
		end

	make_by_file_modification_time (a_file: FILE)
			-- Create FILETIME structure and initialize
			-- it to universal modification time of file `a_file'
		require
			non_void_file: a_file /= Void
		do
			make
			file_times (a_file, Void, Void, Current)
		ensure
			exists: exists
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of FILETIME structure
		do
			Result := c_size_of_file_time
		end

feature -- Conversion

	system_time: WEL_SYSTEM_TIME
			-- FILETIME in SYSTEMTIME format
		require
			exists: exists
		do
			create Result.make
			cwel_file_time_to_system_time (item, Result.item)
		end

	local_file_time: WEL_FILE_TIME
			-- universal FILETIME in local FILETIME form
			-- `Current' must be in universal time form
		require
			exists: exists
		do
			create Result.make
			cwel_file_time_to_local_file_time (item, Result.item)
		end

	universal_file_time: WEL_FILE_TIME
			-- local FILETIME in universal FILETIME form
			-- `Current' must be in local time form
		require
			exists: exists
		do
			create Result.make
			cwel_local_file_time_to_file_time (item, Result.item)
		end

feature -- Basic operations

	is_equal (a_file_time: WEL_FILE_TIME): BOOLEAN
			-- is `a_file_time' equal to `Current'?
		do
			if exists and then a_file_time.exists then
				if (cwel_compare_file_time (item, a_file_time.item) = 0) then
					Result := True
				end
			end
		end

	is_larger_than (a_file_time: WEL_FILE_TIME): BOOLEAN
			-- is `Current' larger than `a_file_time'?
		require
			exists: exists
			a_file_time_not_void: a_file_time /= Void
			a_file_time_exists: a_file_time.exists
		do
			if (cwel_compare_file_time (item, a_file_time.item) = 1) then
				Result := True
			end
		end

feature {NONE} -- Implementation

	file_times (a_file: FILE; a_creation_time, an_access_time, a_modification_time: detachable WEL_FILE_TIME)
			-- retrieves file times of file `a_file'
		require
			valid_file: a_file /= Void
			one_time_non_void: a_creation_time /= Void xor an_access_time /= Void xor a_modification_time /= Void
		local
			time1, time2: WEL_FILE_TIME
		do
			create time1.make
			create time2.make
			if a_creation_time /= Void then
				cwel_get_file_time (handle_from_file_descriptor (a_file.descriptor), a_creation_time.item,
						time1.item, time2.item)
			elseif a_modification_time /= Void then
				cwel_get_file_time (handle_from_file_descriptor (a_file.descriptor), time1.item,
						time2.item, a_modification_time.item)
			elseif an_access_time /= Void then
				cwel_get_file_time (handle_from_file_descriptor (a_file.descriptor), time1.item,
						an_access_time.item, time2.item)
			end
		end

feature {NONE} -- Externals

	handle_from_file_descriptor (a_fd: INTEGER): POINTER
			-- Associated handle of `a_fd'.
		external
			"C inline use <io.h>"
		alias
			"(EIF_POINTER) _get_osfhandle($a_fd)"
		end

	c_size_of_file_time: INTEGER
		external
			"C [macro %"wel_time.h%"]"
		alias
			"sizeof(FILETIME)"
		end

	cwel_compare_file_time (ft1, ft2: POINTER):INTEGER
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_file_time_to_system_time (ft, st: POINTER)
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_file_time_to_local_file_time (ft, lft: POINTER)
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_local_file_time_to_file_time (lft, ft: POINTER)
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_get_file_time (file_handle, cft, aft, mft: POINTER)
		external
			"C [macro %"wel_time.h%"]"
		end

	cwel_get_system_time_as_file_time (ft: POINTER)
		external
			"C [macro %"wel_time.h%"]"
		end

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
