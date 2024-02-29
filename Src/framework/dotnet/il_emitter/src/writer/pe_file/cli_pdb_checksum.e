note
	description: "Object Representing the hash of the content of the symbol file the PE/COFF file was built with."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_PDB_CHECKSUM

create
	make

feature {NONE} -- Initialization

	make
		do
			set_algorithm_name_sha256
			create checksum.make_filled (0, 1, checksum_size)
		end

feature -- Access

	algorithm_name: ARRAY [NATURAL_8]
			-- SHA256 <<53 48 41 32 35 36 00>>
			-- SHA384 <<53 48 41 33 38 34 00>>
			-- SHA512 <<53 48 41 35 31 32 00>>


	checksum: ARRAY[NATURAL_8]
		-- Blob. Checksum of the PDB content.

	checksum_size: INTEGER

feature -- Element Change

	set_checksum (a_checksum: like checksum)
		do
			checksum := a_checksum
		ensure
			checksum_set: checksum = a_checksum
		end

feature {NONE} -- Implementation
	set_algorithm_name_sha256
		do
			algorithm_name := sha_256
			checksum_size := 32
		end


	set_algorithm_name_sha384
		do
			algorithm_name := sha_384
			checksum_size := 48
		end

	set_algorithm_name_sha512
		do
			algorithm_name := sha_512
			checksum_size := 64
		end

feature -- Managed Pointer

	item: CLI_MANAGED_POINTER
			-- write the items to the buffer in  little-endian format.
		local
			ac: BYTE_ARRAY_CONVERTER

		do
			create Result.make (size_of)

				-- algorithm_name
			Result.put_natural_8_array (algorithm_name)

				-- checksum
			Result.put_natural_8_array (checksum)
		ensure
			item.position = size_of
		end

feature -- Measurement

	size_of: INTEGER
			-- Size of `CLI_PDB_CHECKSUM' structure.
		local
			s: CLI_MANAGED_POINTER_SIZE
		do
			create s.make
				-- algorithm_name
			s.put_natural_8_array (algorithm_name.count)
				-- checksum
			s.put_natural_8_array (checksum_size)
			Result := s
		end


feature {NONE} -- Implementation

	sha_256: ARRAY [NATURAL_8]
			-- Zero-terminated UTF8 string
		do
			Result := {ARRAY [NATURAL_8]} <<53, 48, 41, 32, 35, 36, 00>>
		end

	sha_384: ARRAY [NATURAL_8]
			-- Zero-terminated UTF8 string
		do
			Result := {ARRAY [NATURAL_8]} <<53, 48, 41, 33, 38, 34, 00>>
		end

	sha_512: ARRAY [NATURAL_8]
			-- Zero-terminated UTF8 string
		do
			Result := {ARRAY [NATURAL_8]} <<53, 48, 41, 35, 31, 32, 00>>
		end

end
