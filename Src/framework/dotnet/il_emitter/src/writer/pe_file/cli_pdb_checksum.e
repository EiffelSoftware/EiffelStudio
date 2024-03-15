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
			-- SHA256 <<0x53 0x48 0x41 0x32 0x35 0x36 0x00>>
			-- SHA384 <<0x53 0x48 0x41 0x33 0x38 0x34 0x00>>
			-- SHA512 <<0x53 0x48 0x41 0x35 0x31 0x32 0x00>>


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
			Result := {ARRAY [NATURAL_8]} <<0x53, 0x48, 0x41, 0x32, 0x35, 0x36, 0x00>>
		end

	sha_384: ARRAY [NATURAL_8]
			-- Zero-terminated UTF8 string
		do
			Result := {ARRAY [NATURAL_8]} <<0x53, 0x48, 0x41, 0x33, 0x38, 0x34, 0x00>>
		end

	sha_512: ARRAY [NATURAL_8]
			-- Zero-terminated UTF8 string
		do
			Result := {ARRAY [NATURAL_8]} <<0x53, 0x48, 0x41, 0x35, 0x31, 0x32, 0x00>>
		end

end
