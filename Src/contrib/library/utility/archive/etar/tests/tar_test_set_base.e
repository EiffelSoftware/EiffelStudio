note
	description: "Summary description for {TAR_TEST_SET_BASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAR_TEST_SET_BASE

inherit
	EQA_TEST_SET

feature {NONE} -- Utilites

	compare_special (expected, actual: SPECIAL[CHARACTER_8]): BOOLEAN
			-- Compare all bytes of `expected` to `actual` and return whether they are equal.
			-- If they are not equal print all differences found
		require
			same_size: expected.count = actual.count
		local
			i: INTEGER
		do
			from
				i := 0
				Result := true
			until
				i >= expected.count
			loop
				if expected[i] /= actual[i] then
					io.put_string ("Missmatch in block: ")
					io.put_integer (i // {TAR_CONST}.tar_block_size)
					io.put_string (" byte: ")
					io.put_integer (i \\ {TAR_CONST}.tar_block_size)
					io.put_string (" expected: ")
					io.put_string (printable_character_representation (expected[i]))
					io.put_string (" actual: ")
					io.put_string (printable_character_representation (actual[i]))
					io.new_line
					Result := False
				end
				i := i + 1
			end
		end

	printable_character_representation (c: CHARACTER_8): STRING
			-- Transform `c' into a printable version
		do
			inspect c
			when '%U' then
				Result := "%%U"
			when '%N' then
				Result := "%%N"
			else
				Result := c.out
			end
		end

	needed_blocks (n: INTEGER): INTEGER
			-- Indicate how many blocks are needed to represent `n' bytes
		require
			non_negative_bytes: n >= 0
		do
			Result := (n + {TAR_CONST}.tar_block_size - 1) // {TAR_CONST}.tar_block_size
		ensure
			bytes_fit: n <= Result * {TAR_CONST}.tar_block_size
			smallest_fit: (Result - 1) * {TAR_CONST}.tar_block_size < n
		end

	write_archivable_to_new_managed_pointer (a_archivable: ARCHIVABLE): MANAGED_POINTER
			-- write the whole `a_archivable' to a new managed pointer
		local
			i: INTEGER
		do
			from
				create Result.make ({TAR_CONST}.tar_block_size * a_archivable.required_blocks)
				i := 0
			until
				a_archivable.finished_writing
			loop
				a_archivable.write_block_to_managed_pointer (Result, i * {TAR_CONST}.tar_block_size)
				i := i + 1
			end
		end

	write_header_to_new_managed_poitner (a_writer: TAR_HEADER_WRITER): MANAGED_POINTER
			-- write everything `a_writer' writes blockwise to new managed pointer
		local
			i: INTEGER
		do
			from
				create Result.make ({TAR_CONST}.tar_block_size * a_writer.required_blocks)
			until
				a_writer.finished_writing
			loop
				a_writer.write_block_to_managed_pointer (Result, i * {TAR_CONST}.tar_block_size)
				i := i + 1
			end
		end

end
