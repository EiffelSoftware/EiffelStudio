note
	description: "Object used to retrieve total and free disk space on any%
	 			  %local hard drive. Remote drive are not yet supported"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DISK_SPACE

create
	default_create

feature -- Update

	query_local_drive (drive_letter: CHARACTER)
			-- Query the disk space available on the local drice
			-- designated by the letter `drive_letter'.
		local
			ufree_bytes, total_bytes, free_bytes: NATURAL_64
		do
			last_query_success := cwin_query_disk_space (drive_letter, $ufree_bytes, $total_bytes, $free_bytes)
				-- For the time being, we ignore `ufree_bytes' the amount of free bytes available to current user.
			last_free_space_in_bytes := free_bytes
			last_total_space_in_bytes := total_bytes
		end

feature -- Access

	last_free_space: NATURAL_64
			-- Free space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.
			--
			-- THIS FEATURE RETURNS THE RESULT IN MEGABYTES
			-- Use `last_free_space_in_bytes' to get an accurate result
			-- in bytes.
		require
			last_query_successful: last_query_success
		do
			Result := last_free_space_in_bytes |>> 20
		end

	last_total_space: NATURAL_64
			-- Total space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.
			--
			-- THIS FEATURE RETURNS THE RESULT IN MEGABYTES
			-- Use `last_total_space_in_bytes' to get an accurate result
			-- in bytes.
		require
			last_query_successful: last_query_success
		do
			Result := last_total_space_in_bytes |>> 20
		end

	last_free_space_in_bytes: NATURAL_64
			-- Free space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.
		require
			last_query_successful: last_query_success
		attribute
		end

	last_total_space_in_bytes: NATURAL_64
			-- Total space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.
		require
			last_query_successful: last_query_success
		attribute
		end

	last_free_space_in_string: STRING
			-- Compute the string representing the value of the free space
			-- as computed on the last call to `query_disk_space'.
			-- Example of possible returned strings: "600 MB", "30.1 MB", "1.33 MB",
			-- "320 KB", "52.7 KB", "75 B", "30 TB", ...
		require
			last_query_successful: last_query_success = True
		do
			Result := convert_space_into_string (last_free_space, last_free_space_in_bytes)
		end

	last_total_space_in_string: STRING
			-- Compute the string representing the value of the total space
			-- as computed on the last call to `query_disk_space'.
			-- Example of possible returned strings: "600 MB", "30.1 MB", "1.33 MB",
			-- "320 KB", "52.7 KB", "75 B", "30 TB", ...
		require
			last_query_successful: last_query_success = True
		do
			Result := convert_space_into_string (last_total_space, last_total_space_in_bytes)
		end

feature -- Status report

	last_query_success: BOOLEAN
			-- Was the last call to `query_disk_space' successful?

feature {NONE} -- Implementation

	convert_space_into_string (mbyte_value, byte_value: NATURAL_64): STRING
			-- Convert the value corresponding to `mbyte_value' and
			-- `byte_value' into a string. `mbyte_value' is the value
			-- represented in megabytes, and `byte_value' is the sane
			-- value represented in bytes.
		do
			if mbyte_value > 1048576 then
				-- Result exprimed in terabytes
				Result := format_space_string (mbyte_value, 1048576, "TB")

			elseif mbyte_value > 1024 then
				-- Result exprimed in gigabytes
				Result := format_space_string (mbyte_value, 1024, "GB")

			elseif byte_value > 1048576 then
				-- Result exprimed in megabytes
				Result := format_space_string (byte_value, 1048576, "MB")

			elseif byte_value > 1024 then
				-- Result exprimed in kilobytes
				Result := format_space_string (byte_value, 1024, "KB")

			else
				-- Result exprimed in bytes
				Result := format_space_string (byte_value, 1, "B")
			end
		end

	format_space_string(value: NATURAL_64; divisor: NATURAL_64; extension: STRING): STRING
			-- Format the string corresponding to `value'.
		require
			valid_divisor: (divisor = 1) or
						   (divisor = 1024) or
						   (divisor = 1048576)
			valid_extension: extension /= Void and then
							 not extension.is_empty
		local
			integer_part: NATURAL_64
			fractional_part_first_digit: NATURAL_64
			fractional_part_second_digit: NATURAL_64
		do
			create Result.make(8) -- Average maximum size
			integer_part := value // divisor
			Result.append(integer_part.out)

			if integer_part < 100 then
					-- We display the fractional part
				if integer_part < 10 then
						-- 2 digit fractional part
					fractional_part_first_digit := (((value \\ divisor) * 100 ) // divisor) // 10
					fractional_part_second_digit := (((value \\ divisor) * 100 ) // divisor) \\ 10
					if fractional_part_first_digit /= 0 or fractional_part_second_digit /= 0 then
						Result.append_character('.')
						Result.append(fractional_part_first_digit.out)
						if fractional_part_second_digit /= 0 then
							Result.append(fractional_part_second_digit.out)
						end
					end
				else
						-- 1 digit fractional part
					fractional_part_first_digit := (((value \\ divisor) * 100 ) // divisor) // 10
					if fractional_part_first_digit /= 0 then
						Result.append_character('.')
						Result.append(fractional_part_first_digit.out)
					end
				end
			end
			Result.append_character(' ')
			Result.append(extension)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature {NONE} -- Externals

	cwin_query_disk_space (drive_letter: CHARACTER; ufree_bytes, total_bytes, free_bytes: TYPED_POINTER [NATURAL_64]): BOOLEAN
		external
			"C inline use %"wel_disk_space.h%""
		alias
			"[
			{
				TCHAR szRootPath[4]; /* Path to root directory of requested drive. */
				ULARGE_INTEGER u, t, f;
				EIF_BOOLEAN Result;

				szRootPath[0] = (TCHAR) $drive_letter;
				szRootPath[1] = ':';
				szRootPath[2] = '\\';
				szRootPath[3] = (char) 0;

				Result = EIF_TEST(GetDiskFreeSpaceEx (szRootPath, &u, &t, &f));
				*(EIF_NATURAL_64 *) $ufree_bytes = u.QuadPart;
				*(EIF_NATURAL_64 *) $total_bytes = t.QuadPart;
				*(EIF_NATURAL_64 *) $free_bytes = f.QuadPart;

				return Result;
			}
			]"
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
