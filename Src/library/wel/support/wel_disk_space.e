indexing
	description	: "Object used to retrieve total and free disk space on any%
	 			  %local hard drive. Remote drive are not yet supported"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_DISK_SPACE

inherit
	WEL_DISK_SPACE_CALLBACK

create
	default_create

feature -- Access

	last_free_space: INTEGER is
			-- Free space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.
			--
			-- THIS FEATURE RETURNS THE RESULT IN MEGABYTES
			-- Use `last_free_space_in_bytes' to get an accurate result
			-- in bytes.
		require
			last_query_successful: last_query_success = True
		do
			Result := internal_last_free_space
		end

	last_total_space: INTEGER is
			-- Total space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.
			--
			-- THIS FEATURE RETURNS THE RESULT IN MEGABYTES
			-- Use `last_total_space_in_bytes' to get an accurate result
			-- in bytes.
		require
			last_query_successful: last_query_success = True
		do
			Result := internal_last_total_space
		end

	last_free_space_in_bytes: INTEGER is
			-- Free space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.
			--
			-- This value is only valid if the free disk space
			-- is less than 2 Gb. Otherwise, it cannot be represented
			-- by an INTEGER which is a signed 32 bits value.
		require
			result_meaningfull: last_free_space < 2047
			last_query_successful: last_query_success = True
		do
			Result := internal_last_free_space_in_bytes
		end

	last_total_space_in_bytes: INTEGER is
			-- Total space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.
			--
			-- This value is only valid if the free disk space
			-- is less than 2 Gb. Otherwise, it cannot be represented
			-- by an INTEGER which is a signed 32 bits value.
		require
			result_meaningfull: last_total_space < 2047
			last_query_successful: last_query_success = True
		do
			Result := internal_last_total_space_in_bytes
		end

	last_free_space_in_string: STRING is
			-- Compute the string representing the value of the free space
			-- as computed on the last call to `query_disk_space'.
			-- Example of possible returned strings: "600 Mb", "30.1 Mb", "1.33 Mb",
			-- "320 Kb", "52.7 Kb", "75 bytes", "30 Tb", ...
		require
			last_query_successful: last_query_success = True
		do
			Result := convert_space_into_string (
							internal_last_free_space, 
							internal_last_free_space_in_bytes
							)
		end

	last_total_space_in_string: STRING is
			-- Compute the string representing the value of the total space
			-- as computed on the last call to `query_disk_space'.
			-- Example of possible returned strings: "600 Mb", "30.1 Mb", "1.33 Mb",
			-- "320 Kb", "52.7 Kb", "75 bytes", "30 Tb", ...
		require
			last_query_successful: last_query_success = True
		do
			Result := convert_space_into_string (
							internal_last_total_space, 
							internal_last_total_space_in_bytes
							)
		end

feature {NONE} -- Implementation

	convert_space_into_string (mbyte_value, byte_value: INTEGER): STRING is
			-- Convert the value corresponding to `mbyte_value' and
			-- `byte_value' into a string. `mbyte_value' is the value
			-- represented in megabytes, and `byte_value' is the sane
			-- value represented in bytes.
		do
			if mbyte_value > 1048576 then
				-- Result exprimed in TeraBytes
				Result := format_space_string(mbyte_value, 1048576, "Tb")

			elseif mbyte_value > 1024 then
				-- Result exprimed in GigaBytes
				Result := format_space_string(mbyte_value, 1024, "Gb")

			elseif byte_value > 1048576 then
				-- Result exprimed in MegaBytes
				Result := format_space_string(byte_value, 1048576, "Mb")

			elseif byte_value > 1024 then
				-- Result exprimed in KiloBytes
				Result := format_space_string(byte_value, 1024, "Kb")

			else
				-- Result exprimed in Bytes
				Result := format_space_string(byte_value, 1, "bytes")
			end
		end

	format_space_string(value: INTEGER; divisor: INTEGER; 
						extension: STRING): STRING is
			-- Format the string corresponding to `value'.
		require
			valid_divisor: (divisor = 1) or 
						   (divisor = 1024) or 
						   (divisor = 1048576)
			valid_extension: extension /= Void and then 
							 not extension.is_empty
		local
			integer_part: INTEGER
			fractional_part_first_digit: INTEGER
			fractional_part_second_digit: INTEGER
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

feature {NONE} -- Internal values

	internal_last_free_space: INTEGER
			-- Free space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.

	internal_last_total_space: INTEGER
			-- Total space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.

	internal_last_free_space_in_bytes: INTEGER
			-- Free space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.


	internal_last_total_space_in_bytes: INTEGER
			-- Total space available on the last requested drive via the
			-- query `query_disk_space'. This value is updated by
			-- the feature `query_disk_space'.

feature {NONE} -- Externals

	eif_set_disk_space_attributes_callback(
		-- Callback function called from the C code.
			free_space: INTEGER;
			total_space: INTEGER;
			free_space_in_bytes: INTEGER;
			total_space_in_bytes: INTEGER
			) is
		do
			internal_last_free_space := free_space
			internal_last_total_space := total_space
			internal_last_free_space_in_bytes := free_space_in_bytes
			internal_last_total_space_in_bytes := total_space_in_bytes
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




end -- class WEL_DISK_SPACE

