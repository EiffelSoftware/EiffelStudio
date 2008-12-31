note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	HASH_TEST

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main
			-- Program entry point
		local
			s1, s2: SYSTEM_STRING
			data1_to_hash, data2_to_hash: NATIVE_ARRAY [NATURAL_8]
			hash_value1, hash_value2: NATIVE_ARRAY [NATURAL_8]
			same: BOOLEAN
			i: INTEGER
		do
			{SYSTEM_CONSOLE}.write_line ("Enter String 1 to hash:")
			s1 := {SYSTEM_CONSOLE}.read_line
			{SYSTEM_CONSOLE}.write_line ("Enter String 2 to hash:")
			s2 := {SYSTEM_CONSOLE}.read_line

				-- Convert `s1' to byte array
			data1_to_hash := convert_string_to_byte_array (s1)
				-- Convert `s2' to byte array
			data2_to_hash := convert_string_to_byte_array (s2)

				-- Create hash value from string 1 using MD5 intstance returned by cryto config system
			hash_value1 := (({HASH_ALGORITHM}) #? {CRYPTO_CONFIG}.create_from_name ("MD5")).compute_hash (data1_to_hash)

			{SYSTEM_CONSOLE}.write ("Hsah value of String 1: ")
			{SYSTEM_CONSOLE}.write_line ({BIT_CONVERTER}.to_string (hash_value1))

				-- Create hash value from string 2 using MD5 intstance returned by cryto config system
			hash_value2 ?= (create {MD5_CRYPTO_SERVICE_PROVIDER}.make).compute_hash (data2_to_hash)

			{SYSTEM_CONSOLE}.write ("Hsah value of String 2: ")
			{SYSTEM_CONSOLE}.write_line ({BIT_CONVERTER}.to_string (hash_value2))

				-- Memberwise compare of hash value bytes
			from
				i := 0
				same := True
			until
				i = hash_value1.count or not same
			loop
				same := hash_value1.item (i) = hash_value2.item (i)
				i := i + 1
			end

			if same then
				{SYSTEM_CONSOLE}.write_line ("The has values of String 1 and String 2 are the same!")
			else
				{SYSTEM_CONSOLE}.write_line ("The has values of String 1 and String 2 are not the same!")
			end

			{SYSTEM_CONSOLE}.write_line ("Please press Enter to continue...")
			{SYSTEM_CONSOLE}.read_line.do_nothing
		end

feature {NONE} -- Implementation

	convert_string_to_byte_array (a_str: SYSTEM_STRING): NATIVE_ARRAY [NATURAL_8]
			-- Converts a supplied string into an array of {NATURAL_8}
		require
			a_str_attached: a_str /= Void
		do
			Result := (create {UNICODE_ENCODING}.make).get_bytes (a_str)
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software/Microsoft Corporation. All rights reserved."
	license: "[
			This file is part of the Microsoft .NET Framework SDK Code Samples.

			This source code is intended only as a supplement to Microsoft
			Development Tools and/or on-line documentation.  See these other
			materials for detailed information regarding Microsoft code samples.

			THIS CODE AND INFORMATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY
			KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
			IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
			PARTICULAR PURPOSE.
		]"


end
