indexing
	description: "Wrapper of FILETIME structure"
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

creation
	make,
	make_by_pointer,
	make_by_current_time,
	make_by_file_access_time,
	make_by_file_modification_time,
	make_by_file_creation_time

feature {NONE} -- Initialization

	make_by_current_time is
			-- Create FILETIME structure and initialize it 
			-- to current universal time.
		do
			make
			cwel_get_system_time_as_file_time (item)
		ensure
			initialized: item /= default_pointer
		end

	make_by_file_access_time (a_file: FILE) is
			-- Create FILETIME structure and initialize 
			-- it to universal access time of file `a_file'
		require
			non_void_file: a_file /= Void	
		do
			make
			file_times (a_file, Void, Current, Void)	
		ensure
			initialized: item /= default_pointer
		end

	make_by_file_creation_time (a_file: FILE) is
			-- Create FILETIME structure and initialize 
			-- it to universal creation time of file `a_file'
		require
			non_void_file: a_file /= Void	
		do
			make
			file_times (a_file, Current, Void, Void)	
		ensure
			initialized: item /= default_pointer
		end

	make_by_file_modification_time (a_file: FILE) is
			-- Create FILETIME structure and initialize 
			-- it to universal modification time of file `a_file'
		require
			non_void_file: a_file /= Void
		do
			make
			file_times (a_file, Void, Void, Current)	
		ensure
			initialized: item /= default_pointer
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of FILETIME structure
		do
			Result := c_size_of_file_time
		end

feature -- Conversion

	system_time: WEL_SYSTEM_TIME is
			-- FILETIME in SYSTEMTIME format
		do
			create Result.make
			cwel_file_time_to_system_time (item, Result.item)
		end

	local_file_time: WEL_FILE_TIME is
			-- universal FILETIME in local FILETIME form
			-- `Current' must be in universal time form
		do
			create Result.make
			cwel_file_time_to_local_file_time (item, Result.item)
		end

	universal_file_time: WEL_FILE_TIME is
			-- local FILETIME in universal FILETIME form
			-- `Current' must be in local time form
		do
			create Result.make
			cwel_local_file_time_to_file_time (item, Result.item)
		end

feature -- Basic operations

	is_equal (a_file_time: WEL_FILE_TIME): BOOLEAN is
			-- is `a_file_time' equal to `Current'?
		do
			if (cwel_compare_file_time (item, a_file_time.item) = 0) then
				Result := true
			end
		end

	is_larger_than (a_file_time: WEL_FILE_TIME): BOOLEAN is
			-- is `Current' larger than `a_file_time'?
		require
			non_default_item: item /= default_pointer
		do
			if (cwel_compare_file_time (item, a_file_time.item) = 1) then
				Result := true
			end
		end

feature {NONE} -- Implementation

	file_times (a_file: FILE; a_creation_time, an_access_time, a_modification_time: WEL_FILE_TIME) is
			-- retrieves file times of file `a_file'
		require
			valid_file: a_file /= Void
			one_time_non_void: a_creation_time /= Void or else
					an_access_time /= Void or else
					a_modification_time /= Void
		local
			time1, time2: WEL_FILE_TIME
		do
			create time1.make
			create time2.make
			if (a_creation_time /= Void) then
				cwel_get_file_time (a_file.descriptor, a_creation_time.item,
						time1.item, time2.item)
			elseif (a_modification_time /= Void) then
				cwel_get_file_time (a_file.descriptor, time1.item,
						time2.item, a_modification_time.item)
			else
				cwel_get_file_time (a_file.descriptor, time1.item,
						an_access_time.item, time2.item)
			end
		end

feature {NONE} -- Externals

	c_size_of_file_time: INTEGER is
		external 
			"C [macro %"wel_time.h%"]"
		alias
			"sizeof(FILETIME)"
		end

	cwel_compare_file_time (ft1, ft2: POINTER):INTEGER is
		external 
			"C [macro %"wel_time.h%"]"
		end

	cwel_file_time_to_system_time (ft, st: POINTER) is
		external 
			"C [macro %"wel_time.h%"]"
		end

	cwel_file_time_to_local_file_time (ft, lft: POINTER) is
		external 
			"C [macro %"wel_time.h%"]"
		end

	cwel_local_file_time_to_file_time (lft, ft: POINTER) is
		external 
			"C [macro %"wel_time.h%"]"
		end

	cwel_get_file_time (file_handle: INTEGER; cft, aft, mft: POINTER) is
		external 
			"C [macro %"wel_time.h%"]"
		end

	cwel_get_system_time_as_file_time (ft: POINTER) is
		external 
			"C [macro %"wel_time.h%"]"
		end

end -- class WEL_FILE_TIME
