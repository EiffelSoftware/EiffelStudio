note
	description: "Code View Entry"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Code View Spec", "src=https://github.com/dotnet/runtime/blob/main/docs/design/specs/PE-COFF.md#codeview-debug-directory-entry-type-2", "protocol=uri"

class
	CLI_CODE_VIEW

create
	make


feature {NONE} -- Initialization

	make (a_path: PATH)
		do
			set_path (a_path)
			guid := new_random_guid
			age := 1
		end

feature -- Access

	signature: STRING = "RSDS"

    guid: ARRAY [NATURAL_8]
    	-- GUID (Globally Unique Identifier) of the associated PDB.

    age: INTEGER
    	-- Iteration of the PDB. The first iteration is 1. The iteration is incremented each time the PDB content is augmented.

    path: PATH
    		-- Associated .pdb file location

	utf8_path_value: STRING_8
			-- UTF-8 NUL-terminated path to the associated .pdb file location

feature -- Change Element

	random_guid
			-- Set `guid` with a random guid.
		do
			guid := new_random_guid
		end

	set_age (a_age: INTEGER)
			-- Set `age` with `a_age`
		do
			age := a_age
		ensure
			age_set: age = a_age
		end

	set_path (a_path: PATH)
			-- Set path with a_path
		do
			path := a_path
			utf8_path_value := a_path.utf_8_name + "%U"
		end

feature -- Managed Pointer

	item: CLI_MANAGED_POINTER
			-- write the items to the buffer in  little-endian format.
		local
			ac: BYTE_ARRAY_CONVERTER

		do
			create Result.make (size_of)

				-- signature
			create ac.make_from_string (signature)
			Result.put_natural_8_array (ac.to_natural_8_array)

				-- Guid
			Result.put_natural_8_array (guid)

				-- Age
			Result.put_integer_32 (age)

				-- Path
			create ac.make_from_string (utf8_path_value)
			Result.put_natural_8_array (ac.to_natural_8_array)
		ensure
			item.position = size_of
		end

feature -- Measurement

	size_of: INTEGER
			-- Size of `CLI_ENTRY' structure.
		local
			s: CLI_MANAGED_POINTER_SIZE
		do
			create s.make
				-- signature
			s.put_integer_32
				-- guid
			s.put_natural_8_array (guid.count)
				-- age
			s.put_integer_32
				-- path
			s.put_natural_8_array (utf8_path_value.count)
			Result := s
		end

feature {NONE} -- Random

	new_random_guid: ARRAY [NATURAL_8]
			-- Create a random GUID.
		local
			l_random: RANDOM
			l_data1: NATURAL_32
			l_data2: NATURAL_16
			l_data3: NATURAL_16
			l_data4: ARRAY [NATURAL_8]
			l_seed: INTEGER
			l_time: TIME
			l_val: NATURAL_8
			l_guid: CIL_GUID
		do
			create l_time.make_now
			l_seed := l_time.hour
			l_seed := l_seed * 60 + l_time.minute
			l_seed := l_seed * 60 + l_time.second
			l_seed := l_seed * 1000 + l_time.milli_second

			create l_random.set_seed (l_seed)
			l_random.start

			l_data1 := l_random.item.to_natural_32
			l_random.forth

			l_data2 := ((l_random.item.to_natural_32 \\ {NATURAL_16}.max_value) + 1).to_natural_16
			l_random.forth

			l_data3 := ((l_random.item.to_natural_32 \\ {NATURAL_16}.max_value) + 1).to_natural_16
			l_random.forth

			l_data4 := {ARRAY [NATURAL_8]} <<0, 0, 0, 0, 0, 0, 0, 0>>

			across 1 |..| 8 as i loop
				l_val := ((l_random.item.to_natural_32 \\ {NATURAL_8}.max_value) + 1).to_natural_8
				l_data4 [i] := l_val
				l_random.forth
			end

			create l_guid.make (l_data1, l_data2, l_data3, l_data4)
			Result := l_guid.to_array_natural_8
		end
end
